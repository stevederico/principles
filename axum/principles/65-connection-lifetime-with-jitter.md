# Rotate connections by age, with jitter and an opt-in grace

**Rule:** To make clients rotate connections (so new backends get traffic), cap connection age, add random per-connection jitter, and force-close in-flight work only if a grace period was explicitly set.

**Why:** The docs explain the load-balancer motivation and the reconnect-storm risk without jitter. Without a grace period the age only stops new requests; with one it becomes a hard deadline and slow requests are cut off with no response. HTTP/1 sends a close header and HTTP/2 a goaway; upgraded connections are not tracked. The age also bounds shutdown on a stuck handler.

**Do:**
```
limit = max_age + random(0..jitter)
at limit: connection.graceful_shutdown(); if grace set: after grace, force close
```

**Don't:** Set a grace shorter than your slowest legitimate request, or rotate every connection at the same instant.

**Break it when:** Long-lived streams or upgrades dominate the traffic (docs note upgraded connections are not tracked).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/serve/mod.rs (connection_lifetime_limits docs, random_duration, tests).
