# Precompute at deploy

**Rule:** Build derived framework state (config, routes, events, compiled views) once during deploy with one command, keep one command to undo it, and restart long-lived processes afterwards.

**Why:** Per-request boot work is wasted. The price is staleness: new routes or config are invisible until rebuilt, and raw env reads see nothing once config is cached.

**Do:**
```
deploy: app optimize ; app restart-workers
dev or rollback: app optimize:clear
```

**Don't:** Running the cached build in development, where it hides edits, or compiling templates on the first user request.

**Break it when:** Local development, or a small app where startup cost is negligible.

**Source:** https://laravel.com/docs/deployment, https://laravel.com/docs/views, https://laravel.com/docs/routing, https://laravel.com/docs/configuration ; code: src/Illuminate/Foundation/Console/OptimizeCommand.php, src/Illuminate/Foundation/Console/ConfigCacheCommand.php
