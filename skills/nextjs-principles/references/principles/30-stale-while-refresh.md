# Serve stale, refresh in the background, keep the last good copy

**Rule:** Serve the cached copy immediately, regenerate after the lifetime ends only when a request arrives, swap the entry only if regeneration succeeds, and keep serving the last good copy if it throws; pick long windows plus precise invalidation over short polling windows.

**Why:** Users never wait on regeneration and a failing upstream degrades to old content. Invalidation only marks entries stale, so nothing is rebuilt for pages nobody visits; short windows burn compute. A cache status header (hit, stale, miss) makes the state visible, and a loader must still be able to say "gone" for a page that was built earlier.

**Do:**
```
cache(lifetime = hours, tag = "cms")
on cms_change_webhook: invalidate(tag = "cms")
regeneration throws -> keep last good, retry next request
```

**Don't:** Cache an error page by returning a failure value instead of throwing, or set a one-second lifetime to fake real time.

**Break it when:** Content must be real-time or per user; render it dynamically.

**Source:** https://nextjs.org/docs/app/guides/incremental-static-regeneration, https://nextjs.org/docs/app/guides/how-revalidation-works, https://nextjs.org/docs/app/getting-started/revalidating, https://nextjs.org/docs/pages/api-reference/functions/get-static-props; code: packages/next/src/server/next-server.ts, packages/next/src/server/route-modules/pages/pages-handler.ts
