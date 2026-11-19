# Health and maintenance

**Rule:** Expose one health URL that succeeds only if the app boots and every registered check passes, and answer maintenance mode from the front of the request path, backed by a flag every server shares.

**Why:** Load balancers need a plain signal, and components add checks by listening to an event. A down page that needs the full app to boot still errors during an update, so pre-render it. A per-machine marker means running "down" on each host.

**Do:**
```
GET /up: try: emit HealthCheck; return 200   catch e: report(e); return 500 (no body unless debug)
exempt /up from maintenance mode
app.down(prerendered_page = render("503"), secret = "abc")     # front controller answers before boot
maintenance.driver = "shared_cache"                            # one command flips all servers
```

**Don't:** Database and queue checks written into the route itself, or leaking exception text from the health URL.

**Break it when:** Zero-downtime rollouts make the down page unneeded. Deep dependency checks go in a separate readiness endpoint.

**Source:** https://laravel.com/docs/deployment, https://laravel.com/docs/configuration ; code: src/Illuminate/Foundation/Http/HealthCheck.php, src/Illuminate/Foundation/MaintenanceModeManager.php, src/Illuminate/Foundation/Configuration/ApplicationBuilder.php
