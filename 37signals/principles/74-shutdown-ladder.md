# Shut down in a ladder: ask, wait a bounded time, then force

**Rule:** On a stop signal, ask children to finish, wait up to a timeout, then demand immediate exit, and return in-flight work to the queue when a process deregisters; a launcher wrapping one child relays signals and exits with the child's status.

**Why:** Deploys and restarts must not lose or double-run work, and must not hang. Orchestrators rely on signals and exit codes, so a wrapper that swallows signals or returns success after the child was killed breaks them.

**Do:**
```
on TERM: signal children TERM ; wait up to T ; if any alive: signal QUIT
on deregister: for claimed jobs: put back as ready
launcher: forward INT and TERM to the child ; exit(128 + signal if signalled else child code)
```

**Don't:** Kill workers outright on deploy, or wait with no limit.

**Break it when:** A job cannot be safely re-run after interruption; make it idempotent or extend T. A real init system already exists.

**Source:** https://github.com/rails/solid_queue README.md (Threads, processes, and signals) ; code: lib/solid_queue/supervisor.rb, app/models/solid_queue/process/executor.rb ; https://github.com/basecamp/thruster internal/upstream_process.go.
