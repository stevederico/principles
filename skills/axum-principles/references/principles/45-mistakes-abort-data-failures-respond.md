# Programmer mistakes abort at build time; data-dependent failures respond

**Rule:** Fail loudly at build time for programmer mistakes (setting a once-only field twice, a newline in an id), and turn failures that depend on runtime data into an error value or a 500 response, never a panic.

**Why:** The event builder panics on repeated once-only fields while JSON data returns a result; a redirect with a newline in its target now becomes a 500 response instead of a panic, and invalid header values from data are validated rather than emitted. Request-time data must never crash a worker.

**Do:**
```
event.name("a").name("b")        -> abort("set twice")
event.json_data(obj)             -> Result
Redirect("bad\nvalue")           -> 500 response, no panic
```

**Don't:** Return a result for conditions only a code bug can cause, or panic on user data.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/response/sse.rs (Event builder panics, json_data); https://github.com/tokio-rs/axum/blob/main/axum/src/response/redirect.rs (invalid location is 500); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (redirect fix).
