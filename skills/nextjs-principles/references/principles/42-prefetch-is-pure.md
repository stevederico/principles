# Prefetch and render must never change state

**Rule:** Keep rendering code free of side effects (analytics, writes, counters, cookie changes) and never put a state change behind a GET link that can be prefetched; run effects from client code or from explicit POST mutations.

**Why:** Routes are rendered at prefetch time, before the user visits, and rendering may be repeated, cached or run for bots. A logout or mode-toggle link with default prefetch would run without a click, and cookies cannot be set once streaming starts, so the framework enforces read-only cookies in render.

**Do:**
```
render():            read cookie, no writes
logout:              POST mutation, or link(prefetch = off)
page view tracking:  client effect after mount
```

**Don't:** Call track() in a server render, delete a cookie because a query parameter says so, or link to a toggle endpoint with default prefetching.

**Break it when:** Idempotent, non-critical logging.

**Source:** https://nextjs.org/docs/app/guides/prefetching, https://nextjs.org/docs/app/guides/data-security, https://nextjs.org/docs/app/api-reference/functions/cookies, https://nextjs.org/docs/app/api-reference/functions/draft-mode; code: packages/next/src/server/web/spec-extension/adapters/request-cookies.ts, packages/next/src/server/request/cookies.ts
