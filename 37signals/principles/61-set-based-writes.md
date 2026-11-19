# Write fan-out as one set-based statement

**Rule:** Grant, revoke and mark-as-read across many rows with a single bulk statement that tolerates duplicates, not a loop of saves.

**Why:** One statement runs under the single write lock, so no room is closed or removed between the read and the insert. Bulk paths are also faster.

**Do:**
```
insert into memberships select room, ? from rooms where open  on conflict do nothing
upsert(accesses, unique_by = [book, user]) ; delete rows not in the set
update unread_at = t where member and not connected
```

**Don't:** Loop over users and create a membership each.

**Break it when:** Per-row callbacks are required; wrap them in one transaction.

**Source:** https://github.com/basecamp/once-campfire app/models/room.rb, app/models/user.rb, app/models/membership/connectable.rb ; https://github.com/basecamp/writebook app/models/book/accessable.rb, app/models/user.rb.
