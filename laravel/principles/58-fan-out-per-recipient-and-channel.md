# Fan out per recipient and channel

**Rule:** When a message goes to several recipients over several channels, make each recipient-and-channel pair its own unit of work with its own queue, delay and layers.

**Why:** A failing SMS provider retries alone and the email is not sent again; channels can use different lanes, delays and limits.

**Do:**
```
for r in recipients: for ch in n.channels(r):
  enqueue(Deliver(n, r, ch), lane = n.lane_for(ch), delay = n.delay_for(ch), layers = n.layers_for(ch))
```

**Don't:** One job that loops over all recipients and channels and retries the lot on any error.

**Break it when:** Delivery is instant and local: send inline.

**Source:** https://laravel.com/docs/notifications ; code: src/Illuminate/Notifications/NotificationSender.php
