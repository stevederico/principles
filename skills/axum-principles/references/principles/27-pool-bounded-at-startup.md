# Create the pool once at startup, bounded, and share it

**Rule:** Build the connection pool before the server starts, with a maximum size and an acquire timeout, hold it in state, and check out a connection per request.

**Why:** Every database example creates the pool before serving and passes it as state; the sqlx example sets a maximum and a short acquire timeout and stops if it cannot connect. A connection extractor is offered only for handlers that want one.

**Do:**
```
pool = Pool(max = 5, acquire_timeout = 3s).connect(url) or crash("cannot connect")
app.with_state(pool)
handler(State(pool)): conn = pool.get(); ...
```

**Don't:** Open a new connection per request or leave acquire unbounded.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/sqlx-postgres/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tokio-postgres/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/diesel-postgres/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tokio-redis/src/main.rs.
