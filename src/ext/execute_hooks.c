#include "execute_hooks.h"

#include <php.h>
// the space below prevents clang-format from re-ordering the headers, which breaks compilation

#include <Zend/zend_exceptions.h>
#include <Zend/zend_execute.h>

#include "ddtrace.h"
#include "dispatch_compat.h"
#include "env_config.h"
#include "logging.h"
#include "trace.h"

#undef EX  // php7 style EX
#define EX(x) ((execute_data)->x)

#if PHP_VERSION_ID < 50500
ZEND_EXTERN_MODULE_GLOBALS(ddtrace);

// todo: extract to header
static ddtrace_dispatch_t *find_function_dispatch(const HashTable *lookup, zval *fname) {
    char *key = zend_str_tolower_dup(Z_STRVAL_P(fname), Z_STRLEN_P(fname));
    ddtrace_dispatch_t *dispatch = NULL;
    dispatch = zend_hash_str_find_ptr(lookup, key, Z_STRLEN_P(fname));

    efree(key);
    return dispatch;
}

// todo: extract to header
static ddtrace_dispatch_t *find_method_dispatch(const zend_class_entry *class, zval *fname TSRMLS_DC) {
    if (!fname || !Z_STRVAL_P(fname)) {
        return NULL;
    }
    HashTable *class_lookup = NULL;

#if PHP_VERSION_ID < 70000
    const char *class_name = NULL;
    size_t class_name_length = 0;
    class_name = class->name;
    class_name_length = class->name_length;
    class_lookup = zend_hash_str_find_ptr(DDTRACE_G(class_lookup), class_name, class_name_length);
#else
    class_lookup = zend_hash_find_ptr(DDTRACE_G(class_lookup), class->name);
#endif

    ddtrace_dispatch_t *dispatch = NULL;
    if (class_lookup) {
        dispatch = find_function_dispatch(class_lookup, fname);
    }

    if (dispatch) {
        return dispatch;
    }

    if (class->parent) {
        return find_method_dispatch(class->parent, fname TSRMLS_CC);
    } else {
        return NULL;
    }
}

static ddtrace_dispatch_t *_find_dispatch(zval *this, zend_op_array *op_array TSRMLS_DC) {
    zend_class_entry *class = NULL;
    zval *fname;
    ddtrace_dispatch_t *dispatch;

    ALLOC_INIT_ZVAL(fname);
    ZVAL_STRING(fname, op_array->function_name, 0);

    if (this) {
        class = Z_OBJCE_P(this);
    } else {
        class = op_array->scope;
    }
#if 0
    } else if ((fbc->common.fn_flags & ZEND_ACC_STATIC) != 0) {
        // Check for class on static method static
        class = fbc->common.scope;
    }
#endif

    dispatch = (class) ? find_method_dispatch(class, fname TSRMLS_CC)
                       : find_function_dispatch(DDTRACE_G(function_lookup), fname);

    efree(fname);
    return dispatch;
}

BOOL_T _should_trace(zend_execute_data *execute_data, zend_function **fbc, ddtrace_dispatch_t **dispatch TSRMLS_DC) {
    if (DDTRACE_G(disable) || DDTRACE_G(disable_in_current_request) || DDTRACE_G(class_lookup) == NULL ||
        DDTRACE_G(function_lookup) == NULL) {
        return FALSE;
    }

    *fbc = EX(function_state).function;
    if (!*fbc) {
        return FALSE;
    }

    // Don't trace closures; are there such things as internal closures?
    if ((*fbc)->common.fn_flags & ZEND_ACC_CLOSURE) {
        return FALSE;
    }
    zval *fname;
    ALLOC_INIT_ZVAL(fname);
    ZVAL_STRING(fname, (*fbc)->common.function_name, 0);

    zval *this = ddtrace_this(execute_data);
    *dispatch = ddtrace_find_dispatch(this, *fbc, fname TSRMLS_CC);
    efree(fname);
    if (!*dispatch || (*dispatch)->busy) {
        return FALSE;
    }

    return TRUE;
}

// todo: re-evaluate name
BOOL_T _should_trace_user(zend_op_array *op_array, ddtrace_dispatch_t **dispatch TSRMLS_DC) {
    if (DDTRACE_G(disable) || DDTRACE_G(disable_in_current_request) || DDTRACE_G(class_lookup) == NULL ||
        DDTRACE_G(function_lookup) == NULL) {
        return FALSE;
    }

    if (!op_array->function_name) {
        return FALSE;
    }

    if (op_array->fn_flags & ZEND_ACC_CLOSURE) {
        return FALSE;
    }

    *dispatch = _find_dispatch(EG(This), op_array TSRMLS_CC);
    if (!*dispatch || (*dispatch)->busy) {
        return FALSE;
    }

    if (!(*dispatch)->run_as_postprocess) {
        return FALSE;
    }

    return TRUE;
}

// true globals; should only be modified during minit/mshutdown
static void (*_execute)(zend_op_array *op_array TSRMLS_DC);
static void _ddtrace_execute(zend_op_array *op_array TSRMLS_DC) {
    ddtrace_dispatch_t *dispatch;

    if (!_should_trace_user(op_array, &dispatch)) {
        _execute(op_array TSRMLS_CC);
        return;
    }

    ddtrace_class_lookup_acquire(dispatch);
    dispatch->busy = 1;

    ddtrace_span_t *span = ddtrace_open_span(TSRMLS_C);

    _execute(op_array TSRMLS_CC);
    dd_trace_stop_span_time(span);
    ddtrace_span_attach_exception(span, EG(exception));

    if (!EG(exception) && Z_TYPE(dispatch->callable) == IS_OBJECT) {
        zval *rv_ptr = EG(return_value_ptr_ptr) ? *EG(return_value_ptr_ptr) : EG(uninitialized_zval_ptr);
        int orig_error_reporting = EG(error_reporting);
        EG(error_reporting) = 0;

        ddtrace_execute_tracing_closure(&dispatch->callable, span->span_data, EG(current_execute_data),
                                        rv_ptr TSRMLS_CC);
        EG(error_reporting) = orig_error_reporting;
        // If the tracing closure threw an exception, ignore it to not impact the original call
        if (EG(exception)) {
            ddtrace_log_debug("Exeception thrown in the tracing closure");
            zend_clear_exception(TSRMLS_C);
        }
    }

    ddtrace_close_span(TSRMLS_C);

    dispatch->busy = 0;
    ddtrace_class_lookup_release(dispatch);
}

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

    _execute_internal(execute_data, return_value_used TSRMLS_CC);

    ddtrace_close_span(TSRMLS_C);

    if (!EG(exception) && Z_TYPE(dispatch->callable) == IS_OBJECT) {
        int orig_error_reporting = EG(error_reporting);
        EG(error_reporting) = 0;

        ddtrace_execute_tracing_closure(&dispatch->callable, span->span_data, execute_data, *rv_ptr TSRMLS_CC);
        EG(error_reporting) = orig_error_reporting;
        // If the tracing closure threw an exception, ignore it to not impact the original call
        if (EG(exception)) {
            // TODO Log the exception
            zend_clear_exception(TSRMLS_C);
        }
    }

    dispatch->busy = 0;
    ddtrace_class_lookup_release(dispatch);
}

void ddtrace_execute_hooks_init(void) {
    _execute = zend_execute;
    zend_execute = _ddtrace_execute;

    _execute_internal = zend_execute_internal ? zend_execute_internal : execute_internal;
    _prev_execute_internal = zend_execute_internal;
    zend_execute_internal = _ddtrace_execute_internal;
}

void ddtrace_execute_hooks_shutdown(void) {
    zend_execute = _execute;
    zend_execute_internal = _prev_execute_internal;
}
#else

void ddtrace_execute_hooks_init(void) {}
void ddtrace_execute_hooks_shutdown(void) {}

#endif
