# Authenticate by default and opt out in one line

**Rule:** The base controller requires authentication through an included concern; public, signed-out-only and API-key access are declared by class-level macros at the top of each controller. API clients are sibling controllers with their own key, denied everywhere except an explicit action list.

**Why:** Forgetting the macro yields a locked page, not an open one. Subclassing shares logic while limiting blast radius, and CSRF is skipped only when the key was used. A key that travels in a URL must be scrubbed from logs beyond parameter filters.

**Do:**
```
ApplicationController includes Authentication, Authorization
FirstRunsController: allow_unauthenticated_access
ByBotsController:    allow_bot_access only [index, create]
log formatter: replace /rooms/<id>/<botkey> with FILTERED
```

**Don't:** Use opt-in `authenticate` filters, or build a separate API app duplicating the rules.

**Break it when:** The service is a fully public site, or the API needs a different shape (add a serializer layer).

**Source:** https://github.com/basecamp/once-campfire app/controllers/application_controller.rb, app/controllers/concerns/authentication.rb, app/controllers/messages/by_bots_controller.rb, lib/rails_ext/log_scrubbing_formatter.rb ; https://github.com/basecamp/writebook app/controllers/concerns/authentication.rb.
