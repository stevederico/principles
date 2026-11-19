# Make server-only modules fail the build in client code

**Rule:** Mark modules that touch secrets or server resources so that importing them from client code fails the build, instead of relying on naming or on runtime failure.

**Why:** Modules are shared across both environments. Without a marker a server function imported by client code ships to the browser, runs without its secrets, fails confusingly and may leak logic. The bundler resolves the marker differently per layer: empty on the server, a throwing module on the client.

**Do:**
```
data_access module:
  import server_only_marker
  get_data(): call(api, secret_header)
client module imports it -> build error with a clear message
```

**Don't:** Assume a server function "just will not work" in the browser, or alias the error away when refactoring the import graph would fix it.

**Break it when:** A pure helper with no secrets and no server-only dependency meant for both sides.

**Source:** https://nextjs.org/docs/app/getting-started/server-and-client-components, https://nextjs.org/docs/app/guides/data-security; code: packages/next/src/build/create-compiler-aliases.ts
