# Never add functionality early

**Rule:** Build only what is scheduled for the current iteration and ignore guesses about future needs and extra flexibility.

**Why:** The site claims only about 10 percent of such extras ever get used, so most of that effort is wasted, and extra flexibility always makes a design more complex and slows you down. Readiness for change comes from a simple design, not from speculation. In the coffee-maker example the customer ruled out a cancel-brew button as costing money with no market value, and the team put off switch debouncing, saying it can be added if needed.

**Do:**
```
pick next task from this iteration's cards only
if you think "we will need X later": do not build X
add flexibility when a scheduled story needs it, not before
```

**Don't:** Adding something because you see exactly how, or because it would make the system better.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/early.html, http://www.extremeprogramming.org/rules/simple.html, http://www.extremeprogramming.org/example/coffeestories.html, http://www.extremeprogramming.org/example/hardwaredesign2.html
