--TEST--
traced functions that return by reference should not emit a notice
--INI--
error_reporting=-1
display_errors=1
--SKIPIF--
<?php if (!extension_loaded('ddtrace')) die('skip: ddtrace extension is required'); ?>
--FILE--
<?php

dd_trace_function('DB', function () {});

function &DB() {
    $obj = new stdclass();
    return $obj;
}

$db =& DB();

?>
--EXPECT--
