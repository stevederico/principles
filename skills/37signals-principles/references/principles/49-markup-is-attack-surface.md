# Treat declarative markup as an attack surface

**Rule:** If anyone who can inject markup can name handler methods, no handler may perform a sensitive action without its own server-side authorization; only explicitly registered handler classes may be reachable, and nothing evaluates strings.

**Why:** An attacker who can edit the DOM can wire an action to any method on a registered controller. Registration is explicit, there is no eval, and instantiation is gated. The safeguard therefore lives in the invoked code, alongside output escaping and a content security policy.

**Do:**
```
handler.delete_account(): require_server_side_confirmation()
register only the handler classes you mean to expose
never assume the markup was authored by you
```

**Don't:** Rely on the page being "your own markup", or dispatch by looking up arbitrary method names.

**Break it when:** There is no user-supplied HTML anywhere on the page, though escaping and a policy still apply.

**Source:** https://github.com/hotwired/stimulus SECURITY.md ; code: src/core/application.ts, src/core/binding.ts.
