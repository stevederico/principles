# Shape function middleware like a handler

**Rule:** Let a middleware function take any number of metadata extractors, at most one body extractor placed just before "next", and let it either continue or return a response; a request mapper returns the request or a rejection, and a response mapper may use only metadata extractors.

**Why:** The body is consumed once, so the doc requires zero or more metadata extractors, one whole-request extractor second to last, and next last. The code runs all metadata extractors against a shared head, then rebuilds the request for the body extractor. Extractor failures become ordinary responses, so the middleware's error type is "never". Helpers get no application state unless a variant with explicit state is used.

**Do:**
```
middleware(head_a, head_b, body_or_request, next):
    response = next.run(request)
    return response
map_request(req): if not authorized(req): return reject(401) else return req
```

**Don't:** Put two body extractors in one middleware, or read the request body in a response mapper.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/middleware/from_fn.rs (docs and call impl); https://github.com/tokio-rs/axum/blob/main/axum/src/middleware/map_request.rs; https://github.com/tokio-rs/axum/blob/main/axum/src/middleware/map_response.rs.
