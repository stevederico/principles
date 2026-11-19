# Keep realtime events small

**Rule:** Keep realtime events small and send only what other clients need: exclude the originating connection when it already updated itself, leave oversized results out of the live stream (persist them and let clients load them afterwards), and emit a terminal failure event when queued work fails.

**Why:** The sender already has the response, so echoing it shows the change twice; the client sends its connection id and the server carries it in the payload so the broadcast can skip it. Realtime platforms cap message size at around ten kilobytes, so a large event breaks the broadcast. Without a failure event a front end waits forever.

**Do:**
```
client sends header connection_id with every request
broadcast(OrderUpdated(order.id, changed_fields)).to_others()   # skips that connection
broadcast_except([tool_result]); persist(all_results)
on queued_failure: broadcast("stream_failed", run_id)
```

**Don't:** Guessing duplicates on the client, broadcasting whole result bodies, or letting a failed background job end silently.

**Break it when:** Payloads that are always tiny; or an originator that relies on the broadcast to update itself.

**Source:** https://laravel.com/docs/broadcasting, https://laravel.com/docs/ai-sdk ; code: src/Illuminate/Broadcasting/BroadcastEvent.php
