# Make the browser login flow single-use, random and server-backed

**Rule:** Generate a random state value for each authorization redirect, store it server-side behind a session cookie, compare and destroy it on callback, set session cookies with HttpOnly, Secure, SameSite and a path, and destroy the stored session on logout.

**Why:** The callback loads the session, reads the stored token, deletes the session, then compares it to the returned value. Both Set-Cookie sites use those attributes and logout calls destroy on the store, not just on the cookie. The in-memory store is flagged as unsuitable for production.

**Do:**
```
start: token = random(); sid = store.save({csrf: token}); set_cookie(sid, SameSite=Lax, HttpOnly, Secure); redirect(auth_url, state=token)
callback: s = store.load(cookie); store.destroy(s); if s.csrf != query.state: error
logout: store.destroy(session)
```

**Don't:** Skip the state check, keep the state session after use, or use an in-process store across instances or restarts.

**Break it when:** Plain-HTTP local development will not send Secure cookies (the example notes the memory store is not for production).

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/oauth/src/main.rs (login and authorized handlers, logout).
