# Validate configuration strictly and ship defaults that work

**Rule:** Reject unknown keys (reserving a prefix for user blocks), let a repo declare the minimum tool version, give a no-side-effect check command, refuse combinations known to misbehave, and ship defaults that run in production with one unavoidable input; accept a tool-specific env prefix that wins over the bare name.

**Why:** Typos silently ignored become production misbehavior, and failing early beats half-applying an unknown format. Running behind Thruster needs only the domain name; sharing an environment with the app makes names like PORT collide.

**Do:**
```
unknown = keys(config) - known_keys - those starting with "x-"       # only at allowed levels
if config.minimum_version > tool.version: raise("need >= X")
check(): errors = validate(config) ; exit nonzero          # usable in CI, no credentials
value = env("TOOL_" + key) if set else env(key) if set else default
```

**Don't:** Silently ignore typos, demand a config file with dozens of required keys, or discover mistakes through a crashed worker.

**Break it when:** A plugin system needs open keys (give it a validated namespace); settings with security consequences and no safe default should fail loudly.

**Source:** https://kamal-deploy.org/docs/configuration/overview/ ; https://github.com/basecamp/thruster README.md ; https://github.com/rails/solid_queue README.md (Validating the configuration) ; code: kamal lib/kamal/configuration/validator.rb, thruster internal/config.go, solid_queue lib/solid_queue/configuration.rb.
