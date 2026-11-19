# A cache failure is a miss, but only for transient errors

**Rule:** Treat timeouts, lost connections and deadlocks from the cache store as a miss or failed write and report them; let every other error surface. Spread large caches over nodes with a consistent hash.

**Why:** A cache outage must not take down the request, but catching everything hides programming errors. A consistent hash moves few keys when a node is added or removed; modulo by node count remaps almost everything.

**Do:**
```
try: value = cache.read(k)
on transient_error e: report(e, warning) ; value = nil          # others propagate
node = lookup_table[hash(key) mod table_size]                    # table built from node preferences
```

**Don't:** Catch all exceptions in the cache layer, or use hash modulo node count.

**Break it when:** The cache holds data you cannot recompute, or one database is enough.

**Source:** https://github.com/rails/solid_cache README.md (Cache configuration, Sharding the cache) ; code: lib/solid_cache/store/failsafe.rb, lib/solid_cache/maglev_hash.rb.
