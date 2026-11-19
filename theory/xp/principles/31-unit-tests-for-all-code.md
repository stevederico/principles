# Unit tests for all code, from day one

**Rule:** Give every class automated unit tests, release them with the code, create any missing test the moment you notice it, and start on day one.

**Why:** A deadline is the main resistance, yet an automated test can save a hundred times its cost; the harder a test is to write, the more it pays. A suite cannot be bolted on in the last three months because good suites take time to evolve and development drags without them. Tests also enable collective ownership, refactoring and frequent integration. On VCAPS the framework and first tests took two weeks, then the code took one week with no debugging, and production bugs later fell by a third.

**Do:**
```
new code or change: tests ship in the same commit
found a gap in coverage? write the test now
the suite is the single validation and regression suite
```

**Don't:** Putting unit tests off until the last months, or releasing untested code.

**Break it when:** Trivial getters and setters are usually left untested.

**Source:** http://www.extremeprogramming.org/rules/unittests.html, http://www.extremeprogramming.org/don.html, http://www.extremeprogramming.org/start.html
