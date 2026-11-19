# Session rotation

**Rule:** Issue a new session id on login, and on logout destroy the session data, issue a new forgery token and rotate the remember-me token, and and tie each session to a stamp derived from the password so a password change ends other sessions.

**Why:** A session id planted before login would otherwise become an authenticated one. Leftover tokens outlive a logout. Comparing a password-derived stamp each request ends other devices at once while the current one re-stamps itself. Sensitive pages can ask for the password again after a fixed window.

**Do:**
```
on login:  session.put(user_id); session.regenerate_id()
on logout: auth.logout(); session.invalidate(); session.new_csrf_token(); remember_token = new_random()
each request: if session.stamp != stamp(user.password_hash): logout()
guard(sensitive_route): if now - session.confirmed_at > 3h: redirect("/confirm-password")
```

**Don't:** Authenticating an existing anonymous session id, or clearing only the user id on logout.

**Break it when:** Stateless token APIs have no session. Users with no local password need a different revocation signal.

**Source:** https://laravel.com/docs/authentication, https://laravel.com/docs/session ; code: src/Illuminate/Auth/SessionGuard.php, src/Illuminate/Session/Middleware/AuthenticateSession.php, src/Illuminate/Auth/Middleware/RequirePassword.php
