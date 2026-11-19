# Context across the queue

**Rule:** Capture request-level metadata (trace id, locale, tenant) when work is enqueued and restore it when the work runs, keeping secret items in a hidden part that is never logged.

**Why:** Log lines from a background run then link back to the request that caused it, and per-request settings such as language survive the hop. Hooks must act on the copy they are handed, not the live global.

**Do:**
```
on enqueue: payload.context = snapshot(context)          # hook edits a copy
on job start: context.restore(payload.context)           # then restore hooks run
context.add_hidden("user_id", 7)                         # not written to logs
```

**Don't:** Mutating the live global context inside the capture hook, or putting secrets in the logged part.

**Break it when:** Single process with no async hand-off.

**Source:** https://laravel.com/docs/context, https://laravel.com/docs/notifications ; code: src/Illuminate/Log/Context/ContextServiceProvider.php, src/Illuminate/Log/Context/Repository.php
