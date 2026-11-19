# The URL never picks the code that runs

**Rule:** A route table names every handler explicitly. A URL segment must not be able to choose which handler or action runs, and order is part of the design because the first match wins.

**Why:** A dynamic handler segment exposes every public method. Rails now raises when such a route is drawn.

**Do:**
```
get "/photos/:id" -> photos.show        # handler fixed at definition
specific routes before generic ones
list_routes --unused                    # find routes nothing references
```

**Don't:** Ship a catch-all like "/:handler/:action".

**Break it when:** A mounted dispatcher is its own app and maps names itself, ideally against an allow-list.

**Source:** Guides: https://guides.rubyonrails.org/routing.html (Dynamic Segments note, CRUD, Verbs, and Actions); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 8.1 to 8.2, dynamic route segments). Code: actionpack/lib/action_dispatch/routing/mapper.rb:205-215,438-441.
