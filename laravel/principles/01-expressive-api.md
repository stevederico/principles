# Expressive API

**Rule:** Design each public call so a line of code reads like a plain sentence, built from small, named, chained steps.

**Why:** Intent shows at the call site without comments, and one fluent style across queries, caches, processes and HTTP calls means one habit works everywhere. Long chains stay readable when a repeated piece becomes a small reusable query object.

**Do:**
```
users.where(active).order_by(name).limit(10).get()
process.path(dir).timeout(120).env(vars).run(command)
http.timeout(3).retry(3, 100ms).get(url)
flights.apply(DestinationFilter(dest)).then(Paginate(sort = "time"))
```

**Don't:** Positional flag lists that nobody can read: query(users, true, "name", 10, null, false). Parameter names are outside the framework's compatibility promise, so named arguments are not a safe way to dodge them.

**Break it when:** A hot path needs a flat raw call. Keep the fluent form as the default and the raw one as the labelled exception.

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/processes, https://laravel.com/docs/queries, https://laravel.com/docs/releases ; code: src/Illuminate/Process/PendingProcess.php, src/Illuminate/Http/Client/PendingRequest.php
