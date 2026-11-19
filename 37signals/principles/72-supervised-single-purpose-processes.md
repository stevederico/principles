# Run single-purpose roles under a supervisor, and size threads by the pool

**Rule:** Split queue work into worker, dispatcher and scheduler roles with a supervisor that starts, heartbeats and replaces them, each isolated in its own process by default; set worker threads below the database connection pool, leaving headroom.

**Why:** Isolation keeps one actor's crash or memory growth from taking the rest down, and roles scale independently. Threads beyond the pool only wait for connections, and each process also holds polling and heartbeat connections.

**Do:**
```
supervisor: for each configured role: start ; watch heartbeat ; replace on death
config lists only the roles this host runs
threads <= pool_size - 2 ; warn at boot when the pool is below the estimated need
```

**Don't:** Merge all roles into one process in production for convenience, or raise thread counts without raising the pool.

**Break it when:** Memory-constrained hosts or runtimes without fork (accept lost isolation), or jobs that rarely hold connections.

**Source:** https://github.com/rails/solid_queue README.md (Workers, dispatchers, and scheduler ; Fork vs. async mode) ; code: lib/solid_queue/fork_supervisor.rb, lib/solid_queue/configuration.rb.
