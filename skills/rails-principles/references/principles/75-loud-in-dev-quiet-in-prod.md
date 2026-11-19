# Fail loudly where a developer is watching

**Rule:** Configure development and test to raise on suspicious conditions, and production to report and continue. Load all code at boot in production and in CI so loading mistakes show before deploy.

**Why:** Bugs surface early, yet a rare "can't happen" condition does not take the site down. Stricter-everywhere causes an outage from a surprise; lenient-everywhere hides typos until a user finds them.

**Do:**
```
report_unexpected(error):
  if env in (dev, test): raise wrapped error (so no outer handler hides it)
  else: send to the error reporter; continue
dev/test: raise on pending migrations, hooks naming missing actions, unpermitted params
production: log and continue (and alert)
eager_load = true in production; in test only when the CI variable is set
test "app loads": load everything; report mismatches between file names and defined names
```

**Don't:** Swallow in all environments, raise in all, or discover a load error on the first production request.

**Break it when:** The condition endangers data or money: stop in every environment. A regression test must reproduce production's lenient behavior exactly. Very large apps may skip eager load in dev.

**Source:** Guides: https://guides.rubyonrails.org/error_reporting.html (Reporting Unexpected Errors); https://guides.rubyonrails.org/configuring.html (raise_on_missing_callback_actions, action_on_unpermitted_parameters); https://guides.rubyonrails.org/autoloading_and_reloading_constants.html (Eager Loading); https://guides.rubyonrails.org/testing.html (Testing Eager Loading); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 3.1 to 3.2 strict mass assignment). Code: activesupport/lib/active_support/error_reporter.rb:151-160; railties/lib/rails/application/bootstrap.rb:66-68; railties/lib/rails/generators/rails/app/templates/config/environments/development.rb.tt:54,88; .../test.rb.tt:10-20,60; .../production.rb.tt:10.
