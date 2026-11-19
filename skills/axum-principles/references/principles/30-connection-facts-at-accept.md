# Derive connection facts at accept time and inject them as request data

**Rule:** Derive facts that belong to the connection (peer address, TLS info) when it is accepted, attach them to every request as typed data, and provide a test hook that fakes them.

**Why:** A per-connection step builds the info through a user-extensible conversion and wraps the app so each request carries it. The extractor returns 500 if the app was not served this way. A mock layer exists for in-process tests, and the real value wins if both are present, so tests never need a socket.

**Do:**
```
on_accept(conn): info = derive(conn); service = add_attachment(app, info)
test: app.layer(FixedPeerInfo("0.0.0.0:3000")).call(request)
```

**Don't:** Read the socket from inside handlers.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/routing/into_make_service_with_connect_info.md; https://github.com/tokio-rs/axum/blob/main/axum/src/extract/connect_info.rs (Connected, MockConnectInfo); https://github.com/tokio-rs/axum/blob/main/examples/testing/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/unix-domain-socket/src/main.rs.
