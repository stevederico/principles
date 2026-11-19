# Compose a response from ordered parts

**Rule:** Build a response by listing pieces in order: optional status, then header and attachment parts, then the body last; parts may touch only headers and attachments, and an explicit status outranks part defaults. Wrappers set the content type for you.

**Why:** The docs say this prevents a part from accidentally overriding status or body. A redirect part sets a default status, but an explicit status in the list wins (tests pin it). Wrappers for HTML and event streams set their own content type, and setting a header replaces by default, with a distinct "append" wrapper for repeatable headers such as cookies.

**Do:**
```
return (201, [header("x-id", id)], Html(markup))
return (append_headers([("set-cookie", a), ("set-cookie", b)]), body)
```

**Don't:** Hand-build raw response objects in every handler, or use replace semantics for set-cookie.

**Break it when:** Full wire-level control: return the low-level response type (response.md).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/response.md ("Building responses"); https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/into_response.rs (tuple impls); https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/into_response_parts.rs; https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/append_headers.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/response/mod.rs (Html, tests); https://github.com/tokio-rs/axum/blob/main/axum/src/response/redirect.rs (explicit status test).
