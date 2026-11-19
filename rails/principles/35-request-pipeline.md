# Build the request path from small wrappers

**Rule:** Implement cross-cutting request concerns (host check, logging, request id, error pages, cookies, caching headers) as small single-purpose wrappers around the app, all with one call shape so a handler, a function or a whole app can sit at any route. Configuration adds, removes, swaps and orders them.

**Why:** A wrapper may act before, act after, or answer without calling inner code. One shape composes with any server. Order matters: the host check runs first, request id before the logger and error pages.

**Do:**
```
stack = [HostCheck, Static, Executor, RequestId, Logger, ShowErrors, Cookies, Session, ETag]
if api_only: remove Cookies, Session, Flash
insert_before(Logger, AuditTrail)
app = fold(stack, router)       # wrapper: before(); r = inner(env); after(r)
route "/health" -> function(request): response(204)
route "/admin"  -> mount(AdminApp)        # app sees paths without the prefix
```

**Don't:** Repeat logging, auth and header changes inside each handler, or add a wrapper without knowing its position.

**Break it when:** A concern needs the matched route or domain object (per-record authorization): use a handler-level hook there.

**Source:** Guides: https://guides.rubyonrails.org/rails_on_rack.html (Rack Middleware, Configuring the Middleware Stack, Internal Middleware Stack); https://guides.rubyonrails.org/routing.html (Routing to Rack Applications). Code: railties/lib/rails/application/default_middleware_stack.rb:16-111; actionpack/lib/action_controller/metal.rb:384-397.
