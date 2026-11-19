# Put timeout, concurrency cap and shedding in front of handlers

**Rule:** Place a request timeout, a cap on concurrent requests and overload shedding in front of the handlers, and keep any readiness-sensitive limiter around the whole app so excess load is dropped quickly.

**Why:** The examples map an elapsed timeout to 408 and shedding to 503. Routing needs the request before it can pick a service, so readiness cannot be checked up front; the docs say to avoid readiness-sensitive services inside the router or shed load outside it. Long-lived streaming routes are scoped away from the timeout.

**Do:**
```
stack = [handle_error, load_shed, concurrency_limit(1024), timeout(10s)]
```

**Don't:** Leave slow clients and runaway handlers unbounded, or queue unbounded work behind a slow inner service.

**Break it when:** Long-lived streams (SSE, websockets) must outlive the timeout, so scope the timeout away from them (key-value example scopes limits per route).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/middleware.md ("Routing to services/middleware and backpressure"); https://github.com/tokio-rs/axum/blob/main/examples/key-value-store/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/todos/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/handler/service.rs (always ready).
