# Laravel, without PHP

Engineering principles from the Laravel documentation and framework code, rewritten in plain terms. Each file has a rule, the reason, a language-neutral example, the common failure, when to break it, and the docs page and code path it comes from. General ideas such as migrations, queues and callbacks appear only where the Laravel docs add something distinct.

Coverage: all 105 docs pages read and checked against the framework source. Pages about separate packages (billing, search, monitoring, feature flags, AI tools) are marked "docs only" in each Source line.

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
9. [Config from the environment](principles/09-config-from-environment.md): Env read in config files only, config is plain data

## Requests and routing

10. [Middleware pipeline](principles/10-middleware-pipeline.md): Ordered layers around a request, in and back out
11. [Layer order and scope](principles/11-layer-order-and-scope.md): Explicit priority list, three scopes, browser and API groups
12. [Form requests](principles/12-form-requests.md): Validate before the handler, authorize first, hand over validated data only
13. [Normalize input at the edge](principles/13-normalize-input-at-the-edge.md): Trim, empty to null, typed strict readers, once
14. [Validation errors per client](principles/14-validation-errors-per-client.md): One typed error, rendered once by client type
15. [Route model binding](principles/15-route-model-binding.md): URL segments become loaded objects, nested through the parent
16. [Links from names](principles/16-links-from-names.md): Named routes, signed links for public actions
17. [API resources](principles/17-api-resources.md): An explicit output layer with allowlisted, per-viewer fields
18. [Pagination by need](principles/18-pagination-by-need.md): Count only when the screen shows a count

## Data

19. [Eager loading](principles/19-eager-loading.md): Load or count related rows in bulk, not per item
20. [Strict in dev, quiet in prod](principles/20-strict-in-dev-quiet-in-prod.md): Silent mistakes throw outside production, stay quiet inside
21. [Collections](principles/21-collections.md): Chainable, non-mutating list operations, in memory or streamed
22. [Mass assignment allowlist](principles/22-mass-assignment-allowlist.md): Only listed fields fill from input
23. [Casts at the model edge](principles/23-casts-at-the-model-edge.md): Convert storage types once, store time in UTC
24. [Bulk paths skip hooks](principles/24-bulk-paths-skip-hooks.md): Bulk statements fire no per-record events
25. [Transactions and races](principles/25-transactions-and-races.md): Commit or roll back, retry deadlocks, let constraints decide races
26. [Read your own writes](principles/26-read-your-own-writes.md): Route reads to the primary after a write
27. [Query safety](principles/27-query-safety.md): Bound values, allowlisted identifiers, grouped ORs
28. [Migrations](principles/28-migrations.md): Ordered versioned schema files, safe on big tables
29. [Search as a derived copy](principles/29-search-as-derived-copy.md): Index is synced, filtered and rechecked
30. [Feature flags](principles/30-feature-flags.md): Resolve once per scope, check an override first

## Caching and coordination

31. [Fresh, stale and missing](principles/31-cache-fresh-stale-missing.md): Serve stale values while one request refreshes them
32. [Invalidate by group](principles/32-invalidate-by-group.md): Tag, namespace per environment, never flush a shared store
33. [Atomic check and update](principles/33-atomic-check-and-update.md): One atomic step, not read then write
34. [Locks expire and are shared](principles/34-locks-expire-and-are-shared.md): Every lock expires, releases in finally, and is shared
35. [Precompute at deploy](principles/35-precompute-at-deploy.md): Build caches once per deploy, with an undo

## Views

36. [Escape by default](principles/36-escape-by-default.md): Safe output syntax first, raw output named and visible
37. [User text is data](principles/37-user-text-is-data.md): Never template text, escaped for the exact output format

## Background work and mail

38. [Events and listeners](principles/38-events-and-listeners.md): Announce facts, let separate listeners react
39. [Dispatch after commit](principles/39-dispatch-after-commit.md): Hold events and jobs until the transaction commits
40. [Notifications](principles/40-notifications.md): One message, many channels, any kind of recipient
41. [Fan out per recipient and channel](principles/41-fan-out-per-recipient-and-channel.md): Each delivery is its own unit of work
42. [Jobs reload and recheck](principles/42-jobs-reload-and-recheck.md): Queue identifiers, reload, re-ask whether to run
43. [Failure budget](principles/43-failure-budget.md): Attempts, backoff, timeouts and error classes, set on purpose
44. [Workers drain and recycle](principles/44-workers-drain-and-recycle.md): Graceful stop, restart on deploy, bounded life
45. [Unique or debounce](principles/45-dedupe-unique-or-debounce.md): Pick a dedupe meaning, with a key and a ceiling
46. [Context across the queue](principles/46-ambient-context-across-queue.md): Capture at enqueue, restore at run
47. [Defer after the response](principles/47-defer-after-response.md): Light work after send, heavy work in a queue
48. [Scheduler](principles/48-scheduler.md): Recurring work in code, one per-minute trigger
49. [Ordered fallbacks](principles/49-ordered-fallbacks.md): Fail over for availability, rotate for load, signal on failure
50. [Side channels fail quietly](principles/50-side-channels-fail-quietly.md): Supplementary features never break the request

## Security and auth

51. [Policies and gates](principles/51-policies-and-gates.md): One named place for who may do what
52. [Deny by default](principles/52-deny-by-default.md): No rule or no user means no
53. [Credentials by client type](principles/53-credentials-by-client-type.md): Cookie for your own browser app, scoped tokens for the rest
54. [Session rotation](principles/54-session-rotation.md): Fresh session id on login, bound to the credential
55. [Equal-time failure path](principles/55-equal-time-failure-path.md): Pad failed logins to a fixed floor
56. [Rehash passwords on login](principles/56-rehash-passwords.md): Raise hash cost at login without forcing resets
57. [Hash what you issue](principles/57-store-hashes-of-issued-secrets.md): Issued tokens are shown once and stored hashed
58. [Authenticated encryption and rotation](principles/58-authenticated-encryption-and-rotation.md): Tamper detection, key list, no free-form deserialization
59. [Origin first, token second](principles/59-csrf-origin-then-token.md): Check the browser origin signal first, token second
60. [Trusted proxies and hosts](principles/60-trusted-proxies-and-hosts.md): Forwarded headers only from known senders
61. [Uploads](principles/61-uploads.md): Generated file names and types decided from content
62. [Keyed rate limits](principles/62-rate-limits-keyed.md): Named limits with their own key

## Payments and agents

63. [Webhooks are the truth](principles/63-webhooks-are-the-truth.md): Local billing state from signed provider events
64. [Describe agent actions](principles/64-agent-actions-described.md): Metadata a model can choose by
65. [Gate agent runs](principles/65-agent-runs-gated.md): Human approval, narrow tools and budget checks per step

## Testing

66. [Test fakes](principles/66-test-fakes.md): Swap outside effects for fakes, forbid strays
67. [Factories](principles/67-factories.md): Describe a valid record once, with named states
68. [Reset matches the process](principles/68-db-reset-matches-process.md): Rollback in process, truncate across processes
69. [Pin what regresses](principles/69-pin-what-regresses.md): Query counts and exact response shape
70. [Seams for nondeterminism](principles/70-nondeterminism-seams.md): One wrapper per clock, sleep, id source

## Tooling and operations

71. [CLI for every app](principles/71-cli-per-app.md): Operations, generators and a live shell
72. [Confirm destructive commands](principles/72-destructive-commands-confirm.md): Ask in production, offer a dry run
73. [Dev environment](principles/73-dev-environment.md): One command, production-shaped services, no real recipients
74. [Generated code is owned code](principles/74-generated-code-is-owned.md): Scaffolds copy editable code into the app, no upgrade path
75. [Serve only the public directory](principles/75-public-root-only.md): Web server serves one public folder, nothing above it
76. [Health and maintenance](principles/76-health-and-maintenance.md): Plain signals that survive a deploy
77. [Error handler](principles/77-error-handler.md): Report and render separately, reveal nothing in production
78. [Structured logs](principles/78-structured-logs.md): Fixed message, named context, shared request id
79. [Gate ops and debug tools](principles/79-ops-tools-gated.md): Open in dev, deny elsewhere, filtered capture
80. [State the compatibility promise](principles/80-compat-promise.md): Semver, a stated public surface, upgrades ranked by impact
