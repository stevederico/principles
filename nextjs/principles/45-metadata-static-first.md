# Declare metadata statically unless data decides it

**Rule:** Use a plain static value for page metadata unless it depends on route parameters or fetched content; when it does, use a server-side generator that shares a memoized read with the page body, and know that parent and child values merge shallowly so a nested object is replaced whole.

**Why:** Static values prerender trivially and dynamic ones may force request-time work or an extra fetch. Generators run on the server only, so memoizing the shared read keeps it to one request. A child that sets one nested field loses the parent's other nested fields, and a title template applies only to descendants.

**Do:**
```
static:  metadata = { title, description }
dynamic: generate_metadata(params): post = memo_get_post(params.slug); return {...}
page:    post = memo_get_post(params.slug)
```

**Don't:** Use a function for fixed values, fetch the same record twice, or expect partial nested overrides to deep merge.

**Break it when:** Metadata needs the parent's resolved values; accept the parent argument instead.

**Source:** https://nextjs.org/docs/app/getting-started/metadata-and-og-images, https://nextjs.org/docs/app/api-reference/functions/generate-metadata; code: packages/next/src/lib/metadata/metadata-resolution-primitives.ts
