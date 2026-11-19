# Deny by default

**Rule:** An authorization check with no rule for the ability, or with no signed-in user, must answer no without running anything, and anything a caller may not use should be absent from lists and rejected when called by name.

**Why:** Missing rules and anonymous callers are the usual way access leaks. Guests are denied unless a rule explicitly declares it accepts them, and an unregistered ability counts as denied. Private realtime channels follow the same shape: no matching rule means refusal.

**Do:**
```
can(user, ability, target):
  if user is null and not rule.accepts_guest: return deny
  rule = find_rule(ability, target)
  if rule is missing: return deny
  return rule(user, target)
tool.should_register(request): request.user.is_subscribed     # not listed and not callable otherwise
```

**Don't:** Returning allow when no rule is found, or running owner checks on a null user and crashing into a 500.

**Break it when:** A page is intentionally public: mark that one rule as guest-accepting. Discovery that advertises paid features for upsell.

**Source:** https://laravel.com/docs/authorization, https://laravel.com/docs/broadcasting, https://laravel.com/docs/mcp ; code: src/Illuminate/Auth/Access/Gate.php, src/Illuminate/Broadcasting/Broadcasters/Broadcaster.php
