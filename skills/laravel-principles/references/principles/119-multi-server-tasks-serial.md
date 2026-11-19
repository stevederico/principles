# Multi-server tasks run serially

**Rule:** Run a remote task on several servers one at a time unless parallel is requested, gate destructive tasks behind explicit confirmation, and run the start, success, error and finish hooks on the operator's machine rather than the servers.

**Why:** A bad deploy that hits every host at once has no brake, while serial order gives a stopping point. Notifications sent from the box that just failed may never arrive.

**Do:**
```
task deploy on [web1, web2], parallel = false, confirm = true
hooks: before, after, on_error, on_success, finished      # run locally, in file order
```

**Don't:** Defaulting to parallel everywhere, or notifying from the failed host.

**Break it when:** Many identical stateless hosts where parallel is safe and speed matters.

**Source:** https://laravel.com/docs/envoy ; code: docs only
