# A failed response build must not be masked by an outer status

**Rule:** When serializing a body fails, return a 500 carrying a failure marker so an enclosing "set status to 201" wrapper cannot turn it into a success; offer an explicit force-status wrapper for the rare opposite wish.

**Why:** Handlers often return (201, body). Earlier, a serialization failure under that wrapper reported 201 with an error body. A test shows a non-serializable body under a teapot status returns 500 while the force wrapper returns 418; later parts skip their status and headers when the marker is present. The marker is deliberately not itself a response.

**Do:**
```
inner = serialize(body)
if inner.failed: response = 500 + failed_marker
status_wrapper: if not response.has(failed_marker): set status
```

**Don't:** Send a success status wrapped around an error payload.

**Break it when:** Use the explicit force-status variant when you want a fixed status even on failure.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/mod.rs (IntoResponseFailed, ForceStatusCode); https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/into_response.rs (status tuple); https://github.com/tokio-rs/axum/blob/main/axum/src/json.rs (serialization failure); https://github.com/tokio-rs/axum/blob/main/axum/src/response/mod.rs (tests).
