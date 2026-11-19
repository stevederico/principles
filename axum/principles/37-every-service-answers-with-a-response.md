# Errors become responses before they reach the transport

**Rule:** Make the contract total: no component may leak a raw error to the transport. Handlers return responses even for failures, and any fallible layer (timeout, load shedding) is paired with a converter placed outside it.

**Why:** An error reaching the connection layer ends the connection without a reply. So every service's error type is "never", a returned error value is just another response, and a router layer is accepted only if its error is convertible to never. The docs say to return responses from middleware and convert third-party errors; converters can run metadata extractors first and receive the error last. A converter below the raising layer never sees its errors.

**Do:**
```
stack = [convert_errors_to_response, timeout(30s), app]    # converter is outer
convert(err): match err { Elapsed -> (408, "timed out"), Overloaded -> (503, "busy"), _ -> (500, "error") }
```

**Don't:** Let a timeout error bubble to the server loop, or put the converter below the layer that raises.

**Break it when:** When the transport itself failed (reset connection) nothing can be sent.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/error_handling.md ("axum's error handling model", "Applying fallible middleware"); https://github.com/tokio-rs/axum/blob/main/axum/src/error_handling/mod.rs (HandleError, HandleErrorLayer); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/mod.rs (layer bound); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/handle_error.rs; https://github.com/tokio-rs/axum/blob/main/examples/key-value-store/src/main.rs.
