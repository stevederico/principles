# Let one task own a socket and select over its event sources

**Rule:** Give each long-lived connection a single owning task that waits on inbound messages and an internal channel for outbound ones, instead of splitting the socket into halves behind locks.

**Why:** The docs call this the actor pattern, say the receive call is cancel safe so it can be one branch of a select, and warn that each split half takes a lock on every operation. The examples still show the split form, ending both tasks when either one finishes.

**Do:**
```
loop select:
    msg = socket.recv() -> handle or return
    out = channel.recv() -> socket.send(out) or return
```

**Don't:** Spawn separate extractor and writer tasks sharing locks by default.

**Break it when:** The docs offer split halves when each direction needs its own task, at the cost of a lock per operation; when one half ends, abort the other.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/ws.rs ("Read and write concurrently"); https://github.com/tokio-rs/axum/blob/main/examples/chat/src/main.rs (split form); https://github.com/tokio-rs/axum/blob/main/examples/websockets/src/main.rs.
