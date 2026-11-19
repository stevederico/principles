# Record every user-facing error with an owner

**Rule:** When a user sees a generic error screen, a matching exception record with context must exist for engineers, a named group owns keeping the exception list under control, and dashboards with alert rules and searchable logs cover performance and delivery.

**Why:** Errors that leave no record cannot be diagnosed, and exceptions, metrics with alerts and logs answer three different questions.

**Do:**
```
on unhandled error: show generic page AND record exception with context
owner: the on-call group triages the exception list
metrics: dashboards and alert rules ; logs: searchable for slow requests and delivery
```

**Don't:** Swallow errors behind a friendly page with no record.

**Break it when:** Privacy rules forbid logging the data; record a scrubbed version.

**Source:** https://github.com/basecamp/handbook/blob/main/our-internal-systems.md. Docs only.
