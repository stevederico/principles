# Resource routes

**Rule:** Map each resource to one handler group with a fixed conventional set of actions (list, new form, create, show, edit form, update, delete) registered in one line, put any extra routes before the resource line, and move a complex or off-pattern action into its own single-action handler.

**Why:** Everyone can guess the URL, verb and name of an action, and every action gets a route name for free. Extra literal routes that come after a wildcard resource line can be swallowed by it. The docs advise splitting a handler once you routinely add methods outside the standard set, and offer an API variant without the two form screens plus a singleton form (no create route, no identifier) for a resource that only ever has one instance.

**Do:**
```
resource("photos", PhotoHandler)          # index, create, store, show, edit, update, destroy
get("/photos/popular", PhotoHandler.popular)  # extra route goes BEFORE the resource line
resource("photos", PhotoHandler)
api_resource("photos", ApiPhotoHandler)    # no form screens
get("/reports/export", ExportReport)       # one complex action, its own handler
```

**Don't:** Adding a ninth method to a resource handler, hand-writing the seven routes, or registering a literal path after the resource that shares its prefix.

**Break it when:** A narrow RPC-style surface where the seven actions do not fit: name routes by hand and keep them consistent.

**Source:** https://laravel.com/docs/controllers, https://laravel.com/docs/routing ; code: src/Illuminate/Routing/ResourceRegistrar.php
