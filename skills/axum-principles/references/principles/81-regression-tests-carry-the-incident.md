# Name regression tests after the incident and say what broke

**Rule:** Name regression tests after the issue and explain in a comment what used to break, and add a test with every behavior change plus a runnable example with every public API; derive twin tests for APIs that must behave identically.

**Why:** Examples include a HEAD length regression, fallback tests for two numbered issues, CONNECT tests, and a test whose comment explains the old connection-cloning bug. The contributing guide requires tests for code changes and runnable doc examples, and a test attribute duplicates each nest test with a service-mount variant.

**Do:**
```
// regression: issue 1955 - CONNECT with authority-form target reached the matcher
test connect_goes_to_fallback()
test_both(fn): run body; also run body with mount_router replaced by mount_service
```

**Don't:** Merge a fix without a test that fails without it, or maintain duplicate tests by hand.

**Break it when:** Documentation-only changes need no test (CONTRIBUTING).

**Source:** https://github.com/tokio-rs/axum/blob/main/CONTRIBUTING.md ("Tests", "Documentation tests"); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/route.rs (regression test); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/fallback.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (CONNECT tests); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/axum_test.rs.
