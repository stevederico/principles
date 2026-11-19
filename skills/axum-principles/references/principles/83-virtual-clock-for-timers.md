# Test time-dependent behavior with a virtual clock

**Rule:** Test timers (keep-alive, connection caps, lifetimes) with a virtual clock that you advance, not with real sleeps.

**Why:** The tests start the clock paused and step in one-second increments to assert exactly which frames arrive and when a blocked accept resumes.

**Do:**
```
clock.pause(); advance(1s); assert next_frame == keepalive
```

**Don't:** Real sleeps, which are slow and flaky.

**Break it when:** Testing against real network timeouts.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/response/sse.rs (keep-alive tests); https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (connection limit and lifetime tests).
