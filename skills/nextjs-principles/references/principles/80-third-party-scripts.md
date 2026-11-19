# Load each third-party script once, narrowly, with a priority

**Rule:** Include each external script in the smallest layout that needs it, load identical sources once, classify each by when it must run (before interaction, soon after, idle), give inline scripts a stable id, and use one analytics path per signal, turning off the automatic one if you send events manually.

**Why:** Early tiers delay first-party code, so only consent or bot detection belong there; analytics fit the default tier and widgets fit idle. Duplicate components for one source share a load. Route changes already emit page views, so a second collector double-counts. Analytics reporting should use a fire-and-forget beacon so it survives page unload.

**Do:**
```
script(src, strategy = idle)                 # chat widget
script(src, strategy = after_interactive)    # analytics, once
report(metric): beacon(url, json) or keepalive request
```

**Don't:** Put every vendor snippet in the root layout, add a tag manager and a direct analytics script for one property, or wait on analytics in a render path.

**Break it when:** A script required to render the first view, or a consent manager needed on every page.

**Source:** https://nextjs.org/docs/app/guides/scripts, https://nextjs.org/docs/app/api-reference/components/script, https://nextjs.org/docs/app/guides/third-party-libraries, https://nextjs.org/docs/app/guides/analytics; code: packages/next/src/client/script.tsx
