# Per-request data rides on the request; dependencies live in state

**Rule:** Put process-wide dependencies in typed state and put per-request values (current user, request id) into the request's attachment bag from middleware.

**Why:** State is global for the router and cannot hold per-request values. The attachment bag is the documented path from middleware to handler, but a missing entry is a runtime 500 caused by deployment, so typed state is preferred when the value does not vary per request. Version 0.6 introduced typed state because missing values fail at build time instead of runtime.

**Do:**
```
middleware auth: user = authenticate(req); req.attachments.insert(user); next(req)
handler(Attachment(User)): ...        # 500 if middleware is not installed
```

**Don't:** Smuggle per-request values into global state, or stash global dependencies in the untyped bag.

**Break it when:** The docs prefer typed state wherever the value does not vary per request.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/middleware.md ("Passing state from middleware to handlers"); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/with_state.md; https://github.com/tokio-rs/axum/blob/main/axum/src/extension.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.6 typed state).
