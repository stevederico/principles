# Fan out with a bounded broadcast channel and clean up registrations

**Rule:** To send one message to many connections, keep a bounded broadcast channel in state and have each connection subscribe; subscribe before announcing the join, and after the connection's tasks stop, publish a leave event and remove its registration.

**Why:** Chat and the HTTP/2 websocket example both use a fixed-capacity channel, so one send reaches every subscriber without tracking sockets. The chat example subscribes first so the new client sees its own join, and frees the username afterwards so it can be reused.

**Do:**
```
state.tx = broadcast_channel(capacity = 100)
rx = tx.subscribe(); tx.send(name + " joined")
... run tasks ...
tx.send(name + " left"); registry.remove(name)
```

**Don't:** Keep a list of sockets and write to each from the sender, or leak the registration when the socket drops.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/examples/chat/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/websockets-http2/src/main.rs.
