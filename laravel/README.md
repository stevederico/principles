# Laravel, without PHP

Engineering principles from the Laravel documentation and framework code, rewritten in plain terms. Each file has a rule, the reason, a language-neutral example, the common failure, when to break it, and the docs page and code path it comes from.

Coverage: 121 principles from all 105 docs pages, each read and checked against the framework source and judged only against Laravel's own docs and code. Pages about separate packages (billing, search, monitoring, feature flags, AI tools) are marked "docs only" in each Source line.

## Philosophy

1. [Expressive API](principles/01-expressive-api.md): Fluent, sentence-like calls over long positional argument lists
2. [Batteries included](principles/02-batteries-included.md): A first-party answer per common need, each optional
3. [Start with what you already run](principles/03-start-with-what-you-already-run.md): Database-backed defaults, swap by config when load proves it

## Wiring

4. [Service container](principles/04-service-container.md): One registry builds objects and fills dependencies by type
5. [Container lifetimes](principles/05-container-lifetimes.md): Match each service's lifetime to the process that runs it
6. [Service providers](principles/06-service-providers.md): Two-phase startup: register binds, boot uses
7. [Facades](principles/07-facades.md): Short global-looking access that still resolves a swappable service
8. [Swappable drivers](principles/08-swappable-drivers.md): One interface per capability, driver chosen by config
9. [Keep driver contracts minimal](principles/09-driver-contracts-minimal.md): Drivers handle opaque strings; serialization and encryption live in one layer above
10. [Contracts in their own package](principles/10-contracts-as-separate-package.md): Publish interfaces apart from implementations so extensions depend on the interface only
11. [Packages ship overridable defaults](principles/11-package-overrides.md): Config merged under app values, views and strings shadowed by the app, swap points for models and routes
12. [Config from the environment](principles/12-config-from-environment.md): Env read in config files only, config is plain data

## Requests and routing

13. [Middleware pipeline](principles/13-middleware-pipeline.md): Ordered layers around a request, in and back out
14. [Layer order and scope](principles/14-layer-order-and-scope.md): Explicit priority list, three scopes, browser and API groups
15. [Form requests](principles/15-form-requests.md): Validate before the handler, authorize first, hand over validated data only
16. [Normalize input at the edge](principles/16-normalize-input-at-the-edge.md): Trim, empty to null, typed strict readers, once
17. [Presence and format are separate](principles/17-validation-presence-vs-format.md): State required or nullable on their own, since format rules skip empty values
18. [Uniqueness on update ignores the record itself](principles/18-unique-ignores-self.md): Exclude the current record by its system id, never an id from the request
19. [One password policy](principles/19-password-policy-once.md): Define the default policy once and check breaches by hash prefix, failing open
20. [Validation errors per client](principles/20-validation-errors-per-client.md): One typed error, rendered once by client type
21. [Route model binding](principles/21-route-model-binding.md): URL segments become loaded objects, nested through the parent
22. [Resource routes](principles/22-resource-routes.md): One conventional set of seven actions per resource, extras first, complex actions in their own handler
23. [Links from names](principles/23-links-from-names.md): Named routes, signed links for public actions
24. [Redirect after a write](principles/24-redirect-after-write.md): Answer a successful form post with a redirect and a one-request message, and never redirect to unchecked outside URLs
25. [API resources](principles/25-api-resources.md): An explicit output layer with allowlisted, per-viewer fields
26. [Pagination by need](principles/26-pagination-by-need.md): Count only when the screen shows a count

## Data

27. [Eager loading](principles/27-eager-loading.md): Load or count related rows in bulk, not per item
28. [Strict in dev, quiet in prod](principles/28-strict-in-dev-quiet-in-prod.md): Silent mistakes throw outside production, stay quiet inside
29. [Collections](principles/29-collections.md): Chainable, non-mutating list operations, in memory or streamed
30. [Mass assignment allowlist](principles/30-mass-assignment-allowlist.md): Only listed fields fill from input
31. [Casts at the model edge](principles/31-casts-at-the-model-edge.md): Convert storage types once, store time in UTC
32. [Bulk paths skip hooks](principles/32-bulk-paths-skip-hooks.md): Bulk statements fire no per-record events
33. [Model lifecycle hooks](principles/33-model-lifecycle-hooks.md): Before and after hooks, grouped in one observer, with scoped muting and after-commit handlers
34. [Touch the parent](principles/34-touch-parent-timestamps.md): Declare which parents get a fresh updated-at when a child changes
35. [Sync links as a set](principles/35-set-based-link-sync.md): State the desired set of linked records and let the library compute the diff
36. [Soft deletes as a default filter](principles/36-soft-deletes.md): Delete by timestamp, hide through a default constraint, make seeing and purging explicit
37. [Stored type names are aliases](principles/37-stable-type-aliases.md): Polymorphic links store a short fixed alias, never a class name
38. [Time-ordered ids](principles/38-time-ordered-ids.md): Sortable public ids for indexed keys, one unique id per record
39. [Batch by key, not by offset](principles/39-batch-by-id-cursor.md): A loop that changes its own filter pages by last seen id
40. [Transactions and races](principles/40-transactions-and-races.md): Commit or roll back, retry deadlocks, let constraints decide races
41. [Read your own writes](principles/41-read-your-own-writes.md): Route reads to the primary after a write
42. [Query safety](principles/42-query-safety.md): Bound values, allowlisted identifiers, grouped ORs
43. [Migrations](principles/43-migrations.md): Ordered versioned schema files, safe on big tables
44. [Search as a derived copy](principles/44-search-as-derived-copy.md): Index is synced, filtered and rechecked
45. [Feature flags](principles/45-feature-flags.md): Resolve once per scope, check an override first

## Caching and coordination

46. [Fresh, stale and missing](principles/46-cache-fresh-stale-missing.md): Serve stale values while one request refreshes them
47. [Invalidate by group](principles/47-invalidate-by-group.md): Tag, namespace per environment, never flush a shared store
48. [Atomic check and update](principles/48-atomic-check-and-update.md): One atomic step, not read then write
49. [Locks expire and are shared](principles/49-locks-expire-and-are-shared.md): Every lock expires, releases in finally, and is shared
50. [Precompute at deploy](principles/50-precompute-at-deploy.md): Build caches once per deploy, with an undo

## Views

51. [Escape by default](principles/51-escape-by-default.md): Safe output syntax first, raw output named and visible
52. [User text is data](principles/52-user-text-is-data.md): Never template text, escaped for the exact output format
53. [Bind recurring view data once](principles/53-view-composers.md): Register the data a template always needs against the template, not in each handler
54. [Fingerprinted assets behind one tag](principles/54-asset-fingerprints.md): One template tag, hashed file names resolved through a manifest, dev server detected by a marker file

## Background work and mail

55. [Events and listeners](principles/55-events-and-listeners.md): Announce facts, let separate listeners react
56. [Dispatch after commit](principles/56-dispatch-after-commit.md): Hold events and jobs until the transaction commits
57. [Notifications](principles/57-notifications.md): One message, many channels, any kind of recipient
58. [Fan out per recipient and channel](principles/58-fan-out-per-recipient-and-channel.md): Each delivery is its own unit of work
59. [Jobs reload and recheck](principles/59-jobs-reload-and-recheck.md): Queue identifiers, reload, re-ask whether to run
60. [Failure budget](principles/60-failure-budget.md): Attempts, backoff, timeouts and error classes, set on purpose
61. [Job middleware](principles/61-job-middleware.md): Cross-cutting run rules wrap a job as layers, not as code in the job body
62. [Failed tasks are kept and retryable](principles/62-failed-tasks-are-kept.md): A failed store with payload, operator retry commands, a failure hook, and quiet discard for vanished records
63. [Group keys for order and fairness](principles/63-queue-groups-order-and-fairness.md): Work in one group runs in order, groups run in parallel, and a dedupe id gives exactly-once
64. [Batches and chains](principles/64-job-batches-and-chains.md): Tracked groups with progress and cancel, ordered chains that stop on the first failure
65. [One routing table for queues](principles/65-queue-routing-table.md): Decide the connection and lane per task type in one place; isolate heavy work in capped pools
66. [Workers drain and recycle](principles/66-workers-drain-and-recycle.md): Graceful stop, restart on deploy, bounded life
67. [Unique or debounce](principles/67-dedupe-unique-or-debounce.md): Pick a dedupe meaning, with a key and a ceiling
68. [Context across the queue](principles/68-ambient-context-across-queue.md): Capture at enqueue, restore at run
69. [Defer after the response](principles/69-defer-after-response.md): Light work after send, heavy work in a queue
70. [Scheduler](principles/70-scheduler.md): Recurring work in code, one per-minute trigger
71. [Ordered fallbacks](principles/71-ordered-fallbacks.md): Fail over for availability, rotate for load, signal on failure
72. [Side channels fail quietly](principles/72-side-channels-fail-quietly.md): Supplementary features never break the request

## Outside calls, files and text

73. [Bounded outbound calls](principles/73-outbound-calls-bounded.md): A default timeout, failure as a value, retries only for named errors
74. [A fresh message per recipient](principles/74-mail-message-per-recipient.md): Never reuse one mutable message object across a recipient loop
75. [Mail is a renderable object](principles/75-mail-as-object.md): Each email is a self-contained object: render without sending, queue by declaration, text beside HTML
76. [Translation fallback chain](principles/76-localization-fallback-chain.md): Requested language, then fallback language, then the key itself
77. [Render in the recipient's language](principles/77-recipient-language.md): Pick the language from the recipient, keep it through the queue
78. [Storage failure policy](principles/78-storage-failure-policy.md): Make "what happens when a write fails" a named setting per storage target
79. [Read-through storage migration](principles/79-storage-read-through-migration.md): Move files between backends lazily, with no maintenance window

## Security and auth

80. [Policies and gates](principles/80-policies-and-gates.md): One named place for who may do what
81. [Deny by default](principles/81-deny-by-default.md): No rule or no user means no
82. [Find the identity, then prove the request](principles/82-identity-lookup-vs-proof.md): A user provider fetches identities, a guard decides how each request proves one
83. [Lock sessions that write](principles/83-session-write-lock.md): An opt-in per-session lock on routes where concurrent requests write the session
84. [Credentials by client type](principles/84-credentials-by-client-type.md): Cookie for your own browser app, scoped tokens for the rest
85. [Session rotation](principles/85-session-rotation.md): Fresh session id on login, bound to the credential
86. [Equal-time failure path](principles/86-equal-time-failure-path.md): Pad failed logins to a fixed floor
87. [Rehash passwords on login](principles/87-rehash-passwords.md): Raise hash cost at login without forcing resets
88. [Hash what you issue](principles/88-store-hashes-of-issued-secrets.md): Issued tokens are shown once and stored hashed
89. [Authenticated encryption and rotation](principles/89-authenticated-encryption-and-rotation.md): Tamper detection, key list, no free-form deserialization
90. [Origin first, token second](principles/90-csrf-origin-then-token.md): Check the browser origin signal first, token second
91. [Trusted proxies and hosts](principles/91-trusted-proxies-and-hosts.md): Forwarded headers only from known senders
92. [Uploads](principles/92-uploads.md): Generated file names and types decided from content
93. [Keyed rate limits](principles/93-rate-limits-keyed.md): Named limits with their own key

## Realtime

94. [Channel access is not secrecy](principles/94-channel-access-is-not-secrecy.md): A channel rule controls who joins; a third-party relay still sees the payload unless it is encrypted
95. [Keep realtime events small](principles/95-realtime-events-stay-small.md): Skip the sender, leave out oversized data, and always send a terminal failure event

## Payments and agents

96. [Webhooks are the truth](principles/96-webhooks-are-the-truth.md): Local billing state from signed provider events
97. [Incomplete payment is a state](principles/97-incomplete-payment-state.md): A charge needing customer action is a named state with its own flow, not a swallowed error
98. [Check conversation ownership](principles/98-conversation-ownership.md): A client-supplied conversation id must be checked against the caller
99. [Interrupted actions are unknown](principles/99-interrupted-calls-are-unknown.md): After a partial agent failure mark unrecorded side effects as interrupted
100. [Describe agent actions](principles/100-agent-actions-described.md): Metadata a model can choose by
101. [Gate agent runs](principles/101-agent-runs-gated.md): Human approval, narrow tools and budget checks per step

## Testing

102. [Test fakes](principles/102-test-fakes.md): Swap outside effects for fakes, forbid strays
103. [Factories](principles/103-factories.md): Describe a valid record once, with named states
104. [Reset matches the process](principles/104-db-reset-matches-process.md): Rollback in process, truncate across processes
105. [Pin what regresses](principles/105-pin-what-regresses.md): Query counts and exact response shape
106. [Seams for nondeterminism](principles/106-nondeterminism-seams.md): One wrapper per clock, sleep, id source
107. [Feature tests first](principles/107-feature-tests-first.md): Test through the real request path; reserve isolated tests for pure logic
108. [Stable hooks for browser tests](principles/108-stable-test-hooks.md): Select by a test-only attribute and wrap screens in page and component objects

## Tooling and operations

109. [CLI for every app](principles/109-cli-per-app.md): Operations, generators and a live shell
110. [Confirm destructive commands](principles/110-destructive-commands-confirm.md): Ask in production, offer a dry run
111. [Dev environment](principles/111-dev-environment.md): One command, production-shaped services, no real recipients
112. [Generated code is owned code](principles/112-generated-code-is-owned.md): Scaffolds copy editable code into the app, no upgrade path
113. [Serve only the public directory](principles/113-public-root-only.md): Web server serves one public folder, nothing above it
114. [Health and maintenance](principles/114-health-and-maintenance.md): Plain signals that survive a deploy
115. [Error handler](principles/115-error-handler.md): Report and render separately, reveal nothing in production
116. [Structured logs](principles/116-structured-logs.md): Fixed message, named context, shared request id
117. [Subsystems emit observation events](principles/117-observation-events.md): Each core subsystem announces its operations so tools attach without code changes
118. [Sample and group telemetry](principles/118-telemetry-sampling-and-grouping.md): Pre-aggregate in buckets, scale sampled values, normalize ids out of keys
119. [Multi-server tasks run serially](principles/119-multi-server-tasks-serial.md): Remote tasks go one server at a time, destructive ones confirm, hooks run on the operator's machine
120. [Gate ops and debug tools](principles/120-ops-tools-gated.md): Open in dev, deny elsewhere, filtered capture
121. [State the compatibility promise](principles/121-compat-promise.md): Semver, a stated public surface, upgrades ranked by impact
