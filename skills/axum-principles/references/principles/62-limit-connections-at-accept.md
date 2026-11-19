# Bound connections at accept time, not only requests in flight

**Rule:** Cap concurrent connections by acquiring a permit before accepting and holding it inside the connection until it drops; define the listener as a small interface so caps and tuning are wrappers.

**Why:** The doc contrasts this with a request concurrency limiter, which does not limit connections that are idle or still sending headers. A paused-clock test shows the second accept blocks until the first connection is dropped and never reaches the underlying accept. Listeners compose (TCP, Unix, connection cap, per-connection tuning), and tests use an in-memory stream as a listener.

**Do:**
```
accept(): permit = semaphore.acquire(); conn = inner.accept(); return Conn(conn, permit)
listener = TcpListener(addr).limit_connections(1000).tap_io(set_no_delay)
```

**Don't:** Rely on a per-request limiter for connection exhaustion.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/listener.rs (limit_connections, tap_io, ListenerExt); https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (tests).
