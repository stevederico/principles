# Never swallow the framework's control-flow throws

**Rule:** When the framework signals redirect, not-found, auth failure or prerender bail-out by throwing, call those functions outside try blocks or rethrow the framework's sentinels first in any catch, and keep your own error handling for application errors.

**Why:** A catch-all turns a redirect or 404 into a swallowed error so the intended UI never renders, or cancels the bail-out and adds build noise. The framework's own boundaries rethrow these sentinels so a parent can handle them.

**Do:**
```
try:
  result = work()
catch e:
  rethrow_if_framework_signal(e)             # first line
  log(e)
redirect(target)                             # outside the try
```

**Don't:** Wrap a call that throws a redirect in a generic try that logs and moves on, or log every caught error without filtering signals.

**Break it when:** Your code owns the signal's lifecycle and handles it deliberately.

**Source:** https://nextjs.org/docs/app/api-reference/functions/unstable_rethrow, https://nextjs.org/docs/app/api-reference/functions/not-found, https://nextjs.org/docs/app/api-reference/functions/redirect, https://nextjs.org/docs/app/guides/migrating-to-cache-components; code: packages/next/src/client/components/unstable-rethrow.ts, packages/next/src/client/components/error-boundary.tsx, packages/next/src/client/components/redirect.ts
