# Guard only matched routes so unknown paths stay 404

**Rule:** Apply rejecting middleware (authorization) only to requests that matched a route, so unknown paths stay 404 and the guard does not run on the catch-all fallback.

**Why:** A guard on the whole router answers 401 before routing can say "not found". The route-scoped variant wraps only endpoints, leaves the fallback alone, and is rejected when added before any route. At single-path level a wrong method still gets 405; at router level a test comment records that it does not.

**Do:**
```
router.route("/a", ...).route("/b", ...).route_layer(require_token)    # unknown path -> 404
router.layer(counter)                                                   # sees 404s too
```

**Don't:** Put auth around everything so a missing page returns 401, or assume router-level route layers yield 405.

**Break it when:** Guard unknown paths too when you want unauthenticated clients to learn nothing about which paths exist (the other layer scope does exactly that).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/route_layer.md; https://github.com/tokio-rs/axum/blob/main/axum/src/docs/method_routing/route_layer.md; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (layer vs route_layer); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (route_layer tests); https://github.com/tokio-rs/axum/blob/main/examples/prometheus-metrics/src/main.rs.
