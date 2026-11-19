# Hold names and hooks, not references

**Rule:** Long-lived places (config, registries, base types, middleware lists) store a name or a deferred hook, never a direct reference to code that can reload or may not be loaded yet.

**Why:** Unloading removes a type but old references keep the stale copy, so an old instance is no longer an instance of the new type. Initializers run once and cannot touch reloadable code, and reaching for a type early forces it to load too soon.

**Do:**
```
config.user_model = "User"                      # a name
user_type = resolve(config.user_model)          # when used
on_load("record_base"): include(MyExtension)    # runs when ready, or now if already ready
on_prepare(): Gateway.endpoint = url            # at boot and after each reload; idempotent
```

**Don't:** Stash a reloadable type in a long-lived registry, load app types inside an initializer, or include into a base type at require time hoping it exists.

**Break it when:** Reloading is off (production) and the target is always loaded first by construction.

**Source:** Guides: https://guides.rubyonrails.org/autoloading_and_reloading_constants.html (Reloading and Stale Objects, Autoloading When the Application Boots); https://guides.rubyonrails.org/plugins.html (Automatic Module Inclusion); https://guides.rubyonrails.org/engines.html. Code: activesupport/lib/active_support/lazy_load_hooks.rb:5-50,67-89; railties/lib/rails/application/finisher.rb:17-29,64-76.
