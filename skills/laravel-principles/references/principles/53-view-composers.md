# Bind recurring view data once

**Rule:** When several handlers render the same template and always need the same extra data, register that data supplier once against the template name (or a wildcard) instead of fetching it in each handler.

**Why:** Handlers stay thin and the data cannot be forgotten. Data every view needs can be shared globally. The composer runs each time the view renders, so an expensive lookup on a wildcard composer is paid on every render.

**Do:**
```
view_composer("profile", view -> view.with("count", users.count()))
share("app_name", "Example")          # for all views
```

**Don't:** Repeating the same lookup in ten handlers, or putting an expensive query in a wildcard composer.

**Break it when:** Data that depends on the handler's own context.

**Source:** https://laravel.com/docs/views ; code: docs only
