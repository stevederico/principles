# Pick the cache tier and key cardinality on purpose

**Rule:** Use in-process memory for cheap local reuse, a shared remote store only when the upstream is slow, costly or rate-limited and keys repeat, and the browser for per-user results; cache on low-cardinality dimensions and filter the rest in memory.

**Why:** A remote lookup adds latency and cost and gives nothing for calls that are already fast, keys that are mostly unique, or data that changes every few seconds. Each distinct key value is a separate entry, so per-user or per-filter keys give a near-zero hit rate.

**Do:**
```
cache(key = category)                        # few values, larger shared result
results = in_memory_filter(result, price_range)
```

**Don't:** Wrap every data call in a distributed cache, or cache by user id or free-form filter and wonder why the upstream still takes every hit.

**Break it when:** Instances are short-lived and local memory is never reused, so only a shared store yields hits; or the filter changes what must be fetched upstream.

**Source:** https://nextjs.org/docs/app/api-reference/directives/use-cache-remote, https://nextjs.org/docs/app/getting-started/caching; docs only
