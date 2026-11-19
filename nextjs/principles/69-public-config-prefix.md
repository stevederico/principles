# Config is server-private unless prefixed, and public values freeze at build

**Rule:** Treat every environment variable as server-only unless its name carries the public prefix, treat public values (and any value declared in build config) as constants baked into the client bundle, and read anything environment-specific on the server at request time so one built artifact can be promoted through environments.

**Why:** Inlining is a build-time scan for the prefix; dynamic lookups cannot be replaced statically, so a prefixed secret ships to every client and a value built with staging settings stays staging after promotion. Reading at request time requires dynamic rendering or handing the value to the client from the server. In tests, local override files are skipped so every machine gets identical results.

**Do:**
```
PUBLIC_SITE_NAME=...      # inlined into the client bundle at build
API_KEY=...               # server only
per-environment value: read env on the server at request time, pass down as a prop
```

**Don't:** Prefix a secret to make it work, read env by a dynamic key for public values, or rebuild per environment just to change config.

**Break it when:** A value that is constant per artifact and safe to expose (a build id, a public key).

**Source:** https://nextjs.org/docs/app/guides/environment-variables, https://nextjs.org/docs/app/api-reference/config/next-config-js/env, https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/getting-started/server-and-client-components; code: packages/next/src/lib/static-env.ts, packages/next/src/lib/inline-static-env.ts
