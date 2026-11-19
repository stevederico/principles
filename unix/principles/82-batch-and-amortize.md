# Batch work that shares setup cost and compute on demand by default

**Rule:** Group operations that share a fixed cost, keep a long-lived process when loading data is expensive, and compute results when asked rather than in anticipation, adding precomputation only to meet a measured throughput target.

**Why:** Buffered writes flushed at chosen moments, and a daemon holding parsed data in memory across requests, avoid repeating setup. Cycles are cheap, so short start-up and quick response matter more to users than total cycles saved by precomputing.

**Do:**
```
buffer(updates); flush(at_chosen_boundary)
daemon: load_data_once(); serve(many_requests)
result = compute_when_asked()
if measured_throughput < requirement: add(precompute or cache)
```

**Don't:** Start a fresh process per request that re-parses the same database, or precompute everything at start-up "for efficiency".

**Break it when:** Updates must be visible immediately, or the workload is monstrously compute-bound and throughput is the goal.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch12s04.html (Throughput vs. Latency (Batching Operations and Overlapping Operations)). Book only.
