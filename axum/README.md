# Axum, without Rust

Engineering principles from Axum, the Rust web framework from the Tokio project (MIT licensed). Each file gives a rule, the reason, a language-neutral example, the common failure, when to break it, and the code path or doc page it comes from. The principles cover how a request is routed, how handlers declare their inputs, how state is shared, how middleware is layered, how errors become responses, how bodies are limited, how a server starts and stops, how streams and websockets are run, how the code is tested, and how a library keeps a stable core.

Coverage: 100 principles from every file read: the README, CONTRIBUTING, the contrib folder, the axum, axum-core, axum-extra and axum-macros crates, 59 examples and 3 changelogs. Where a doc and the code disagree, the code is the rule. Rust-only mechanics (lifetimes, trait bounds, macro internals) are left out unless a general principle sits under them. "Docs only" in a Source line means no code backs the claim, and "the source states none" under Break it when means the source gives no exception.

## Handlers and extractors

1. [A handler is a plain function of declared inputs](principles/01-handlers-are-plain-functions.md): Parameters declare what is needed; return value converts to a response
2. [Read metadata freely, consume the body once and last](principles/02-metadata-extractors-then-one-body-extractor.md): Metadata extractors run in any order; one body extractor goes last
3. [A failed input read answers the client before the handler runs](principles/03-failed-input-read-is-a-response.md): Each extractor owns a typed rejection; handler never sees bad input
4. [Optional input is empty only when absent](principles/04-optional-means-absent.md): Optional input yields none only when missing, never when malformed
5. [Wrap built-in extractors once so every input error shares a shape](principles/05-wrap-extractor-for-one-error-format.md): Wrap stock extractors in your own so errors keep one format
6. [Validate in the extractor, not the handler body](principles/06-parse-and-validate-in-the-extractor.md): Turn raw request data into valid domain values before the handler
7. [Ask for the headers you need; never consume shared metadata](principles/07-read-needed-headers-without-consuming.md): Ask for typed headers; never move metadata out of the request
8. [Authenticate by declaring the principal as a parameter](principles/08-principal-as-an-extractor.md): An extractor that yields the user makes the route protected by construction
9. [Check the declared content type and parse strictly](principles/09-strict-media-type-and-parse.md): Check declared content type, reject trailing bytes, never sniff the body
10. [Choose the status code by who is at fault](principles/10-status-by-who-is-at-fault.md): Bad input is 4xx by cause; wiring mistakes are 500
11. [Name the failing field and pay for it only on failure](principles/11-name-the-failing-field.md): Report which field failed; pay for diagnostics only on failure
12. [Decode path captures once and fail loudly on bad text](principles/12-decode-captures-strictly.md): Percent-decode once, require valid text, defer errors until read

## Routing

13. [Ambiguous or malformed routes abort at startup](principles/13-route-conflicts-fail-at-startup.md): Validate the route table while building it, not per request
14. [Route matching is deterministic and independent of order](principles/14-matching-is-deterministic-and-literal.md): Static beats capture; router matches shape only; handlers validate values
15. [Keep "no route", "wrong method" and "handler said 404" separate](principles/15-fallbacks-have-distinct-jobs.md): Separate no-match, wrong-method and handler-404, with inherited fallbacks
16. [A known path with the wrong method answers 405 plus Allow](principles/16-wrong-method-gets-405-with-allow.md): A known path with another method gets 405 listing allowed methods
17. [Answer HEAD from the GET route](principles/17-head-derives-from-get.md): HEAD falls back to GET with the body stripped
18. [Treat /foo and /foo/ as different routes](principles/18-trailing-slash-is-significant.md): No implicit redirect or aliasing; make the choice explicit
19. [Mounting a sub-app strips the prefix but keeps the original path](principles/19-mount-strips-prefix-keeps-original.md): Strip by whole segments; keep original URI and outer captures visible
20. [Build each feature as a router-returning function](principles/20-compose-routers-from-functions.md): Feature functions return the same router type and are merged or nested
21. [Make one type the route, the extractor and the URL builder](principles/21-typed-route-single-source.md): A route type carries its template, parses captures and formats links
22. [Build routers without their state, supply it once, finalize before serving](principles/22-build-routers-without-state-supply-once.md): A router records what it lacks and is finished before it serves
23. [Parse the API version once and reject unknown ones](principles/23-version-in-an-extractor.md): Parse the version segment into a closed set; unknown versions get 404

## Shared state and dependencies

24. [Keep shared state global, cheap to clone and briefly locked](principles/24-state-global-cheap-clone-short-locks.md): One value cloned per request; mutate behind a lock held briefly
25. [Per-request data rides on the request; dependencies live in state](principles/25-request-data-vs-global-state.md): Typed state for dependencies, request-scoped bag for per-request values
26. [Depend on the slice of state you need](principles/26-depend-on-state-slices.md): Handlers and reusable extractors ask for a part of the app state
27. [Create the pool once at startup, bounded, and share it](principles/27-pool-bounded-at-startup.md): Build a bounded pool before serving and share it through state
28. [Prove backing services and apply migrations before accepting traffic](principles/28-prove-and-migrate-before-serving.md): Ping dependencies and run migrations, then bind and serve
29. [Read secrets and endpoints from the environment](principles/29-config-from-environment.md): Required values from the environment; defaults only for harmless ones
30. [Derive connection facts at accept time and inject them as request data](principles/30-connection-facts-at-accept.md): Peer info is built per connection and faked in tests

## Middleware and layers

31. [Reuse the ecosystem's middleware contract; pick the style by audience](principles/31-reuse-shared-middleware-contract.md): No private middleware system; closures local, full services published
32. [Layer order decides what is covered and who runs first](principles/32-layer-order-defines-coverage.md): Layers wrap only existing routes, in onion order, listed in one place
33. [Guard only matched routes so unknown paths stay 404](principles/33-route-scoped-layer-for-guards.md): Route-scoped layers keep 404 and 405 from turning into 401
34. [Rewrite request paths outside the router](principles/34-rewrite-outside-the-router.md): Routing runs first; wrap the whole router to change what matches
35. [Shape function middleware like a handler](principles/35-middleware-shaped-like-handlers.md): Head extractors, at most one body extractor, then next
36. [Turn a validating extractor into a gate when the handler needs no value](principles/36-gate-from-an-extractor.md): Reuse an extractor as a pre-route gate that returns its rejection
37. [Errors become responses before they reach the transport](principles/37-every-service-answers-with-a-response.md): A total contract: fallible layers get a converter placed outside them
38. [Put timeout, concurrency cap and shedding in front of handlers](principles/38-bound-the-server.md): Bound request time, concurrency and queueing; shed overload early
39. [To inspect a body in middleware, read it and rebuild the request](principles/39-buffer-bodies-in-middleware-by-rebuild.md): Split, collect, use, then rebuild before calling the next layer

## Errors and responses

40. [Use one application error type that knows how to become a response](principles/40-one-app-error-type.md): Handlers return results; the error converts to a response once
41. [Log the real cause; send a generic message](principles/41-keep-internal-detail-out.md): Server-side failures give a fixed body; details go to the log
42. [Keep error conversion pure and log from one layer](principles/42-pure-conversion-log-in-middleware.md): Attach the error to the response; one logging layer reports it
43. [Compose a response from ordered parts](principles/43-compose-response-from-parts.md): Status first, header parts next, body last; parts cannot replace the body
44. [A failed response build must not be masked by an outer status](principles/44-failed-build-is-not-masked.md): Mark failed responses so a surrounding status cannot hide them
45. [Programmer mistakes abort at build time; data-dependent failures respond](principles/45-mistakes-abort-data-failures-respond.md): Build-time panics for misuse; error values or 500 for runtime data
46. [Choose the redirect status by what must happen to the method](principles/46-redirect-status-by-method.md): 303 turns into GET, 307 keeps the method, 308 is permanent
47. [Return the specific success status](principles/47-specific-success-statuses.md): 201 on create, 204 on delete, 404 when the target is missing
48. [Compute framing headers last and enforce protocol edges once](principles/48-framing-headers-last-protocol-edges-once.md): Set length from the final body; apply edge rules once, outermost

## Bodies, limits and security

49. [Cap every buffered body by default](principles/49-cap-buffered-bodies-by-default.md): A default size ceiling; raising it is explicit and per route
50. [A local limit only protects extractors that honor it](principles/50-local-limit-vs-global-limit.md): Use a global cap at the edge when third-party extractors exist
51. [Stream large bodies; buffer only when the size is bounded](principles/51-stream-large-bodies.md): Move big bodies through streams to disk or client
52. [Never put client-controlled strings into paths or headers unchecked](principles/52-client-strings-into-paths-and-headers.md): Validate names, escape header parameters, reject line breaks
53. [Parse range requests leniently on unit, strictly on values, and bound the work](principles/53-bound-range-request-work.md): Cap ranges honored; invalid ranges get 416
54. [Choose cookie protection by what you need](principles/54-cookie-protection-levels.md): Plain, signed (tamper-evident) or encrypted; keys come from state
55. [A cookie jar is a value you must return](principles/55-cookie-jar-is-a-returned-value.md): Cookie changes reach clients only when the jar is returned
56. [Issue expiring tokens and report every failure the same way](principles/56-opaque-token-failures-with-expiry.md): One opaque auth error; mandatory expiry; secret from configuration
57. [Make the browser login flow single-use, random and server-backed](principles/57-browser-login-flow.md): Random server-stored state, hardened session cookie, destroy on logout
58. [Allow explicit origins and methods for cross-origin access](principles/58-explicit-cors-allow-list.md): An allow-list, not a wildcard; JSON needs its header allowed
59. [Use a modern TLS profile and redirect the plain port](principles/59-tls-profile-and-single-port-redirect.md): Minimum version, advertised protocols, plain port only redirects
60. [Ship security fixes as defaults, on every maintained line](principles/60-security-fixes-as-defaults.md): Change the default with an escape hatch and backport it

## Serving and shutdown

61. [The accept loop never ends on transient errors](principles/61-accept-loop-survives.md): Skip client resets, back off on exhaustion, one task per connection
62. [Bound connections at accept time, not only requests in flight](principles/62-limit-connections-at-accept.md): Take a permit before accepting; it is released when the connection drops
63. [Ship safe network defaults and few knobs](principles/63-safe-network-defaults.md): No-delay sockets, a header-read timeout, the rest left to the lower layer
64. [Shut down gracefully: stop accepting, drain in-flight work, bound the wait](principles/64-graceful-shutdown.md): Handle interrupt and terminate, drain, and cap the drain
65. [Rotate connections by age, with jitter and an opt-in grace](principles/65-connection-lifetime-with-jitter.md): Cap connection age, randomize it, force-close only with a set grace
66. [A new connection must cost no more than a request](principles/66-share-the-finished-app-per-connection.md): Hand each connection a cheap handle to the finished app
67. [The router can be called as a request-to-response function](principles/67-router-as-a-plain-function.md): Use the app without a listener for serverless and tests

## Streaming and websockets

68. [Validate the upgrade in the extractor and run the session detached](principles/68-upgrade-validated-in-extractor.md): Check handshake up front; metadata is last read in the handler
69. [Let one task own a socket and select over its event sources](principles/69-one-task-owns-the-socket.md): The actor pattern is preferred over split halves
70. [Fan out with a bounded broadcast channel and clean up registrations](principles/70-broadcast-fanout-and-cleanup.md): One channel in state; each connection subscribes, then deregisters
71. [Give streaming connections their own size and buffer caps](principles/71-explicit-streaming-size-caps.md): Set message, frame and buffer limits; do not trust large defaults
72. [Make line-framed streams injection-proof and chunking-independent](principles/72-sse-framing-injection-proof.md): Split or reject line breaks; output must not depend on write splits
73. [Keep long streams alive with an idle timer reset by real events](principles/73-idle-keepalive-for-long-streams.md): Send a harmless comment frame only after idle time
74. [Handle line-delimited data as a stream with per-item errors](principles/74-line-delimited-streams.md): A bad line is a stream item, not a failed request

## Observability

75. [Log automatic rejections at trace level under their own target](principles/75-log-rejections-at-trace.md): Make "why did this request 400" visible without custom code
76. [Give every request an id and a span with the route template](principles/76-request-id-span.md): Id assigned if absent, echoed back, carried by a span
77. [Label metrics by route template and serve them privately](principles/77-metrics-by-route-template-on-a-private-port.md): Template labels bound cardinality; the metrics endpoint is not public

## Testing

78. [Build the app in a function that main and tests both call](principles/78-build-the-app-from-a-factory.md): One assembly function; tests never boot a process
79. [Test in-process first; keep a few tests on a real socket](principles/79-in-process-first-one-real-socket.md): Direct calls for most; port 0 for streaming and upgrades
80. [Pin boundary behavior, including failure bodies and known limits](principles/80-pin-boundary-behavior-and-failure-bodies.md): Assert status and body of 404, validation, fallback and quirks
81. [Name regression tests after the incident and say what broke](principles/81-regression-tests-carry-the-incident.md): A fix ships with a test that fails without it
82. [Fuzz parsers that face the network](principles/82-fuzz-parsers-on-hostile-input.md): A randomized test whose only claim is "does not crash"
83. [Test time-dependent behavior with a virtual clock](principles/83-virtual-clock-for-timers.md): Advance a paused clock instead of sleeping
84. [Pin how many times state and services are cloned](principles/84-pin-copy-counts.md): A counting test double that prints where copies happen
85. [Assert on structured logs as data](principles/85-assert-on-logs-as-data.md): Capture events as JSON and compare whole values
86. [Benchmark each feature against a minimal baseline](principles/86-benchmark-each-feature-through-a-real-listener.md): Run end-to-end scenarios, one feature each, against a real socket

## Library structure and API stability

87. [Keep a small stable core and push volatile pieces into extras](principles/87-stable-core-and-extras.md): Integrators depend on the core; extras carry opt-in extractors
88. [Keep error types opaque and open; seal extension traits](principles/88-open-opaque-errors-sealed-extensions.md): New variants and methods are not breaking changes
89. [Deprecate with a pointer, remove later, keep an opt-in helper](principles/89-deprecate-then-remove-with-an-escape-route.md): Never change meaning silently; fail loudly on retired syntax
90. [Show old code, new code and the reason for each break](principles/90-document-breaking-changes-with-before-and-after.md): Changelog entries carry a migration path and changed-default versions
91. [Pull a release that breaks compatibility by accident](principles/91-yank-accidental-breaks.md): Yank and re-release instead of patching forward
92. [Replace special-purpose APIs with composition](principles/92-composition-over-special-purpose-apis.md): Remove one-off helpers a general block can express
93. [Keep default features minimal and heavy parts opt-in](principles/93-minimal-default-features.md): Document every feature in a table; pay only for what you use
94. [State what the framework will not abstract](principles/94-state-non-goals.md): Document non-goals so promises match the design

## Compile-time help

95. [Reject misuse before runtime and say how to fix it](principles/95-reject-misuse-early-and-name-the-fix.md): Build-time errors that name the problem and the supported alternative
96. [Offer an opt-in check that re-verifies each handler requirement](principles/96-debug-only-handler-check.md): Targeted errors in debug builds, free in release
97. [Infer from usage when unambiguous; demand a choice when not](principles/97-infer-or-demand-explicit.md): State type inferred from arguments, with an error that tells the fix
98. [Test diagnostics with must-fail and must-compile fixtures](principles/98-fixtures-for-diagnostics.md): One rule per fixture, with the exact message stored

## Project practice

99. [Land a change that is better than the status quo](principles/99-land-incremental-improvement.md): Request changes kindly; large changes start as an issue
100. [Ask for the behavior and a minimal failing test](principles/100-bug-reports-need-a-minimal-reproducer.md): Two items make a bug report actionable
