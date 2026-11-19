# Container lifetimes

**Rule:** Choose each shared service's lifetime on purpose: process-wide for stateless services, per request or job (reset at the boundary) for anything that holds request state.

**Why:** In servers that keep the app in memory across requests (app-server workers, queue workers), an object built at boot keeps whatever it captured, so later requests see a stale request, container or config.

**Do:**
```
singleton(Config)                       # stateless, safe forever
scoped(CurrentTenant)                   # forgotten when a new request or job begins
on each_job_start(): container.forget_scoped()
service.handle(request.field("name"))   # pass per-call data, or a resolver for the live object
```

**Don't:** A singleton whose constructor takes the current request, or request code that appends to a static array.

**Break it when:** The runtime starts a fresh process per request, so every object dies with it anyway.

**Source:** https://laravel.com/docs/container, https://laravel.com/docs/octane ; code: src/Illuminate/Container/Container.php, src/Illuminate/Queue/QueueServiceProvider.php
