# Sample and group telemetry

**Rule:** For high-volume metrics sample, aggregate into time buckets at write time, label scaled values as estimates, trim data outside the display window, and group by normalized keys with thresholds set per pattern.

**Why:** Dashboards stay fast without scanning millions of rows. Without key grouping every id becomes its own row, and one global slow threshold flags known slow endpoints all day. Capture failures are swallowed so monitoring cannot break the app it watches, and under heavy traffic the data can go to its own database or an ingest stream.

**Do:**
```
record("sale", key = user.id, value = amount).sum().count()      # bucketed on write
sample_rate 0.1 -> show "~" and multiply stored values by 10
groups: { "/:\d+/": ":*" }                  # first matching rewrite wins
thresholds: { "^/admin/": 5000, default: 1000 }
```

**Don't:** Aggregating raw rows on every dashboard refresh, alerting on raw URLs, or writing metrics synchronously with exceptions allowed.

**Break it when:** Low volume, or exact figures such as billing: record everything.

**Source:** https://laravel.com/docs/pulse ; code: docs only
