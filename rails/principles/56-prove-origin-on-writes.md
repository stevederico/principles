# Safe methods read; unsafe ones prove their origin

**Rule:** Reads never change state. Every state-changing request carries proof the attacker's site cannot supply: a per-session token, or the browser's cross-site header with a phased fallback to the token.

**Why:** Browsers attach cookies to cross-site requests. Read requests skip the check, so a write behind a GET is forgeable and fires from prefetchers and images. The header cannot be set by page scripts and needs no token in every form.

**Do:**
```
GET, HEAD: never mutate
unsafe request:
  site = header Sec-Fetch-Site
  same-origin or same-site -> allow;  cross-site -> reject
  header missing and strategy = hybrid -> check token, log the fallback
failed token -> reject and clear the auth cookie
per-form tokens bound to action and method; also compare the Origin header
GET returning script: only for same-origin script-initiated requests
```

**Don't:** Delete data from a link, exempt a mutating endpoint "because it is JSON", or keep the token path forever once all your audience's browsers send the header.

**Break it when:** Pure token-authenticated APIs with no ambient cookies. An emailed one-click link may act on GET only because its unguessable token is the proof.

**Source:** Guides: https://guides.rubyonrails.org/action_controller_advanced_topics.html (Authenticity Token); https://guides.rubyonrails.org/security.html (Cross-Site Request Forgery); https://guides.rubyonrails.org/8_2_release_notes.html; https://guides.rubyonrails.org/4_1_release_notes.html (CSRF protection from remote script tags); https://guides.rubyonrails.org/configuring.html (forgery_protection_verification_strategy). Code: actionpack/lib/action_controller/metal/request_forgery_protection.rb:19-22,96-103,224-240,535-545,561-566,609-617,677-680.
