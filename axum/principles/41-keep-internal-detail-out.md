# Log the real cause; send a generic message

**Rule:** Answer server-side failures with a generic message and log the real cause on the server; never format an internal error into the client body.

**Why:** The error-handling example tells you not to expose error details to the client, OAuth returns a generic body while logging the chain, a changelog fix stopped leaking internal type names in a query rejection, and the extras crate ships a one-line wrapper that logs at error level and returns a fixed 500 text.

**Do:**
```
on err: log.error(err)
respond(500, "An error occurred while processing your request.")
```

**Don't:** Return the text of a database or library error as the 500 body.

**Break it when:** A user-input error with a safe message gets a specific status instead (the wrapper is for unexpected failures).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/error-handling/src/main.rs (AppError); https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/response/error_response.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.5.15, query rejection).
