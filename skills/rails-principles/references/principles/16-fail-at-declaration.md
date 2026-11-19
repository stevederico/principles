# Fail at declaration, not at first use

**Rule:** Reject a mistake when it is declared: name collisions, unknown option keys, duplicate or ambiguous routes, hooks naming missing actions, scope bodies that are not deferred, routes to missing handlers.

**Why:** A typo that silently does nothing is found in production. A declaration-time error points at the exact line and costs a second.

**Do:**
```
declare_enum(status: [active, archived])   # "archived?" already exists -> error now
declare_children(posts, {dependant: "destroy"})  # error: unknown key "dependant"
route get "/" to home.index                # verb required; duplicate route name -> error
before_hook(only: "shw")                   # no such action -> error at boot
scope recent = where(...)                  # error: body must be a function, evaluated per use
boot (eager): log every route whose target is missing
```

**Don't:** Ignore extra option keys "for forward compatibility" where behavior depends on them, or let a generated method replace a built-in.

**Break it when:** Options pass through to another layer that validates them, or are open-ended on purpose (HTML attributes). Require an explicit flag for a deliberate override.

**Source:** Guides: https://guides.rubyonrails.org/4_1_release_notes.html (dangerous name conflicts raise); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Rails 3.2 to 4.0 routes; Rails 8.1 to 8.2 missing controllers); https://guides.rubyonrails.org/active_support_core_extensions.html (assert_valid_keys); https://guides.rubyonrails.org/configuring.html (raise_on_missing_callback_actions). Code: activerecord/lib/active_record/enum.rb:462-484; activerecord/lib/active_record/scoping/named.rb:197-217; actionpack/lib/action_dispatch/routing/mapper.rb:104; actionpack/lib/abstract_controller/callbacks.rb:51-62.
