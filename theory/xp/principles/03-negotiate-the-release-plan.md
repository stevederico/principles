# Negotiate the release plan

**Rule:** Create the release plan in one meeting where developers estimate, the customer orders by value, and everyone negotiates until all agree; never edit estimates to make the plan fit.

**Why:** Technical people make technical decisions and business people make business decisions, and the meeting rules let each side decide its own part. The estimates stay valid and are reused in iteration planning, so shaving them now only causes trouble later. The plan aims at a usable, testable system that makes business sense and arrives early.

**Do:**
```
developers: estimate each story (ideal weeks)
customer:   put most important stories first
together:   move cards on a table to form the next release
if management dislikes the plan:
    change scope or date and renegotiate
    do NOT touch the estimates
done when developers, customers and managers all agree
```

**Don't:** Lowering story estimates because management dislikes the resulting plan.

**Break it when:** Re-estimate and renegotiate the whole plan when velocity changes sharply for more than one iteration, and expect it every three to five iterations. Otherwise the estimates stand.

**Source:** http://www.extremeprogramming.org/rules/planninggame.html, http://www.extremeprogramming.org/rules/commit.html, http://www.extremeprogramming.org/rules/iterationplanning.html
