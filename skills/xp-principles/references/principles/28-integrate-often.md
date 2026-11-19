# Integrate often

**Rule:** Integrate and commit to the shared repository every few hours and never sit on changes for more than a day, always working from the latest version.

**Why:** Frequent integration prevents diverging work, avoids patching obsolete code, and spreads the pain thin: integrate now or pay more later, instead of weeks at the end while the deadline slips. A VCAPS team that skipped unit tests for a deadline built on obsolete versions and cost 32 developer hours; adapting the tests took one hour. With a single test suite, a failure after merging shows your version clashes with the team's.

**Do:**
```
at a reasonable break (tests 100% or a small slice done):
    merge with latest, run latest test suite
    pass -> commit; fail -> fix now (small problem)
never hold work over a day
```

**Don't:** Delaying integration because it is painful; the site says make it frequent so it gets fast and easy.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/integrateoften.html, http://www.extremeprogramming.org/rules/unittests.html, http://www.extremeprogramming.org/stories/unittests.html, http://www.extremeprogramming.org/rules/sequential.html
