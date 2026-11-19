# Session cookies are server-set, locked down, minimal

**Rule:** Issue session cookies from server code with httpOnly, secure, same-site, path and an expiry, keep the payload to the smallest identifiers (user id, role), keep the signing secret in server-only configuration, and use database sessions when you need revocation, device tracking or log-out-everywhere.

**Why:** A server-set httpOnly cookie cannot be read or altered by page script and expiry bounds exposure. Stateless tokens are simple but hard to revoke; database sessions cost a lookup per check but can be revoked, with a cookie copy allowing cheap optimistic checks. A small payload limits what a leaked cookie reveals.

**Do:**
```
secret = random_bytes(32) in env
token = sign({ user_id, expires_at }, secret)
set_cookie("session", token, httpOnly, secure, sameSite = lax, expires, path = "/")
# revocation needed: store session row, cookie holds encrypted session id
```

**Don't:** Put email, phone or card data in the token, let client script write the cookie, or run a database query for a check on every request path.

**Break it when:** Cross-site embedding needs another same-site policy; add other forgery defenses then. Revocation is irrelevant and tokens are short-lived.

**Source:** https://nextjs.org/docs/app/guides/authentication; docs only
