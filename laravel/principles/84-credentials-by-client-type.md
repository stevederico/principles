# Credentials by client type

**Rule:** Authenticate your own browser app with a cookie session, issue revocable scoped bearer tokens to third parties and mobile apps, and reach for a full OAuth server only when a standard client requires it, and a token's scope may narrow what the user can do, never widen it.

**Why:** Cookies keep secrets out of script-reachable storage; tokens suit clients without cookies. The heavy protocol adds grants and refresh flows most apps never need. Scope is a second check on top of ownership, not a replacement.

**Do:**
```
if request has a valid session cookie from own origin: authenticated (stateful)
else if request has a bearer token: look up token, authenticated as its user
allowed = user.owns(record) and request.token_can("update")      # session requests: token_can is true
first-party browser: session cookie ; own mobile or API: scoped tokens ; third parties: OAuth server
```

**Don't:** Storing a long-lived bearer token in the browser app, or checking only the scope and trusting it for ownership.

**Break it when:** The SPA lives on a different registrable domain than the API, so cookies cannot work. A standard client (an AI connector) expects OAuth.

**Source:** https://laravel.com/docs/sanctum, https://laravel.com/docs/authentication, https://laravel.com/docs/passport ; code: docs only (not in the framework repo)
