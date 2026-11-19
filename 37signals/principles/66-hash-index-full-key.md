# Index a fixed-width hash and keep the full key to verify

**Rule:** Look rows up by a compact integer hash of the key, store the full key, and confirm equality on read; keep the maximum key size equal to what the index can hold.

**Why:** A 64-bit integer index is far smaller than an index on long keys, so more of it stays in memory; storing the key guards against collisions. A key the index cannot store only produces errors.

**Do:**
```
key_hash = int64(sha256(key)) ; index(key_hash)
read: row = lookup(key_hash) ; return row.value only if row.key == key
max_key_bytes = index limit of the database
```

**Don't:** Index long keys directly or trust a hash alone.

**Break it when:** Keys are short enough to index directly.

**Source:** https://github.com/rails/solid_cache README.md (Index size limits), upgrading_to_version_0.4.x.md ; code: app/models/solid_cache/entry.rb, lib/solid_cache/store/api.rb.
