# Service providers

**Rule:** Each feature has one startup place that registers its parts and then boots them. All app setup flows through those places.

**Why:** You always know where to look to see how something is wired. Features are added or removed by listing one provider.

**Do:**
```
class BillingProvider:
  register(): container.bind(Gateway, StripeGateway)
  boot():     routes.load(billing_routes); listen(PaymentFailed, Notify)

app.providers = [Core, Billing, Search]
```

**Don't:** Scatter setup across random files that run at import time.

**Break it when:** The app is tiny. One startup file is enough.

**Source:** Laravel docs, service providers.
