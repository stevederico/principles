# Contracts in their own package

**Rule:** Publish the core service interfaces as a separate, dependency-light package, and have extensions and libraries depend on that package instead of on the concrete framework.

**Why:** An integration that needs only "something that queues" or "something that sends mail" should not pull in the whole implementation. The interfaces package requires almost nothing but two small standard interface packages, so it can sit under any extension, and every service still has a default implementation inside the framework.

**Do:**
```
package courier-integration:
  depends on: core-interfaces            # QueueInterface, MailerInterface
  not on:     core-implementation
class OrderListener(queue: QueueInterface)   # container supplies the real one
```

**Don't:** Making a reusable extension require the full framework just to type-hint one service, or letting the interface package grow implementation code.

**Break it when:** A single application that will never be packaged: facades or plain injection of the concrete services are fine, and the docs call the choice between them taste.

**Source:** https://laravel.com/docs/contracts ; code: src/Illuminate/Contracts/composer.json, src/Illuminate/Cache/composer.json
