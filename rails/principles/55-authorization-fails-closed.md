# Authorization fails closed

**Rule:** Require a signed-in user on every handler through the base type and let each public handler opt out by name. Fetch owned records through the current owner's own collection so a foreign id is simply not found. Keep admin handlers in a separate tree with a role-checking base.

**Why:** A forgotten annotation then fails closed. One base type makes the rule visible and testable. Lookup through the owner answers 404, so no ownership check can be forgotten.

**Do:**
```
Base:        require_login on all actions
Catalog:     allow_anonymous only [index, show]
AdminBase:   require_role(admin);  admin/products inherits it
wishlist = current_user.wishlists.find(id)         # not Wishlist.find(id) then an if
opt-out naming an action that does not exist -> error at boot
test: another user's id -> 404 and nothing changed; regular user redirected from every admin route
```

**Don't:** List the handlers you protect ("only these"), add `if admin` inside actions, load by bare id then check later, or keep edit and delete buttons in public views.

**Break it when:** A mostly public site: guard the few private areas, still in one base rule. Per-record permissions need a policy layer on top of roles.

**Source:** Guides: https://guides.rubyonrails.org/security.html (Permitted Lists Versus Restricted Lists, Privilege Escalation); https://guides.rubyonrails.org/getting_started.html (Allowing Unauthenticated Access); https://guides.rubyonrails.org/sign_up_and_settings.html (Adding Admin Only Access, Testing Settings); https://guides.rubyonrails.org/wishlists.html (Wishlists Controller, Testing Wishlist Products). Code: railties/lib/rails/generators/rails/authentication/templates/app/controllers/concerns/authentication.rb.tt:4-13; actionpack/lib/abstract_controller/callbacks.rb:51,61-77; activerecord/lib/active_record/railtie.rb:25.
