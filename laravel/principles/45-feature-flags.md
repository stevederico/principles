# Feature flags

**Rule:** Resolve a feature flag once per scope (user, team, global), store the result, and check a cheap override before the stored value so a feature can be switched off or on globally without destroying stored results.

**Why:** A rollout re-rolled on every request would flip users between variants. Stored values keep each experience stable. With no logged-in user the scope is empty, so jobs must pass it explicitly; a missing scope resolves to off and emits an event. An event for unknown flags exposes stale call sites. A flag may return a variant value instead of a boolean, and anything other than false counts as active, so one mechanism serves on/off and A/B tests. Store a stable flag name, not the class name, so a rename does not orphan stored results.

**Do:**
```
flag("new-api", scope = user): stored = store.get(flag, user); if stored: return stored
                               value = definition(user); store.set(flag, user, value); return value
flag.before(user): if config.disabled: return user.is_staff       # none means fall through
flag.for(team).active("billing-v2") ; flag.globally().active("x")
deploy step: purge removed flags from the store
color = flag.value("purchase-button")          # "seafoam-green" or false
flag name stored = "new-api"                    # not the class name
```

**Don't:** A random roll per request, deleting stored values to turn a feature off, or reading the current user inside a queued job.

**Break it when:** A flag that must follow live data every time (a permission check): use a plain function.

**Source:** https://laravel.com/docs/pennant ; code: docs only (not in the framework repo)
