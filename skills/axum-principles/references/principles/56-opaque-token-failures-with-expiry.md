# Issue expiring tokens and report every failure the same way

**Rule:** Issue tokens with an expiry that validation requires, read the signing secret from configuration, and answer every token failure (missing, malformed, bad signature, expired) with the same opaque invalid-token response.

**Why:** The JWT example marks the expiry claim as mandatory, reads the secret from the environment without a default, and discards the underlying cause at each step so the caller learns nothing about which check failed. Credential errors differ only by who is at fault: missing is 400, wrong is 401.

**Do:**
```
claims = { sub, company, exp: now + ttl }
secret = env("JWT_SECRET")                            # no default
claims = decode(bearer.token).map_err(-> InvalidToken)
```

**Don't:** Hard-code the key, issue tokens that never expire, or tell the caller whether signature or expiry failed.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/jwt/src/main.rs (Keys, Claims, AuthError).
