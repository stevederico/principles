# Depend on the slice of state you need

**Rule:** Let handlers and reusable extractors request a sub-part of the application state through a small "derive from reference" conversion, and keep library extractors generic over the state type.

**Why:** Nested routers must share one state type, so projections are how each piece gets its part. A library extractor requires only that the user's state can produce the library's own state, so it works in any app. A derive can expose every field as a sub-state, with an opt-out for secrets and an error for generic structs.

**Do:**
```
extractor requires: LibState can be derived from S
user: implement derive(LibState from AppState)
handler(State(pool): State(Pool), State(client): State(Client))
```

**Don't:** Make a library extractor demand the application's concrete state type.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/state.rs (FromRef, substates); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/from_ref.rs; https://github.com/tokio-rs/axum/blob/main/axum-macros/src/from_ref.rs (skip attribute); https://github.com/tokio-rs/axum/blob/main/examples/sqlx-postgres/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs.
