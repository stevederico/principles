# Hold request identity in one context; pass actors explicitly elsewhere

**Rule:** Expose the session and user as per-request attributes used only as association defaults and in controllers; give jobs, channels and webhooks their actor as an argument.

**Why:** Models can default `creator` to the current user, which keeps controllers short, while background code has no request and must name who acts, such as a bot replying.

**Do:**
```
Current.user = session.user                 # in the authentication step
message.creator default = Current.user
webhook reply: room.messages.create(body, creator = bot)
```

**Don't:** Read the context inside jobs or channels.

**Break it when:** The runtime has no per-request global storage.

**Source:** https://github.com/basecamp/once-campfire app/models/current.rb, app/models/message.rb, app/models/webhook.rb ; https://github.com/basecamp/writebook app/models/current.rb.
