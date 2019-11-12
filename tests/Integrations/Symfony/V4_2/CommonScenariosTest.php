<?php

namespace DDTrace\Tests\Integrations\Symfony\V4_2;

use DDTrace\Tests\Common\SpanAssertion;
use DDTrace\Tests\Common\WebFrameworkTestCase;
use DDTrace\Tests\Frameworks\Util\Request\RequestSpec;

class CommonScenariosTest extends WebFrameworkTestCase
{
    const IS_SANDBOX = false;

    protected static function getAppIndexScript()
    {
        return __DIR__ . '/../../../Frameworks/Symfony/Version_4_2/public/index.php';
    }

    protected static function getEnvs()
    {
        return array_merge(parent::getEnvs(), [
            'DD_TRACE_DEBUG' => 'true',
            'DD_SERVICE_NAME' => 'test_symfony_42',
        ]);
    }

    /**
     * @dataProvider provideSpecs
     * @param RequestSpec $spec
     * @param array $spanExpectations
     * @throws \Exception
     */
    public function testScenario(RequestSpec $spec, array $spanExpectations)
    {
        $traces = $this->tracesFromWebRequest(function () use ($spec) {
            $this->call($spec);
        });

        $this->assertFlameGraph($traces, $spanExpectations);
    }

    public function provideSpecs()
    {
        return $this->buildDataProvider(
            [
                'A simple GET request returning a string' => [
                    SpanAssertion::build(
                        'symfony.request',
                        'test_symfony_42',
                        'web',
                        'simple'
                    )
                        ->withExactTags([
                            'symfony.route.action' => 'App\Controller\CommonScenariosController@simpleAction',
                            'symfony.route.name' => 'simple',
                            'http.method' => 'GET',
                            'http.url' => 'http://localhost:9999/simple',
                            'http.status_code' => '200',
                            'integration.name' => 'symfony',
                        ])
                        ->withChildren([
                            SpanAssertion::exists('symfony.kernel.handle')
                                ->withChildren([
                                    SpanAssertion::exists('symfony.kernel.request'),
                                    SpanAssertion::exists('symfony.kernel.controller'),
                                    SpanAssertion::exists('symfony.kernel.controller_arguments'),
                                    SpanAssertion::exists('symfony.kernel.response'),
                                    SpanAssertion::exists('symfony.kernel.finish_request'),
                                ]),
                        ]),
                    // This should be fixed as this should be a child
                    // of the root span while here it is a lone trace
                    SpanAssertion::exists('symfony.kernel.terminate'),
                ],
                'A simple GET request with a view' => [
                    SpanAssertion::build(
                        'symfony.request',
                        'test_symfony_42',
                        'web',
                        'simple_view'
                    )
                        ->withExactTags([
                            'symfony.route.action' => 'App\Controller\CommonScenariosController@simpleViewAction',
                            'symfony.route.name' => 'simple_view',
                            'http.method' => 'GET',
                            'http.url' => 'http://localhost:9999/simple_view',
                            'http.status_code' => '200',
                            'integration.name' => 'symfony',
                        ])
                        ->withChildren([
                            SpanAssertion::exists('symfony.kernel.handle')
                                ->withChildren([
                                    SpanAssertion::exists('symfony.kernel.request'),
                                    SpanAssertion::exists('symfony.kernel.controller'),
                                    SpanAssertion::exists('symfony.kernel.controller_arguments'),
                                    SpanAssertion::build(
                                        'symfony.templating.render',
                                        'test_symfony_42',
                                        'web',
                                        'Twig\Environment twig_template.html.twig'
                                    )
                                        ->withExactTags([
                                            'integration.name' => 'symfony',
                                        ]),
                                    SpanAssertion::exists('symfony.kernel.response'),
                                    SpanAssertion::exists('symfony.kernel.finish_request'),
                                ]),
                        ]),
                    // This should be fixed as this should be a child
                    // of the root span while here it is a lone trace
                    SpanAssertion::exists('symfony.kernel.terminate'),
                ],
                'A GET request with an exception' => [
                    SpanAssertion::build(
                        'symfony.request',
                        'test_symfony_42',
                        'web',
                        'error'
                    )
                        ->withExactTags([
                            'symfony.route.action' => 'App\Controller\CommonScenariosController@errorAction',
                            'symfony.route.name' => 'error',
                            'http.method' => 'GET',
                            'http.url' => 'http://localhost:9999/error',
                            'http.status_code' => '500',
                            'integration.name' => 'symfony',
                        ])
                        ->setError('Exception', 'An exception occurred')
                        ->withExistingTagsNames(['error.stack'])
                        ->withChildren([
                            SpanAssertion::exists('symfony.kernel.handle')
                                ->withChildren([
                                    SpanAssertion::exists('symfony.kernel.request'),
                                    SpanAssertion::exists('symfony.kernel.controller'),
                                    SpanAssertion::exists('symfony.kernel.controller_arguments'),
                                    SpanAssertion::exists('symfony.kernel.handleException')
                                        ->withChildren([
                                            SpanAssertion::exists('symfony.kernel.exception')
                                                ->withChildren([
                                                    SpanAssertion::exists('symfony.templating.render'),
                                                ]),
                                            SpanAssertion::exists('symfony.kernel.response'),
                                            SpanAssertion::exists('symfony.kernel.finish_request'),
                                        ]),
                                ]),
                        ]),
                    // This should be fixed as this should be a child
                    // of the root span while here it is a lone trace
                    SpanAssertion::exists('symfony.kernel.terminate'),
                ],
            ]
        );
    }
}
