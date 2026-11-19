# Gate ops and debug tools

**Rule:** Reach internal dashboards and debug tooling without login only in local development, require an explicit allow rule everywhere else, never ship test-only login shortcuts to production, and capture everything locally but only anomalies elsewhere.

**Why:** These pages expose users, queries and server data. A named gate decides who gets in, and an environment name that is wrong in production would expose the tool, so verify it. Unpruned captures grow quickly: prune daily on a short retention.

**Do:**
```
if env == "local": allow else: gate("view_dashboard")(user)        # default deny
if env == "local" and Debugger is installed: register(Debugger)
if env is test: register(test_login_route)
capture(entry): keep if local or entry.is_exception or is_failed_job or is_slow_query or has_watched_tag
schedule daily: prune(older_than = 24h)
```

**Don't:** Leaving a monitoring page open until someone remembers, or gating the login shortcut with a config flag a deploy could leave on.

**Break it when:** A hardened internal tool behind VPN and single sign-on. Short targeted investigations may raise capture temporarily.

**Source:** https://laravel.com/docs/telescope, https://laravel.com/docs/pulse, https://laravel.com/docs/horizon, https://laravel.com/docs/dusk ; code: docs only (not in the framework repo)
