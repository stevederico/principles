# Cache only what is marked, at the narrowest unit

**Rule:** Treat every data read as per-request unless the author explicitly marks the specific function or component as cacheable, and place the mark on the data function rather than the whole page unless the whole output is one shared artifact.

**Why:** Correctness comes first: stale user data from an invisible default leaks silently. A mark on a function caches only that function's result (a page-level mark widens what goes stale together), and route-wide switches changed the default for every read in the route. In the code a read with no cache setting runs uncached at request time; the only implicit caching is during build-time prerender so export workers can share results.

**Do:**
```
get_products():
  cache(lifetime = hours, tag = "products")
  return db.query(...)
page(): products = get_products()           # page itself stays uncached
```

**Don't:** Cache everything and hunt for the reads that must be fresh, put a cache mark on a request handler export, or keep both a global switch and local marks.

**Break it when:** Content is fully static and known at build; static-by-default is cheaper there.

**Source:** https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/api-reference/config/next-config-js/cacheComponents, https://nextjs.org/docs/app/guides/migrating-to-cache-components, https://nextjs.org/docs/app/api-reference/directives/use-cache; code: packages/next/src/server/lib/patch-fetch.ts
