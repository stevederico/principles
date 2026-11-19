# Authorize by loading through the user's reachable set, and fail closed

**Rule:** Look up every record through a relation scoped to what the current user may see, so an unauthorized id behaves exactly like a missing one; keep a separate editor check for writes; when the owner needed for a decision resolves to nothing, deny.

**Why:** A read path cannot forget the check, and ids leak nothing about private records. Variants and superseded revisions can lose the link to their book; the code treats that as not found, and an empty policy table allows nothing. A subclass that relaxes permission must narrow scope in the same breath.

**Do:**
```
set_room: current_user.rooms.find(id)                 # 404 if not a member
set_book: Book.accessible_or_published(user).find(id)
ensure_editable: forbid unless book.editable?
owners = non_empty(owners_of(blob)) ; allow = any(owner.published or owner.accessible)   # empty -> false
```

**Don't:** Find by id and then ask "may the user view it?", or write "allow unless owner is private" where a nil owner allows.

**Break it when:** The resource is public by design (scope to the public set, not to everything).

**Source:** https://github.com/basecamp/once-campfire app/controllers/rooms_controller.rb, app/controllers/messages/boosts_controller.rb, app/channels/room_channel.rb ; https://github.com/basecamp/writebook app/controllers/concerns/book_scoped.rb, app/controllers/concerns/active_storage_authorization.rb, app/models/embed_provider.rb.
