# Out-of-request code has no ambient context

**Rule:** Set per-request ambient state (language, time zone, current user) in a scoped block that restores the old value, capture it in each job's payload and restore it at run time, and give mail and jobs configured absolute URLs.

**Why:** Assigning a thread-wide value leaks into later requests on that thread. A worker has no request, so it would use the default language and zone. An email is read elsewhere, so a relative link is broken.

**Do:**
```
around every request: with_locale(pick(request)) { handle(request) }   # restored even on error
enqueue(job): payload = {args, locale: current_locale, zone: current_zone}
perform(payload): with_locale(payload.locale) { with_zone(payload.zone) { run } }
current_user holder: cleared automatically when the request or job ends
config: default_url_options.host = "example.com"; email link = full_url(route)
now = clock.current()          # the user's zone, not the server's
```

**Don't:** Assign `current_locale = "es"` in one handler and hope the next overwrites it, use relative paths in messages, or let the host default to localhost in production.

**Break it when:** System jobs not tied to a user (a nightly report in the company zone), or state that is truly process-wide config set once at boot.

**Source:** Guides: https://guides.rubyonrails.org/i18n.html (Managing the Locale across Requests); https://guides.rubyonrails.org/action_mailer_basics.html (Generating URLs in Action Mailer Views, Adding Images); https://guides.rubyonrails.org/5_2_release_notes.html (CurrentAttributes); https://guides.rubyonrails.org/active_support_core_extensions.html (Time.current). Code: activejob/lib/active_job/core.rb:121-134,174; activejob/lib/active_job/execution_state.rb:5-9; actionpack/lib/action_dispatch/http/url.rb:156-162; activesupport/lib/active_support/railtie.rb:51-66; activesupport/lib/active_support/core_ext/time/calculations.rb:44-46.
