# Side channels fail quietly

**Rule:** Run supplementary features (realtime push, telemetry, logging) off the request path, and report their own failures without showing them to the user.

**Why:** A dead websocket relay or metrics store should not turn a successful save into an error. Broadcasts go through the queue by default, with opt-in inline and opt-in rescue; telemetry is written after the response or on a separate connection with errors swallowed; a logger that cannot be built falls back to a minimal file logger.

**Do:**
```
event Broadcast            # queued by default
event BroadcastNow         # opt in to inline
event Rescue               # failure is reported, request continues
after_response: recorder.write(entries)         # try / catch, report through the handler
logger = try build(config.channel) catch e: emergency_file_logger.log("logger failed", e)
```

**Don't:** Letting an unreachable socket server fail the request, or writing metrics synchronously with exceptions allowed.

**Break it when:** The push is the product (a chat send): fail visibly or retry. Audit rows that must be durable before returning.

**Source:** https://laravel.com/docs/broadcasting, https://laravel.com/docs/pulse, https://laravel.com/docs/logging ; code: src/Illuminate/Broadcasting/BroadcastManager.php, src/Illuminate/Log/LogManager.php
