# Test in-process first; keep a few tests on a real socket

**Rule:** Call the app directly as a request-to-response function for most tests, and keep a small number of tests that bind port 0, spawn the server and use a real client without redirects, for streaming and upgrades; write long-lived handlers over generic send and receive halves so channels can stand in for sockets when setup is heavy.

**Why:** In-process calls are fast and need no network; only real sockets cover streaming and websockets, and port 0 avoids collisions. The test helper uses a client with redirects disabled, and the HEAD tests bypass the client because it strips bodies from HEAD responses. The websocket example says integration tests are recommended unless setup is heavy.

**Do:**
```
resp = app.call(Request(GET, "/")); assert resp.status == 200
listener = bind("127.0.0.1:0"); spawn(serve(listener, app)); client.get(base + "/stream")
```

**Don't:** Hard-code a port in tests, test streaming only in-process, or let the test client follow redirects and assert on the transformed result.

**Break it when:** When setup makes real sockets hard, test the handler over channels (testing-websockets example).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/testing/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/testing-websockets/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/sse/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/test_helpers/test_client.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/get_to_head.rs.
