# Queue and retry on real connectivity loss

**Rule:** Treat a network failure (not an intentional abort and not a timeout) as offline, keep the request pending, poll a tiny probe with capped stepped backoff, retry each queued action once after recovery, and expose an offline flag to the UI instead of trusting the OS online flag alone.

**Why:** The OS flag reports online for a device with a link but no upstream. Telling abort and timeout apart avoids marking a slow server offline, and capped steps avoid both hammering and long waits. A pending request looks like a slow server, so the UI should say what is happening.

**Do:**
```
on network_failure (not abort, not timeout):
  offline = true; wait while probe(timeout = short, treat_timeout_as_success) fails, backing off 0.5s,1s,2s,3s
  retry queued action once; offline = false
```

**Don't:** Throw to the user on the first network error with hand-written retry in every form, or flush every queued prefetch at once.

**Break it when:** Non-idempotent requests where blind retry risks duplicates (use an idempotency key), or full-page offline loads (need a service worker).

**Source:** https://nextjs.org/docs/app/guides/offline-support, https://nextjs.org/docs/app/api-reference/config/next-config-js/useOffline; code: packages/next/src/client/components/offline.ts
