# Show optimistic UI with a client-made id, then reconcile by that id

**Rule:** The browser makes an id for each outgoing item, shows a placeholder at once, sends the id, and removes the placeholder when the server's real item with the same id arrives; placeholders are marked so another user's item can never be removed.

**Why:** Instant feedback, and the broadcast that echoes the poster's own message must not duplicate it.

**Do:**
```
id = random() ; insert placeholder(pending, client_id = id) ; POST { client_message_id: id }
on stream insert: remove placeholders where pending and client_id == item.client_id
on submit failure: mark the placeholder failed
server: if item.client_message_id is missing: set it to a new uuid      # bots omit it
```

**Don't:** Deduplicate by text or timestamp.

**Break it when:** Writes are rare and a slower feel is fine.

**Source:** https://github.com/basecamp/once-campfire app/javascript/controllers/composer_controller.js, app/javascript/controllers/messages_controller.js, app/models/message.rb, app/views/messages/_template.html.erb.
