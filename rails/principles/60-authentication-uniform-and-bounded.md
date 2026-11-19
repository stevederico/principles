# Authentication is uniform, bounded and re-proved

**Rule:** Fail login and reset the same way whether or not the account exists, do equal work for unknown users, compare secrets in constant time, limit attempts per caller, and demand current-password proof for account-takeover steps in a way that omitting the field cannot skip.

**Why:** Different messages and timings let attackers harvest usernames. Early-exit comparison leaks matching bytes. A check that runs only when its input is present is skipped by dropping the field. A stolen session must not be able to change the email and reset the password.

**Do:**
```
authenticate_by(email, password):
  if password blank: return nothing                   # no query
  user = find_one(email)
  if none: hash(password); return nothing             # burn the same time
  return user if verify(user.digest, password)
message always: "try another email or password"
rate_limit(10 per 3 minutes, by client, store = shared cache, on_exceed = friendly redirect)
change email or password: input default current_password = ""   # empty string is checked and fails
constant_time_equal(hash(provided), hash(expected))   # fixed-length values
admin surface on its own origin and user store; serious actions re-ask the password
```

**Don't:** Say "no such user", count attempts in process memory across several processes, use one global bucket, or trust that the form always includes the challenge field.

**Break it when:** Public registration must say "taken" (mitigate with limits). Usernames shown on profiles are not secret. A gateway may already rate-limit, but keep a low login limit.

**Source:** Guides: https://guides.rubyonrails.org/security.html (Brute-Forcing Accounts, Account Hijacking, Intranet and Admin Security); https://guides.rubyonrails.org/sign_up_and_settings.html (Rate Limiting Sign Up, Safely Updating Passwords, Email Routes & Controller); https://guides.rubyonrails.org/7_1_release_notes.html (authenticate_by). Code: activerecord/lib/active_record/secure_password.rb:8-60; activemodel/lib/active_model/secure_password.rb:238-245; actionpack/lib/action_controller/metal/rate_limiting.rb:84-111; activesupport/lib/active_support/security_utils.rb:5-34 (a variable-length compare still reveals length; the 5.2 notes claim otherwise).
