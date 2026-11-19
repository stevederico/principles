# Validate the upgrade in the extractor and run the session detached

**Rule:** Check every upgrade precondition while reading the request (method, headers, version, upgradeability), return the protocol-switch response from the handler, run the long-lived session in a separate task, and read headers, peer address and auth in the handler because they are gone once the protocol switches.

**Why:** The websocket extractor returns a distinct rejection per failure (wrong method 405, bad headers 400, not upgradable 426). The upgrade callback spawns the session task and returns the switching response. A failed background upgrade has no response channel, so it is ignored by default with an optional error callback. The server example documents the handler as the last place to read the peer address and user agent.

**Do:**
```
extractor: verify handshake else reject(specific_code)
handler(upgrade, user_agent, peer_addr): return upgrade.on_upgrade(session(peer_addr))
session end: send Close(code = NORMAL, reason)       # send it yourself
```

**Don't:** Run the session inside the request future, read headers from inside the session task, or drop the socket without a close frame.

**Break it when:** The default ignores upgrade failures; register the error callback only if you need to observe them.

**Source:** https://github.com/tokio-rs/axum/blob/main/axum/src/extract/ws.rs (WebSocketUpgrade, rejections, on_upgrade); https://github.com/tokio-rs/axum/blob/main/examples/websockets/src/main.rs; https://github.com/tokio-rs/axum/blob/main/examples/websockets/src/client.rs; https://github.com/tokio-rs/axum/blob/main/axum/CHANGELOG.md (0.8, close helper removed).
