# Switch traffic only after the new version is healthy

**Rule:** Boot the new version beside the old, route traffic only after its health endpoint answers OK, stop the old version last, and on failure stop the new one and leave the old serving. Start secondary roles only after the primary role's first container is healthy.

**Why:** Failure to start the new container stops it and re-raises, and the old one stops only after success. A barrier makes workers wait for the first healthy web container and closes if it is not, printing logs. Use distinct timeouts: wait for readiness, let in-flight requests drain, and recheck containers without a health check after a delay; probe with growing backoff until the deadline. While both versions serve, expose both versions' hashed assets and remove the old ones only after the old version stops.

**Do:**
```
try: start(new) ; wait until health(new) == ok before deadline
on failure: stop(new) ; raise
route(new) ; stop(old) ; then remove old assets
secondaries: barrier.wait() ; boot()
```

**Don't:** Stop the old version first, call a merely started container healthy, or boot workers against a failing web tier.

**Break it when:** A singleton resource cannot run two copies (accept a short gap and say so), roles are independent and parallel boot is wanted, or assets come from a versioned CDN.

**Source:** https://kamal-deploy.org/docs/commands/deploy/ ; https://kamal-deploy.org/docs/configuration/overview/ ; https://kamal-deploy.org/docs/configuration/roles/ ; code: https://github.com/basecamp/kamal lib/kamal/cli/app/boot.rb, lib/kamal/cli/healthcheck/poller.rb, lib/kamal/commands/app/assets.rb.
