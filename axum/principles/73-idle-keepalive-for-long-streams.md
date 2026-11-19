# Keep long streams alive with an idle timer reset by real events

**Rule:** For long-lived streams, emit a harmless comment frame after an idle interval, reset the timer on every real event, and stop when the source completes.

**Why:** Keep-alive is off by default; when enabled the interval defaults to 15 seconds with an empty comment, errors and completion pass straight through, and a raw event also resets the timer. Tests use a paused clock to check which frames arrive.

**Do:**
```
on poll: if source yields event: reset_timer; emit
         elif timer fires: emit keepalive_comment; reset_timer
         if source ended: end
```

**Don't:** Ping unconditionally, or keep pinging after the stream finished.

**Break it when:** Proxies in the path may need a shorter interval, which is configurable (sse.rs docs).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/response/sse.rs (KeepAlive, KeepAliveStream, tests).
