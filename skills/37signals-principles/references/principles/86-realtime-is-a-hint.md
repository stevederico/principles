# Treat realtime as a hint and give every live view an HTTP catch-up

**Rule:** Each live page has a pull endpoint taking a "since" cursor, called on every (re)connect and when the tab returns after a long absence; ignore stale notices by timestamp; page feeds by cursor in both directions with a small page size and a capped client window.

**Why:** Sockets drop and messages arrive out of order. New items keep arriving, so offsets shift.

**Do:**
```
on channel connected or tab visible after > 60 s: GET /room/refresh?since=lastSeen
server: new = created_since(t) ; changed = updated_since(t) minus new
page_before(m) = created_at < m.created_at, last 40 ; client keeps ~300 nodes, trims the far end
unread notice with at <= readAt[room] is ignored
```

**Don't:** Rely on the socket as the only delivery path, or use OFFSET for a live feed.

**Break it when:** Loss is acceptable (typing indicators), or the list is small and static.

**Source:** https://github.com/basecamp/once-campfire app/javascript/controllers/refresh_room_controller.js, app/controllers/rooms/refreshes_controller.rb, app/models/message/pagination.rb, app/javascript/models/message_paginator.js.
