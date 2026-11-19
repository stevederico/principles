# Layer order and scope

**Rule:** Treat layer order as part of the contract: keep one explicit priority list for layers that depend on each other, attach layers at global, group and route scope (a route may opt out of group or route layers, never global ones), and keep browser and API routes in separate groups.

**Why:** Layers are attached from many places, so attach order cannot guarantee dependencies (URL defaults must run before model binding). Global layers carry safety rules. Groups give browser clients (cookies, session, forgery guard) and token clients (no session) the right defaults instead of per-route patches.

**Do:**
```
priority = [session, csrf, throttle, set_url_defaults, resolve_bindings, authenticate]
chain = stable_sort(chain, by position in priority)
global: [trust_proxy, trim_strings]    group web: [encrypt_cookies, session, csrf]    group api: [throttle]
route.without(csrf)                    # allowed
route.without(trim_strings)            # no effect, it is global
```

**Don't:** Relying on "I attached it first", or mixing cookie routes and token routes in one group and patching exceptions in.

**Break it when:** One or two layers with an obvious order. To drop a global layer, edit the global list so the exception is visible in review.

**Source:** https://laravel.com/docs/middleware, https://laravel.com/docs/urls, https://laravel.com/docs/structure ; code: src/Illuminate/Routing/SortedMiddleware.php, src/Illuminate/Foundation/Configuration/Middleware.php, src/Illuminate/Routing/Route.php
