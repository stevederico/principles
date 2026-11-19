# Prove backing services and apply migrations before accepting traffic

**Rule:** Before binding the listener, ping the database or cache, apply pending schema migrations, and fail the start if either fails; ship migrations inside the binary as ordered up and down pairs.

**Why:** The examples ping MongoDB, do a write-and-read check on Redis, stop on a failed sqlx connect, and run migrations at boot. Each migration directory pairs an up script with a down script and is embedded at build time.

**Do:**
```
db.ping() or crash
run_pending_migrations(embedded_migrations)
listener = bind(addr); serve(listener, app)
```

**Don't:** Discover a down database on the first user request, or rely on someone running SQL by hand before deployment.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/mongodb/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tokio-redis/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/diesel-postgres/src/main.rs (embedded migrations); https://github.com/tokio-rs/axum/tree/main/examples/diesel-postgres/migrations/.
