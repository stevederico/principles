# Browser tests for critical paths only

**Rule:** Test most behavior at the model and request level. Reserve browser-driven tests for core business flows and client-side logic that nothing else can reach, and keep shared fixtures to the small common case.

**Why:** Browser tests are slower, brittle and costlier to maintain. The framework stopped generating them with scaffolds and skips them in the default test command. Fixtures are not meant to create every object a test needs.

**Do:**
```
model tests: many; request tests: one per workflow
browser tests: sign-up, checkout, payment; run as a separate CI step
fixtures: user admin, user one, product tshirt     # entries reference each other by name
test: product = create(Product, inventory = 0)     # the sold-out case is built in the test
```

**Don't:** Write a browser test for every page, or grow one giant fixture set every test depends on.

**Break it when:** A behavior exists only in client code, or a large read-only dataset is needed by many tests.

**Source:** Guide: https://guides.rubyonrails.org/testing.html (When to Use System Tests, Generating System Tests, Running tests in Continuous Integration, What are Fixtures?). Code: railties/lib/rails/generators/test_unit/scaffold/scaffold_generator.rb:16,28.
