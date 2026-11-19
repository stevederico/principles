# Many instances need a shared, synced, failure-tolerant cache

**Rule:** With more than one instance, replace the per-instance cache with a shared store that is size-bounded, serializes binary and map values, indexes entries by tag, records each tag's invalidation time, and loads recent invalidations once per request before the first read; failures there must degrade to extra renders or stale data.

**Why:** By default an invalidation reaches only the instance that received it, so users see different content per instance. The framework compares timestamps; the store owns eviction. A read error that is thrown becomes a render error, so reads must catch and return a miss, and a failed write only loses the entry. Turn off each instance's private memory copy when a shared store exists.

**Do:**
```
store.get(key): try read, bytes -> entry; on any error return MISS
per request: refresh_tags(since = last_sync)    # once, before first read
entry stale when tag_invalidated_at > entry.created_at
```

**Don't:** Keep the one-shot stream you were handed, store values with JSON that loses binary members, delete entries on one instance only, or let a cache outage become a 500.

**Break it when:** One instance with persistent disk; or data correctness is regulatory and you fail closed with alerts.

**Source:** https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/guides/how-revalidation-works, https://nextjs.org/docs/app/api-reference/config/next-config-js/cacheHandlers, https://nextjs.org/docs/app/api-reference/config/next-config-js/cacheMaxMemorySize; code: packages/next/src/server/lib/cache-handlers/default.ts, packages/next/src/server/lib/cache-handlers/types.ts, packages/next/src/server/use-cache/use-cache-wrapper.ts
