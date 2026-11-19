# Test fakes

**Rule:** Ship built-in fakes for outside effects (mail, queue, events, storage, HTTP, processes), and a test swaps the fake in, runs the code, asserts on what was handed off, and turns on a guard that fails on any un-faked outside call.

**Why:** Tests stay fast and free of real effects. A partial fake lets unmatched calls run for real unless strays are forbidden. A fake replaces behavior, so listeners do not run once events are faked. Do not mock the inputs: send a real request and set real config values.

**Do:**
```
Http.fake({"api.x.com/*": ok}) ; Http.prevent_stray_requests() ; Process.prevent_stray()
user = factory.create()                    # build fixtures BEFORE faking events they rely on
place_order(order)
Mail.assert_queued(Receipt, to: user)      # queued and sent are different assertions
set_config("cache.ttl", 10)                # not mock(config)
```

**Don't:** Hitting the real network in tests, faking one host and assuming the rest is blocked, or stubbing the request or config reader.

**Break it when:** A labelled integration test needs the real service, or a vendor sandbox whose behavior is the thing you must trust. Then run a small tagged group against the sandbox and assert on your own state.

**Source:** https://laravel.com/docs/mocking, https://laravel.com/docs/http-tests, https://laravel.com/docs/events, https://laravel.com/docs/processes, https://laravel.com/docs/mail, https://laravel.com/docs/billing ; code: src/Illuminate/Support/Testing/Fakes/MailFake.php, src/Illuminate/Http/Client/Factory.php, src/Illuminate/Process/Factory.php, src/Illuminate/Support/Facades/Facade.php
