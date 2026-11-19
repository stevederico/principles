# Next.js, without JavaScript

Engineering principles from the Next.js documentation and framework code, rewritten in plain terms. Each file has a rule, the reason, a language-neutral example, the common failure, when to break it, and the docs page and code path it comes from. The set covers the rendering model, the server and client boundary, data fetching and caching, routing, mutations, error handling, security, streaming, deployment, observability, testing and upgrades.

Coverage: 100 principles from all 480 docs pages read, each checked against the framework source and judged only against Next.js's own docs and code. Where the docs and the code disagree, the code is the rule. Pages about separate packages or experimental features are marked "docs only" in each Source line.

## Rendering model

1. [Classify content by what it varies on](principles/01-content-varies-by-input.md): Decide static, cached or streamed from each piece's inputs
2. [Read request data in the deepest component that needs it](principles/02-push-reads-down.md): Move cookies, params and fetches down so siblings stay static
3. [Time, randomness and ids must be chosen, not frozen](principles/03-nondeterminism-explicit.md): Per-execution values need an explicit request-time or cached decision
4. [Make static guarantees fail the build](principles/04-static-guarantees-enforced.md): Declare what must stay static and let the build enforce it
5. [Prebuild a bounded known set, build the rest lazily](principles/05-prerender-known-params.md): List the common parameter values, render others on first visit
6. [One shared shell per route, URL data behind a boundary](principles/06-shell-per-route.md): Build one reusable shell per route, not per link
7. [Build ahead unless the request matters](principles/07-render-ahead-by-default.md): Pre-render pages, and keep request-time loaders rare
8. [Static output rejects server needs; browser APIs wait for mount](principles/08-static-export-limits.md): Fail fast when a file-only deploy needs a server
9. [Layouts persist, so keep per-navigation inputs out](principles/09-layouts-persist.md): Shared wrappers must not read query, path or request
10. [Kept-alive views need bounds and deliberate resets](principles/10-kept-alive-views.md): Preserve useful state, reset transient state on hide

## Server and client boundary

11. [Put the client boundary at the interactive leaf](principles/11-client-leaf.md): Mark the smallest interactive piece as client code
12. [Code crosses by import, data by serializable props](principles/12-boundary-data-and-slots.md): Send values, not server code, across the boundary
13. [Make server-only modules fail the build in client code](principles/13-server-only-build-error.md): Mark secret-touching modules so wrong imports break the build
14. [Send the client only the fields it needs](principles/14-send-client-minimum.md): Props, mutation results and loader output are all public
15. [Keep heavy transformation on the server, load the rest on demand](principles/15-heavy-work-server.md): Ship markup, not libraries; defer big client-only code
16. [Hand unresolved promises to the client](principles/16-unresolved-promise-handoff.md): Start the fetch on the server, resolve it behind a fallback

## Data fetching

17. [Read data where it renders, straight from its source](principles/17-read-at-render-source.md): Server rendering calls the data layer, not your own HTTP route
18. [Start independent reads together](principles/18-parallel-reads.md): Wait sequentially only for true dependencies
19. [Deduplicate reads within one request, never across requests](principles/19-dedupe-per-request.md): Per-request memo for non-HTTP reads, explicit cache for the rest
20. [Mutations dispatch one at a time; reads stay out of them](principles/20-mutations-are-queued.md): Use server mutation calls for writes only
21. [Add a client data library only for shared revalidating state](principles/21-client-data-library.md): Pass a promise first; hydrate pending state per request
22. [Layers differ in freshness but share identity](principles/22-cache-layers-contract.md): One key and tag contract, invalidated together
23. [Optimistic updates rest on server truth](principles/23-optimistic-updates.md): Cancel, snapshot, apply, restore, and share one reducer

## Caching

24. [Cache only what is marked, at the narrowest unit](principles/24-uncached-by-default.md): Opt in per function, never route-wide
25. [A cache key covers every input that changes the result](principles/25-key-covers-inputs.md): Identity of code plus serialized inputs, nothing ambient
26. [Per-user data never enters a shared cache](principles/26-private-never-shared.md): Keep private data out of shared tiers and key text
27. [Freshness is three clocks, stated at every cache site](principles/27-three-clocks.md): Client reuse, background refresh, hard expiry
28. [Tag by data identity and invalidate by tag](principles/28-tag-by-identity.md): Paths over-invalidate or miss other consumers
29. [Choose invalidation strength by who is waiting](principles/29-invalidation-strength.md): Immediate expiry for the writer, stale-while-refresh for the rest
30. [Serve stale, refresh in the background, keep the last good copy](principles/30-stale-while-refresh.md): Prefer long windows with on-demand invalidation
31. [Cache entries never outlive the code that wrote them](principles/31-deploy-scoped-keys.md): Include the build identity and plan for a cold start
32. [Pick the cache tier and key cardinality on purpose](principles/32-cache-tiers.md): Remote caches only where hits are frequent
33. [Cached code forwards opaque values and returns expected failures](principles/33-cache-boundary-contract.md): What crosses a cache boundary must be keyable
34. [Many instances need a shared, synced, failure-tolerant cache](principles/34-multi-instance-cache.md): Share tag state; degrade to a miss, not an error
35. [Cache a page's HTML and data payload as one unit](principles/35-html-payload-vary.md): Encode response-varying inputs in the key, not only in Vary
36. [Match Cache-Control to output kind and purge the CDN yourself](principles/36-cdn-and-assets.md): Hashed assets immutable, dynamic private, purge both variants

## Routing and navigation

37. [Only entry files expose URLs](principles/37-entry-files-expose-urls.md): Folders shape routes; a page or handler file publishes one
38. [Routing resolves in fixed phases and by specificity](principles/38-deterministic-resolution.md): Publish the order so rules can be placed on purpose
39. [Treat URL values as untrusted and narrow them once](principles/39-url-values-untrusted.md): Validate path and query at the entry, encode when building
40. [Choose redirect status by intent and the layer by what you know](principles/40-redirects.md): Config, interceptor, server code and event handler each have a job
41. [Prefetch by cost: the link states intent, the target caps work](principles/41-prefetch-by-cost.md): Full for static, shell only for dynamic, none for huge lists
42. [Prefetch and render must never change state](principles/42-prefetch-is-pure.md): Rendering is pure; writes need an explicit user action
43. [Give every dynamic route an instant, honest loading shell](principles/43-loading-shells.md): Narrow boundaries, matching fallbacks, delayed spinners
44. [Parallel regions need an explicit fallback](principles/44-parallel-regions.md): Define what each region shows when state is unrecoverable
45. [Declare metadata statically unless data decides it](principles/45-metadata-static-first.md): Share the data read with the page, merge shallowly
46. [Endpoints are one function per verb on web-standard types](principles/46-route-handlers.md): Uncached by default, protocol methods derived

## Mutations

47. [Mutate, then invalidate, then redirect](principles/47-mutate-invalidate-redirect.md): The redirect is a thrown signal and must come last
48. [Reading a page never changes state](principles/48-no-writes-in-render.md): Writes belong to POST mutations, not render
49. [Server validation is authoritative](principles/49-server-validation.md): Schema check first, field errors as data, hash secrets
50. [Return expected failures as values; throw for the unexpected](principles/50-expected-failures-as-values.md): Control-flow signals and bugs go to boundaries
51. [Queue and retry on real connectivity loss](principles/51-offline-retry.md): Derive offline from failures, probe cheaply, back off

## Error handling

52. [Nest error boundaries; the nearest one catches](principles/52-nested-error-boundaries.md): A failure replaces only the region that owns it
53. [Boundaries see render failures, not handler failures](principles/53-boundary-render-only.md): Catch event and async errors yourself
54. [Never swallow the framework's control-flow throws](principles/54-control-flow-passes-through.md): Redirect, not-found and bail-out travel as exceptions
55. [Redact server errors in production, correlate by digest](principles/55-redact-server-errors.md): Generic message out, full detail logged under an id

## Security

56. [Authorize inside every mutation and endpoint](principles/56-authorize-every-entry.md): Each entry point is public; check who and which resource
57. [Separate authentication, session and authorization](principles/57-identity-three-concerns.md): Cheap early checks, real decisions at the data
58. [Route protected reads through one server-only data layer](principles/58-data-access-layer.md): Verify the session first, return only narrow objects
59. [Do not gate access in layouts](principles/59-no-layout-gating.md): Check where the data is read, not in shared wrappers
60. [Session cookies are server-set, locked down, minimal](principles/60-session-cookies.md): Stateless or database sessions, chosen by control needed
61. [Check Origin against the host on every mutation](principles/61-csrf-origin.md): An allowlist for proxies; know what the check does not stop
62. [Redirect targets from input must be same-origin](principles/62-same-origin-redirects.md): Parse, compare origins, or redirect to a fetched value
63. [Authenticate webhooks before acting, over the raw body](principles/63-webhook-verification.md): Secret or signature first, then validate, then invalidate
64. [Proxy to a backend through a fixed table and an allowlist of headers](principles/64-backend-proxy-allowlist.md): Never let the caller pick the upstream or the headers
65. [Server-side fetch proxies are allowlist-only and SSRF-hardened](principles/65-fetch-proxy-ssrf.md): Allowlist sources, block private addresses, detect type from bytes
66. [A nonce policy forces per-request rendering](principles/66-csp-and-headers.md): Hashes keep pages static; set baseline headers globally
67. [Treat inbound payloads as hostile](principles/67-hostile-payloads.md): Type, size, time, escaping and shared rate limits
68. [Keep the request interceptor fast, stateless and complete](principles/68-interceptor-scope.md): Cheap decisions only, covering every form of a resource
69. [Config is server-private unless prefixed, and public values freeze at build](principles/69-public-config-prefix.md): Read environment-specific values at request time
70. [Ship secrets at start, not inside the artifact](principles/70-artifacts-leak-nothing.md): No secrets in the image, no public source maps
71. [Draft preview is a secret-gated, per-viewer cache bypass](principles/71-draft-preview-bypass.md): Unguessable per build, never cached, never prefetched
72. [Deny cross-origin access to dev servers by default](principles/72-dev-server-default-deny.md): Allowlist hostnames; expose dev state only in development

## Streaming and performance

73. [Stream the shell first, each region at its boundary](principles/73-stream-at-boundaries.md): Each region streams and hydrates independently of its siblings
74. [Decide the status code before streaming starts](principles/74-status-before-first-byte.md): After the first flush the status is final
75. [Give script-less crawlers a complete head in the first response](principles/75-crawlers-full-head.md): Detect them by user agent, with a configurable list
76. [Protect the largest paint and reserve space](principles/76-lcp-and-layout-stability.md): Hero outside boundaries, media sized, one preloaded image
77. [Bound the variants a generator can produce](principles/77-bounded-image-variants.md): Fixed sizes and formats; stale while refreshing; no purge
78. [Streaming only works if no layer buffers](principles/78-unbuffered-path.md): Verify the whole path, not one hop
79. [Fetch third-party assets at build and serve them yourself](principles/79-self-host-fonts.md): Hashed files on your origin, fallback metrics matched
80. [Load each third-party script once, narrowly, with a priority](principles/80-third-party-scripts.md): Narrow scope, explicit priority, one analytics collector per signal

## Deployment and operations

81. [One server is the baseline; platform extras are performance](principles/81-minimum-server-fidelity.md): Separate "does it work" from "how fast"
82. [Put a reverse proxy in front and tune it with the app](principles/82-reverse-proxy-edge.md): Idle timeouts, compression and request limits belong at the edge
83. [Every instance runs one artifact and shares its keys](principles/83-one-artifact-shared-key.md): Same build id, same encryption key
84. [Detect version skew with a deployment id and reload](principles/84-version-skew.md): Rolling deploys make old clients meet new servers
85. [Drain in-flight work, including post-response callbacks](principles/85-graceful-shutdown.md): Stop accepting requests, finish pending work, then exit
86. [Own the build output and cache it only where it persists](principles/86-build-hygiene.md): Separate dev and build, lock one instance, bound caches
87. [Make the build verify what it can](principles/87-build-gates.md): Type check as a gate, literal config, early validation

## Observability

88. [Emit traces through a vendor-neutral standard](principles/88-neutral-tracing.md): Modest default spans, verbose ones behind a flag
89. [Create spans while serving a request](principles/89-spans-in-requests.md): Not at load time and not in the startup hook
90. [Run a startup hook once, and keep reporters from taking the app down](principles/90-startup-hook-isolated.md): Finish before serving; failures in reporting are logged
91. [Run non-critical work after the response](principles/91-after-response.md): Capture request context by value before scheduling

## Testing

92. [Match test type to what the unit depends on](principles/92-test-type-match.md): Async server-rendered units need end-to-end tests
93. [Run end-to-end tests against a production build](principles/93-e2e-production-build.md): Dev mode never caches and does not prefetch
94. [Test the instant-UI contract by pausing dynamic work](principles/94-instant-ui-test.md): Assert what shows now, release, assert the final page
95. [Keep test-control hooks out of user-facing builds](principles/95-test-hooks-test-builds.md): A flag, a dedicated build, a prerequisite check

## Upgrades and migration

96. [Migrate in place, one page at a time](principles/96-incremental-migration.md): Old and new coexist; move behavior first, then optimize
97. [Roll changes out per scope, then globally, then delete the flag](principles/97-staged-rollout.md): Opt-in, warn when unset, flip the default, remove
98. [Deprecate with a window, a shim, a warning and a codemod](principles/98-deprecation-window.md): Then remove the shim in the next major
99. [Automate safe changes, flag the rest, verify the result](principles/99-codemod-discipline.md): A green build does not close a migration
100. [Fall back to the old tool for custom setups, and fail loudly on conflicts](principles/100-legacy-fallback.md): Never quietly drop a user's configuration
