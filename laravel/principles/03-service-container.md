# Service container

**Rule:** Keep one registry that builds objects and fills in what they depend on. Classes ask for what they need by type, and never construct their own dependencies.

**Why:** Parts stay loose. Swapping an implementation or a test double is a one-line change.

**Do:**
```
class InvoiceSender(mailer: Mailer, store: Storage)    # asks by type

container.bind(Mailer, SmtpMailer)
container.make(InvoiceSender)    # resolves and builds it
```

**Don't:** Call `new SmtpMailer()` inside business code.

**Break it when:** A small script needs no wiring. Plain construction is fine.

**Source:** Laravel docs, service container.
