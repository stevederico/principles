# Acceptance tests from stories

**Rule:** Turn each story into automated black-box acceptance tests that the customer specifies, run them often, publish the score, and count a story done only when its tests pass.

**Why:** A story can have one or many tests. The team schedules time each iteration to fix failures, and new tests must appear every iteration or reported progress is zero. QA, separate or inside the team, works closely with development. On VCAPS a year of adding tests (about 40 percent coverage) halved trouble tickets and nearly ended emergency re-releases, giving customers a feeling of stability. The team, not the customer, proves the code works.

**Do:**
```
per story: customer lists scenarios; automate each as black-box test
run often; publish the score to the team
before release: run as regression; customer reviews the score, chooses go or stop
add tests for new and for changed old functionality
```

**Don't:** Counting a story as finished without passing its acceptance tests.

**Break it when:** A near-release failure may still ship if the customer reviews the score and allows it.

**Source:** http://www.extremeprogramming.org/rules/functionaltests.html, http://www.extremeprogramming.org/stories/functionaltests.html, http://www.extremeprogramming.org/rules/customer.html, http://www.extremeprogramming.org/introduction.html, http://www.extremeprogramming.org/lessons.html
