# Structured logs

**Rule:** Log a fixed message with named context values, attach request-wide context such as a request id once so every later entry carries it, and choose each destination's minimum severity separately.

**Why:** Fixed messages group well and context fields are searchable. One request id ties a trace together, and different destinations (file, chat) need different noise levels.

**Do:**
```
middleware: id = uuid(); log.share_context({request_id: id}); response.header("Request-Id") = id
log.info("User {id} failed login", {id: user.id})
stack: [file(level = debug), chat(level = critical)]
```

**Don't:** Interpolating values into the message string, or repeating the id in every call.

**Break it when:** A tiny script with one destination.

**Source:** https://laravel.com/docs/logging, https://laravel.com/docs/context ; code: src/Illuminate/Log/LogManager.php, src/Illuminate/Log/ParsesLogConfiguration.php
