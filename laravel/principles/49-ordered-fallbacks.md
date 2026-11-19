# Ordered fallbacks

**Rule:** For infrastructure whose outage should not take the app down (cache, queue, mail), configure an ordered fallback list, emit a signal when one backend fails, raise the last error only if all fail, and keep round-robin for spreading load.

**Why:** Availability without silent degradation: operators learn a backend dropped. For third-party APIs fall over only on errors that mean the provider is unavailable, because a bad request fails everywhere. Queue failover moves on after any error, since pushing the same job elsewhere is safe.

**Do:**
```
store failover = [redis, database, memory]
get(k): for s in stores: try: return s.get(k) catch e: emit FailedOver(s, e)
        raise last_error
mailers: failover [postmark, mailgun] ; roundrobin [ses, postmark]
api_call: catch Unavailable (rate limit, overload, no credit): next provider ; bad request: raise now
```

**Don't:** Falling back silently, or looping through providers on every error type.

**Break it when:** The fallback has weaker guarantees you cannot accept (an in-memory queue loses jobs on restart).

**Source:** https://laravel.com/docs/cache, https://laravel.com/docs/queues, https://laravel.com/docs/mail, https://laravel.com/docs/ai-sdk ; code: src/Illuminate/Cache/FailoverStore.php, src/Illuminate/Queue/FailoverQueue.php, src/Illuminate/Mail/MailManager.php
