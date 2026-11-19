# 37signals, without Ruby

Engineering principles from 37signals and Basecamp: the books Shape Up and Getting Real, the company handbook, the Hotwire docs (Turbo and Stimulus), the Kamal deployment docs, the Solid Cache, Solid Cable and Solid Queue libraries, the Thruster proxy, and the code of two production apps, Campfire and Writebook. Each file gives a rule, the reason, a language-neutral example, the common failure, when to break it, and the page or code path it comes from. Product and process principles stand next to code and operations ones, because the source treats them as one way of working.

Coverage: 110 principles from all pages read (Shape Up 24, Getting Real 92, the handbook 16, the Turbo and Stimulus docs, the Kamal docs, Solid Cache, Solid Cable and Solid Queue, Thruster) plus every Ruby file in Campfire and Writebook. The 37signals dev blog is not included. Where a doc and the code disagree, the code is the rule. The app checkouts are current forks with many security comments, so only patterns seen in two or more places, or stated in a comment, are kept. "Docs only" in a Source line means no code backs the claim.


## Shaping and planning

1. [Set the time budget first, then design to fit it](principles/01-time-budget-before-design.md): Fix the time first, then shrink the design to fit
2. [Answer new ideas with a soft no and keep no backlog](principles/02-soft-no-no-backlog.md): Reply "maybe someday" to ideas and keep no central backlog
3. [Narrow every request to the moment the workflow breaks](principles/03-narrow-to-the-pain-moment.md): Design against one story of failure, not a feature name
4. [Specify work that is rough, solved and bounded](principles/04-rough-solved-bounded.md): Define work rough, solved and bounded, in words not wireframes
5. [Run a shaping track one step ahead of the build track](principles/05-shape-ahead-of-the-build.md): Prepare work one step ahead of builders, privately
6. [Close rabbit holes and name no-gos before committing](principles/06-rabbit-holes-and-no-gos.md): Stress-test for unknowns, patch simply, fence what is out
7. [A proposal needs a problem, a budget and a solution](principles/07-pitch-problem-budget-solution.md): Proposals carry a problem, a budget and a rough solution
8. [Reduce the risk of not shipping before anything else](principles/08-risk-of-not-shipping-first.md): Make finishing reliable before refining what to build
9. [Plan in fixed cycles with a cool-down between them](principles/09-fixed-cycles-with-cooldown.md): Fixed cycles long enough to finish, with a cool-down
10. [A bet is a commitment: protected time, no default extension](principles/10-bet-is-a-commitment.md): Protect a committed team; stop at the deadline, reshape
11. [Decide in the room, one cycle ahead, from a few shaped options](principles/11-decide-one-cycle-at-a-time.md): Decide in a short meeting, one cycle ahead
12. [Match the method to the product's maturity and the team's size](principles/12-match-method-to-maturity.md): Spike new products, shape mature ones, adopt by one experiment

## Building small

13. [Assign the whole project, not tasks](principles/13-assign-projects-not-tasks.md): Give teams the whole project; tasks are discovered while building
14. [Done means deployed inside the time box](principles/14-done-means-deployed.md): Finished means tested and deployed inside the time box
15. [Integrate one thin vertical slice in the first week](principles/15-thin-vertical-slice-first.md): Wire one core, small, novel slice end to end early
16. [Build plain affordances first and stub what you can](principles/16-affordances-before-pixels.md): Plain controls and stubs first, styling after the flow works
17. [Organise work by independently finishable scopes](principles/17-scopes-by-structure.md): Group work into named, independently finishable scopes
18. [Report progress as unknown versus known, and do the riskiest work first](principles/18-hill-progress-riskiest-first.md): Track unknown versus known; tackle the riskiest work first
19. [Cut scope, never quality, and compare to today's baseline](principles/19-cut-scope-not-quality.md): Vary scope, hold quality, beat today's baseline
20. [Builders own quality; QA hunts the edges](principles/20-builders-own-quality.md): Builders test their own work; QA hunts edge cases
21. [Triage bugs by reach and severity, not by arrival](principles/21-triage-bugs-by-reach.md): Rank bugs by reach and severity, not arrival order

## Product and scope

22. [Build half a product, and price every feature you keep](principles/22-half-a-product.md): Ship a small core and price every feature kept
23. [Write a one-sentence vision, know your user, take sides](principles/23-vision-and-known-user.md): State a one-sentence vision, know your user, take sides
24. [Make the call yourself; prefer general concepts to options](principles/24-defaults-over-preferences.md): Decide small things yourself; prefer general mechanisms to options
25. [Defer problems you do not have, and offer only what you can run](principles/25-defer-what-you-do-not-have.md): Postpone scale and offers you cannot yet run
26. [Design the interface first, from the core outward, large to small](principles/26-interface-first-core-outward.md): Interface first, essentials outward, details last
27. [Design every screen's states and words, for its own context](principles/27-design-every-screen-state.md): Design populated, empty and failure states in real words
28. [Settle arguments with running software, not paper](principles/28-running-software-over-paper.md): Settle debates with running software, not specs or betas
29. [Restate the hard problem as an easier one](principles/29-simplify-the-hard-problem.md): Counter-offer an easier version of the hard request
30. [Keep the cost of change low, decide quickly, repay debt on a schedule](principles/30-cheap-change-and-debt.md): Keep change cheap, decide fast, repay shortcuts on schedule
31. [Never lock data in](principles/31-never-lock-data-in.md): Easy signup, easy cancel, data always exportable

## Team and company

32. [Keep teams and modules small, with few dependencies between them](principles/32-small-teams-few-dependencies.md): Tiny teams and modules with few dependencies between them
33. [Protect long blocks of uninterrupted time](principles/33-protect-focus-time.md): Guard long uninterrupted blocks; cut meetings
34. [Collaborate in writing by default, on a fixed rhythm](principles/34-async-by-default.md): Write first, talk later, post updates on a rhythm
35. [Scale review to demonstrated trust and the risk of the change](principles/35-review-scaled-to-trust.md): Review depth follows track record and change risk
36. [Let the people who build the product answer its support](principles/36-builders-answer-support.md): Builders read and answer customer support themselves

## Frontend delivery

37. [Keep logic on the server and ship finished HTML](principles/37-server-owns-logic-ships-html.md): Logic and rendering stay on the server, HTML goes out
38. [One template for every path, and a closed set of update actions](principles/38-one-template-closed-actions.md): One template feeds every path; updates use a closed verb set
39. [Make the plain request path work first; live updates are an upgrade](principles/39-non-live-path-first.md): Build the plain request path first; live updates are extra
40. [After a successful change, redirect; render in place only for errors](principles/40-redirect-after-change.md): Redirect after success, render errors in place, block double submits
41. [Speed up navigation by keeping the client process alive](principles/41-persistent-process-navigation.md): Keep the client alive between pages; defer to the browser outside scope
42. [Client caches and speculative loads must obey writes](principles/42-caches-and-speculation-obey-writes.md): Clear caches and pause prefetching whenever a write happens
43. [Split pages into fragments by change rate and audience](principles/43-independent-fragments.md): Split pages into fragments by change rate and audience
44. [Write client code that survives page swaps](principles/44-swap-safe-client-code.md): Attach, release and re-run client code safely across swaps
45. [Keep UI state in the markup and render from one change callback](principles/45-state-in-markup.md): Put state in attributes and render from one change handler
46. [Build small, scoped components wired in readable markup](principles/46-small-scoped-components.md): Small scoped components, readable markup, events over references
47. [Fail loudly on missing parts, and isolate faults at the boundary](principles/47-fail-loudly-isolate-faults.md): Raise on missing required parts; contain faults at the boundary
48. [Ship a baseline that works without the script, then reveal enhancements](principles/48-progressive-enhancement.md): Baseline works without script; reveal enhancements after a feature test
49. [Treat declarative markup as an attack surface](principles/49-markup-is-attack-surface.md): Handlers named in markup need their own authorization

## App structure

50. [Split a growing model into one-word capability modules](principles/50-capability-modules.md): Split models into one-word capability modules with named preloads
51. [Give each non-CRUD behavior its own singular resource](principles/51-non-crud-singular-resources.md): Each extra verb becomes a small singular resource controller
52. [Controllers call one domain verb, then respond](principles/52-domain-verbs.md): Actions call one domain verb; plain classes hold cross-model flows
53. [Model closed sets of variants as subtypes with a shared base controller](principles/53-subtypes-with-abstract-controller.md): Variants as subtypes with a thin shared base controller
54. [Store state as named values, and deactivate instead of deleting](principles/54-named-states-and-soft-delete.md): Named string states; deactivate or trash rather than delete
55. [Hold request identity in one context; pass actors explicitly elsewhere](principles/55-request-context-explicit-actors.md): Request identity in one context; background code takes explicit actors
56. [Authenticate by default and opt out in one line](principles/56-authenticate-by-default.md): Authentication is the default; opt out declaratively per controller
57. [One broken item must not break the page](principles/57-one-broken-item-not-the-page.md): A failing item renders a placeholder, not a failed page
58. [Define the verification gate in one script](principles/58-one-verification-gate.md): One script gates every merge, built output tested in browsers

## Data and jobs

59. [One deployment, one account: enforce it in the schema](principles/59-one-deployment-one-account.md): One instance per customer, one account row, enforced by constraint
60. [Let a unique constraint decide races](principles/60-unique-constraint-decides-races.md): Optimistic write, and the unique index picks the winner
61. [Write fan-out as one set-based statement](principles/61-set-based-writes.md): Bulk grants and revocations as single statements
62. [Keep derived counters correct with database triggers](principles/62-triggers-for-counters.md): Database triggers keep counters right for every writer
63. [Index text in the same database and quote every query token](principles/63-search-in-the-same-database.md): Full-text index beside the data, with quoted query terms
64. [On a single-writer database, take the lock up front and hold it briefly](principles/64-short-write-lock.md): Do slow work before the write lock; re-check inside it
65. [Ship schema changes in additive steps that tolerate unknown installs](principles/65-migrations-for-unknown-installs.md): Additive, staged, re-runnable migrations for unknown installs
66. [Index a fixed-width hash and keep the full key to verify](principles/66-hash-index-full-key.md): Index a compact hash and verify against the stored key
67. [Use the database you already run before adding a service](principles/67-database-before-broker.md): Use the existing database before a broker, in its own schema
68. [Put slow work in a method, add a "later" twin, keep the job one line](principles/68-later-method.md): Work method plus a later twin; the job is one line
69. [Revoke access immediately, delete data later in small transactions](principles/69-revoke-now-delete-later.md): Cut access now, delete the children later in small steps
70. [Enqueue only after the surrounding transaction commits](principles/70-enqueue-after-commit.md): Enqueue only once the data's transaction has committed
71. [One table per job state, and polls your indexes fully cover](principles/71-table-per-state-indexed-polls.md): One table per job state, indexed polls, skip-locked claims
72. [Run single-purpose roles under a supervisor, and size threads by the pool](principles/72-supervised-single-purpose-processes.md): Single-purpose supervised processes; threads sized under the pool
73. [Detect dead processes by heartbeat; sweep for events that never fired](principles/73-heartbeat-and-sweeper.md): Heartbeats find dead processes; a sweeper catches missed events
74. [Shut down in a ladder: ask, wait a bounded time, then force](principles/74-shutdown-ladder.md): Ask, wait a bounded time, then force; return in-flight work
75. [Route job errors and infrastructure errors separately](principles/75-two-error-paths.md): Job failures and queue faults take different paths
76. [Cap concurrent runs with an expiring lease bound to the holder](principles/76-concurrency-lease.md): Expiring concurrency lease released only by its holder
77. [Make redundant schedulers safe with a unique record written with the enqueue](principles/77-redundant-schedulers-unique.md): Redundant schedulers made safe by a unique run record

## Caching

78. [A shared cache stores only responses that opt in as public](principles/78-cache-explicit-public.md): Shared caches keep only what the origin marks public
79. [Bound the cache by size and evict cheaply, driven by writes](principles/79-bound-the-cache.md): Cap size, evict cheaply, clean up in proportion to writes
80. [A cache failure is a miss, but only for transient errors](principles/80-failure-is-a-miss.md): Transient cache errors become misses; shard by consistent hash
81. [Key caches on a storage-level version or on rendered content](principles/81-storage-version-keys.md): Key on storage version or rendered content and policy version
82. [Authorize first, then serve cached output keyed by viewer](principles/82-authorize-then-serve-cached.md): Authorize first, then serve cached output keyed by viewer
83. [Match cache lifetime to the strictest audience, and version long-cached URLs](principles/83-cache-lifetime-strictest-audience.md): Cache lifetime follows the strictest audience; version long-lived URLs

## Realtime

84. [Sync clients with one refresh signal, echo suppression and debounce](principles/84-refresh-signal.md): One refresh signal, echo suppression and debounced re-fetch
85. [Name streams by audience and broadcast viewer-neutral markup](principles/85-no-shared-streams.md): Publish per-audience streams carrying viewer-neutral markup
86. [Treat realtime as a hint and give every live view an HTTP catch-up](principles/86-realtime-is-a-hint.md): Sockets hint; every live view can catch up over HTTP
87. [Show optimistic UI with a client-made id, then reconcile by that id](principles/87-optimistic-client-id.md): Client-made ids reconcile optimistic placeholders with broadcasts
88. [Model presence as an expiring lease renewed by the client](principles/88-presence-lease.md): Presence as a short lease the client keeps renewing
89. [Size pub/sub retention to the slowest listener and batch the writes](principles/89-retention-and-batching.md): Retention sized to the slowest listener; batch the inserts

## Deployment and operations

90. [Drive deploys as an imperative script with a ladder of commands](principles/90-imperative-blocking-deploy.md): Ordered blocking steps, with narrower commands and confirmations
91. [Switch traffic only after the new version is healthy](principles/91-switch-after-healthy.md): Route to the new version only once healthy
92. [Keep recent releases on each host so rollback needs no download](principles/92-rollback-from-kept-versions.md): Keep a bounded count of old releases for instant rollback
93. [Serialize, hook and record every mutating operator action](principles/93-lock-hooks-audit.md): Atomic lock, event-named hooks and a per-host audit trail
94. [Version every release by its source commit and stamp it on responses](principles/94-version-by-commit.md): Name releases by commit; stamp version on responses
95. [Put dependencies in the image and all state under one mount](principles/95-image-holds-dependencies-and-state.md): Dependencies in the image, all state under one mount
96. [Keep secrets out of config files and command lines](principles/96-secrets-out-of-config.md): Resolve secrets on demand into owner-only files
97. [Give stateful dependencies their own lifecycle](principles/97-stateful-deps-own-lifecycle.md): Databases and caches deploy by explicit commands, privately bound
98. [Change many hosts in groups, and keep every upgrade reversible](principles/98-roll-in-groups-reversible.md): Change hosts in groups, drain first, keep upgrades reversible
99. [Validate configuration strictly and ship defaults that work](principles/99-strict-config-zero-defaults.md): Reject unknown keys, ship working defaults, check before boot
100. [Let a thin edge terminate TLS, protect slow clients and serve files](principles/100-edge-duties.md): A thin edge handles TLS, timeouts, forwarded headers and files
101. [Record every user-facing error with an owner](principles/101-every-error-recorded.md): Every error page has a matching tracked exception and owner

## Security

102. [Authorize by loading through the user's reachable set, and fail closed](principles/102-reachable-set-and-fail-closed.md): Load through what the user may reach; deny when owner unknown
103. [Re-evaluate permission on every access](principles/103-recheck-permission-every-access.md): Signed links and sockets prove the past; recheck each use
104. [Close or guard every framework side door](principles/104-close-side-doors.md): Guard or remove framework endpoints that bypass your auth layer
105. [Fetch user-chosen URLs only through a guarded, pinned, bounded client](principles/105-guarded-outbound-fetch.md): Outbound fetches resolve once, pin, cap size, and set deadlines
106. [Sanitize by allowlist in layers sharing one list, and use hashes for CSP](principles/106-allowlist-sanitize-hash-csp.md): Allowlist sanitizing from one list; hash-based script policy
107. [Serve user uploads as downloads unless plainly media, and bound processing](principles/107-uploads-as-downloads.md): Uploads download unless plainly media; bound preview cost
108. [A credential change must revoke everything derived from the old one](principles/108-credential-change-revokes.md): Password change revokes sessions, sockets and derived links
109. [Keep code and secrets on trusted devices, and impersonate only with consent](principles/109-trusted-devices-and-consent.md): Secrets only on managed devices; impersonate only with consent
110. [Compress by default with size jitter, and guard authenticated traffic on request](principles/110-compress-with-jitter.md): Compress with jitter, strict mode for authenticated traffic
