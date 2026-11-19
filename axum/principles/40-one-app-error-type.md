# Use one application error type that knows how to become a response

**Rule:** Have handlers return a result whose error is one application error type, define its conversion to a response once, and add conversions from library errors so early return works.

**Why:** The examples use a thin wrapper over a general error for small apps and a detailed enum where clients need distinct answers. A returned error is still a response, never a dropped connection. A result alias whose error is "anything response-convertible" lets one handler mix error kinds without a unifying enum.

**Do:**
```
enum AppError { BadInput(Rejection), Time(LibError) }
from(LibError) -> AppError.Time
AppError.to_response(): BadInput -> (400, json), Time -> (500, generic)
handler() -> Result(Json(User), AppError): ts = now(); ...
```

**Don't:** Map errors ad hoc inside each handler with different formats.

**Break it when:** A route group that needs a different error contract (HTML versus JSON) gets its own error type; the mixed-kind alias erases the type if you need to inspect it later.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/anyhow-error-response/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/error-handling/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs (AppError); https://github.com/tokio-rs/axum/blob/main/axum-core/src/response/mod.rs (ErrorResponse).
