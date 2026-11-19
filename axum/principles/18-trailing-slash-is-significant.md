# Treat /foo and /foo/ as different routes

**Rule:** Do not guess that /foo and /foo/ are the same resource: the unregistered form is a 404 unless you register both or opt into an explicit permanent redirect for one route.

**Why:** Version 0.6 removed automatic slash redirects. Tests pin 404 for the other form and separate handlers when both exist. The opt-in helper registers a second explicit route that redirects permanently, keeps the query string and the original method filter, refuses the root path, and collides loudly if the second form is also registered.

**Do:**
```
route("/foo", h)                       # GET /foo/ -> 404
route_with_slash_redirect("/foo", get(h))    # opt in: /foo/ -> 308 /foo
```

**Don't:** Rely on a hidden redirect that clients and caches treat as a new URL, or serve one page at two addresses.

**Break it when:** Legacy URLs that must keep working use the explicit redirect helper.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (trailing slash tests); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.6, removed automatic redirects); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/routing/mod.rs (route_with_tsr).
