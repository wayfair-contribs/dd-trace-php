--TEST--
dd_trace_function() can trace with internal spans with internal functions
--FILE--
<?php
use DDTrace\SpanData;

var_dump(dd_trace_function('array_sum', function (SpanData $span) {
    $span->name = 'ArraySum';
}));
var_dump(dd_trace_function('mt_rand', null));

var_dump(array_sum([1, 3, 5]));

var_dump(dd_trace_serialize_closed_spans());
var_dump(dd_trace_serialize_closed_spans());
?>
--EXPECTF--
bool(true)
bool(false)
int(9)
array(1) {
  [0]=>
  array(5) {
    ["trace_id"]=>
    int(%d)
    ["span_id"]=>
    int(%d)
    ["start"]=>
    int(%d)
    ["duration"]=>
    int(%d)
    ["name"]=>
    string(8) "ArraySum"
  }
}
array(0) {
}
