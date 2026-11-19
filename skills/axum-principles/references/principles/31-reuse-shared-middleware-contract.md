# Reuse the ecosystem's middleware contract; pick the style by audience

**Rule:** Do not invent a framework-private middleware system; build on a small widely shared request-to-response service interface, and write simple function middleware for app-local use but full configurable layers for published packages.

**Why:** The README names this as the thing that sets the crate apart: timeouts, tracing, compression and auth come for free and can be shared with other frameworks. The docs list the styles by trade-off: function middleware (easy, framework-only), extractor-as-middleware, combinators for small tweaks, boxed-future services (configurable, publishable) and hand-written futures (lowest overhead).

**Do:**
```
app_local: middleware = function(request, next) -> response
published: middleware = Layer(config) wrapping Service(inner)
```

**Don't:** Publish a framework-only middleware as a library, or hand-roll low-level machinery for a one-off header tweak.

**Break it when:** Hand-written futures when the shared interface costs too much on a hot path (middleware.md lists it as the lowest-overhead style).

**Source:** https://github.com/tokio-rs/axum/blob/main/README.md ("High level features"); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/middleware.md ("Writing middleware"); https://github.com/tokio-rs/axum/blob/main/axum/src/lib.rs (overview).
