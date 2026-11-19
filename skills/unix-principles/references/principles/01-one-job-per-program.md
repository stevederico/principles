# Give each program one job and build a new one for a new job

**Rule:** Make every program do one thing you can state in a sentence; when a different job appears, write a second program and connect the two instead of adding a mode to the first.

**Why:** Each added mode enlarges the program, blurs its contract and puts at risk the other tools that depend on it. Narrow tools stay easy to test, replace and combine, and the cost of a new job stays proportional to the job.

**Do:**
```
if new_job.fits_in(existing_tool.one_sentence_purpose):
    extend(existing_tool)
else:
    tool_b = build(new_job)
    connect(existing_tool.output, tool_b.input)
```

**Don't:** Grow one binary with a switch per use case until nobody can say what it is for.

**Break it when:** The new job needs the old tool's private internal state, so splitting would mean exporting that state through an awkward interface.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Basics of the Unix Philosophy (the four-point summary of the approach)) ; http://www.catb.org/esr/writings/taoup/html/ch13s04.html (The Right Size of Software). Book only.
