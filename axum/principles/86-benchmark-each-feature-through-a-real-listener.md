# Benchmark each feature against a minimal baseline

**Rule:** Keep an end-to-end benchmark suite where each scenario isolates one feature (empty app, single route, merge, nest, many routes, JSON in and out, state versus attachment) against a real socket with an external load tool.

**Why:** The harness builds an actual server per scenario, filters scenarios by name, uses short runs in CI and long runs locally, and compares state with the attachment path using identical payloads. The README claims thin overhead over the HTTP engine.

**Do:**
```
for scenario in [minimal, routing_1000, json_in, state, attachment]:
    start_server(scenario); run_load_tool; print(results)
```

**Don't:** Claim performance from micro-benchmarks that skip the network stack and router.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/benches/benches.rs; https://github.com/tokio-rs/axum/blob/main/README.md ("Performance").
