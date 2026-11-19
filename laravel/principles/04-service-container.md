# Service container

**Rule:** Keep one registry that builds objects and fills in their dependencies by type, and classes ask for what they need and never construct their collaborators.

**Why:** Swapping an implementation or a test double is a one-line change. Concrete classes with concrete dependencies need no registration at all; only interfaces and special cases get bound.

**Do:**
```
class InvoiceSender(mailer: Mailer, store: Storage)    # asks by type
container.bind(Mailer, SmtpMailer)                     # interface to implementation
container.make(InvoiceSender)                          # concrete dependencies resolved for free
# commands, jobs, listeners, controllers and policies are built the same way
# an optional parameter with no binding gets its default, not a built object
```

**Don't:** Calling the constructor of a concrete mailer inside business code, or registering every concrete class by hand.

**Break it when:** A small script with nothing to swap. Plain construction is fine.

**Source:** https://laravel.com/docs/container, https://laravel.com/docs/artisan, https://laravel.com/docs/queues, https://laravel.com/docs/events, https://laravel.com/docs/controllers, https://laravel.com/docs/upgrade ; code: src/Illuminate/Container/Container.php, src/Illuminate/Console/Command.php
