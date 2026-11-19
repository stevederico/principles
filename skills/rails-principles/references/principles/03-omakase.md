# The menu is omakase

**Rule:** Ship a complete, opinionated default stack chosen by someone with taste, make every part swappable, and move high-upkeep parts out into opt-in packages instead of keeping them forever.

**Why:** Most people cannot choose well on day one. A chef's set menu beats a blank order form, and experts still change what they need.

**Do:**
```
new project = database + migrations + views + jobs + cache + mail + tests
              + lint rules + security scan + CI script + container file
              all wired, all working
swap a part:     change one dependency line or one generator setting
retire a part:   publish it as an optional package, name the replacement
style rules:     one person's taste, usable whole, as a start, or ignored
```

**Don't:** Hand over ten libraries and a choose-your-own-adventure guide, or keep a feature that drags every user into a trap for compatibility.

**Break it when:** A team has firm needs. Swapping must not mean fighting the framework.

**Source:** Doctrine: https://rubyonrails.org/doctrine (The menu is omakase). Guides: https://guides.rubyonrails.org/7_2_release_notes.html (omakase lint rules, security scanner, CI in new apps); https://guides.rubyonrails.org/4_0_release_notes.html (extraction of features to gems); https://guides.rubyonrails.org/generators.html (Overriding Generators with Fallbacks); https://guides.rubyonrails.org/getting_started.html. Code: railties/lib/rails/generators/rails/app/app_generator.rb:319; railties/lib/rails/generators/rails/app/templates/Gemfile.tt:14-24; templates/config/ci.rb.tt.
