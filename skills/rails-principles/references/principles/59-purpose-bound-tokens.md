# Tokens carry a purpose, an expiry and state

**Rule:** Sign or encrypt each token for one named purpose with an expiry, derive its key from the purpose, and embed the piece of current state it authorizes against. Redeem by recomputing that state; a bad token is "not found", never an error.

**Why:** A token made for one action must not verify for another. A fragment of the password salt makes a reset link die once the password changes, with no used-tokens table. A signed id is safe to expose, and tampering raises or returns nothing.

**Do:**
```
v = verifier("remember_me")                   # key = derive(master, purpose)
v.verify(token)                               # value, or raises InvalidSignature
verifier("unsubscribe").verify(token)         # fails: different purpose, different key
user.token_for("password_reset", expires = 15 min, binds = last10(password_salt))
find_by_token(purpose, token): decode; user only if recomputed state matches and not expired
record.signed_id(purpose, expires) in hidden form fields; find_signed returns nothing when forged
```

**Don't:** Sign everything with one raw secret, store random tokens you must remember to delete, sign only the user id, or put secrets in the embedded state (it is readable).

**Break it when:** A token must survive state changes (a long-lived invite) or be revocable by an admin: store it server-side. Tokens never expire unless you set an expiry.

**Source:** Guides: https://guides.rubyonrails.org/4_1_release_notes.html (Message Verifiers); https://guides.rubyonrails.org/5_2_release_notes.html (purpose and expiry); https://guides.rubyonrails.org/7_1_release_notes.html (generates_token_for); https://guides.rubyonrails.org/sign_up_and_settings.html (New Email Confirmation); https://guides.rubyonrails.org/getting_started.html (Unsubscribe Links). Code: activerecord/lib/active_record/token_for.rb:20-103; activerecord/lib/active_record/signed_id.rb:34-63; activesupport/lib/active_support/message_verifier.rb:48-60; railties/lib/rails/application.rb:208-244.
