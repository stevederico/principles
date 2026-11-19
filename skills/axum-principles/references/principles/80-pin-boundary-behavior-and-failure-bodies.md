# Pin boundary behavior, including failure bodies and known limits

**Rule:** Test the exact status and body of not-found, unknown-version, validation-failure and fallback paths, not only the success path, and when accepted behavior is not ideal, say so in a comment beside the test that pins it.

**Why:** The examples assert the empty 404 body, the per-field validation message, the 404 for an unknown version and the status of a single-page-app fallback. The routing tests carry comments such as "it would be nice if this returned 405" and "documenting current state, not intended behavior", so a later extractor knows the quirk is deliberate.

**Do:**
```
assert call("/does-not-exist").status == 404 and body == ""
// documents current behavior, not desired: wrong method returns 401 instead of 405
```

**Don't:** Assert only 200 paths, or pin a surprising result with no explanation.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/testing/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/validator/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/versioning/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (route_layer test comments).
