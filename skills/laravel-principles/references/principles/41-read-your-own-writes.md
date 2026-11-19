# Read your own writes

**Rule:** When reads and writes go to different servers, send reads to the primary inside a transaction, for the rest of a request after any write, and for a short window on the user's next request.

**Why:** Replicas lag, so a user who just saved and was redirected would see old data.

**Do:**
```
read_connection(): primary if in_transaction or request_wrote or session.last_write > now - 2s else replica
after_request(): if wrote: session.last_write = now
progress counters: write without marking, so they do not pin reads
```

**Don't:** Letting redirect-after-save hit a lagging replica.

**Break it when:** Reads that tolerate seconds of staleness (public pages).

**Source:** https://laravel.com/docs/database ; code: src/Illuminate/Database/Connection.php, src/Illuminate/Foundation/Http/Middleware/PreventStaleDatabaseReads.php
