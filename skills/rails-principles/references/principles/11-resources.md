# Everything is a resource

**Rule:** Model the app as things with a small fixed set of actions (list, show, new, create, edit, update, destroy). A new capability becomes a new resource, singular when there is one per user or session.

**Why:** A small vocabulary is predictable: URLs, handlers and tests follow one pattern. Many extra actions usually disguise another resource, and a custom action name can collide with a framework method.

**Do:**
```
POST /posts/5/publication     # create a publication, not a "publish" verb
/password   (show, update)    # singular: no id in the URL
/sign_up    (show, create)
/products        read-only public handler
/admin/products  full handler in its own namespace
```

**Don't:** Grow a handler with twenty custom actions, or one handler full of "if admin" branches.

**Break it when:** The domain is an operation, not a thing (search, login, legacy URLs). Keep the exception small and name it.

**Source:** Guides: https://guides.rubyonrails.org/routing.html (Resource Routing, Singular Resources, Adding Routes for Additional New Actions, Non-Resourceful Routes); https://guides.rubyonrails.org/action_controller_overview.html (Structure of a Controller); https://guides.rubyonrails.org/sign_up_and_settings.html; https://guides.rubyonrails.org/product_reviews.html. Code: actionpack/lib/action_dispatch/routing/mapper.rb:2119-2120.
