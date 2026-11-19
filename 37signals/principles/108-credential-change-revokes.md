# A credential change must revoke everything derived from the old one

**Rule:** Changing a password ends all sessions, push subscriptions and open sockets, binds transfer links to the credential state so they die too, requires the current password, and rate-limits exactly the endpoints an attacker can use to guess.

**Why:** A new password is how someone shuts out whoever else got in. The profile screen takes the current password, so it shares the sign-in limit, and the limiter must count the same condition the model checks.

**Do:**
```
after password digest changes: sessions.delete_all ; subscriptions.delete_all ; on commit close sockets (log failures)
transfer token = generate(:transfer, expires 4 h, bound to the password salt tail)
sign-in: 10 attempts per 3 minutes ; profile update: same limit when current_password is present
```

**Don't:** Invalidate only the session that made the change, or limit login and leave password change open.

**Break it when:** You support long-lived device tokens by design (document it), or another layer already throttles.

**Source:** https://github.com/basecamp/once-campfire app/models/user.rb, app/models/session.rb, app/models/user/transferable.rb, app/controllers/users/profiles_controller.rb, app/controllers/sessions_controller.rb ; https://github.com/basecamp/writebook app/models/user/transferable.rb.
