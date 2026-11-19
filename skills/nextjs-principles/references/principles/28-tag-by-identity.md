# Tag by data identity and invalidate by tag

**Rule:** Attach tags naming the underlying data to cached entries, give each read a time window plus tags, and invalidate by tag after the mutation that changes the data; use path invalidation only to refresh a rendered page.

**Why:** Invalidating one path leaves other pages reading the same data stale, because only entries tied to that path are touched. Path invalidation is built on implicit tags for the route and each ancestor layout, so one tag store serves both. Time covers unpredictable upstream change, tags make your own writes visible at once.

**Do:**
```
cache(lifetime = hours, tag = ["product", "product:" + id])
after write: invalidate(tag = "product:" + id)
```

**Don't:** Rely on path invalidation when the same data feeds a feed or sitemap, or use short TTLs in place of invalidation for data you control.

**Break it when:** One page owns the data completely; path invalidation is enough. Uncontrollable upstream: time only.

**Source:** https://nextjs.org/docs/app/api-reference/functions/revalidatePath, https://nextjs.org/docs/app/api-reference/functions/cacheTag, https://nextjs.org/docs/app/guides/how-revalidation-works; code: packages/next/src/lib/constants.ts, packages/next/src/server/lib/cache-handlers/types.ts
