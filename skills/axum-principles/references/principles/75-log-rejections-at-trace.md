# Log automatic rejections at trace level under their own target

**Rule:** Emit a low-level log event for every automatic extractor rejection, with a stable target, the status, the body text and the rejection type, behind an opt-in switch, and enable that target when debugging.

**Why:** Rejections happen before handler code runs, so otherwise they are invisible. A test captures events for a missing attachment (500) and invalid text (400) and asserts the exact fields. Every example's default filter sets its own module to debug and leaves the rejection target for opt-in.

**Do:**
```
on reject(r): log(level = trace, target = "framework.rejection", {status, body, type_name(r)})
filter = env("LOG") or "my_app=debug,framework.rejection=trace"
```

**Don't:** Return 400 with no server-side trace of its cause, or log client mistakes at error level.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-core/src/macros.rs (__log_rejection); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (rejection logging test); https://github.com/tokio-rs/axum/blob/main/examples/tracing-aka-logging/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/CHANGELOG.md (tracing feature).
