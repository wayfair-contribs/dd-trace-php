<?php

namespace DDTrace\Tests\Integration;

use DDTrace\Tests\Common\AgentReplayerTrait;
use DDTrace\Tests\Unit\BaseTestCase;

use DDTrace\Tracer;

final class TracerTest extends BaseTestCase
{
    use AgentReplayerTrait;

    public function testInternalAndUserlandSpansAreMergedIntoSameTraceOnSerialization()
    {
        if (\PHP_VERSION_ID < 50600) {
            $this->markTestSkipped('Sandbox API not available on < PHP 5.6');
            return;
        }
        putenv("DD_AGENT_HOST=request_replayer");
        putenv("DD_TRACE_AGENT_PORT=80");
        putenv("DD_AGENT_PORT=80");
        putenv("DD_TRACE_BETA_SEND_TRACES_VIA_THREAD=1");

        \dd_trace_internal_fn('ddtrace_reload_config');

        \dd_trace_internal_fn('set_writer_send_on_flush', true);

        \dd_trace_function('array_sum', function () {
            // Do nothing
        });
        $tracer = new Tracer();
        $span = $tracer->startSpan('foo');
        array_sum([1, 2]);
        $span->finish();
        \dd_trace_coms_trigger_writer_flush();
        \usleep(50); // sleep to avoid flaky tests
        \dd_trace_internal_fn('shutdown_writer', true); //shuting down worker immediately will result in curl traces flush
        //$tracer->flush();

        var_dump($request = $this->getLastAgentRequest());

        //$traces = $tracer->getTracesAsArray();
    }
}
