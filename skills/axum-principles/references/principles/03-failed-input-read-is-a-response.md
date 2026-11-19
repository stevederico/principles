# A failed input read answers the client before the handler runs

**Rule:** Give every input extractor its own rejection type that converts to a response, and return that response at the first failure without calling the handler.

**Why:** The extractor contract requires its error to be response-convertible, and the handler wrapper returns that response on the first failure, so handler code can assume its inputs are valid. Each failure cause is a small named type with a fixed status and body text, and per-extractor enums list every way the read can fail.

**Do:**
```
for extractor in extractors_in_order:
    result = extractor.run(request)
    if result.failed: return result.rejection.to_response()
return handler(values).to_response()
```

**Don't:** Pass half-parsed or optional inputs into the handler and re-validate there, or collapse every cause into one generic bad-request.

**Break it when:** One handler that wants to handle a failure itself asks for "result of extractor" and receives the rejection as a value (extract.md, "Handling extractor rejections").

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/docs/extract.md ("Handling extractor rejections"); https://github.com/tokio-rs/axum/blob/main/axum/src/handler/mod.rs (per-arity impl, rejection returned as response); https://github.com/tokio-rs/axum/blob/main/axum-core/src/macros.rs (__define_rejection, __composite_rejection); https://github.com/tokio-rs/axum/blob/main/axum-core/src/extract/rejection.rs.
