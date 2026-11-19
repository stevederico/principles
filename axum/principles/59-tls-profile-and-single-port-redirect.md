# Use a modern TLS profile and redirect the plain port

**Rule:** Use a vetted modern TLS profile with a minimum protocol version, verify the key matches the certificate, advertise both h2 and http/1.1, and let the plain-HTTP port do nothing but redirect permanently to the secure one, sharing the shutdown signal.

**Why:** Each low-level TLS example configures one of these: a minimum version, a modern profile with a key check, the protocol list. Both TLS examples spawn a redirect server, and the graceful variant hands it the same shutdown future.

**Do:**
```
tls = acceptor(profile = "modern", min_version = TLS1_2); tls.check_private_key()
tls.alpn = ["h2", "http/1.1"]
spawn(redirect_server(http_port, https_port, shutdown_future))
```

**Don't:** Accept legacy protocol versions by default, or serve content on the plain port.

**Break it when:** Terminating TLS at a load balancer removes the need for the redirect server in the app.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/low-level-rustls/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/low-level-openssl/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/low-level-native-tls/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tls-rustls/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/tls-graceful-shutdown/src/main.rs.
