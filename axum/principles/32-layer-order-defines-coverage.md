# Layer order decides what is covered and who runs first

**Rule:** Attach middleware after the routes it must cover, at the narrowest scope that fits (router, one path, one handler), and treat repeated layering as wrapping: the last layer added is outermost. Prefer one composed list in execution order.

**Why:** A router layer wraps the endpoints present when it is applied, plus the fallback; later routes are not covered, and a test shows a timeout added between two routes covering only the first. Separate layer calls read backwards, while the composed builder runs top to bottom. Error handling goes outside any layer that can fail, and tracing outermost so inner logs inherit its span.

**Do:**
```
router = Router().route(a).route(b).layer(trace)    # covers a, b
router = router.route(c)                            # c is NOT traced
stack = compose([tracing, auth, rate_limit])        # request visits in this order
```

**Don't:** Add middleware first and assume later routes inherit it, or reason about order from memory across many calls.

**Break it when:** Group the routes you want covered into separate routers merged afterwards, each with its own layers (layer.md).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/layer.md; https://github.com/tokio-rs/axum/blob/main/axum/src/docs/middleware.md ("Ordering"); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (layer maps existing endpoints); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (layer scope test); https://github.com/tokio-rs/axum/blob/main/examples/error-handling/src/main.rs.
