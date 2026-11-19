# Error handler

**Rule:** Send every uncaught error through one central handler with two separate jobs, recording it and turning it into a response, with per-type overrides of each, and reveal details only when debug is on and keep expected failures out of the log.

**Why:** Logging policy changes independently of what the user sees. Detail (message, class, file, trace) helps attackers in production. A tracker full of 404s hides real faults, and a dead third party can generate thousands of identical reports a minute.

**Do:**
```
handler.report(PaymentError, e -> send_to_tracker(e))         # may stop default logging
handler.render(PaymentError, (e, req) -> response(...))       # nothing returned means default
if config.debug: body = {message, class, file, line, trace} else: body = {message: "Server Error"}
never_report = [NotFound, Unauthenticated, ValidationFailed, TokenMismatch]
report_throttle(e): ThirdPartyDown -> 300 per minute ; NoisyMonitor -> sample 1 in 1000
```

**Don't:** Catching errors in each handler to build ad hoc bodies, or returning raw database messages to clients.

**Break it when:** Debugging a specific class of 404 or validation problem: remove it from the ignore list temporarily. A one-off script with no users can just crash.

**Source:** https://laravel.com/docs/errors, https://laravel.com/docs/configuration ; code: src/Illuminate/Foundation/Exceptions/Handler.php
