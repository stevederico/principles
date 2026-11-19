# Keep a small stable core and push volatile pieces into extras

**Rule:** Put the interfaces that third parties implement (request reading, response conversion, body, error) in a small slow-changing core package that integrators depend on, and keep opinionated or heavy extractors and responses in a separate extras package.

**Why:** The docs tell library authors to depend on the core because it is less likely to break; the main crate re-exports it so applications see one surface. Header extractors and host extractors moved out of the main crate into extras, and deprecated ones were removed there. The core also forbids unsafe code and has its own version track.

**Do:**
```
core:   { FromRequest, FromRequestParts, IntoResponse }      # stable
extras: { typed headers, cookies, multipart, protobuf }       # opt-in features
```

**Don't:** Make every extension library depend on the whole framework's release cadence.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/lib.rs ("Required dependencies", core note); https://github.com/tokio-rs/axum/blob/main/axum-core/src/lib.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (extractors moved to extras); https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md.
