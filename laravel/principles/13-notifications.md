# Notifications

**Rule:** Model "tell the user something" as one notification with many channels (email, SMS, push, chat). The channel list is chosen per user.

**Why:** The message and the delivery are separate concerns. Adding a channel does not touch the places that send.

**Do:**
```
class InvoicePaid:
  channels(user): user.prefs.channels   # [email, push]
  toEmail(user):  Email(...)
  toPush(user):   Push(...)

user.notify(InvoicePaid(invoice))
```

**Don't:** Write email code, SMS code and push code at each place something happens.

**Break it when:** Only one channel will ever be used. Use that directly.

**Source:** Laravel docs, notifications.
