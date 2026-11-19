# Name streams by audience and broadcast viewer-neutral markup

**Rule:** Use one stream per user or per room, publish only to people who may know about the event, and render a fragment once for everyone with no tokens or personal state, letting the browser decorate it for the viewer.

**Why:** A global stream reveals timing of activity in private rooms to every connected user. A neutral fragment serves a whole room, can be cached, and sends the same bytes to the poster and the broadcast; viewer ids come from meta tags and the client toggles "mine", "mentions me".

**Do:**
```
stream "user_<id>_unreads" ; for member in room.members where unread or connected: publish
room stream (room, :messages) with membership check at subscribe
server: html = render(message) ; broadcast(room, html)
client: node.toggle("mine", node.author == current_user)
```

**Don't:** Broadcast "unreads" on a global stream, render per-recipient HTML in a loop, or embed viewer ids or tokens in shared fragments.

**Break it when:** The event is public by design, or the data truly differs per viewer (render per viewer and say so).

**Source:** https://github.com/basecamp/once-campfire app/channels/unread_rooms_channel.rb, app/models/message/broadcasts.rb, app/helpers/messages_helper.rb, app/javascript/models/message_formatter.js, app/javascript/initializers/current.js.
