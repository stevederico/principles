# Bound the cache by size and evict cheaply, driven by writes

**Rule:** Cap total and per-item bytes, evict oldest-first or by sampling rather than exact ordering, estimate size by sampling instead of measuring, and trigger cleanup from writes at a fixed multiple of the write rate on a bounded background queue that drops work under pressure; spread cleaners over different rows.

**Why:** Predictable memory and no read bookkeeping: oldest-first needs no write on read and infers size from the id range, and a large disk-backed cache offsets the weaker policy. The code triggers batches at random so about two deletes are attempted per write, which the README describes as a half-batch counter; effect is equal. Cleanup then idles when the system idles. Overlapping cleaners waste work and wait on locks.

**Do:**
```
if item.size > max_item or > capacity: skip
entries ~= max(id) - min(id) + 1 ; bytes ~= rows * mean(sampled byte_size)
on write(n): batches = n * (2 / batch_size) rounded randomly ; try_enqueue(expire) # drop if queue full
victims = random_sample(oldest(3 * batch), batch)  or  select for update skip locked
```

**Don't:** Allow unbounded growth, scan globally per eviction, or run cleanup on a timer inside the request.

**Break it when:** A hard schedule or exact quota is needed (use a job on a worker), or a small hot cache needs strict LRU.

**Source:** https://github.com/rails/solid_cache README.md (Cache expiry, Implementation) ; code: lib/solid_cache/store/expiry.rb, app/models/solid_cache/entry/expiration.rb ; https://github.com/rails/solid_cable README.md (Trimming) ; https://github.com/basecamp/thruster internal/memory_cache.go.
