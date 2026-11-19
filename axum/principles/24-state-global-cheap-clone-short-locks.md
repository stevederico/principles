# Keep shared state global, cheap to clone and briefly locked

**Rule:** Keep application-wide state (pools, clients, config) in one value that is cloned per request, make that clone cheap, and guard mutation with a lock that is released before any wait or I/O.

**Why:** The docs say state is cloned for each request and recommend shared-ownership wrappers or all-cheap fields; the server clones the app per connection, and the changelog repeatedly removes needless clones. A blocking lock held across a suspension point makes the task non-transferable, so the lint table warns on it; the todos example copies the item out under a read lock, then takes a separate short write lock.

**Do:**
```
state = Shared(AppState { pool, config, counter: Lock(0) })
item = state.read().get(id).clone()      # guard dropped here
state.write().insert(id, updated)        # separate short critical section
```

**Don't:** Hold a lock while calling a database or the network, or put a large owned structure directly in state.

**Break it when:** Read-modify-write that must be atomic holds one write lock with no wait inside (key-value example).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/lib.rs ("Sharing state with handlers"); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/state.rs (shared mutable state); https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/with_state.md; https://github.com/tokio-rs/axum/blob/main/examples/todos/src/main.rs (update); https://github.com/tokio-rs/axum/blob/main/examples/key-value-store/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/Cargo.toml (lint table).
