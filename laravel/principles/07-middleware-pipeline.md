# Middleware pipeline

**Rule:** Pass each request through an ordered chain of small layers. Each can inspect it, change it, stop it, or hand it on.

**Why:** Cross-cutting rules (login check, rate limit, logging, locale) live in one place and attach by name, not copied into every handler.

**Do:**
```
route /admin -> [authenticate, require_admin, rate_limit] -> handler

layer(request, next):
  if not request.user: return redirect("/login")
  return next(request)
```

**Don't:** Repeat the same check at the top of ten handlers.

**Break it when:** A rule applies to one handler only. Keep it inline.

**Source:** Laravel docs, middleware.
