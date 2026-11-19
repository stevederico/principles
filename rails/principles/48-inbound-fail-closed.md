# Inbound endpoints fail closed

**Rule:** A webhook or ingress is off unless that specific one is configured, refuses to run when its credential is missing, compares secrets in constant time, and never treats routing on sender-supplied data as proof of identity.

**Why:** The sender controls every header a route rule matches, so "arrived at address X" does not mean "X's owner sent it". A blank secret must raise, not allow.

**Do:**
```
if configured_ingress != this_ingress: return 404
if secret is blank: raise ConfigError
authenticate(request, secret) with constant-time compare
route(/^save@/ -> ForwardsHandler)
ForwardsHandler.before: sender = find_user(mail.from); if not allowed for this account: bounce()
```

**Don't:** Ship an endpoint that accepts unauthenticated requests when the environment variable is unset, or let a handler act for an account based on the recipient address alone.

**Break it when:** Local development: use a dev-only test page rather than loosening the production path. Read-only public dispatch does not need identity.

**Source:** Guide: https://guides.rubyonrails.org/action_mailbox_basics.html (Configure Routing warning, Ingress Configuration). Code: actionmailbox/app/controllers/action_mailbox/base_controller.rb:10-33; actionmailbox/app/controllers/action_mailbox/ingresses/mailgun/inbound_emails_controller.rb:123; actionmailbox/lib/action_mailbox/mail_ext/recipients.rb:5-8.
