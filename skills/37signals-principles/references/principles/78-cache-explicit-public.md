# A shared cache stores only responses that opt in as public

**Rule:** A shared cache keeps a response only when the origin marks it public with a positive lifetime, and bypasses everything uncertain; the key includes host, path, query and the values of varied headers.

**Why:** Caching private content at a shared layer leaks it. The code is stricter than "public assets": it rejects private, no-store, no-cache and "vary all", error and not-modified statuses, oversized bodies, requests that are not plain GET or HEAD, and strips cookies from cached copies. Adding host to the key fixed cross-host mixups.

**Do:**
```
bypass if method not in (GET, HEAD) or request has body, range or upgrade
cacheable = status ok and cache_control has "public" and lifetime > 0 and not (private | no-store | no-cache)
key = (method, host, path, query, varied header values)
```

**Don't:** Cache by URL alone, or cache responses that set cookies.

**Break it when:** The cache sits inside a single-user context.

**Source:** https://github.com/basecamp/thruster README.md, CHANGELOG.md ; code: internal/cacheable_response.go, internal/cache_handler.go, internal/variant.go.
