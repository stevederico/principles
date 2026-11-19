# Endpoints are one function per verb on web-standard types

**Rule:** Define each endpoint as one function per HTTP method on standard request and response objects, never beside a page at the same path, treat it as uncached unless you opt a safe GET in, let HEAD, OPTIONS and 405 be derived, and send no cross-origin headers unless a route asks for them.

**Why:** A page and an endpoint at one path both claim every verb. Non-GET methods are never cached, and a GET that reads request data or does uncached I/O is rendered per request while a deterministic GET is built ahead like a page. Hand-written protocol boilerplate drifts from the declared handlers; CORS preflight is the case that needs an explicit override.

**Do:**
```
route /api/items:
  GET():  return json(cached_list())          # built ahead only if deterministic
  POST(): authorize; validate; write; return 201
# HEAD from GET, OPTIONS lists methods, other verbs get 405
```

**Don't:** Mix a page and an endpoint at one path, cache a handler that reads request data, or set a wildcard origin globally.

**Break it when:** A deliberately public API needing explicit CORS handling in OPTIONS.

**Source:** https://nextjs.org/docs/app/getting-started/route-handlers, https://nextjs.org/docs/app/api-reference/file-conventions/route, https://nextjs.org/docs/pages/building-your-application/routing/api-routes; code: packages/next/src/server/route-modules/app-route/helpers/auto-implement-methods.ts, packages/next/src/server/route-modules/app-route/module.ts
