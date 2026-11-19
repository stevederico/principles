# Route model binding

**Rule:** Let the router turn a URL segment into the loaded object (by id or a chosen unique key) before the handler runs, and no match means not-found, and a nested segment is looked up through its parent.

**Why:** Handlers stop repeating load-and-check code. Nesting makes "post 9 of user 1" fail when post 9 belongs to someone else, instead of leaking it through a global lookup. Models can override the resolver (custom key, soft-delete handling).

**Do:**
```
route /users/{user}/posts/{post:slug} -> show(user: User, post: Post)
# router: user = User.find(seg1)             else 404
#         post = user.posts.find(slug = seg2) else 404
show(user, post): respond(post)
```

**Don't:** Looking the child up with a global query and hoping the caller owns it.

**Break it when:** Soft-deleted rows must be reachable (restore, audit routes): opt in on that route only. A miss should redirect instead of 404: attach a missing-handler to that route.

**Source:** https://laravel.com/docs/routing, https://laravel.com/docs/controllers ; code: src/Illuminate/Routing/ImplicitRouteBinding.php, src/Illuminate/Database/Eloquent/Model.php, src/Illuminate/Foundation/Exceptions/Handler.php
