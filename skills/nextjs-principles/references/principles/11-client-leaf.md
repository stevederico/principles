# Put the client boundary at the interactive leaf

**Rule:** Mark only the smallest interactive component as client code, keep layout, data access and static markup on the server, wrap each third-party client-only widget once in your own client module, and place context providers as deep as they can go.

**Why:** Everything a client module imports or renders joins the browser bundle and loses server-only data access. A provider around the whole document pushes more of the tree into the client path. Native elements (disclosure, plain form posts) need no client code at all.

**Do:**
```
layout (server)
  logo (server)
  search (client)                            # only this module carries the marker
  theme_provider (client) wraps children only
wrapper module (client): reexport carousel from third_party
```

**Don't:** Put the client marker on a page or layout "to be safe", mark every consumer of a third-party widget, or wrap the whole document in a provider.

**Break it when:** A whole subtree is heavily interactive and shares state; one boundary at its root is simpler.

**Source:** https://nextjs.org/docs/app/getting-started/server-and-client-components, https://nextjs.org/docs/app/guides/server-and-client-boundary; docs only
