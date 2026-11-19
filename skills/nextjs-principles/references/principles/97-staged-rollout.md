# Roll changes out per scope, then globally, then delete the flag

**Rule:** Ship a behavior change as opt-in at the narrowest scope (per route), then a global switch, warn when the switch is unset, flip the default, and finally delete the option; when a strict validation flags many routes at once, add a greppable per-route opt-out everywhere by codemod, get building, then remove it route by route.

**Why:** Teams can adopt and deploy one destination at a time, and the unset-warning prevents silent drift. Opt-outs are visible debt. Dependent flags must fail fast when their prerequisite is off, and an opt-out that only permits blocking does not by itself make the route dynamic.

**Do:**
```
route.mode = new            # step 1
config.new_mode = true      # step 2: error if prerequisite flag is off
warn when new_mode unset    # step 3
codemod: add opt_out marker everywhere, then remove one route at a time
```

**Don't:** Flip a global default with no migration path, hand-convert every route in one change, or leave opt-outs untracked.

**Break it when:** The change is small enough to ship in one step, or the app is new.

**Source:** https://nextjs.org/docs/app/guides/adopting-partial-prefetching, https://nextjs.org/docs/app/guides/migrating-to-cache-components, https://nextjs.org/docs/app/api-reference/config/next-config-js/partialPrefetching; code: packages/next/src/server/config.ts
