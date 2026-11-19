# Authenticate by declaring the principal as a parameter

**Rule:** Implement authentication as an extractor that produces the user or claims; any handler that lists it is protected by construction. Use a route-scoped guard for blanket rules, and let browser-facing extractors reject with a redirect to login.

**Why:** The JWT and OAuth examples protect routes only by listing the extractor. A browser-page extractor rejects with a redirect, and a separate optional form lets the index page behave differently when logged in; JSON APIs reject with 401 instead.

**Do:**
```
extractor Claims: token = bearer(request); return decode(token) or reject(InvalidToken)
handler protected(claims: Claims): ...
admin_router.layer(bearer_auth_guard)
```

**Don't:** Check the authorization header by hand at the top of every handler, or send 401 JSON to a browser navigation.

**Break it when:** JSON APIs: the JWT example rejects with an error status rather than a redirect.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/jwt/src/main.rs (Claims extractor); https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs (User extractor, redirect rejection, optional impl); https://github.com/tokio-rs/axum/blob/main/examples/key-value-store/src/main.rs (bearer guard on admin routes).
