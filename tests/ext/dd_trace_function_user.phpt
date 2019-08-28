--TEST--
dd_trace_function() can trace with internal spans with userland functions
--FILE--
<?php
namespace NS;

use DDTrace\SpanData;

function filter_to_array($fn, $input) {
    $output = [];
    foreach ($input as $value) {
        if (\call_user_func($fn, $value)) {
            $output[] = $value;
        }
    }
    return $output;
}

var_dump(dd_trace_function('NS\\filter_to_array', function (SpanData $span) {
    $span->name = 'FilterToArray';
}));

$is_odd = function ($x) {
    return $x % 2 == 1;
};
var_export(filter_to_array($is_odd, [1, 2, 3]));

echo "\n---\n";

var_dump(dd_trace_serialize_closed_spans());
var_dump(dd_trace_serialize_closed_spans());
?>
--EXPECTF--
bool(true)
array (
  0 => 1,
  1 => 3,
)
---
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
    string(13) "FilterToArray"
  }
}
array(0) {
}
