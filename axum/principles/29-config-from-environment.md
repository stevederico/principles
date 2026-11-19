# Read secrets and endpoints from the environment

**Rule:** Read secrets and connection strings from environment variables, fail early with a clear message when a required one is missing, and give defaults only to harmless values.

**Why:** The OAuth example marks id and secret as required with a context message and defaults only the redirect URLs; databases read their URL from the environment; the JWT secret is never in source.

**Do:**
```
client_id = env("CLIENT_ID") or error("Missing CLIENT_ID")
redirect = env("REDIRECT_URL") or "http://127.0.0.1:3000/auth/authorized"
```

**Don't:** Embed secrets in code, or default a production URL to a localhost value silently.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs (environment reads); https://github.com/tokio-rs/axum/blob/main/examples/jwt/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/mongodb/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/diesel-postgres/src/main.rs.
