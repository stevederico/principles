# Narrow every request to the moment the workflow breaks

**Rule:** Turn a requested feature into one concrete story of when the user's work failed, and design against that story; refuse projects that have no single problem.

**Why:** A request for "a calendar" became "see free days from home"; a request for complex permissions became a warning on one dangerous action, one day of work instead of six weeks. Projects named "redesign X" or "X 2.0" have no start, no end and no visible done, and go badly until split into small problems with their own budgets.

**Do:**
```
story   = ask("when did you last want this? what were you doing?")
problem = narrowest_statement_of_what_failed(story)
if no specific story: spend little time, walk away until one appears
if project_name matches "redesign | refactor X | 2.0": rewrite as "X is hard because <story>", split
```

**Don't:** Take the requested solution at face value, ask "what should it look like", or begin a large rewrite because enthusiasm is high.

**Break it when:** A structural refactor is driven by one documented failure and has a stated end condition.

**Source:** https://basecamp.com/shapeup/1.2-chapter-03 (Narrow down the problem, Watch out for grab-bags). Docs only.
