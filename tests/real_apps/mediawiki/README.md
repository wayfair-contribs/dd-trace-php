## Prerequisites

You have to setup the following environment variable with your Datadog key `DATADOG_API_KEY`.

## Launch the app

From a terminal:

    docker-composer up mediawiki

Browse to [http://localhost:8081](http://localhost:8081).

Login using username: `Ddtrace` and password `ddtrace2019`.

As you use the app, traces will appear under the servce name: `php_tracer_mediawiki`.
