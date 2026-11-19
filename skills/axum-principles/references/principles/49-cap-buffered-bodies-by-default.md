# Cap every buffered body by default

**Rule:** Put a conservative default size limit on every extractor that buffers a body in memory, count streamed bodies as they arrive, and make raising or removing the limit an explicit, scoped act.

**Why:** Without a cap a hostile peer can send a huge or endless body and exhaust memory; the fix shipped as a 2 MB default on every maintained line. Bytes, string, JSON, form, multipart and line-delimited extractors share one buffering path, so they all inherit it, and tests show 413 on an endless stream without a length header. Upload routes disable the default and add an explicit larger ceiling instead of going unlimited, and the standalone helper takes a mandatory limit.

**Do:**
```
limit = request.limit_override or DEFAULT_2MB
body = read_with_limit(request.body, limit)      # on limit hit: 413, generic text
upload_route.layer(disable_default_limit).layer(request_body_limit(250MB))
```

**Don't:** Read bodies with no ceiling, or switch the limit off with no replacement.

**Break it when:** Upload routes raise the limit for that route only, or stream instead of buffering (multipart and key-value examples).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md ("Request body limits"); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/default_body_limit.rs; https://github.com/tokio-rs/axum/blob/main/axum-core/src/ext_traits/request.rs (DEFAULT_LIMIT, with_limited_body); https://github.com/tokio-rs/axum/blob/main/axum/src/body/mod.rs (to_bytes); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (limit tests); https://github.com/tokio-rs/axum/blob/main/examples/multipart-form/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.5.16 limit).
