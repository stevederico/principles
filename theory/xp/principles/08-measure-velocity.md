# Measure project velocity

**Rule:** Add up the estimates of stories and tasks finished in each iteration and let the next iteration take on that same amount.

**Why:** The rule lets developers recover after a hard iteration and averages out estimating bias; teams that estimate high or low get the same steady pace. Velocity is about as detailed a measure as stays accurate. The first estimate of a project is a guess however much detail goes into it, so a couple of real iterations measure total size better than a long specification.

**Do:**
```
velocity = sum(estimate of stories finished this iteration)
next iteration: customer picks stories totaling velocity
early on: run a couple of iterations, measure, then estimate total scope
```

**Don't:** Dividing velocity by iteration length or headcount, or using it to compare two teams.

**Break it when:** A big change over more than one iteration calls for re-estimating through release planning; expect another shift when the system reaches production and maintenance starts.

**Source:** http://www.extremeprogramming.org/rules/velocity.html, http://www.extremeprogramming.org/rules/planninggame.html, http://www.extremeprogramming.org/rules/iterationplanning.html
