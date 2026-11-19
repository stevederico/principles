# Build the app in a function that main and tests both call

**Rule:** Put route and middleware assembly in one function that returns the app object, and have both the entry point and every test call it.

**Why:** Tests can drive the app without starting a server, and the same wiring is exercised in production and in tests.

**Do:**
```
function build_app(deps) -> App: return App().route(...).layer(...)
main(): serve(listener, build_app(real_deps))
test(): response = build_app(fake_deps).call(request)
```

**Don't:** Assemble routes inline in main so the only test is a process on a fixed port.

**Break it when:** A one-route hello-world where there is nothing to test.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/testing/src/main.rs (app function); https://github.com/tokio-rs/axum/blob/main/examples/form/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/mongodb/src/main.rs.
