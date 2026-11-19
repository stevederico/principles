# Answer HEAD from the GET route

**Rule:** Serve HEAD by running the GET route and dropping the body, keep the length the GET would have reported, and write an explicit HEAD handler only when computing the body is expensive.

**Why:** Dispatch tries a HEAD handler, then GET; the content length is computed before the body is removed so HEAD reports the same length. The example comments that a dedicated HEAD handler only pays off when the body is costly, and a regression test covers a handler that returns empty for HEAD and must not report a length.

**Do:**
```
handler = head_handler ?? get_handler
resp = handler(request)
if resp.length unset and body size known: resp.length = size(body)
if method == HEAD: resp.body = empty
```

**Don't:** Force every GET endpoint to write a duplicate HEAD endpoint, or drop the length along with the body.

**Break it when:** When the body is expensive to compute, register an explicit HEAD handler (handle-head-request example).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/method_routing.rs (head falls back to get); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/route.rs (content-length before body strip, regression test); https://github.com/tokio-rs/axum/blob/main/examples/handle-head-request/src/main.rs.
