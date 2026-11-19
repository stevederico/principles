# Render in the recipient's language

**Rule:** Choose a message's language from the recipient's stored preference, or an explicit override, and carry that choice with the message through any queue hop.

**Why:** The language of the process or request that triggered the send is usually not the recipient's. The notification system checks an explicit override first, then the recipient's preferred locale, then the default, and stores the chosen locale in the queued payload.

**Do:**
```
locale = notification.locale_override or recipient.preferred_locale or default
with_locale(locale): render(notification)
notification.locale = locale               # kept in the queued payload
```

**Don't:** Using the ambient locale of whoever triggered the send.

**Break it when:** A single-language product.

**Source:** https://laravel.com/docs/notifications, https://laravel.com/docs/localization ; code: src/Illuminate/Notifications/NotificationSender.php
