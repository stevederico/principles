# Wrap built-in extractors once so every input error shares a shape

**Rule:** Define one thin extractor around each built-in extractor (JSON, path, form) whose failure type is your application error, and use it everywhere instead of the stock one.

**Why:** Built-in extractors answer bad input in their own plain format. The source shows three techniques with stated trade-offs: a wrapper type adapter (easy, verbose types), a derive (easy, known limits), and a hand-written extractor (most control, most boilerplate). The adapter only needs an error type that converts from the inner rejection.

**Do:**
```
type AppJson(T) = WithRejection(JsonBody(T), AppError)
handler(AppJson(params): AppJson(UserParams)) -> Result(AppJson(User), AppError)
```

**Don't:** Let some routes emit plain-text rejections and others emit your JSON envelope.

**Break it when:** The source lists the three techniques with different costs; pick the cheapest that covers the routes you need (customize-extractor-error README).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/customize-extractor-error/README.md (three approaches); https://github.com/tokio-rs/axum/blob/main/examples/customize-extractor-error/src/with_rejection.rs; https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/with_rejection.rs (WithRejection); https://github.com/tokio-rs/axum/blob/main/axum-macros/src/lib.rs (FromRequest, via and rejection attributes).
