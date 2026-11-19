# Ask for the headers you need; never consume shared metadata

**Rule:** Read request headers through a typed extractor for each header you need, and make header and attachment extractors copy or borrow rather than remove, so later extractors still see them.

**Why:** The whole-map extractor clones every header, and its docs point to the typed alternative. An earlier version removed the headers from the request, which broke later extractors; it was changed to clone, and the raw attachments map stopped being an extractor at all so it cannot be emptied by accident. A typed extractor also separates "missing" from "present but unparsable".

**Do:**
```
ua = typed_header(UserAgent)         # error names the header and reason
maybe_cookie = optional(typed_header(Cookie))
```

**Don't:** Clone the whole header map for one field, or move the header map out of the request.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/request_parts.rs (HeaderMap extractor doc); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (header map extractor now clones); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/typed_header.rs (TypedHeader, TypedHeaderRejection).
