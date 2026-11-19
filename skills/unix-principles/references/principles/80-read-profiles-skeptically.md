# Measure with a harness, read profiles skeptically, and leave cold code alone

**Rule:** Build tests and a repeatable load before tuning, use them both to catch regressions and to profile, treat profiler output with suspicion, and fit cost against problem size to see where regimes change.

**Why:** Even authors who know the code guess wrong. Instrumentation adds noise that inflates tiny routines, outside latency makes single runs unreliable, and time charged to callers overweights the upper nodes of a call graph. A fitted model smooths noise and exposes boundaries, such as in-cache versus out-of-memory regions. Most runtime sits in a small share of the code, and refusing to touch the rest holds complexity down.

**Do:**
```
harness = test_load + expected_outputs
for size in sizes: record(cost); fit(model); inspect(deviations)
check call counts of tiny hot routines; keep upper-level routines mostly calls
after each tuning change: run harness (correctness) then profile (speed)
```

**Don't:** Tune with no way to tell whether behavior changed, rely on one timing at one size, or optimize everything "while you are in there".

**Break it when:** Throwaway code, or a one-off check where heavy tooling is pointless.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch12s02.html (Measure before Optimizing) ; http://www.catb.org/esr/writings/taoup/html/ch15s07.html (Profiling). Book only.
