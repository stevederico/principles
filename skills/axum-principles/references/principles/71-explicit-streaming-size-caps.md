# Give streaming connections their own size and buffer caps

**Rule:** Configure message size, frame size and write-buffer limits explicitly for streaming connections, and keep rejection of unmasked client frames on.

**Why:** The upgrade object exposes read and write buffer sizes and maximum message and frame sizes; its docs state large defaults (64 MB message, 16 MB frame, 128 KiB buffers), an unlimited write-buffer cap, and rejection of unmasked frames unless enabled. The limits are enforced by the underlying websocket library, not in this repository.

**Do:**
```
upgrade.max_message_size(1MB).max_frame_size(256KB).max_write_buffer_size(...)
```

**Don't:** Accept the large defaults on a public endpoint without a decision.

**Break it when:** the source states none.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/ws.rs (WebSocketUpgrade size settings docs).
