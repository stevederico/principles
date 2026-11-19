# Swappable drivers

**Rule:** Define a small interface for each capability (cache, queue, mail, storage). Provide drivers behind it and pick one by config.

**Why:** Local dev uses a file or memory. Production uses a managed service. The code never changes.

**Do:**
```
interface Storage: put(path, data); get(path)
drivers: local, s3, memory
config: storage.driver = "s3"

Storage.put("a.png", bytes)    # same call everywhere
```

**Don't:** Import a vendor SDK directly in business code.

**Break it when:** You use one vendor-only feature. Wrap it and mark it as non-portable.

**Source:** Laravel docs, manager and driver pattern.
