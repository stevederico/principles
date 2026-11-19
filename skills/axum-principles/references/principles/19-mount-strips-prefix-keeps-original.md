# Mounting a sub-app strips the prefix but keeps the original path

**Rule:** Give a mounted router paths relative to its mount point, remove the prefix segment by segment, record the original URI once, and keep outer captures readable through a whole-path extractor with an inner-only view.

**Why:** Prefix stripping compares whole segments (a capture segment matches any value), so "/api" never swallows "/apiary", and the query string is preserved. Wrapping middleware sees the full URI, mounted handlers see the stripped one, and the original is always kept for logs and redirects. Nesting at the root and wildcard nesting are refused, and a mount registers the prefix with and without a slash.

**Do:**
```
mount("/api/{tenant}", api_router)
inside api_router: path = "/users"; original = "/api/acme/users"; inner_params = {}
```

**Don't:** Use a plain startsWith check, nest at the root (merge instead), or let a sub-app hard-code its mount point.

**Break it when:** A sub-app that must see the full URI should use a wildcard route instead of a mount (nest.md, "Differences from wildcard routes").

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/nest.md ("How the URI changes", "Captures from outer routes"); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/strip_prefix.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/path_router.rs (nest); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/original_uri.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/inner_path.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/nest.rs.
