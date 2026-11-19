# Route model binding

**Rule:** Let the router turn an id in the URL into the loaded object before your handler runs. A missing object returns "not found" automatically.

**Why:** Every handler would otherwise start with "load it, check it exists". That is noise, and easy to forget.

**Do:**
```
route /posts/{post} -> show(post: Post)
# router: Post.findOrFail(id) -> not found = 404, no code in the handler

show(post): respond(post)
```

**Don't:** Write `post = find(id); if not post: return 404` in every handler.

**Break it when:** Lookup needs extra rules (scope by tenant). Define the rule once on the binding.

**Source:** Laravel docs, routing.
