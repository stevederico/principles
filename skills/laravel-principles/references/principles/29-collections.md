# Collections

**Rule:** Wrap lists in an object with chainable, non-mutating operations, and give the in-memory list and the lazy stream one shared contract.

**Why:** A chain of named steps shows the transformation in order. Every transform returns a new list, the few in-place operations are flagged, and the stream has no mutators. One contract means memory limits do not force a rewrite.

**Do:**
```
orders.filter(paid).group_by(customer).map(sum_total).sort_desc().take(5)
big_query.stream().filter(p).each(handle)           # one row in memory
last = 0                                            # changing rows while batching:
loop: rows = where(flag and id > last).order(id).limit(200); update(rows); last = max(rows.id)
```

**Don't:** Nested loops with mutable counters, or paging by offset while updating the column you filter on.

**Break it when:** Data is huge: stream it. Random access such as sorting is not cheap on a stream. Plain read-only batches can use offset.

**Source:** https://laravel.com/docs/collections, https://laravel.com/docs/eloquent, https://laravel.com/docs/queries ; code: src/Illuminate/Collections/Collection.php, src/Illuminate/Collections/LazyCollection.php, src/Illuminate/Database/Concerns/BuildsQueries.php
