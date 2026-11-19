# Use the database you already run before adding a service

**Rule:** Prefer your relational database for queue, cache and pub/sub when measured latency is acceptable, keep those ephemeral tables in a database separate from the system of record, and list what you deliberately skip so nobody adds it back by habit.

**Why:** It removes an infrastructure dependency. Separate databases suit different churn and durability, and sharing makes cache or enqueue writes join the caller's transaction, a coupling that silently changes if you later move them. Polling a table was measured slower than a broker at small intervals but acceptable, with no 8 KB payload limit. Both apps skip bundlers, search services, counter callbacks and tenant columns on purpose.

**Do:**
```
queue_db, cache_db, cable_db = separate connections from primary_db
poll every 100 ms by default ; lower the interval for lower latency (more load)
no bundler (import map) ; no search service (FTS in file) ; no tenant columns
```

**Don't:** Add a broker "just in case", or assume a cache write is independent of the caller's transaction when the connection is shared.

**Break it when:** A tight latency target at large connection counts (the broker stays flatter), or small apps where one database file is simpler.

**Source:** https://github.com/rails/solid_cable README.md (Benchmarks) ; https://github.com/rails/solid_cache README.md (Connection configuration) ; https://github.com/rails/solid_queue README.md (Single database configuration) ; https://github.com/basecamp/once-campfire config/importmap.rb, app/models/message/searchable.rb.
