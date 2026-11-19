# Compose behavior from small modules

**Rule:** Pull one cohesive behavior into a named module and mix it into the objects that need it. Add behavior with your own modules, not by patching built-in types.

**Why:** Big objects become unreadable. A module gives a behavior a name and a home. Patching core types clashes with other libraries, breaks on upgrades and hides where a method came from.

**Do:**
```
module Archivable: archive(), archived?(), scope archived   # one idea, named for what it adds
Post    includes Archivable
Comment includes Archivable
app-owned base type per layer: AppRecord extends FrameworkRecord; Post extends AppRecord
own value type: RateLimit(10, per = "hour")     # not 10.requests_per_hour on the integer type
```

**Don't:** Use a module as a junk drawer, or add methods to string, number or list types for convenience.

**Break it when:** A module needs knowledge of many objects (use an explicit collaborator). A small, namespaced, documented extension is the entire point of a library.

**Source:** Guides: https://guides.rubyonrails.org/getting_started.html (Extracting a Concern); https://guides.rubyonrails.org/engines.html (Reopening Existing Classes Using ActiveSupport::Concern); https://guides.rubyonrails.org/plugins.html (Extending Core Classes warning); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (ApplicationRecord, ApplicationJob). Code: railties/lib/rails/generators/rails/app/templates/app/models/application_record.rb.tt.
