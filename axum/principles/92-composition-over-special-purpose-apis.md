# Replace special-purpose APIs with composition

**Rule:** When a general building block can express a special-purpose feature, remove the special one and document the composition.

**Why:** The single-page-app router was removed in favour of a directory service plus a not-found service; the body-stream and raw-body extractors were removed because the body type already reads itself; resource nesting helpers were replaced by converting to a router; the content-length limiter was replaced by the default body limit.

**Do:**
```
before: SpaRouter(assets, dist).index_file(...)
after:  nest_service("/assets", ServeDir(dist).not_found_service(ServeFile(index)))
```

**Don't:** Keep adding one-off helpers that duplicate composition.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md (SpaRouter removal); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (extractor removals); https://github.com/tokio-rs/axum/blob/main/examples/static-file-server/src/main.rs.
