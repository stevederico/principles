# Shut down gracefully: stop accepting, drain in-flight work, bound the wait

**Rule:** Listen for both interrupt and termination signals, stop accepting and release the listener, let in-flight requests finish, wait until every connection task is done, and cap the wait with a deadline that matches the orchestrator's kill timeout.

**Why:** Each connection task holds a clone of a close receiver and the main loop waits until all are dropped. A test holds a request open, signals shutdown, sees the server still pending, releases the request and then sees a normal response. Idle connections close at once and stalled requests are cut by the header-read timeout. The examples add a request timeout so a never-ending request cannot hang the drain, and the TLS example notes the container runtime's ten seconds.

**Do:**
```
signal = first_of(ctrl_c, sigterm)
serve(listener, app).with_graceful_shutdown(signal)
app.layer(timeout(10s))
```

**Don't:** Handle only the interactive interrupt, so container stops become hard kills, or kill in-flight requests at the signal.

**Break it when:** Long-lived streams you close explicitly on the signal (graceful-shutdown example comments).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (graceful shutdown loop and tests); https://github.com/tokio-rs/axum/blob/main/examples/graceful-shutdown/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tls-graceful-shutdown/src/main.rs.
