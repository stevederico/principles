# Extreme Programming (XP)

Principles taken only from the official extremeprogramming.org site. Extreme Programming (XP) is, in the site's words, an agile process that stresses customer satisfaction and teamwork: it delivers the software the customer needs as it is needed, and lets developers respond to requirements that change late. It improves a project in five ways named as values (communication, simplicity, feedback, respect, courage) and works through a set of simple rules for planning, managing, designing, coding and testing. The site says the rules are not the goal; they set expectations that build a collaborative environment, and the team may change them to fit. It targets small teams (2 to 12 developers) with shifting requirements or high risk.

Coverage: all 77 pages of the site were read in full. Rule, story, value and lesson pages hold the principles; the five map pages are navigation stubs for the flow chart, and the coffee-maker example, links, books and author pages add only a few supporting details.

## Planning

1. [User stories in customer words](principles/01-user-stories-in-customer-words.md): Customer writes short business-language cards; detail comes face to face
2. [Estimate in ideal time](principles/02-estimate-in-ideal-time.md): Developers size stories 1 to 3 ideal weeks; split big, merge small
3. [Negotiate the release plan](principles/03-negotiate-the-release-plan.md): Developers estimate, customer prioritizes, all agree; never fudge estimates
4. [Four project variables](principles/04-four-variables.md): Scope, resources, time, quality: nobody controls all four
5. [Small frequent releases](principles/05-small-frequent-releases.md): Ship tested software every iteration; customer decides go-live
6. [Constant short iterations](principles/06-constant-iterations.md): About a dozen fixed-length iterations of one to three weeks
7. [Plan each iteration just in time](principles/07-just-in-time-iteration-plan.md): Break stories into tasks at iteration start; owners estimate their own
8. [Measure project velocity](principles/08-measure-velocity.md): Sum finished estimates; next iteration takes the same amount
9. [Hold the deadline, cut scope](principles/09-hold-the-deadline-cut-scope.md): If an iteration slips, re-plan and drop tasks; finish fewer things
10. [Re-plan instead of catching up](principles/10-replan-dont-catch-up.md): Plans are temporary; make a new one when reality changes
11. [Prioritize and prune](principles/11-prioritize-and-prune.md): Customer must rank stories; discard stories that lose value

## Design

12. [The simplest thing that could work](principles/12-simplest-thing.md): Do the simplest thing next; replace complex code now, not later
13. [Judge simplicity with TUBE](principles/13-tube-qualities.md): Testable, Understandable, Browsable, Explainable, decided by the team
14. [Once and only once, both halves](principles/14-once-and-only-once.md): Express every intention once; keep apart code with different intent
15. [Never add functionality early](principles/15-no-early-functionality.md): Build only what is scheduled today; ignore future needs
16. [Choose a system metaphor](principles/16-system-metaphor.md): Pick shared naming that explains the design to newcomers
17. [Design with CRC cards](principles/17-crc-cards.md): Whole team designs with index cards and simulates message flow
18. [Spike solutions](principles/18-spike-solutions.md): Throwaway program answers one risky technical question
19. [Refactor mercilessly](principles/19-refactor-mercilessly.md): Remove redundancy and obsolete design in small, test-guarded steps
20. [Fight software rot](principles/20-fight-software-rot.md): Keep change cheap: refactor, test, deliver early, never call design done
21. [Treat the database as easy to change](principles/21-database-easy-to-change.md): Migrate often using gold, silver and bronze copies and scripts

## Coding

22. [Coding standards](principles/22-coding-standards.md): Format all code to one agreed standard
23. [Pair-program all production code](principles/23-pair-programming.md): Two people at one computer write every line that ships
24. [Rules of thumb for pairing](principles/24-pair-rules-of-thumb.md): Never two novices, share the screen, everyone pairs, build trust
25. [Pair idioms](principles/25-pair-idioms.md): Named moves for honesty, deadlocks, pacing and attention
26. [Pairing replaces reviews and egos](principles/26-pairing-replaces-reviews.md): Replace formal reviews with pairing; take pride in everyone's code
27. [Collective ownership](principles/27-collective-ownership.md): Anyone changes any code; unit tests guard the whole base
28. [Integrate often](principles/28-integrate-often.md): Commit every few hours; never hold changes beyond a day
29. [One pair integrates at a time](principles/29-one-pair-integrates.md): Take turns releasing via a shared token or integration computer
30. [Move people around](principles/30-move-people-around.md): Rotate people across the code to avoid knowledge islands

## Testing

31. [Unit tests for all code, from day one](principles/31-unit-tests-for-all-code.md): Every class gets automated tests, released with the code, starting now
32. [Code the unit test first](principles/32-test-first.md): Failing test, simplest code to pass, next test, repeat
33. [All tests pass before release](principles/33-all-tests-pass-before-release.md): Release only at 100 percent; if red, debug or back out locally
34. [Own your test framework](principles/34-own-your-test-framework.md): Treat the test framework as a development tool; make it yours
35. [A bug gets a test first](principles/35-bug-gets-a-test.md): Acceptance test, then unit tests, then fix until both pass
36. [Acceptance tests from stories](principles/36-acceptance-tests.md): Customer-defined, automated, scored, and required before a story is done
37. [Test what could actually break](principles/37-test-what-could-break.md): Aim for the sweet spot between no tests and too many
38. [Break hard problems into testable pieces](principles/38-small-testable-pieces.md): Solve a simpler subproblem; rely on its passing test for the rest

## Team

39. [One team, equal partners](principles/39-one-team.md): Managers, customers and developers work as one self-organizing team
40. [The customer is always available](principles/40-customer-always-available.md): Assign a real expert customer to the team, on site
41. [Daily stand-up meeting](principles/41-stand-up-meeting.md): One short daily circle: yesterday, today, blockers
42. [Dedicated open work space](principles/42-open-work-space.md): Central shared desks, a stand-up area, whiteboards, posted charts
43. [Set a sustainable pace](principles/43-sustainable-pace.md): No overtime, no late staffing; change scope instead
44. [Fix XP when it breaks](principles/44-fix-xp-when-it-breaks.md): Follow the rules, then change them deliberately via retrospectives
45. [Start with the biggest problem](principles/45-start-with-the-biggest-problem.md): Adopt the practice that fixes your worst pain first
46. [When XP fits](principles/46-when-xp-fits.md): Changing requirements, risk, 2 to 12 developers, testable work

## Values

47. [Value: simplicity](principles/47-value-simplicity.md): Do what is needed and asked for, no more, in small steps
48. [Value: communication](principles/48-value-communication.md): Everyone on the team, face to face daily, from requirements to code
49. [Value: feedback](principles/49-value-feedback.md): Deliver working software each iteration, demo early, adapt the process
50. [Value: respect](principles/50-value-respect.md): Everyone is a valued contributor; experts respect each other
51. [Value: courage](principles/51-value-courage.md): Tell the truth about progress; adapt to change; no excuse documents
