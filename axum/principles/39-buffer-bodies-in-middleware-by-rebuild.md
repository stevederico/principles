# To inspect a body in middleware, read it and rebuild the request

**Rule:** To look at a body in middleware, split the request into metadata and body, collect the body, use it, and rebuild the request with the saved bytes before calling the next layer; do it only on bounded bodies.

**Why:** The body can be read once, so rebuilding lets downstream extractors read it again. Both logging examples use this shape, and the docs say buffering fails for long-running streams.

**Do:**
```
(meta, body) = request.split()
bytes = body.collect()
log(bytes)
return next(Request(meta, Body(bytes)))
```

**Don't:** Forget to put the bytes back, or buffer SSE and proxied streams in logging middleware.

**Break it when:** Large or unbounded bodies: log headers only (print-request-response example restricts to what it can buffer).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/consume-body-in-extractor-or-middleware/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/print-request-response/src/main.rs.
