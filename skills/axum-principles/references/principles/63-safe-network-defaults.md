# Ship safe network defaults and few knobs

**Rule:** The convenience server sets low-latency TCP and a header-read timeout by default, exposes few settings, and points users to the lower-level library when they need more.

**Why:** The docs say only the executor and connection lifetime are tunable. A timer is installed so the HTTP/1 header-read timeout is actually enabled (a test shows a stalled request line closed at 30 seconds), and no-delay is set on accepted TCP sockets with a hook to undo it. Chunk reads of file bodies were raised from 4 KiB to 64 KiB for throughput.

**Do:**
```
conn.set_no_delay(true)
http1.header_read_timeout = default      # requires a timer to take effect
```

**Don't:** Leave slow-client defences off because no timer was configured.

**Break it when:** Use the lower-level API when you need tunable timeouts (serve docs).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (docs, header-read timeout test); https://github.com/tokio-rs/axum/blob/main/axum/src/serve/listener.rs (set_nodelay); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (no-delay, 64 KiB chunks).
