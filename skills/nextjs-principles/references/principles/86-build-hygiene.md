# Own the build output and cache it only where it persists

**Rule:** Treat the build directory as tool-owned inside the workspace and refuse a value equal to or containing the app directory, write dev and production output to separate directories with a lock holding the owner's pid and url, persist the incremental build cache between CI runs keyed by lockfile and source hashes with a lockfile-only fallback, and keep generated files out of version control and hand edits.

**Why:** A tool that cleans its output can delete source if pointed wrongly. Concurrent dev and build in one tree corrupt each other, and a lock lets humans and agents find the running server. A cache that is written and never restored wastes time, and a key that never changes goes stale or changes every run and never hits.

**Do:**
```
dist_dir inside workspace; dev_dir != build_dir
lock: exclusive lock on dev/lock, write {pid, port, url}; second start reports the first
cache.key = os + hash(lockfile) + hash(sources); restore_keys = [os + hash(lockfile)]
```

**Don't:** Store hand-written files in the output directory, share one cache between concurrent dev and build, or edit a generated declaration file.

**Break it when:** Reproducibility audits that require clean builds; ephemeral builds where a cold start is acceptable.

**Source:** https://nextjs.org/docs/app/guides/ci-build-caching, https://nextjs.org/docs/app/api-reference/config/next-config-js/distDir, https://nextjs.org/docs/app/api-reference/cli/next, https://nextjs.org/docs/app/api-reference/config/typescript; code: packages/next/src/lib/dist-dir.ts, packages/next/src/build/lockfile.ts, packages/next/src/build/index.ts
