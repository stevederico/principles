# Assert on structured logs as data

**Rule:** Capture log events in memory as JSON under a target filter and compare whole event values in tests, rejecting unknown fields so adding one forces a deliberate test change.

**Why:** The tracing helper installs a scoped subscriber that writes JSON lines to a buffer, parsed into a typed event with unknown fields denied.

**Do:**
```
events = capture_logs(filter = "app.rejection=trace", run)
assert events == [ {fields: {status: 500}, target: "app.rejection", level: "TRACE"} ]
```

**Don't:** Grep rendered log text.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/test_helpers/tracing_helpers.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (rejection logging test).
