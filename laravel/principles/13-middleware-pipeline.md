# Middleware pipeline

**Rule:** Pass each request through an ordered chain of small layers, and each may change the request, stop with its own answer, or call the next layer and then change the response on the way back.

**Why:** Cross-cutting rules (login, throttling, locale, headers, bookkeeping) live once and attach by name. The same shape wraps queued jobs, notifications and plain data pipelines.

**Do:**
```
route /admin -> [authenticate, require_admin, throttle] -> handler
layer(request, next):
  if not request.user: return redirect("/login")      # before: may stop
  response = next(request)                            # inner layers and handler
  response.headers.add("Vary", "Cookie")              # after: edit response
  return response
job.layers = [without_overlap(key), rate_limit("api")]
```

**Don't:** Repeating the same check at the top of ten handlers, or writing response header logic in every handler.

**Break it when:** A rule needs data that exists only inside the handler. Per-route and per-method layers cover most one-handler rules.

**Source:** https://laravel.com/docs/middleware, https://laravel.com/docs/lifecycle, https://laravel.com/docs/authentication, https://laravel.com/docs/queues ; code: src/Illuminate/Pipeline/Pipeline.php, src/Illuminate/Queue/Middleware/WithoutOverlapping.php, src/Illuminate/Foundation/Http/Middleware/PreventStaleDatabaseReads.php
