# Progress over stability

**Rule:** Break compatibility only in a minor or major release, only after a deprecation warning shipped in the release before, and never in a patch. Promise stability only for the documented public surface.

**Why:** A framework frozen for compatibility rots, but users upgrade one step at a time and need warning. A published rule lets everyone plan; a public/internal line lets the project move fast inside.

**Do:**
```
1.4.0  old_api() works and warns "removed in 1.5, use new_api()"
1.5.0  old_api() is deleted
1.4.1  fixes only, never breaks
internal helpers: callable but marked internal, no promise
widely used feature: move to an optional package, say where
upgrade guide linked from every release note
```

**Don't:** Remove something that never warned, change behavior in a patch, or freeze internals the same way as public API.

**Break it when:** A security fix has no safe old form: ship only that change and say so loudly. Rarely a change cannot be deprecated first (the 3.1 association-destroy change): ship it as a documented break.

**Source:** Doctrine: https://rubyonrails.org/doctrine (Progress over stability). Guides: https://guides.rubyonrails.org/maintenance_policy.html (Versioning, Security Issues); https://guides.rubyonrails.org/contributing_to_ruby_on_rails.html (Breaking Changes); https://guides.rubyonrails.org/api_documentation_guidelines.html (Method Visibility); https://guides.rubyonrails.org/6_1_release_notes.html. Code: activesupport/lib/active_support/deprecation/reporting.rb:20; railties/lib/rails/application/configuration.rb:97-109.
