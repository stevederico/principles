# Serialize, hook and record every mutating operator action

**Rule:** Guard mutating commands with a lock made by one atomic operation on a shared host (fail fast, wait only if asked), expose extension points as scripts named exactly after the event that abort on nonzero exit and receive context in environment variables, and append a timestamped who-did-what line on every host touched.

**Why:** A directory created atomically cannot race, unlike check-then-create. Waiting applies only to automatic locks, never to one a human set. Hooks hold checks like "CI passed" and "tree clean"; failures show their output. An append-only trail per host survives lost terminals.

**Do:**
```
lock.acquire(message)                 # mkdir ; fails if present
if held: if wait enabled and holder is automatic: poll(interval, timeout) else fail(show holder)
always release
if exists(hooks/event): result = run(file, env = context) ; nonzero -> abort(output)
on host: append(audit_log, "[time] [user] action version")
```

**Don't:** Queue silently behind a maintenance lock, swallow hook failures, or make hooks the only place safety lives.

**Break it when:** A distributed lock service exists, a check must hold even with the skip-hooks flag (put it in the tool), or logs go to a central system.

**Source:** https://kamal-deploy.org/docs/commands/lock/ ; https://kamal-deploy.org/docs/hooks/overview/ ; https://kamal-deploy.org/docs/commands/audit/ ; code: https://github.com/basecamp/kamal lib/kamal/commands/lock.rb, lib/kamal/cli/base.rb, lib/kamal/commands/hook.rb, lib/kamal/commands/auditor.rb.
