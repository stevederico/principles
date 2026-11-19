# Redact server errors in production, correlate by digest

**Rule:** Send clients a generic message with an opaque identifier for server-side failures, log the full detail on the server under that identifier, and render a static error page rather than exception text; keep real messages in development only.

**Why:** Server error text can leak internals, paths and queries. The digest lets support match a user report to a server log line. Error pages are hit often under trouble, so building them as static files keeps them fast and cheap.

**Do:**
```
on server error:
  id = digest(error); log(id, error.full)
  respond("Something went wrong", id)
404 and 500 pages: built ahead, no loaders
```

**Don't:** Forward raw exception messages to browsers, or run full data loaders on error pages.

**Break it when:** Local development, or an internal tool with controlled access where detail helps.

**Source:** https://nextjs.org/docs/app/api-reference/file-conventions/error, https://nextjs.org/docs/pages/building-your-application/data-fetching/get-server-side-props, https://nextjs.org/docs/pages/building-your-application/routing/custom-error; code: packages/next/src/server/app-render/create-error-handler.tsx, packages/next/src/build/index.ts
