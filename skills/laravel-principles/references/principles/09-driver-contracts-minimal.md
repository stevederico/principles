# Keep driver contracts minimal

**Rule:** Define a driver interface at its narrowest level (opaque string in, opaque string out) and apply serialization, encryption and locking once in a shared layer above every driver.

**Why:** A new driver implements a handful of methods and cannot get serialization or encryption wrong. The session store, for example, wraps whatever handler it is given, and swaps in an encrypting variant by configuration.

**Do:**
```
interface SessionHandler: read(id) -> string; write(id, string); destroy(id); gc(age)
store = Store(handler)
if config.encrypt: store = EncryptedStore(handler)     # one place, every driver
```

**Don't:** Making each driver implement its own serialization, or letting a driver see structured data it need not understand.

**Break it when:** A backend that stores native structures where conversion would lose its features.

**Source:** https://laravel.com/docs/session ; code: src/Illuminate/Session/SessionManager.php, src/Illuminate/Session/Store.php
