# Reading a page never changes state

**Rule:** Allow reading request cookies and headers while rendering, but change cookies, data or cache entries only in mutation entry points invoked by POST, because response headers are fixed once streaming starts.

**Why:** Render may be repeated, prefetched, cached or run for crawlers, so side effects there cause surprise logouts and cross-site request bugs. The cookie jar is read-only in render and in cached scopes, and the framework throws on attempts.

**Do:**
```
render(): value = read_cookie("theme")
mutation(): set_cookie("theme", value)
```

**Don't:** Delete a cookie inside a view because a query parameter asked, or set a cookie from a component.

**Break it when:** Never for state; idempotent analytics counters that cannot fail the page are acceptable.

**Source:** https://nextjs.org/docs/app/guides/data-security, https://nextjs.org/docs/app/api-reference/functions/cookies; code: packages/next/src/server/web/spec-extension/adapters/request-cookies.ts, packages/next/src/server/request/cookies.ts
