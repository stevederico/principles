# A local limit only protects extractors that honor it

**Rule:** Know the difference between a limit that only cooperating extractors apply and one that wraps the body before any extractor sees it; use the global one when custom or third-party extractors are involved.

**Why:** The docs explain that the default limit is local (it applies only to extractors that call the limiting helper), while a limit layer from the middleware library applies globally. The limit travels as request metadata set by a layer and looked up at read time, so per-route layering works without process-wide settings.

**Do:**
```
local:  extractor calls with_limited_body(request)
global: middleware wraps the body before routing
```

**Don't:** Assume the default protects a custom extractor that pulls frames from the stream itself.

**Break it when:** When you control every extractor, the local limit is enough (default_body_limit docs on the difference).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/default_body_limit.rs ("Difference between DefaultBodyLimit and RequestBodyLimit"); https://github.com/tokio-rs/axum/blob/main/axum-core/src/ext_traits/request.rs (with_limited_body); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md.
