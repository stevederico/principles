# Revoke access immediately, delete data later in small transactions

**Rule:** To destroy a large parent, cut off access in a quick transaction, then remove children one at a time in a background job, each in its own transaction.

**Why:** Destroying all messages inside the room's own transaction held the write lock and stopped every other write. Closing an open room first keeps late joiners out until the job finishes.

**Do:**
```
target = room.open ? convert_to_closed : room
transaction { save ; former_members = ids ; delete memberships }
enqueue DestroyJob(room, former_members)      # reset sockets ; destroy each message alone ; then the room
```

**Don't:** Destroy a hundred thousand children in the request with a cascading delete.

**Break it when:** The data is small.

**Source:** https://github.com/basecamp/once-campfire app/models/room.rb, app/jobs/room/destroy_job.rb.
