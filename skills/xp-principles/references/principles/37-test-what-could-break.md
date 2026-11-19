# Test what could actually break

**Rule:** Aim for the sweet spot between no tests and exhaustive tests, which is close to testing everything that could actually break, and design code to be testable.

**Why:** Untested code does not save money; it moves the cost of finding bugs onto customers. Chasing 100 percent of all inputs makes cost rise exponentially. Testing and fixing at the end cannot raise quality, only reduce bugs. Designing for testability lowers the cost of testing, and XP requires that automated unit and functional tests be possible; the site says a design may need changing to get there.

**Do:**
```
skip tests for trivia that cannot break
test every branch where a defect could realistically live
if something is hard to test: change the design, do not skip the test
```

**Don't:** Postponing quality to a test-and-fix phase at the end.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/change.html, http://www.extremeprogramming.org/when.html, http://www.extremeprogramming.org/rules/unittests.html
