# Say what you optimize for, then measure

**Rule:** Pick the property you care about (throughput, latency or memory), since improving one usually costs another, then tune by measurement on production-like hardware.

**Why:** Threads help only while requests wait on I/O; processes give parallelism at a memory cost. Averages hide the tail, laptops differ from servers, and the framework's own timing log excludes the server's queue time.

**Do:**
```
goal: p99 latency under 300 ms at 200 req/s
test on a production-size host; discard warmup; compare p50, p90, p99
start with a few request types; use a real load tool
change one setting at a time; A/B settings across production servers
```

**Don't:** Tune from the average, from your laptop, or from the framework's own timing log.

**Break it when:** Traffic is low and defaults are fine.

**Source:** Guide: https://guides.rubyonrails.org/tuning_performance_for_deployment.html (What to Optimize for?, Understanding Ruby's Concurrency and Parallelism, Performance Testing). Code: railties/lib/rails/generators/rails/app/templates/config/puma.rb.tt:11-20 (default of 3 threads and its rationale).
