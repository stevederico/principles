# Rewrite request paths outside the router

**Rule:** Middleware that changes the path used for routing must wrap the whole router from outside; router-level middleware runs after the route is chosen.

**Why:** Layers stored in a router wrap each endpoint, not the matcher, so a rewrite there cannot change which route matches. The router is itself a service, so a rewrite layer can be wrapped around it and then converted into the connection factory.

**Do:**
```
app = rewrite_path_layer(router)      # runs before matching
serve(listener, app.into_connection_factory())
```

**Don't:** Add a URI-rewriting layer through the router's own layer call and expect rerouting.

**Break it when:** A rewrite that only affects handler logic, not route selection, can stay inside (the docs section scopes the rule to routing).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/middleware.md ("Rewriting request URI in middleware"); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/layer.md ("Runs after routing"); https://github.com/tokio-rs/axum/blob/main/axum/src/service_ext.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/path_router.rs (layer).
