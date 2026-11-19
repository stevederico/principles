# The router can be called as a request-to-response function

**Rule:** Treat the application as a function from one request to one response, so serverless platforms and in-process tests can call it without a long-running listener; keep the core free of a specific runtime and network features.

**Why:** The wasm example notes most serverless runtimes export a single function taking a request and returning a response, and calls the router from main, with routing, extractors and middleware still applying. The core was split so wasm builds only disable default features, and that example is kept compiling.

**Do:**
```
function handle(request) -> response: return router.call(request)
core dependency: default_features = false      # no runtime I/O for wasm
```

**Don't:** Assume a long-running listener exists.

**Break it when:** A server-only product that always needs the defaults (the example opts out of default features only for wasm).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/simple-router-wasm/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/simple-router-wasm/Cargo.toml; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (core split for wasm).
