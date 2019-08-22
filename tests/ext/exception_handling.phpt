--TEST--
Exceptions get attached to spans
--FILE--
<?php

register_shutdown_function(function () {
    $stack = dd_trace_serialize_closed_spans();
    echo "Stack size: ", count($stack), "\n";

    $span = $stack[0];
    echo "error: ", $span['error'], "\n";
    echo "Exception name: ", $span['meta']['error.name'], "\n";
    echo "Exception msg: ", $span['meta']['error.msg'], "\n";
    echo "Exception stack:\n", $span['meta']['error.stack'], "\n";

    $span = $stack[1];
    echo "error: ", $span['error'], "\n";
    echo "Exception name: ", $span['meta']['error.name'], "\n";
    echo "Exception msg: ", $span['meta']['error.msg'], "\n";
    echo "Exception stack:\n", $span['meta']['error.stack'], "\n";
});

function outer() {
    inner();
}
function inner() {
    throw new Exception("datadog");
}

dd_trace_function("outer", function() {});
dd_trace_function("inner", function() {});

outer();

?>
--EXPECTF--
Fatal error: Uncaught %s
Stack trace:
#0 %s: inner()
#1 %s: outer()
#2 {main}
  thrown in %s on line %d
Stack size: 2
error: 1
Exception name: Exception
Exception msg: datadog
Exception stack:
#0 %s: inner()
#1 %s: outer()
#2 {main}
error: 1
Exception name: Exception
Exception msg: datadog
Exception stack:
#0 %s: inner()
#1 %s: outer()
#2 {main}

