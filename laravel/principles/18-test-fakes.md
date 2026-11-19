# Test fakes

**Rule:** Ship built-in fakes for outside effects (mail, queue, events, storage, HTTP). A test swaps in the fake, runs the code, then asserts on what happened.

**Why:** Tests stay fast and never send real email or hit real services. Assertions read like the behavior being checked.

**Do:**
```
Mail.fake()
place_order(order)
Mail.assert_sent(Receipt, to: user)

Http.fake({"api.x.com": {status: 200}})
```

**Don't:** Hit the real network in tests, or mock internals line by line.

**Break it when:** You need a real integration test. Run those separately and label them.

**Source:** Laravel docs, mocking and fakes.
