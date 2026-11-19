# Stream the shell first, each region at its boundary

**Rule:** Send the shell immediately and stream each pending region as it completes, independently of its siblings; deliver HTML for first paint and a separate serialized component payload for hydration and client navigation, so navigations fetch only the payload.

**Why:** A slow query otherwise blocks the whole document. Chunks arrive in resolve order, each boundary hydrates on its own, and the user's interaction can be prioritized; one giant boundary means one blocking hydration pass. Skipping HTML on navigations cuts transfer and updates in place.

**Do:**
```
response: shell now
  region_a streams when ready
  region_b streams when ready
client navigation: request(payload_header) -> payload only
```

**Don't:** Wrap the whole page in one boundary for independent sections, or reload full HTML on every navigation.

**Break it when:** Nothing meaningful renders until data arrives; a full-page skeleton is fine. Version skew was detected; do a hard navigation.

**Source:** https://nextjs.org/docs/app/guides/streaming, https://nextjs.org/docs/app/getting-started/linking-and-navigating; code: packages/next/src/client/components/app-router-headers.ts
