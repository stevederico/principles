# Detect version skew with a deployment id and reload

**Rule:** Tag assets, client requests and cache keys with a deployment id, compare it on the server, do a full page load on mismatch, prefer rolling deploys, and keep old hashed assets available while any live deployment can request them.

**Why:** During a rolling deploy a client holding build N can call deleted assets, unknown mutation ids or incompatible prefetch data on build N+1. A full load gets a consistent version at the cost of component state, so keep important state in the URL or storage. The id does not route requests; without host or CDN routing per deployment, a skewed client simply reloads. Mutation ids rotate per build.

**Do:**
```
client request: header deployment_id
server: if header != current_id: respond "reload"
client: hard navigation; retry or refresh path for unknown mutation ids
assets: append-only static folder
```

**Don't:** Let a stale client soft-navigate against a new server, treat an unknown mutation id as fatal, or cut over abruptly mid-mutation.

**Break it when:** One instance with atomic restarts and no CDN, so only one version ever exists.

**Source:** https://nextjs.org/docs/app/guides/self-hosting, https://nextjs.org/docs/app/api-reference/config/next-config-js/deploymentId, https://nextjs.org/docs/app/guides/server-actions, https://nextjs.org/docs/app/api-reference/adapters/immutable-static-assets; code: packages/next/src/shared/lib/router/router.ts, packages/next/src/client/components/router-reducer/fetch-server-response.ts, packages/next/src/lib/constants.ts
