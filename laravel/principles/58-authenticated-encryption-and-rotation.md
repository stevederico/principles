# Authenticated encryption and rotation

**Rule:** Encrypt only with a scheme that detects tampering, write with the newest key, read with the newest key then a short list of retired ones, treat a cookie that fails verification as absent, and never deserialize arbitrary object types from shared stores.

**Why:** Swapping a single key would log everyone out and orphan every stored secret. The integrity tag turns a forged value into an explicit failure. If a signing key leaks, free-form deserialization allows code execution, so allow only named classes and prefer a data-only format.

**Do:**
```
config.key = NEW ; config.previous_keys = [OLD1, OLD2]
decrypt(c): for k in [NEW, OLD1, OLD2]: if tag_valid(c, k): return open(c, k)
            raise DecryptError
cookie.read(): try decrypt and verify; on failure: value = null
cache.allowed_classes = [DashboardStats]         # default none
session.serialization = "json"
```

**Don't:** Encryption with no integrity check, replacing the one key, or storing live objects in shared caches.

**Break it when:** Drop an old key once nothing encrypted with it is still live. A cookie client script must read: mark it plain and treat its value as untrusted.

**Source:** https://laravel.com/docs/encryption, https://laravel.com/docs/requests, https://laravel.com/docs/upgrade ; code: src/Illuminate/Encryption/Encrypter.php, src/Illuminate/Cookie/Middleware/EncryptCookies.php, src/Illuminate/Cache/RedisStore.php, src/Illuminate/Cache/FileStore.php
