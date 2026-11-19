# Re-evaluate permission on every access

**Rule:** A signed id, URL or open connection records who could act when it was minted; resolve the owning object and check current permission on each use, and make long-lived connections re-check their session on a timer.

**Why:** Otherwise revoking a membership or unpublishing a book leaves old links and subscriptions working; stream names carry no expiry and upload URLs handed out earlier stay valid.

**Do:**
```
blob request:  books = owners_of(blob) ; allow if any(book.published or book.accessible_by(user))
subscribe:     room = room_from(verified_stream_name) ; allow if user.rooms includes room
heartbeat (every minute): close the socket unless the session row still exists
```

**Don't:** Treat "the signature verified" as authorization.

**Break it when:** The object is public and immutable.

**Source:** https://github.com/basecamp/writebook app/controllers/concerns/active_storage_authorization.rb, app/controllers/action_text/markdown/uploads_controller.rb ; https://github.com/basecamp/once-campfire app/channels/room_messages_channel.rb, app/channels/application_cable/connection.rb.
