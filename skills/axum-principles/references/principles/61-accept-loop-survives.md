# The accept loop never ends on transient errors

**Rule:** Accepting a connection must log and retry on error, never end the server: skip silently when the failure is the client's (refused, aborted, reset), otherwise log at error level and sleep a short fixed time, and hand each accepted connection to its own task.

**Why:** The code comment (from the HTTP library) explains file-handle exhaustion may clear once other connections close; the delay is fixed at one second. The serve future never returns an error. The TLS examples spawn a task per connection so a slow handshake cannot block accepting others, and log-and-return on a failed handshake.

**Do:**
```
loop: conn = accept(); on error e: if client_reset(e): continue; log_error(e); sleep(1s)
spawn(task: tls = handshake(socket) or { log; return }; serve_connection(tls, app.clone()))
```

**Don't:** Unwrap the accept result in a custom loop, busy-loop on exhaustion, or handshake inside the accept loop.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/listener.rs (Listener, accept error handling); https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (serve docs); https://github.com/tokio-rs/axum/blob/main/examples/low-level-rustls/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/serve-with-hyper/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (accept errors).
