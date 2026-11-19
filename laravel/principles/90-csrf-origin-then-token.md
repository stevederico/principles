# Origin first, token second

**Rule:** Guard every state-changing browser request by checking the browser's same-origin signal first and a per-session secret token second, skip read-only verbs, and keep machine endpoints out of the guarded group.

**Why:** Modern browsers tag each request with its origin relationship, so a forged cross-site post can be rejected with no token; older clients keep the token path. Tokens compare in constant time. Safe defaults with named exclusions make every exception visible in review.

**Do:**
```
guard(request):
  if request.method in [GET, HEAD, OPTIONS]: allow
  if request.path in excluded: allow
  if request.header("Sec-Fetch-Site") == "same-origin": allow
  if constant_time_equal(session.token, request.token): allow
  reject
webhooks: a separate stateless group with signature checks, not an exemption by habit
```

**Don't:** Skipping the check for "rare" write verbs, or exempting routes by habit.

**Break it when:** Cross-site APIs by design: token auth and a stateless group. Unit tests may turn the guard off.

**Source:** https://laravel.com/docs/csrf, https://laravel.com/docs/billing, https://laravel.com/docs/upgrade ; code: src/Illuminate/Foundation/Http/Middleware/PreventRequestForgery.php, src/Illuminate/Foundation/Configuration/Middleware.php
