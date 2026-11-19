# One error table, one reporter, narrow catches

**Rule:** Keep one table from error type to response status (unlisted is a server error), register handlers only for named errors, send all errors through one reporter with a swallow variant and a rethrow variant, and catch only the exact failure you expected.

**Why:** Handlers stay free of status logic, and an unknown failure cannot masquerade as a client mistake. A catch-all stops the framework from handling errors properly. A missing-name error for a different thing inside an optional file is a real bug.

**Do:**
```
status_for = {NotFound: 404, StaleVersion: 409, InvalidRecord: 422, BadParams: 400}  default 500
on NotAuthorized -> redirect back with message           # never a handler for the root error type
value = reporter.handle(fallback = anonymous): load_user(id)   # reported, swallowed
reporter.record: charge(order)                           # reported, rethrown
reporter.context.add(request_id, tenant)                 # once, for every subscriber
try load_optional("posts_helper") catch NotFound e: if e.name != "posts_helper": raise e
```

**Don't:** Return 200 with an error body, scatter try/catch plus vendor calls, let a subscriber raise into the request, or report client-fault errors (not found, bad params).

**Break it when:** A probe endpoint that must always answer up or down may rescue everything. A single endpoint with a special response uses a local handler.

**Source:** Guides: https://guides.rubyonrails.org/error_reporting.html; https://guides.rubyonrails.org/action_controller_advanced_topics.html (rescue_from); https://guides.rubyonrails.org/configuring.html (rescue_responses, show_exceptions); https://guides.rubyonrails.org/active_support_core_extensions.html (Extensions to NameError). Code: actionpack/lib/action_dispatch/middleware/exception_wrapper.rb:12,183,202; activesupport/lib/active_support/error_reporter.rb:83,119,167-172,239-275; railties/lib/rails/health_controller.rb; actionpack/lib/abstract_controller/helpers.rb:235-240.
