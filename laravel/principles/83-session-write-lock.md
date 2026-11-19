# Lock sessions that write

**Rule:** Because a session is read whole and written back whole, concurrent requests on one session can overwrite each other, so offer an opt-in per-session lock with a hold limit and a wait limit on the routes that write session data.

**Why:** Last writer wins and silently drops the other request's changes. The lock needs a shared store with atomic locks, so it cannot work with a cookie-only session. Locking every route would serialize ordinary page loads.

**Do:**
```
route /profile .lock_session(hold = 10s, wait = 10s)
lock = shared_store.lock("session:" + id, hold); lock.wait(wait)
handle(); save_session(); lock.release()
```

**Don't:** Locking every route, or using the lock with a cookie session driver.

**Break it when:** Requests that never write the session.

**Source:** https://laravel.com/docs/session ; code: src/Illuminate/Session/Middleware/StartSession.php, src/Illuminate/Session/Store.php
