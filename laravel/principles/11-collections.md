# Collections

**Rule:** Wrap lists in an object with chainable operations: map, filter, group, sum, sort, chunk, pluck.

**Why:** A chain of named steps shows the transformation in order. Loops with temp variables hide it.

**Do:**
```
orders
  .filter(paid)
  .groupBy(customer)
  .map(sum_total)
  .sortDesc()
  .first(5)
```

**Don't:** Build the same result with nested loops and mutable counters.

**Break it when:** Data is huge. Stream it lazily instead of loading everything.

**Source:** Laravel docs, collections.
