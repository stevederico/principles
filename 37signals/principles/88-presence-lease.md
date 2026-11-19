# Model presence as an expiring lease renewed by the client

**Rule:** Store a connected-at time with a short TTL, have the client renew faster than the TTL and delay visibility changes, and reset all leases when the server boots.

**Why:** Disconnect events are lost on crashes and sleep; a lease heals itself. Brief tab switches are ignored by the delay.

**Do:**
```
connected? = connected_at >= now - 60 s ; client sends a refresh every 50 s
hidden or visible changes are sent only after 5 s of stability
boot: disconnect_all ; heartbeat: re-check the session still exists
```

**Don't:** Trust a counter that only goes down on a clean disconnect.

**Break it when:** You need exact accounting; use an authoritative session service.

**Source:** https://github.com/basecamp/once-campfire app/models/membership/connectable.rb, app/javascript/controllers/presence_controller.js, config/puma.rb, app/channels/application_cable/connection.rb.
