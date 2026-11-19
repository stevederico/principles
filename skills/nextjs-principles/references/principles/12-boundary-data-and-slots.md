# Code crosses by import, data by serializable props

**Rule:** Declare the client boundary once per entry module, pass only serializable values across it (no plain functions or class instances), and let a parent that owns both pieces pass server-rendered output into a client component as a slot rather than importing it.

**Why:** A client module's imports ship to the browser, while rendered server output is just data the client places without receiving its code. A server module importing a client component gets only a reference, so static members on it do not exist.

**Do:**
```
server page:
  client_modal(content = server_cart_view())     # output passed as a slot
client modules: export each piece by name
```

**Don't:** Import a server component inside a client file (it turns into client code), pass event handlers from server to client, or use static properties on a client component from server code.

**Break it when:** The child needs client state; then it belongs on the client side.

**Source:** https://nextjs.org/docs/app/guides/server-and-client-boundary, https://nextjs.org/docs/app/api-reference/directives/use-client; docs only
