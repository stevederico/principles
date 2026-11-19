# Close or guard every framework side door

**Rule:** When the framework mounts generic endpoints (direct uploads, blob proxies, a stock stream channel) outside your base controller, add the same authentication and authorization to them or switch them off.

**Why:** The code comments state these were reachable by anyone who can see the login page, and a subscriber chooses which channel to use, so guarding only your own channel is not enough.

**Do:**
```
each framework controller that writes: before_action require_session
stock stream channel: reject the names your guarded channel owns
proxy endpoints your app never links to: return 404
```

**Don't:** Assume only your controllers handle uploads.

**Break it when:** You use the feature on purpose and have an equivalent check.

**Source:** https://github.com/basecamp/once-campfire config/initializers/active_storage_authentication.rb, app/channels/concerns/room_streams_are_authorized.rb, config/initializers/turbo_streams_authorization.rb ; https://github.com/basecamp/writebook config/initializers/active_storage_authentication.rb.
