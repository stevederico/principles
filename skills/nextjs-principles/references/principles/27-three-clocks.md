# Freshness is three clocks, stated at every cache site

**Rule:** Give each cached value three independent durations (how long a client may reuse it unasked, how long before a background refresh, how long before it may not be served at all), keep refresh no later than expiry, state them at every cache site, and treat very short values as request-time work.

**Why:** One TTL cannot say "serve instantly but refresh quietly" and "never serve past this". The code rejects a refresh time greater than expiry (equal is accepted, although the docs say expiry must be longer; the code is the rule). Entries with near-zero refresh or short expiry are excluded from the prebuilt shell and from link prefetch, and a short inner entry nested in an outer scope with no stated lifetime fails the build.

**Do:**
```
cache(stale = 5m, revalidate = 1h, expire = 1d)
# expire < build/prefetch thresholds -> request-time, behind a fallback
# the shortest lifetime inside a route sets the route's cadence
```

**Don't:** Use one TTL for browser reuse and server refresh, set a one-second window hoping for "fresh but static", or hide the lifetime in a distant helper.

**Break it when:** A documented module-wide default is the team's explicit policy.

**Source:** https://nextjs.org/docs/app/api-reference/functions/cacheLife, https://nextjs.org/docs/app/getting-started/revalidating, https://nextjs.org/docs/app/api-reference/directives/use-cache; code: packages/next/src/server/use-cache/cache-life-profile.ts, packages/next/src/server/use-cache/constants.ts, packages/next/src/server/use-cache/use-cache-messages.ts
