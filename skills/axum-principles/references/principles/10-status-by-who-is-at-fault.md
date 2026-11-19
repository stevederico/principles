# Choose the status code by who is at fault

**Rule:** Map input failures to specific client-error codes by cause (wrong media type, bad syntax, wrong shape, too large) and map developer or server wiring mistakes to 500.

**Why:** The built-in rejections encode a taxonomy: wrong type 415, unparsable syntax 400, well-formed but wrong shape 422, over the limit 413, missing server-registered dependency 500, route parameter count not matching the handler 500, bad URL text 400. A form read from a query string gives 400 while the same failure in a body gives 422. Bad user input is not logged as an error.

**Do:**
```
if content_type != expected: 415
elif not parseable: 400
elif parsed but wrong shape: 422
elif body over limit: 413
elif required server component missing: 500
```

**Don't:** Use one generic 400 for everything, or blame the client when the route and handler disagree.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/rejection.rs (JsonRejection variants); https://github.com/tokio-rs/axum/blob/main/axum/src/extract/path/mod.rs (error kinds to status); https://github.com/tokio-rs/axum/blob/main/axum/src/form.rs (query vs body status); https://github.com/tokio-rs/axum/blob/main/axum/src/extension.rs (missing extension is 500); https://github.com/tokio-rs/axum/blob/main/examples/customize-path-rejection/src/main.rs.
