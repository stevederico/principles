# Split a growing model into one-word capability modules

**Rule:** When a model grows, move each capability (scopes, callbacks, methods) into a module named for it and nested under the model, and list them in one include line. Keep a named preload bundle there too.

**Why:** Each file answers one question (who can access it, how is it searched, how is it positioned) and the model file stays a readable index. A named bundle of preloaded relations, applied on every read path, means one place decides query shape and N+1 fixes apply everywhere.

**Do:**
```
Message includes: Attachment, Broadcasts, Mentionee, Pagination, Searchable    # message/*
Book includes:    Accessable, Sluggable
scope with_presentation = with_creator + attachment_details + boosts
room.messages.with_presentation   # show, index, refresh, search
```

**Don't:** Create a catch-all "services" folder, grow a 500-line model, or copy preload lists into controllers.

**Break it when:** Logic spans several models and belongs to none (see the controller principle on plain objects), or a bundle is used by one view only.

**Source:** https://github.com/basecamp/once-campfire app/models/message.rb, app/models/user.rb, app/models/account.rb ; https://github.com/basecamp/writebook app/models/book.rb, app/models/leaf.rb ; app/controllers/messages_controller.rb.
