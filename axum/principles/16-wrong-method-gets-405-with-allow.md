# A known path with the wrong method answers 405 plus Allow

**Rule:** When a path exists but not for the request method, answer 405 and list the registered methods in an Allow header, unless the fallback already set one or a catch-all method accepts everything.

**Why:** The code cites the rule that a 405 must carry Allow. Registering GET also advertises HEAD, the header merges across merged routers, and it is skipped for any-method routes. A user fallback that sets its own Allow wins because the header is only added when absent.

**Do:**
```
if no handler for method:
    resp = fallback(request)               # default 405
    if resp.status == 405 and no Allow: resp.Allow = join(registered_methods)
```

**Don't:** Return 405 without Allow, return 404 where 405 is correct, or overwrite a handler's own Allow.

**Break it when:** A catch-all registration that accepts every method has no Allow list to send.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/route.rs (Allow handling in RouteFuture); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/method_routing.rs (allow_header, tests); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/method_routing/fallback.md ("Setting the Allow header").
