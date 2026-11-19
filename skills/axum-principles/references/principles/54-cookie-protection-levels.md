# Choose cookie protection by what you need

**Rule:** Pick plain cookies when nothing needs protecting, signed when tampering must be detected, and private (encrypted and authenticated) when the value must be hidden; never put secrets in a signed-only cookie, and keep keys in configuration.

**Why:** Signed values stay readable on the wire, and a cookie that fails verification yields nothing, so iteration returns only valid ones. Keys are fetched from state through the sub-state conversion, redacted in debug output, and the docs warn against generating a new key at every start because sessions would die.

**Do:**
```
signed.add(name, value); signed.get(name)        # value only if signature verifies
private.get(name)                                # plaintext only if decrypt and authenticate pass
key = config.cookie_key                          # persisted, not random per boot
```

**Don't:** Trust a plain cookie for authorization, log keys, or regenerate keys on every restart in production.

**Break it when:** A freshly generated key is acceptable when you want sessions to die at restart (the docs note it as the cost).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/cookie/signed.rs (SignedCookieJar); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/cookie/private.rs (PrivateCookieJar, key docs); https://github.com/tokio-rs/axum/blob/main/axum-extra/src/extract/cookie/mod.rs (tests).
