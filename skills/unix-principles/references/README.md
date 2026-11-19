# unix, language-agnostic

Engineering principles from The Art of Unix Programming by Eric S. Raymond (CC BY-NoDerivs 1.0, read online at http://www.catb.org/esr/writings/taoup/html/), the book that states the Unix design culture as a set of rules and shows them at work in tools, protocols, file formats, interfaces, build practice and open-source projects. Each file is an original principle in its own words, not a rewrite of a passage, and holds a rule, the reason, a language-neutral example, the usual failure, when to break it, and the page it comes from. The book has no framework code, so every Source line is the page and section, marked "Book only". Time-bound advice about 2003-era tools, history, anecdotes, licensing and legal opinion is left out, and so is anything the pages do not state.

Coverage: 101 principles from all 153 book pages read. Where the book gives a figure (such as the 200 to 400 logical line sweet spot for module size, about seven entry points, or a call hierarchy deeper than four levels) it is a rule of thumb, not a law.


## Core rules

1. [Give each program one job and build a new one for a new job](principles/01-one-job-per-program.md): One job per tool; a new job gets a new tool
2. [Build large systems from simple parts behind narrow interfaces](principles/02-simple-parts-narrow-interfaces.md): Small units, few entry points, so faults stay local
3. [Write the code for the next reader, not for the machine](principles/03-write-for-the-next-reader.md): Maintainers are the audience; refuse cheap speedups that obscure
4. [Start from the simplest design and build big only after smaller approaches fail](principles/04-start-simple-build-big-last.md): Try small first; justify any large program with evidence
5. [Size a program by the context it must share](principles/05-size-by-shared-context.md): Draw program boundaries around the state that must be shared
6. [Make programs composable through plain streams](principles/06-compose-through-plain-streams.md): Plain input and output streams let tools join unplanned
7. [Separate policy from mechanism, and interface from engine](principles/07-separate-policy-from-mechanism.md): Stable engine below, swappable policy above, sensible defaults between
8. [Design programs so they can show that they work](principles/08-design-for-visibility.md): Build inspection in early; make output checkable by eye
9. [Get robustness from simplicity and few special cases](principles/09-robustness-from-simplicity.md): Handle empty and odd inputs through the general path
10. [Do the least surprising thing](principles/10-least-surprise.md): Copy what users know; delegate to their own tools
11. [Say nothing when there is nothing unusual to say](principles/11-silence-unless-unusual.md): Quiet on success; errors to the error channel
12. [Repair what you can; otherwise fail early, loudly and near the cause](principles/12-repair-or-fail-loudly.md): Repair when certain, otherwise stop early with context
13. [Spend machine time to save programmer time](principles/13-machine-time-for-programmer-time.md): Pick languages for people cost; drop low only when measured
14. [Generate repetitive code from a simpler specification](principles/14-generate-instead-of-hand-writing.md): Generate repetitive code; never hand-edit the generated output
15. [Leave flexible joints, not speculative features](principles/15-leave-flexible-joints.md): Make seams where change is likely; skip speculative features
16. [Fold knowledge into data so the logic stays dumb](principles/16-fold-knowledge-into-data.md): Move logic into tables people can verify and edit
17. [Be tolerant in what you accept and strict in what you emit](principles/17-tolerant-in-strict-out.md): Accept harmless variation, emit canonical form, specify the leniency

## Judging complexity and design

18. [Track complexity on three axes and name its kind before arguing about it](principles/18-three-axes-of-complexity.md): Track implementation, interface and size; classify complexity before debating
19. [Do not buy simplicity by pushing chores onto users or by multiplying special cases](principles/19-manularity-and-adhocity.md): Neither push chores onto users nor multiply special cases
20. [Decide deliberately whether the interface or the implementation absorbs the complexity](principles/20-who-pays-interface-or-implementation.md): Decide on purpose whether users or builders absorb difficulty
21. [Do the right thing when it is clear; otherwise do the minimum](principles/21-right-thing-or-minimum.md): Do the right thing when clear, else the least
22. [Put hard-to-retrofit properties in the foundation first](principles/22-foundation-first.md): Settle isolation, privilege and concurrency before polishing the surface
23. [Rewrite only on evidence, and keep the rewrite small](principles/23-rewrite-only-on-evidence.md): Rebuild bad designs, but count lost field knowledge first
24. [Prototype early, automate repeated work, and discard clumsy parts](principles/24-prototype-and-discard-freely.md): Prototype early, automate repeated work, delete clumsy parts
25. [Search, read and compose before you write](principles/25-reuse-before-writing.md): Search, read and compose before writing new code

## Modularity and interfaces

26. [Describe the interface in plain words before writing it](principles/26-plain-words-first-api.md): Write the interface in prose first; redesign if confusing
27. [Keep modules mid-sized and audit them against concrete numbers](principles/27-mid-sized-modules-and-structural-audit.md): Defects rise for huge and tiny modules; audit with numbers
28. [Keep interfaces compact enough to fit in a head](principles/28-compact-interfaces.md): Core working set small enough to remember
29. [Make operations orthogonal: one change, one effect](principles/29-orthogonal-operations.md): One change, one effect; any operation takes any selector
30. [Represent every fact once, and treat a cache as a costly second copy](principles/30-single-point-of-truth-and-caches.md): One authoritative copy; caches are costly derived duplicates
31. [Grow reusable primitives unless the specification is firm and complete](principles/31-design-from-primitives.md): Build general primitives unless the specification is firm
32. [Keep glue and abstraction layers thin enough to see through](principles/32-thin-glue-and-abstraction-layers.md): Few thin layers, each mapped to something real
33. [Separate the engine from its interfaces](principles/33-separate-engine-from-interface.md): Logic in an engine; every interface a thin layer
34. [Build extensible hosts as service libraries that plugins call back into](principles/34-plugins-call-back-into-host.md): Host as documented library; pick in-process or separate extensions
35. [Anchor a platform on a few unifying abstractions](principles/35-few-unifying-abstractions.md): One handle and namespace idea serves local and remote alike

## Text and data formats

36. [Default to readable text for files, streams and protocols](principles/36-text-first.md): Readable text by default; binary only after measuring
37. [If you must use binary, specify every detail and let readers skip what they do not know](principles/37-binary-only-when-specified-and-skippable.md): Exact specification, typed length-prefixed chunks, ignorable extensions
38. [Give every binary format a lossless text form and a way back](principles/38-textualizer-for-binary-objects.md): Lossless text conversion and back for every binary format
39. [Decide whether metadata lives in the content or beside it](principles/39-metadata-in-or-beside-content.md): Choose where attributes live and what preserves them
40. [Pick an established text metaformat by the shape of the data](principles/40-metaformat-by-data-shape.md): Reuse a standard text format matching the data's shape
41. [Escape with one rule and delimit records explicitly](principles/41-escaping-and-record-delimiting.md): One escape rule; visible, escapable record boundaries
42. [Follow the common plain-text file conventions](principles/42-plain-text-file-conventions.md): Line-oriented, comment lines, forgiving whitespace, round-trip tested numbers
43. [Give every format a version or independently droppable self-describing parts](principles/43-version-or-self-describe-formats.md): Version or skippable self-describing parts let formats evolve

## Processes and protocols

44. [Split into cooperating processes, then design the protocol between them](principles/44-split-into-processes-then-design-protocol.md): Splitting moves complexity into protocols; design them with care
45. [Escalate to heavier communication mechanisms only on evidence](principles/45-escalate-ipc-only-on-evidence.md): Climb the communication ladder only when benchmarks demand
46. [Use concurrency for structure, and prefer processes and event loops to threads](principles/46-processes-over-threads.md): Prefer processes and event loops; threads as last resort
47. [Confine privilege to a small trusted piece and narrow it step by step](principles/47-confine-privilege.md): Smallest trusted piece; chained steps that shed authority
48. [Do not pipeline when an upstream step must wait for downstream confirmation](principles/48-no-pipeline-when-ack-needed.md): Keep irreversible steps with the confirmation they depend on
49. [If another program will drive yours, offer a protocol instead of a conversation](principles/49-drivable-programs-need-a-protocol.md): Give driving programs end markers, not human prompts
50. [Treat remote calls as remote: failures are ambiguous and round trips are costly](principles/50-remote-calls-are-not-local-calls.md): Failures are ambiguous, round trips cost, keep types simple
51. [Shape application protocols as typed text lines with status plus message](principles/51-text-line-protocols.md): Command line, status plus message, explicit payload terminator
52. [Design protocols and services for latency first, and overlap requests](principles/52-design-protocols-for-latency.md): Few round trips, tagged overlapped requests, early rejection

## Transparency and debugging

53. [Ship a trace of real exchanges, with secrets masked and detail kept quiet](principles/53-trace-view-with-secrets-masked.md): Trace real exchanges, mask secrets, keep detail unobtrusive
54. [Let multi-stage tools expose each stage's readable output](principles/54-readable-intermediate-stages.md): Pipeline stages pass text and expose each result
55. [Pursue both transparency and discoverability, and keep code maintainable by others](principles/55-transparency-and-discoverability-differ.md): Predictable code plus a path into it for newcomers

## Configuration

56. [Detect or try alternatives instead of adding a setting](principles/56-detect-dont-ask.md): Autodetect or try alternatives instead of adding settings
57. [Make every option justify itself against its test cost](principles/57-every-option-justifies-itself.md): Each switch must beat omission, defaults and wrappers
58. [Layer configuration from global to local, matched to how long a setting lasts](principles/58-layer-config-by-lifetime.md): System, user, environment, command line; place settings by lifespan
59. [Let scripts pin behavior, and offer one generic set-option flag](principles/59-scripts-can-pin-behavior.md): Ignore-ambient-settings switch plus one generic override flag
60. [Keep startup settings in forgiving, human-readable files named after the program](principles/60-run-control-files.md): Forgiving readable startup files; shared credentials; no global store
61. [Follow the command-line option conventions](principles/61-follow-cli-conventions.md): Standard option syntax and letter meanings; fail loudly otherwise
62. [Tolerate unknown keys at runtime and audit them in a separate checker](principles/62-tolerate-unknown-keys-audit-separately.md): Engine skips unknown keys; a separate checker flags typos
63. [Treat configuration files and data files as different designs](principles/63-config-and-data-files-differ.md): Configuration is hand-edited and read-only; data is generated

## Interfaces for people and programs

64. [Judge each interface on five metrics, and make it feel intuitive](principles/64-five-interface-metrics.md): Score concision, expressiveness, ease, transparency, scriptability; aim for intuitive
65. [Offer a scriptable command or language interface beside the visual one](principles/65-command-and-visual-both.md): Commands or language beneath, visual interface on the same engine
66. [If you favor mechanism, ship sensible defaults and a way back](principles/66-mechanism-first-with-good-defaults.md): Flexible mechanism still needs defaults, reset and guidance
67. [Choose the least interactive interface shape that does the job](principles/67-least-interactive-shape.md): Prefer launch-and-finish designs; wrap dialogue around them
68. [Write filters that read a stream, write a stream and keep data clean](principles/68-write-filters.md): Stream in, stream out, pass through what you do not change
69. [Prefer undo to confirmation prompts, and put safety nets above the primitives](principles/69-undo-over-confirmation.md): Confirm only likely noes; recoverable delete above literal primitives

## Languages and tools

70. [Use the simplest notation that fits, and decide whether it is data or a language](principles/70-simplest-notation-that-fits.md): Climb from flat file toward language only when forced
71. [Build a small language when primitives are stable and combinations vary](principles/71-small-language-when-primitives-stable.md): Stable primitives, varied combinations, learnable from one example
72. [Sandbox any embedded language that can run untrusted code](principles/72-sandbox-embedded-languages.md): Give embedded code one narrow door to the host
73. [Reuse a host language or a parser generator instead of building an interpreter](principles/73-host-language-or-parser-generator.md): Extend a scripting host or generate parsers from grammars
74. [Keep an editable master and generate the rest from it](principles/74-editable-master-generate-outputs.md): Edit one master; build markup and tables from it
75. [Describe builds as dependencies and rebuild only what is out of date](principles/75-build-by-dependencies.md): Declare dependencies in text; rebuild only what is stale
76. [Provide the standard targets, including a faithful uninstall and a one-command test](principles/76-standard-build-targets.md): Conventional targets, exact uninstall, one-command test suite
77. [Use version control from the start and make reverting nearly free](principles/77-cheap-reversion.md): Version control from day one makes experiments safe
78. [Merge changes instead of locking, keep few branches, and exchange deltas](principles/78-merge-instead-of-lock.md): Merge concurrent edits, few branches, ship small deltas

## Performance and optimization

79. [Get it simple and working, then measure, then tune](principles/79-measure-then-tune.md): Simple and working first; tune only measured bottlenecks
80. [Measure with a harness, read profiles skeptically, and leave cold code alone](principles/80-read-profiles-skeptically.md): Harness first; profiles lie; leave cold code alone
81. [Prefer simple algorithms and data structures until n is known to be large](principles/81-simple-algorithms-small-n.md): Plain methods and compact data until large n is proven
82. [Batch work that shares setup cost and compute on demand by default](principles/82-batch-and-amortize.md): Share setup costs; compute on demand by default

## Portability and reuse

83. [Write for portability, even for throwaway code](principles/83-portability-over-time-and-space.md): Code to standards, assuming platforms are short-lived
84. [Isolate platform differences in a thin layer chosen by feature probes](principles/84-thin-platform-layer-feature-probes.md): Isolate platform differences; branch on features, not platforms
85. [Reach system resources through the service that owns them, not hard-coded paths](principles/85-resources-via-services.md): Ask the owning service, not hard-coded system paths
86. [Resolve dependencies by version and let versions coexist](principles/86-dependencies-by-version.md): Named versions coexisting side by side; installs never clobber
87. [Keep user-visible text out of the logic and use one universal encoding](principles/87-localizable-text-one-encoding.md): Message catalogs with fallback; one universal encoding inside
88. [Depend on components you can inspect, rebuild and vet](principles/88-inspectable-rebuildable-dependencies.md): Depend on code you can read, rebuild and vet
89. [Let standards grow from running code and independent implementations](principles/89-standards-from-running-code.md): Standardize proven practice; require independent interoperating implementations
90. [Treat the specification as primary and revise it from field use](principles/90-spec-is-the-source-of-truth.md): Specification defines correctness; tests derive from it; revise in the field
91. [Keep bedrock interfaces stable and absorb others' interfaces faithfully](principles/91-stable-and-faithful-compatibility.md): Stable core interfaces; emulate rivals faithfully without lock-in

## Documentation

92. [Store structure and meaning, and derive every presentation from it](principles/92-structure-over-presentation.md): Store meaning in a master; derive every rendering
93. [Validate structured input before transforming it](principles/93-validate-before-transform.md): Schema check first; located errors before transformation
94. [Publish known defects and limits plainly](principles/94-known-bugs-and-limits.md): State defects and limits plainly in the reference
95. [Write dense reference documentation for capable readers, and date perishable claims](principles/95-dense-reference-docs.md): Terse, complete, edited; date perishable claims
96. [Ship distinct documents for distinct reader jobs](principles/96-distinct-docs-for-distinct-jobs.md): Reference, tutorial, FAQ and roadmap serve different readers

## Project practice

97. [Release early, often and cheaply, and make the first release run](principles/97-release-early-and-often.md): Small routine releases; the first one must run
98. [Open the process and lower the insider barrier](principles/98-open-the-process.md): Public code and process; one contribution path for all
99. [Package a contribution as a minimal, current, explained delta](principles/99-contribution-packaging.md): Minimal current delta, docs, why-note, comments explaining intent
100. [Name and version releases so programs and people can read them](principles/100-name-and-version-for-readers.md): Parseable artifact names; version numbers signal compatibility
101. [Run every automated check you can before a release](principles/101-pre-release-checks.md): Run every automated check; publish strong checksums
