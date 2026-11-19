# Read data where it renders, straight from its source

**Rule:** Components that render on the server read their data directly from the database or service in the component that needs it, instead of calling your own HTTP endpoint or threading it through a separate loader step.

**Why:** Calling your own endpoint adds a network round trip, and at build time no server is listening so prerendered pages that do this fail the build. Fetching where the data is used removes prop drilling when reads are deduplicated per request.

**Do:**
```
page():
  data = data_layer.get(id)                  # direct call
# endpoints exist for outside clients and browser-side fetching only
```

**Don't:** Fetch the absolute URL of your own API from a page, or create an endpoint only to feed your own server component.

**Break it when:** The browser itself needs the endpoint (polling, client-only APIs), or the endpoint is a separate service.

**Source:** https://nextjs.org/docs/app/guides/backend-for-frontend, https://nextjs.org/docs/app/guides/production-checklist, https://nextjs.org/docs/pages/building-your-application/data-fetching/get-server-side-props; docs only
