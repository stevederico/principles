# Batteries included

**Rule:** Ship a first-party answer for each common need (auth, mail, queues, files, cache, search, testing, billing) and keep every answer optional and replaceable.

**Why:** Without one, each project hunts for libraries and invents its own style. First-party answers share conventions; making the heavy ones separate installs keeps the core small.

**Do:**
```
new app: login, password reset, mail, jobs, storage, tests, all configured the same way
rare or heavy needs are separate installs that publish their own config:
  install(oauth_server); install(monitoring); install(websocket_server); install(browser_tests)
the headless auth backend is optional and the manual path stays documented
```

**Don't:** Telling people to find a package for basics, or making a heavy battery mandatory.

**Break it when:** A need is rare: offer an optional package. If the official answer needs new infrastructure, ship a cheap default first (database-backed search) so it costs nothing to start.

**Source:** https://laravel.com/docs/installation, https://laravel.com/docs/fortify, https://laravel.com/docs/packages, https://laravel.com/docs/search, https://laravel.com/docs/scout ; code: docs only (not in the framework repo)
