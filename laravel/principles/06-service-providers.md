# Service providers

**Rule:** Give each feature one startup unit with two phases: register only records what the feature can build, and boot runs after every unit has registered and is the only place that uses other features' services.

**Why:** In the register phase a service you depend on may not exist yet; two phases remove load-order bugs. A unit that only binds can be deferred until one of its bindings is first requested.

**Do:**
```
provider Billing:
  register(): container.bind(Gateway, StripeGateway)    # bind only
  boot():     routes.load(billing_routes)               # every binding exists now
              events.listen(PaymentFailed, Notify)
app.start(): for p in providers: p.register(); then for p in providers: p.boot()
```

**Don't:** Using another feature's service, adding routes or adding listeners inside register.

**Break it when:** A tiny app with no cross-feature dependencies can use one startup function. In long-lived servers boot runs once per worker, not per request.

**Source:** https://laravel.com/docs/providers, https://laravel.com/docs/lifecycle, https://laravel.com/docs/octane ; code: src/Illuminate/Foundation/Application.php, src/Illuminate/Foundation/ProviderRepository.php
