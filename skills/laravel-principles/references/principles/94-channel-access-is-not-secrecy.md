# Channel access is not secrecy

**Rule:** Authorize joining a private realtime channel with a rule matched against the channel name, and when a third-party relay carries the messages, encrypt the payload as well, because authorization decides only who may subscribe.

**Why:** Channel names are guessable, so the name cannot be a secret. The rule says who may join; the relay still handles plain text. An encrypted private channel keeps the payload readable only by your server and authorized clients (only some providers support it). Presence channels return user info instead of true.

**Do:**
```
channel "orders.{id}": (user, id) -> user.id == Order.find(id).owner_id      # no match: refuse
presence "room.{id}": (user, id) -> user.is_member(id) ? {id: user.id, name: user.name} : false
encrypted_private("orders." + id)       # same rule, payload encrypted end to end
```

**Don't:** Treating the channel name as the secret, or sending sensitive data over a hosted relay because the channel is called private.

**Break it when:** A relay you run and trust yourself, or truly public feeds on a public channel.

**Source:** https://laravel.com/docs/broadcasting ; code: src/Illuminate/Broadcasting/Broadcasters/Broadcaster.php, src/Illuminate/Broadcasting/EncryptedPrivateChannel.php
