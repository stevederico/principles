# Events and listeners

**Rule:** When something notable happens, announce it as a named event that is plain data, and other code listens and reacts, and the source never knows its listeners.

**Why:** "Order placed" can trigger mail, stock and analytics, and adding one more means adding a listener, not editing the order code. By default listeners run in order, in process, and one can stop the rest; running one in the background is an opt-in per listener. The framework uses the same idea for its own parts: model lifecycle, login, mail sending, query execution.

**Do:**
```
place(order): order.save(); emit OrderPlaced(order)         # event holds data only
listen OrderPlaced -> SendReceipt                           # sync by default
listen OrderPlaced -> UpdateStock (queued)                  # background is opt-in
listener may return false to stop later listeners
```

**Don't:** Calling five unrelated services from the code that places the order, or relying on a listener for an invariant that bulk statements bypass.

**Break it when:** Bulk imports need an off switch for listeners. In tests a fake replaces listeners entirely, so build fixtures that depend on them before faking.

**Source:** https://laravel.com/docs/events, https://laravel.com/docs/eloquent, https://laravel.com/docs/verification, https://laravel.com/docs/notifications ; code: src/Illuminate/Events/Dispatcher.php, src/Illuminate/Notifications/NotificationSender.php
