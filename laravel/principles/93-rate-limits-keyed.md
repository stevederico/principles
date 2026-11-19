# Keyed rate limits

**Rule:** Define named rate limits that compute their own key per request (user, address, input field), allow several limits at once, and let a limit count only chosen outcomes.

**Why:** One global counter punishes everyone, per-key limits stop one actor. Login should key on the identity under attack plus the address; endpoints that send mail need a tighter limit; public self-registration must be limited or off. Counting only certain outcomes (not found, failed validation) blunts enumeration without throttling normal use.

**Do:**
```
limiter "login": [limit 500/min, limit 5/min keyed by request.email + ip]
limiter "lookup": limit 10/min keyed by (user.id or ip), count only responses with status 404
limiter "resend_verification": limit 6/min
on exceed: respond 429 with retry-after
```

**Don't:** One limit for the whole route, two limits that share one key string, or an unthrottled login or resend endpoint.

**Break it when:** Cheap public static content, where a plain global cap is enough.

**Source:** https://laravel.com/docs/routing, https://laravel.com/docs/rate-limiting, https://laravel.com/docs/fortify, https://laravel.com/docs/starter-kits, https://laravel.com/docs/verification, https://laravel.com/docs/mcp ; code: src/Illuminate/Routing/Middleware/ThrottleRequests.php, src/Illuminate/Cache/RateLimiter.php
