# Emit traces through a vendor-neutral standard

**Rule:** Emit traces through a provider-neutral API, load runtime-specific SDK code only in the runtime that supports it, emit a modest default span set, and gate high-volume spans behind an explicit switch that can also turn off a built-in class so a custom library can own it.

**Why:** A neutral standard lets you swap observability vendors without code change. A node-only SDK is not compatible with the edge runtime, so it is imported conditionally. Always emitting every span costs money and adds noise, and instrumenting the same call twice duplicates data.

**Do:**
```
startup:
  if runtime == "node": import node_tracing_sdk
verbose_spans = off by default; on temporarily while debugging
```

**Don't:** Import the node-only SDK at the top of a shared startup file, or double-instrument one call.

**Break it when:** One runtime only; no split needed.

**Source:** https://nextjs.org/docs/app/guides/open-telemetry, https://nextjs.org/docs/app/guides/instrumentation; code: packages/next/src/server/lib/trace/tracer.ts
