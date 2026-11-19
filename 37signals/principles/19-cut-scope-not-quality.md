# Cut scope, never quality, and compare to today's baseline

**Rule:** Hold the quality bar constant and let scope vary. Mark discovered nice-to-haves so they are cut first, and ship when the result is better than what users have today, not when it is ideal.

**Why:** Scope grows as people discover detail; that is nobody's fault. Choosing which cases to cover makes a product better at some things instead of mediocre at all. Comparing against the current workaround turns "is it perfect" into "is it more valuable", and lets the team make calls that were stalling it.

**Do:**
```
quality_bar = constant ; scope = variable
new item: must-have? can we ship without it? new problem or already lived with? who sees it?
if not clearly yes: mark "~" and drop at the deadline
ship if new_behavior beats current_workaround for the core case
```

**Don't:** Ship a slower or buggier version to hit the date, or hold a release over a choice between two designs while users live with something worse.

**Break it when:** The item concerns correctness, security or data loss, or the change would regress a core flow below today's baseline.

**Source:** https://basecamp.com/shapeup/3.3-chapter-12 (Mark nice-to-haves with ~) ; https://basecamp.com/shapeup/3.5-chapter-14. Docs only.
