# Give each non-CRUD behavior its own singular resource

**Rule:** When an object needs a new verb (ban, publish, move, refresh, reset a key), add a small controller for a noun that represents that state and give it only create, update, destroy or show.

**Why:** Every controller stays on the standard actions, routes read as nested resources, and each guard filter applies to a tiny surface.

**Do:**
```
resource user:    resource ban          { create -> user.ban ; destroy -> user.unban }
resource book:    resource publication  { show edit update }
resource account: resource join_code    { create -> account.reset_join_code }
```

**Don't:** Add custom actions such as "ban_user" to the parent controller.

**Break it when:** The action really is one of the standard ones on the parent.

**Source:** https://github.com/basecamp/once-campfire config/routes.rb, app/controllers/users/bans_controller.rb, app/controllers/accounts/join_codes_controller.rb ; https://github.com/basecamp/writebook config/routes.rb, app/controllers/books/publications_controller.rb, app/controllers/books/leaves/moves_controller.rb.
