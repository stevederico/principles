# Feature tests first

**Rule:** Write most tests as whole-feature tests that go through the real request path, reserve fast isolated tests for small pure logic, let a single test opt out of booting the app, and feed code real input rather than mocking the request or configuration.

**Why:** Whole-path tests give the most confidence that the system works; the cost to manage is booting per test. The mocking guide warns against stubbing the request and config readers, since a test that hands canned values to your code passes against a fiction. Mock only collaborators that do outside work.

**Do:**
```
test "register": post("/register", {email, password}); assert user_exists(email)
set_config("cache.ttl", 10)                      # not: mock(config).get -> 10
@no_boot test "format_state": assert format_state("ca") == "CA"   # pure function
```

**Don't:** Mocking every collaborator to unit-test glue code, or stubbing the request object.

**Break it when:** Dense pure algorithms deserve many small unit tests.

**Source:** https://laravel.com/docs/testing, https://laravel.com/docs/mocking, https://laravel.com/docs/http-tests ; code: src/Illuminate/Foundation/Testing/Attributes/UnitTest.php
