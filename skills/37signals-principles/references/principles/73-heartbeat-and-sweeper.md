# Detect dead processes by heartbeat; sweep for events that never fired

**Rule:** Have each process refresh a heartbeat; when it expires, remove the process and mark its claimed jobs failed with a distinct error, leaving retry to a deliberate choice. Detect transitions (batch finished, job unblocked) at the event, and run a periodic sweeper for cases the event missed.

**Why:** A killed process cannot release its work, and blind retry can repeat a job that is itself killing workers. Bulk deletes, crashed enqueuers and rolled-back callbacks bypass events; a sweeper converges the system without locking the hot path.

**Do:**
```
every 60 s: process.heartbeat
sweep: for p where last_heartbeat < now - 5 min: fail p.claimed with ProcessPruned ; remove p
on job finish: update counters ; if last: fire callbacks
every few minutes: re-evaluate stalled batches
```

**Don't:** Retry orphaned jobs forever, or assume a heartbeat detects one stuck thread (it tracks the process), or trust events alone.

**Break it when:** Jobs are idempotent and you cap attempts yourself, or missed events are impossible by construction.

**Source:** https://github.com/rails/solid_queue README.md (Threads, processes, and signals ; Batch maintenance) ; code: app/models/solid_queue/process/prunable.rb, app/models/solid_queue/batch/sweepable.rb.
