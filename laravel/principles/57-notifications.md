# Notifications

**Rule:** Model "tell someone something" as one notification with a channel list chosen per recipient and one builder per channel, and the recipient is anything that supplies an address per channel.

**Why:** Message and delivery are separate concerns, so adding a channel touches no sender. A bare email address works as a recipient. A channel that stores data per owner (an in-app inbox) cannot take an anonymous one. The language comes from the recipient's saved preference and survives the queue. A listener can veto a send.

**Do:**
```
class InvoicePaid:
  channels(recipient): recipient.prefs.channels            # [email, push, inbox]
  to_email(recipient): Email(...)
  to_push(recipient):  Push(...)
recipient.notify(InvoicePaid(invoice))
notify_address("ops@example.com", DatabaseBusy(conn))      # no user record needed
locale = notification.locale or recipient.preferred_locale or default
```

**Don't:** Writing mail, SMS and push code at every place something happens, or rendering in the language of whoever triggered the send.

**Break it when:** Only one channel will ever exist: use it directly.

**Source:** https://laravel.com/docs/notifications, https://laravel.com/docs/database, https://laravel.com/docs/passwords ; code: src/Illuminate/Notifications/NotificationSender.php, src/Illuminate/Notifications/AnonymousNotifiable.php
