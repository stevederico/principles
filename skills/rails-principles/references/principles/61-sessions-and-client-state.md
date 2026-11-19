# Keep authority on the server, seal what the client holds

**Rule:** Issue a fresh session id at login, expire sessions on the server both when idle and after a maximum age, and let the client hold only an identifier. Whatever it does hold is signed (readable, tamper-proof) or encrypted (hidden), small, and carries purpose and expiry.

**Why:** Fixation lets an attacker choose the id; clients can edit cookie expiry; anything held client-side can be replayed (a spent credit restored by pasting an old cookie). Cookies have a size cap and may outlive logout.

**Do:**
```
on login: reset_session(); session.set(user_id)      # also resets the forgery token
server sweep: delete sessions idle > 20 min or older than 2 days
session row in the database, cookie holds a signed id; logout deletes the row
cookie.encrypted.set("theme", "dark"); cookie.signed.set("visits", 3); keep to strings and numbers
session loads lazily on first read
```

**Don't:** Store money, quotas or permissions in a cookie, put whole objects in it, accept a session id from the URL, or reuse the pre-login session.

**Break it when:** Server-side sessions for large or revocable state, or another system must read the cookie (then sign and document it). Short-lived preference data may stay on the client.

**Source:** Guides: https://guides.rubyonrails.org/security.html (Session Fixation Countermeasures, Session Expiry, Session Storage, Replay Attacks for CookieStore Sessions); https://guides.rubyonrails.org/action_controller_overview.html (Cookies, Session); https://guides.rubyonrails.org/2_3_release_notes.html (lazy sessions); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 3.2 to 4.0, 5.2 to 6.0 cookies). Code: actionpack/lib/action_dispatch/middleware/cookies.rb:217,634; actionpack/lib/action_dispatch/http/request.rb:504-507; actionpack/lib/action_dispatch/http/session.rb:261-286; railties/lib/rails/generators/rails/authentication/templates/app/controllers/concerns/authentication.rb.tt:41-51.
