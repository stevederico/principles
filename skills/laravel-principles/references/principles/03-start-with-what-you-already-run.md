# Start with what you already run

**Rule:** Default cache, queue and search to the database you already operate, behind the common interface, and move to a dedicated service only when measured needs outgrow it.

**Why:** Most apps never need the extra service, and because every call goes through one API the later move is a config change, not a rewrite.

**Do:**
```
cache.default = "database"
queue.default = "database"
search.engine = "database"
# later, when load or features demand it
search.engine = "dedicated"        # same calls, same model code
```

**Don't:** Standing up four services before the first user arrives.

**Break it when:** Known requirements already exceed the default: typo tolerance, facets, geo or vector search at scale, high queue throughput.

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/queues, https://laravel.com/docs/search, https://laravel.com/docs/scout ; code: docs only (not in the framework repo)
