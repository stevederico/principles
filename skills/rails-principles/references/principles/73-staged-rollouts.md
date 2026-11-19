# Roll changes out in stages

**Rule:** Ship a behavior change behind a switch whose default keeps the old behavior, flip it in a per-release defaults bundle, tighten a new restriction in stages (log, notify, raise), and report use of deprecated things before removing them. Consumers upgrade one minor version at a time, tests first.

**Why:** Upgrades stay small and each change is adopted when the team has time. You find the real callers in production before you break them. Deprecation warnings only help if you go slowly.

**Do:**
```
setting new_behavior default = old; defaults_for(release N+1): new_behavior = true
upgrade file lists each new setting commented out, enable one per deploy; then delete the file
on violation: mode = log -> notify (publish event with caller) -> raise (new apps start here)
explicit opt-out per call: redirect(url, allow_external = true)
deprecated: true on a relation -> every use (direct, preloaded, nested) reports location
consumer: tests green -> latest patch -> fix deprecations -> next minor -> repeat; runtime first
```

**Don't:** Flip a default in the release that adds the setting, go straight to raise on a large user base, log forever, remove a relation because a grep found no callers, or jump several minors at once.

**Break it when:** A security flaw makes the old behavior unsafe to keep: change it at once and say so. With no safe old behavior and a strong suite, accept a bigger jump.

**Source:** Guides: https://guides.rubyonrails.org/contributing_to_ruby_on_rails.html (Changing Behavior); https://guides.rubyonrails.org/configuring.html (Versioned Default Values, action_on_open_redirect); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (General Advice, Configure Framework Defaults); https://guides.rubyonrails.org/8_1_release_notes.html (Deprecated Associations). Code: railties/lib/rails/application/configuration.rb:97-116,407; railties/lib/rails/generators/rails/app/templates/config/initializers/new_framework_defaults_8_2.rb.tt:21; actionpack/lib/action_controller/metal/redirecting.rb:273-295; activerecord/lib/active_record/associations/deprecation.rb:10-18,40-56.
