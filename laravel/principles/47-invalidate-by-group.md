# Invalidate by group

**Rule:** Tag related cache entries so the group can be dropped together, give each environment its own key namespace, and never flush a store that other apps or environments share.

**Why:** Group invalidation is precise, while a full flush ignores prefixes and removes everyone's entries. Two deployments with the same prefix read each other's data, and even queue workers can pick up each other's jobs. Changing a prefix on a live app orphans stored entries. Bump a parent's updated timestamp when a child changes so keys built from it expire.

**Do:**
```
cache.tags(["people", "authors"]).put("anne", v)
cache.tags(["authors"]).flush()                 # only authors; file and database stores refuse tags
staging:    PREFIX = "myapp-staging-"
production: PREFIX = "myapp-prod-"
Comment.touches = [post] ; cache_key(post) = post.id + post.updated_at
```

**Don't:** cache.flush() on a cache several apps share, or one prefix for staging and production.

**Break it when:** A dedicated single-app cache with a rare full reset, or instances that are one logical cluster. Bulk updates skip the touch rule.

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/redis, https://laravel.com/docs/eloquent-relationships ; code: src/Illuminate/Cache/Repository.php, src/Illuminate/Redis/Connectors/PhpRedisConnector.php, src/Illuminate/Database/Eloquent/Concerns/HasRelationships.php
