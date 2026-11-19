# Do the right thing when it is clear; otherwise do the minimum

**Rule:** When the correct approach is evident, take it even if it costs more now; when it is not, do only what the task needs until you learn more.

**Why:** The right design is cheapest over time, while guessing adds complexity you later undo. The minimum keeps options open and the code small.

**Do:**
```
if right_design_is_known:  implement(right_design)
else:                      make_minimal_change(); revisit(after_learning)
if problem_already_solved_elsewhere: reuse(solution)
```

**Don't:** Rush into code without thinking, or redo a solved problem out of pride.

**Break it when:** A deadline forces a stopgap; record it as debt with an owner.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s09.html (Attitude Matters Too). Book only.
