# Size pub/sub retention to the slowest listener and batch the writes

**Rule:** Keep messages only as long as the slowest listener needs plus a reconnect margin, start new subscribers at the newest id, collect concurrent broadcasts for a tiny window into one insert, and silence the polling loop in logs.

**Why:** At 60 messages per second a day of retention holds about 5 million rows against 18,000 for five minutes. Fewer statements under load (defaults: 4 messages or 1 ms). A poll every tenth of a second would drown the logs.

**Do:**
```
retention = max(poll_interval) + reconnect_margin ; rows ~= rate * retention
writer: wait up to 1 ms or 4 messages ; insert_all(batch)       # or inline mode: insert now
poll_with(log_level = silent)
```

**Don't:** Keep a day of messages for a high-rate stream, open one write per message, or treat the table as history.

**Break it when:** Clients need replay on reconnect (use a durable log), or the caller must know the message is stored (inline mode).

**Source:** https://github.com/rails/solid_cable README.md ; code: lib/solid_cable/batched_broadcaster.rb, lib/action_cable/subscription_adapter/solid_cable.rb.
