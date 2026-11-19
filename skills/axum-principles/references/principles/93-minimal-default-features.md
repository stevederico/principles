# Keep default features minimal and heavy parts opt-in

**Rule:** Default to a small feature set, put rarely used or dependency-heavy parts behind explicit switches, document each switch in one table, and let each extra extractor or response be enabled on its own.

**Why:** The extras crate made the cached extractor, handler combinators, routing helpers and rejection wrapper opt-in, and multipart stopped being a default; only rejection tracing is on by default there. HTTP/2 dependencies are only pulled when enabled, and each example lists only the features it needs.

**Do:**
```
extras { feature cookie; feature cookie-signed; feature multipart; ... }
docs table: name | what it enables | default
```

**Don't:** Bundle every heavy dependency into the default build, or add switches that are not listed.

**Break it when:** A tiny dependency that nearly everyone needs.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/lib.rs (feature table); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/mod.rs (feature gates); https://github.com/tokio-rs/axum/blob/main/axum/src/lib.rs (feature flags); https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md (default features).
