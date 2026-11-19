# Bounded outbound calls

**Rule:** Give every call to an outside service or process a default total and connect timeout (plus an idle timeout for child processes), return failure as a value the caller may turn into an exception, and retry only for errors you name, with a hook that can repair the request before the next try.

**Why:** A call with no timeout can hold a worker forever, so the framework sets one and makes "no limit" an explicit, reviewable choice. Treating every error status as an exception forces handlers around expected outcomes. Blind retries repeat failures that can never succeed, while a hook can refresh an expired token. Key-value clients retry only idempotent reads on their own; retrying writes needs an explicit count.

**Do:**
```
r = http.timeout(3).connect_timeout(3).retry(3, 100ms, when: (err, req) -> err is connection_error).get(url)
if r.failed(): handle(r.status)
http.post(url).throw()                      # opt in to exceptions
retry hook on 401: req = req.with_token(refresh()); return true
run("import.sh", timeout = 120s, idle_timeout = 30s); run("daemon", forever)  # visible opt-out
```

**Don't:** Relying on a library's unlimited wait, retrying validation errors, or letting a silent child process hang a worker.

**Break it when:** Long downloads and streams: set a longer or absent total timeout per call and say why.

**Source:** https://laravel.com/docs/http-client, https://laravel.com/docs/processes, https://laravel.com/docs/redis ; code: src/Illuminate/Http/Client/PendingRequest.php, src/Illuminate/Process/PendingProcess.php, src/Illuminate/Process/ProcessResult.php
