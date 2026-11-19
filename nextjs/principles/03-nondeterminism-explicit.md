# Time, randomness and ids must be chosen, not frozen

**Rule:** Anything whose result differs per execution (current time, random numbers, generated ids) must either be deferred to request time, cached so all visitors share one value until refresh, or computed in the browser; never let it run silently during prerender.

**Why:** A value computed while building is frozen into the shared output for every visitor. The framework turns this into an error so the author must pick between per-request and shared, rather than shipping a stale timestamp or one visitor's random id.

**Do:**
```
mark_request_time()                         # per-request value
id = random_uuid()
-- or --
cached():
  stamp = now()                             # one shared value until refresh
# read static local files once at load, not on every render
```

**Don't:** Call the clock or a random source in a component that is prerendered and expect it to vary per visit.

**Break it when:** The value is only used to measure elapsed time for telemetry, where a monotonic timer is fine.

**Source:** https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/api-reference/functions/connection, https://nextjs.org/docs/app/guides/migrating-to-cache-components; code: packages/next/src/server/app-render/sync-io-messages.ts, packages/next/src/server/request/connection.ts
