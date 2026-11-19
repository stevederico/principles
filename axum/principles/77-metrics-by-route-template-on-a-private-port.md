# Label metrics by route template and serve them privately

**Rule:** Record counters and latency histograms labelled with method, route template and status, count only matched routes, and serve the metrics endpoint on a separate private listener.

**Why:** The matched pattern is the same for every id, so label cardinality stays bounded; nested patterns are concatenated, and fallback and mounted-service requests have none, which tests pin. The example's comment says the metrics endpoint must not be public, so it uses a second port.

**Do:**
```
labels = {method, matched_path or raw_path, status}
counter("http_requests_total", labels).inc()
serve(metrics_listener("127.0.0.1:3001"), metrics_app)
```

**Don't:** Put raw URLs with ids in metric labels, or publish metrics on the public port.

**Break it when:** Log the raw path at low-volume trace level when debugging one resource (the matched-path docs show both values).

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/matched_path.rs (MatchedPath docs and tests); https://github.com/tokio-rs/axum/blob/main/examples/prometheus-metrics/src/main.rs.
