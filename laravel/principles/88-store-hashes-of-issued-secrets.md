# Hash what you issue

**Rule:** Store only a hash of every token you issue (API tokens, reset tokens), show the plain value once, give each an expiry or a revoke path, and clean old ones on a schedule.

**Why:** A leaked table then hands out nothing usable. Reset tokens also need a throttle (refuse a new one while a recent one exists) and deletion after use, or the endpoint becomes an email bomb and a guessing channel. A human-readable name per token lets users revoke the right one.

**Do:**
```
create_token(user, name = "Alice's phone", scopes = ["orders:read"]): plain = random(); store(hash(plain)); return plain
request_reset(user): if recent_token(user): return THROTTLED ; store(hash(token)); send_link(token)
reset(user, token, new_password): if expired or hash_mismatch: INVALID ; set_password(); delete_token()
```

**Don't:** Storing plain tokens, keeping reset tokens forever, or issuing tokens nobody can list or revoke.

**Break it when:** Short-lived tokens minted per request. A stateless signed link works if it is single-use and bound to the current password state.

**Source:** https://laravel.com/docs/sanctum, https://laravel.com/docs/passwords ; code: src/Illuminate/Auth/Passwords/DatabaseTokenRepository.php, src/Illuminate/Auth/Passwords/PasswordBroker.php
