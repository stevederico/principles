# Seams for nondeterminism

**Rule:** Route time, sleep, random strings, ids and "should this run" lotteries through one small wrapper per source that tests can freeze, move or script, reset it after every test, and wait for conditions with a deadline instead of fixed sleeps.

**Why:** Real sleeping makes suites slow and random values make assertions impossible. Retry and backoff code that calls the wrapper can assert "waited 1s, then 2s" without waiting. Leaked overrides make later tests order-dependent.

**Do:**
```
travel(1 week): assert thread.is_locked_by_inactivity()       # real time returns after the block
Sleep.fake(); run(); Sleep.assert_sequence([1s, 2s, 3s])
Ids.fix(["id-1", "id-2"]) ; teardown: flush_state(); id_factory.reset()
wait_until(max = 5s, every = 0.1s, check = element_visible("modal"), message = "modal never opened")
```

**Don't:** Sleeping in tests, calling the system clock or raw random in business code, or setting a global in one test and relying on it in the next.

**Break it when:** Time comes from an external system your test clock does not control. Elapsed time itself is under test (debounce, animation).

**Source:** https://laravel.com/docs/mocking, https://laravel.com/docs/helpers, https://laravel.com/docs/strings, https://laravel.com/docs/dusk, https://laravel.com/docs/upgrade ; code: src/Illuminate/Foundation/Testing/Concerns/InteractsWithTime.php, src/Illuminate/Support/Sleep.php, src/Illuminate/Foundation/Testing/Concerns/InteractsWithTestCaseLifecycle.php
