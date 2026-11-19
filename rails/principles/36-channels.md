# Socket endpoints: authenticate, authorize, store first

**Rule:** Authenticate once when a long-lived connection opens, authorize again at each subscription, expose only deliberately listed methods, and treat broadcasts as ephemeral hints over data already stored.

**Why:** A signed stream name proves it was not forged, not that this user may listen. Every public method on a channel type is callable from the wire. A client that was not subscribed when a message went out never receives it.

**Do:**
```
on_open(request): user = verify(cookies); if none: reject()       # connection holds only identity
subscribe(stream): room = resolve(verified(stream)); if room.allows(user): attach else reject
channel Appearance: public appear(), away(); private update_presence()   # private = not callable
create_comment(): save(comment); broadcast("room:5", html)
on_subscribe(): client fetches the last 50 saved comments
```

**Don't:** Re-authenticate inside each message handler, use the broadcast as the system of record, or add a public helper "for convenience" to a channel.

**Break it when:** Public streams carry only public data; typing indicators and cursors are rightly transient.

**Source:** Guides: https://guides.rubyonrails.org/action_cable_overview.html (Connections, Client-Server Interaction, Broadcastings); https://guides.rubyonrails.org/using_hotwire_with_rails.html (Subscribing to Streams, Custom Channels). Code: actioncable/lib/action_cable/connection/base.rb:91-96; actioncable/lib/action_cable/connection/authorization.rb; actioncable/lib/action_cable/channel/base.rb:133-146,292-298; actioncable/lib/action_cable/subscription_adapter/inline.rb:12-18.
