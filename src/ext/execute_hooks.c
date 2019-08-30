#include "execute_hooks.h"

#include <php.h>
// the space below prevents clang-format from re-ordering the headers, which breaks compilation

#include <Zend/zend_exceptions.h>
#include <Zend/zend_execute.h>
#include <signal.h>

#include "ddtrace.h"
#include "dispatch_compat.h"
#include "env_config.h"
#include "logging.h"
#include "trace.h"

ZEND_EXTERN_MODULE_GLOBALS(ddtrace);

#if PHP_VERSION_ID < 70000
static BOOL_T _should_trace(zend_execute_data *execute_data, zend_function **fbc,
                            ddtrace_dispatch_t **dispatch TSRMLS_DC) {
    if (DDTRACE_G(disable) || DDTRACE_G(disable_in_current_request) || DDTRACE_G(class_lookup) == NULL ||
        DDTRACE_G(function_lookup) == NULL) {
        return FALSE;
    }

    if (!execute_data) {
        return FALSE;
    }

    *fbc = execute_data->function_state.function;
    if (!*fbc) {
        return FALSE;
    }

    // Don't trace closures; are there such things as internal closures?
    if ((*fbc)->common.fn_flags & ZEND_ACC_CLOSURE) {
        return FALSE;
    }

    if (!(*fbc)->common.function_name) {
        return FALSE;
    }

    zval fname;
    INIT_ZVAL(fname);
    ZVAL_STRING(&fname, (*fbc)->common.function_name, 0);
    /* this is a stripped down ddtrace_this; maybe refactor? */
#if PHP_VERSION_ID < 50500
    zval *this = execute_data->object ? execute_data->object : NULL;
#else
    zval *this = execute_data->call ? execute_data->call->object : NULL;
#endif

    if (this && Z_TYPE_P(this) != IS_OBJECT) {
        this = NULL;
    }

    *dispatch = ddtrace_find_dispatch(this, *fbc, &fname TSRMLS_CC);

    if (!*dispatch || (*dispatch)->busy) {
        return FALSE;
    }

    if (!(*dispatch)->run_as_postprocess) {
        return FALSE;
    }

    return TRUE;
}

#if PHP_VERSION_ID < 50500
static void (*_prev_execute_internal)(zend_execute_data *, int return_value_used TSRMLS_DC);
static void (*_execute_internal)(zend_execute_data *, int return_value_used TSRMLS_DC);

void _ddtrace_execute_internal(zend_execute_data *execute_data, int return_value_used TSRMLS_DC) {
    ddtrace_dispatch_t *dispatch;
    zend_function *fbc;

    if (!_should_trace(execute_data, &fbc, &dispatch)) {
        _execute_internal(execute_data, return_value_used TSRMLS_CC);
        return;
    }

    ddtrace_class_lookup_acquire(dispatch);
    dispatch->busy = 1;

    ddtrace_span_t *span = ddtrace_open_span(TSRMLS_C);

#if PHP_VERSION_ID < 50400
    // This *might* work on PHP 5.3:
    zval **rv_ptr = &(*(temp_variable *)((char *)execute_data->Ts + execute_data->opline->result.u.var)).var.ptr;
#else
    // this line was lifted from execute_internal
    zval **rv_ptr = &(*(temp_variable *)((char *)execute_data->Ts + execute_data->opline->result.var)).var.ptr;
#endif

    zval user_args;
    ddtrace_copy_function_args(execute_data, &user_args);

    _execute_internal(execute_data, return_value_used TSRMLS_CC);
    dd_trace_stop_span_time(span);

    if (!EG(exception) && Z_TYPE(dispatch->callable) == IS_OBJECT) {
        int orig_error_reporting = EG(error_reporting);
        EG(error_reporting) = 0;

        ddtrace_execute_tracing_closure(&dispatch->callable, span->span_data, &user_args, *rv_ptr TSRMLS_CC);
        EG(error_reporting) = orig_error_reporting;
        // If the tracing closure threw an exception, ignore it to not impact the original call
        if (EG(exception)) {
            ddtrace_log_debug("Exeception thrown in the tracing closure");
            zend_clear_exception(TSRMLS_C);
        }
    }

    zval_dtor(&user_args);

    ddtrace_close_span(TSRMLS_C);

    dispatch->busy = 0;
    ddtrace_class_lookup_release(dispatch);
}

#else
static void (*_prev_execute_internal)(zend_execute_data *, zend_fcall_info *fci, int return_value_used TSRMLS_DC);
static void (*_execute_internal)(zend_execute_data *, zend_fcall_info *fci, int return_value_used TSRMLS_DC);

static void _ddtrace_execute_internal(zend_execute_data *execute_data, zend_fcall_info *fci,
                                      int return_value_used TSRMLS_DC) {
    ddtrace_dispatch_t *dispatch;
    zend_function *fbc;

    if (!_should_trace(execute_data, &fbc, &dispatch)) {
        _execute_internal(execute_data, fci, return_value_used TSRMLS_CC);
        return;
    }

    ddtrace_class_lookup_acquire(dispatch);
    dispatch->busy = 1;

    ddtrace_span_t *span = ddtrace_open_span(TSRMLS_C);

    /* this line was extracted from execute_internal */
    zval **rv_ptr =
        (fci != NULL) ? fci->retval_ptr_ptr : &EX_TMP_VAR(execute_data, execute_data->opline->result.var)->var.ptr;

    zval user_args;
    ddtrace_copy_function_args(execute_data, &user_args);

    _execute_internal(execute_data, fci, return_value_used TSRMLS_CC);
    dd_trace_stop_span_time(span);

    if (!EG(exception) && Z_TYPE(dispatch->callable) == IS_OBJECT) {
        int orig_error_reporting = EG(error_reporting);
        EG(error_reporting) = 0;

        ddtrace_execute_tracing_closure(&dispatch->callable, span->span_data, &user_args, *rv_ptr TSRMLS_CC);
        EG(error_reporting) = orig_error_reporting;
        // If the tracing closure threw an exception, ignore it to not impact the original call
        if (EG(exception)) {
            ddtrace_log_debug("Exeception thrown in the tracing closure");
            zend_clear_exception(TSRMLS_C);
        }
    }

    zval_dtor(&user_args);

    ddtrace_close_span(TSRMLS_C);

    dispatch->busy = 0;
    ddtrace_class_lookup_release(dispatch);
}

#endif

void ddtrace_execute_hooks_init(void) {
    _execute_internal = zend_execute_internal ? zend_execute_internal : execute_internal;
    _prev_execute_internal = zend_execute_internal;
    zend_execute_internal = _ddtrace_execute_internal;
}

void ddtrace_execute_hooks_shutdown(void) { zend_execute_internal = _prev_execute_internal; }

#else
void ddtrace_execute_hooks_shutdown(void) {}
void ddtrace_execute_hooks_init(void) {}
#endif
