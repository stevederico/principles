# Rails, without Ruby

81 engineering principles taken from the Rails guides and framework code, restated in plain, language-agnostic terms. Each file has a rule, the reason, a pseudo-code example, the common failure, an exception, and sources (guide page plus code path, or "docs only").

Coverage: all 77 guide pages read.

## Doctrine

1. [Programmer happiness](principles/01-programmer-happiness.md): optimize for how code feels to write and read
2. [Convention over configuration](principles/02-convention-over-configuration.md): one default per decision; names derive from one source
3. [The menu is omakase](principles/03-omakase.md): complete opinionated default stack, every part swappable or extractable
4. [No one paradigm](principles/04-no-one-paradigm.md): use objects, functions, or declarations, whichever fits the problem
5. [Exalt beautiful code](principles/05-beautiful-code.md): write the ideal call site first, then build it
6. [Provide sharp knives](principles/06-sharp-knives.md): keep dangerous tools, but make call sites say so
7. [Value integrated systems](principles/07-integrated-systems.md): one coherent toolkit lets one person ship a feature
8. [Progress over stability](principles/08-progress-over-stability.md): break only in minors, after one release of warning
9. [Push up a big tent](principles/09-big-tent.md): welcome everyone, with one explicit bar for all

## Structure

10. [Majestic monolith](principles/10-majestic-monolith.md): one deployable app, reuse infrastructure you already run
11. [Everything is a resource](principles/11-resources.md): seven standard actions; new capability means new resource
12. [Models own the domain](principles/12-models-own-domain.md): business rules in domain objects, thin request handlers
13. [One object per table row](principles/13-record-pattern.md): row-wrapping objects with their own rules, plus escape hatches
14. [Compose behavior from small modules](principles/14-compose-modules.md): named modules, never patches to built-in types
15. [The host rules embedded modules](principles/15-embedded-modules.md): host wins, modules namespaced, host classes named late
16. [Fail at declaration, not at first use](principles/16-fail-at-declaration.md): collisions, typos, and bad routes error immediately
17. [Hold names and hooks, not references](principles/17-resolve-late.md): long-lived places store names, resolved at use

## Data

18. [Schema changes are versioned](principles/18-migrations.md): timestamped scripts plus a committed snapshot for fresh databases
19. [Say what cannot be undone](principles/19-irreversible-and-atomic.md): reversible by construction, atomic, locked, honest about one-way steps
20. [Keep data changes out of schema scripts](principles/20-backfills-separate.md): backfills run separately, derived columns activate last
21. [Validate in the model, enforce in the database](principles/21-validate-and-enforce.md): constraints settle races that checks cannot
22. [Let names show failure and bypass](principles/22-names-show-failure-and-bypass.md): bang twins raise; rule-skipping operations get distinct names
23. [Name your queries](principles/23-named-queries.md): chainable, deferred filters with defined order and no nulls
24. [Load only what you need, in bounds](principles/24-bounded-loads.md): batches, database aggregates, strict lazy loading in development
25. [Guard shared writes](principles/25-guard-shared-writes.md): version checks, row locks, explicit transaction scope
26. [Callbacks with restraint](principles/26-callbacks.md): own-data hooks only; outside effects wait for commit
27. [Normalize at assignment and in lookups](principles/27-normalize-at-assignment.md): declare cleanup once; stored and searched values match
28. [Decide what removal means](principles/28-removal-meaning.md): choose child fate per link; unlink differs from destroy
29. [Read your own writes on replicas](principles/29-replica-reads.md): short writer window after writes; database enforces read-only
30. [Know what splitting data costs](principles/30-splitting-data.md): list lost guarantees; one owner per database; locked tenant

## Requests and routing

31. [The URL never picks the code](principles/31-url-never-picks-code.md): routes name every handler explicitly
32. [Keep routes small, shallow and named](principles/32-small-shallow-named-routes.md): one nesting level, used actions only, generated links
33. [Redirect on success, re-render on failure](principles/33-redirect-or-rerender.md): 303 after success, 422 with form on failure
34. [One resource, many representations](principles/34-one-resource-many-formats.md): format chosen by request, not by new endpoints
35. [Build the request path from small wrappers](principles/35-request-pipeline.md): single-purpose wrappers with one call shape
36. [Socket endpoints: authenticate, authorize, store first](principles/36-channels.md): check at connect and subscribe; broadcasts are ephemeral

## Views

37. [Send HTML, not JSON](principles/37-html-over-the-wire.md): server-rendered fragments swapped into the page
38. [Escape by default, trust by explicit mark](principles/38-escape-by-default.md): every string unsafe until deliberately marked
39. [Give templates an input contract](principles/39-strict-template-inputs.md): declared inputs; unknown or missing ones fail loudly
40. [Embed a reference, not a copy](principles/40-embed-reference-not-copy.md): signed references resolved at render, with fallback
41. [No build step by default](principles/41-no-build-step.md): plain modules and pins; bundler only for named needs
42. [Translate whole sentences, derive the keys](principles/42-translate-whole-sentences.md): layout lives in the entry, not in code
43. [Choose the locale explicit-first](principles/43-choose-locale-explicit-first.md): URL beats header; validate; messages resolve specific to general

## Background work and mail

44. [Slow work goes to a queue](principles/44-background-jobs.md): references, declared retry policy, durable queue in production
45. [Outside effects wait for the commit](principles/45-effects-wait-for-commit.md): enqueue and notify only after the transaction succeeds
46. [Make long jobs resumable](principles/46-resumable-jobs.md): named steps, saved cursor, stop at safe checkpoints
47. [Out-of-request code has no ambient context](principles/47-out-of-request-context.md): scoped state, carried into jobs, absolute URLs
48. [Inbound endpoints fail closed](principles/48-inbound-fail-closed.md): off until configured; routing is not authentication
49. [Accept fast, persist raw, process later](principles/49-inbound-accept-fast.md): dedupe by id; delete raw data on a timer

## Caching

50. [Stable cache keys with a version](principles/50-versioned-cache-keys.md): version mismatch is a miss; children touch parents
51. [A cache holds primitives and never fails the request](principles/51-cache-never-fails-request.md): errors are misses; one caller rebuilds on expiry
52. [Let the client revalidate](principles/52-conditional-get.md): version tag and empty not-modified replies
53. [Content hash in file names, cache forever](principles/53-content-hash-filenames.md): changed content gets a new name

## Security

54. [Allow-list input at the boundary](principles/54-allow-list-input.md): named fields, checked shape, server-set owner and privileges
55. [Authorization fails closed](principles/55-authorization-fails-closed.md): default-deny, opt out by name, query through the owner
56. [Safe methods read; unsafe ones prove origin](principles/56-prove-origin-on-writes.md): browser header or token on every write
57. [Allow-list every client-chosen selector](principles/57-allow-list-selectors.md): hosts, redirects, paths, locales, types checked against lists
58. [Reject bad input, keep code and data apart](principles/58-reject-and-keep-code-apart.md): parameters, data-only parsers, capped cost
59. [Tokens carry a purpose, an expiry and state](principles/59-purpose-bound-tokens.md): self-invalidating signed tokens; bad token means not found
60. [Authentication is uniform, bounded and re-proved](principles/60-authentication-uniform-and-bounded.md): identical failures, rate limits, fresh proof for takeover steps
61. [Keep authority on the server](principles/61-sessions-and-client-state.md): fresh session at login, server-side expiry, sealed client data
62. [Secrets are encrypted, layered and rotated](principles/62-secrets.md): encrypted file in repo, key outside, old keys only verify
63. [Declare sensitivity once](principles/63-declare-sensitivity-once.md): one declaration drives encryption and log masking
64. [Secure transport and headers on by default](principles/64-transport-and-headers.md): app-wide HTTPS, protective headers, report-only policy first
65. [Uploaded files are hostile](principles/65-uploads-are-hostile.md): unguessable is not authorized; downloads by default
66. [Big uploads skip your servers](principles/66-direct-uploads-and-orphans.md): signed direct upload, scheduled orphan purge, lazy derivatives

## Testing

67. [Expose hidden coupling in tests](principles/67-random-test-order.md): random order, printed seed, capturing queue
68. [Isolate each test in a rolled-back transaction](principles/68-transaction-wrapped-tests.md): no cleanup code; opt out only for commit-dependent tests
69. [Browser tests for critical paths only](principles/69-browser-tests-for-critical-paths.md): most tests below the browser; small shared fixtures
70. [Make the test environment hermetic](principles/70-hermetic-tests.md): local fakes, schema auto-sync, controlled clock
71. [Fixes carry a failing test](principles/71-fixes-carry-tests.md): optimizations carry benchmarks; every claimed backend is tested
72. [One script runs every check](principles/72-one-ci-script.md): same pipeline file locally and in CI

## Upgrades and operations

73. [Roll changes out in stages](principles/73-staged-rollouts.md): old-default switches; log, notify, raise; small upgrade steps
74. [Change a stored format in two steps](principles/74-migrate-formats-in-two-steps.md): read both first, write new later, count old use
75. [Fail loudly where a developer is watching](principles/75-loud-in-dev-quiet-in-prod.md): raise in dev and test; report and continue in production
76. [One error table, one reporter, narrow catches](principles/76-error-handling.md): map named errors to statuses; never rescue the root
77. [Observe from outside, cheaply in production](principles/77-observability.md): named events, request-id tags, shallow health checks
78. [Bound every wait, retry and pool](principles/78-bound-waits-and-pools.md): timeouts, jittered idempotent retries, pools sized to threads
79. [Guard destructive commands](principles/79-guard-destructive-commands.md): protected environments, sandbox consoles, read-only queries
80. [Wrap work you start outside the framework](principles/80-wrap-outside-work.md): same lifecycle wrapper; per-unit objects; no child global locks
81. [Say what you optimize for, then measure](principles/81-measure-before-tuning.md): pick the target; test on production-like hardware
