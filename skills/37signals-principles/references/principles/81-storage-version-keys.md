# Key caches on a storage-level version or on rendered content

**Rule:** When "touch the parent" invalidation can be bypassed (raw SQL, other processes), key caches on a global data version read from the database itself, or on a digest of the content actually rendered; include the version of any policy that shaped the output; bound entry sizes and memory with an off switch.

**Why:** The code compares the database's data version from a read-only connection so any writer invalidates everything, and fragment keys hash real attributes because foreign writers need not update timestamps. A cached fragment skips the sanitizer, so output from older rules would be served unchanged, and template digests do not change when only helper code does.

**Do:**
```
at request start capture db.data_version ; before store, re-check the same version else do not store
key = hash(attributes, rendered body, related rows)
cache [ record, can_edit, scrubber.cache_version ]       # version = rules_version + digest(allowlist)
cache.max_bytes = 64 MB ; entry <= 1 MB ; key <= 2 KB ; budget 0 disables
```

**Don't:** Use unbounded memory caches, rely on dependency tracking you cannot prove complete, or assume updated-at covers a rule change.

**Break it when:** One writer goes through your ORM and touch chains are reliable.

**Source:** https://github.com/basecamp/once-campfire app/models/response_cache.rb, app/models/fragment_cache.rb, app/views/messages/_message.html.erb ; https://github.com/basecamp/writebook app/models/html_scrubber.rb, app/models/embed_provider.rb.
