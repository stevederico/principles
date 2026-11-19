# Authorize first, then serve cached output keyed by viewer

**Rule:** Run authentication and resource authorization before the cache lookup, include user, session and request shape in the key, and skip the cache for requests carrying flash, conditional headers or API credentials.

**Why:** The cache hook is registered after room authorization, so a cached page can never reach a viewer who failed the check; the README says every request still checks auth and access.

**Do:**
```
before: set_room                      # authorization
around: cache_read_response            # lookup after
key = [path, user_id, session_token, accept, frame, locale]
skip if flash or if-none-match or bot
```

**Don't:** Cache authenticated pages at the edge by URL alone.

**Break it when:** Pages are fully public.

**Source:** https://github.com/basecamp/once-campfire app/controllers/concerns/cached_responses.rb, app/controllers/rooms_controller.rb, app/controllers/messages_controller.rb, README.md (cache paragraph).
