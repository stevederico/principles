# Swappable drivers

**Rule:** Define one small interface per capability, ship several drivers behind it, pick the driver by a named config entry, split optional abilities into extra interfaces, and fail loudly when the chosen driver lacks one.

**Why:** Dev can use a file or memory driver and production a managed service with no code change. Backends differ (tags, locks, temporary URLs), so an explicit error beats silently wrong behavior. Keep the driver contract minimal and do shared work such as serialization and encryption in a layer above every driver.

**Do:**
```
interface Cache: get, put, forget
interface LockProvider: lock(name, ttl)                 # optional ability
config.disks.photos = {driver: "s3", bucket: "b"}       # named instance selects a driver
storage.disk("photos").put(path, data)                  # no name means the default
cache.lock("x")  on a driver without LockProvider: raise "driver lacks locks"
test config: session = in-memory, queue = run-inline, broadcast = null
store = Store(EncryptingHandler(handler))               # shared work above the driver
```

**Don't:** Importing a vendor SDK in business code, assuming every driver supports every ability, or making each driver redo serialization.

**Break it when:** You need one vendor-only feature: wrap it behind its own interface, and fail at startup if the config picks a driver without it.

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/filesystem, https://laravel.com/docs/session, https://laravel.com/docs/broadcasting, https://laravel.com/docs/concurrency ; code: src/Illuminate/Support/Manager.php, src/Illuminate/Cache/CacheManager.php, src/Illuminate/Cache/Repository.php, src/Illuminate/Session/SessionManager.php
