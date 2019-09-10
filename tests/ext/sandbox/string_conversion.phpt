--TEST--
SpanData properties are converted to strings without errors or exceptions
--SKIPIF--
<?php if (PHP_VERSION_ID < 50500) die('skip PHP 5.4 not supported'); ?>
--FILE--
<?php
use DDTrace\SpanData;

date_default_timezone_set('UTC');

class MyDt extends DateTime {
    public function __toString() {
        return $this->format('Y-m-d');
    }
}

function foo() {}

dd_trace_function('foo', function (SpanData $span, array $args) {
    $span->name = $args[0];
    $span->resource = $args[1];
    $span->service = $args[2];
    $span->type = null;
    $span->meta = [
        'bool' => $args[3],
        'closure' => $args[4],
        'object' => $args[5],
        'stringable-object' => $args[6],
        'array' => $args[7],
        'should-get-dropped' => null,
    ];
});

$ch = curl_init();
foo(
    $ch, 42, 4.2, true,
    function () {},
    new DateTime('2019-09-10'),
    new MyDt('2019-09-10'),
    ['foo' => 0]
);
curl_close($ch);

array_map(function($span) {
    var_dump($span['name']);
    var_dump($span['resource']);
    var_dump($span['service']);
    var_dump(isset($span['type']));
    var_dump($span['meta']['bool']);
    var_dump($span['meta']['closure']);
    var_dump($span['meta']['object']);
    var_dump($span['meta']['stringable-object']);
    var_dump(isset($span['meta']['should-get-dropped']));
}, dd_trace_serialize_closed_spans());
?>
--EXPECTF--
string(%d) "Resource id #%d"
string(2) "42"
string(3) "4.2"
bool(false)
string(1) "1"
string(%d) "object(Closure)#%d"
string(%d) "object(DateTime)#%d"
string(%d) "2019-09-10"
string(%d) "Array"
bool(false)
