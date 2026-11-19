# Escalate to heavier communication mechanisms only on evidence

**Rule:** Start with the simplest way for processes to cooperate and move to a more complex mechanism only after a prototype and a benchmark show the simpler one cannot do the job.

**Why:** Programming difficulty rises along the ladder from launching and waiting, through pipes and temporary files, to signals, sockets and shared memory; the simple rung often turns out to be enough. Shared memory in particular needs you to supply the synchronization yourself, and its real uses were performance measures justified by testing, not architecture.

**Do:**
```
ladder = [spawn_and_wait, pipe, tempfile, socket, shared_memory]
rung = first
while not benchmark_meets_requirement(rung): rung = next(ladder)
```

**Don't:** Reach for shared memory or a custom bus on day one.

**Break it when:** A hard latency or copy-cost requirement is known up front and measured on the target workload.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Taxonomy of Unix IPC Methods) ; http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Shared Memory). Book only.
