# Compute framing headers last and enforce protocol edges once

**Rule:** Set content-length only after all middleware has run, from the final exact body size; enforce protocol edge rules (strip body and length from a successful CONNECT response, HEAD stripping, Allow) once at the outermost dispatch, not at each nesting level.

**Why:** Fixes recorded: setting length early blocked body-changing middleware, HEAD answered with length 0, a successful CONNECT kept a length after its body was removed. A test swaps the body in middleware and checks the final length; the comment says a stale length would panic in the server. A top-level flag keeps nested routes from post-processing twice.

**Do:**
```
resp = stack(request)
if resp.length unset and body.exact_size known: resp.length = exact_size
if method == CONNECT and resp.ok: clear body, length, transfer-encoding; log error
```

**Don't:** Stamp content-length in the handler and assume it survives, or post-process in every nested route.

**Break it when:** Streaming bodies of unknown size keep no length and go out chunked.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/routing/route.rs (RouteFuture top_level, CONNECT strip, content-length); https://github.com/tokio-rs/axum/blob/main/axum/src/routing/tests/mod.rs (length tests); https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (framing fixes).
