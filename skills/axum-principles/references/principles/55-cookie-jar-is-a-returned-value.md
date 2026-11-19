# A cookie jar is a value you must return

**Rule:** Treat cookie changes as a value: adding or removing returns an updated jar, nothing is sent unless the jar is returned in the response, only the changed cookies are written (one header each), and reading skips malformed pieces instead of rejecting the request.

**Why:** The docs say changes propagate only when the jar is returned, and the type is marked so ignoring it warns. Response application emits just the delta, not every inbound cookie, and cookie headers may repeat and hold several pairs, so one bad pair must not reject the request.

**Do:**
```
jar = request.jar; jar = jar.add(cookie)
return (jar, redirect)                                    # delta only
for header in all(cookie_headers): for piece in split(header, ";"): try parse(piece) else skip
```

**Don't:** Mutate a jar and drop it, or echo every received cookie on each response.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/cookie/mod.rs (CookieJar, set_cookies delta).
