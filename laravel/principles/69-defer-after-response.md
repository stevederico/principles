# Defer after the response

**Rule:** Run light, non-essential work (metrics, audit rows, cache warming) after the response is sent and only if the request succeeded, and send durable or heavy work to a queue.

**Why:** The caller stops waiting and the response is unaffected by failures there. Deferred work dies with the process, and layers that run after the response are rebuilt fresh, so per-request state kept in their fields is gone. Independent slow calls can also run concurrently and return keyed results.

**Do:**
```
handler(): order = create(); defer(report_metrics(order)); return order     # runs after send, status < 400
defer(fn, always = true)                                                     # run even on failure
on_upload(): store(original); queue(ResizeImage(path))                       # CPU heavy
r = run_all({users: count_users, orders: count_orders}, timeout = 30)
```

**Don't:** Putting must-not-lose work in defer, or saving per-request state on a layer instance and reading it afterwards.

**Break it when:** The result is part of the response, or the work must survive a crash or be retried: use a queue.

**Source:** https://laravel.com/docs/helpers, https://laravel.com/docs/middleware, https://laravel.com/docs/concurrency, https://laravel.com/docs/images ; code: src/Illuminate/Foundation/Http/Kernel.php, src/Illuminate/Foundation/Http/Middleware/InvokeDeferredCallbacks.php, src/Illuminate/Concurrency/ConcurrencyManager.php
