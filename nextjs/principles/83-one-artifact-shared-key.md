# Every instance runs one artifact and shares its keys

**Rule:** Boot every instance of a release from one build artifact (or pin the build id, for example to the commit hash) and give all instances the same symmetric key used to encrypt values closed over by server functions; supply the key explicitly when several instances serve one build.

**Why:** Captured values travel to the client and back, encrypted with a key generated per build and rotated at most every 14 days. An instance with a different generated key cannot decrypt another's values and fails with "action not found", and differing build ids make instances disagree on version. Encryption blocks tampering but is no excuse for capturing secrets.

**Do:**
```
build once -> image
all replicas: ENCRYPTION_KEY from environment; BUILD_ID pinned
```

**Don't:** Rebuild per instance or stage with auto-generated ids and keys, or capture secrets in closed-over variables.

**Break it when:** A single instance with no rolling deploy.

**Source:** https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/guides/data-security; code: packages/next/src/server/app-render/encryption-utils-server.ts, packages/next/src/server/app-render/encryption-utils.ts
