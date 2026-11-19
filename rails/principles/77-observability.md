# Observe from outside, cheaply in production

**Rule:** Wrap important operations in named, timed events with a payload and let logging, metrics and tracing subscribe from outside. Tag every log line with a request id, filter secrets, keep costly call-site capture for development, and keep health checks shallow.

**Why:** Subscribers get name, timing, id and payload without business code calling monitoring. An exception passes through the event untouched, so observing never changes behavior. Stack capture allocates a lot, and a health probe that checks vendors restarts healthy servers when a vendor is down.

**Do:**
```
instrument("charge.billing", {order_id: 7}): gateway.charge(order)
subscribe("*.billing"): (name, start, finish, id, payload) -> timing(name, finish - start)   # monotonic clock
events.set_context(request_id, shop_id); events.notify("user.signup", user_id)   # payload filtered for secrets
id = header X-Request-Id or new_uuid(); log.tag(id); response.header X-Request-Id = id
dev: log source file:line under each query; prod: tag each SQL with controller and action
logger.debug(lambda -> expensive_message)        # built only when the level allows
GET /up -> 200 if the process booted; dependency checks on a separate endpoint
```

**Don't:** Sprinkle metric calls through business code, put raw secrets in events, turn on call-site capture in production, or make the liveness probe call a payment API.

**Break it when:** A single-process script (plain log lines suffice), a short scoped production investigation, or a dependency truly required for any request (add it to a readiness check).

**Source:** Guides: https://guides.rubyonrails.org/active_support_instrumentation.html; https://guides.rubyonrails.org/8_1_release_notes.html (Structured Event Reporting); https://guides.rubyonrails.org/3_2_release_notes.html (Tagged Logging); https://guides.rubyonrails.org/debugging_rails_applications.html (Verbose Query Logs, SQL Query Logs); https://guides.rubyonrails.org/action_controller_advanced_topics.html (Built-in Health Check Endpoint). Code: activesupport/lib/active_support/notifications/instrumenter.rb:84-96; activesupport/lib/active_support/event_reporter.rb:7-45,292-294; actionpack/lib/action_dispatch/middleware/request_id.rb:9-31; railties/lib/rails/health_controller.rb.
