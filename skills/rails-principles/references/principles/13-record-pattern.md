# One object per table row

**Rule:** A domain object wraps one database row, loads and saves itself, and carries the rules for its own data. Fields map to columns by name.

**Why:** Data and behavior stay together and there is almost no mapping code. The guide cites Fowler's definition of the pattern.

**Do:**
```
post = load(Post, 5)
post.title = "New"
save(post)                       # validates, then writes
report: total = sum(orders.subtotal where ...)   # ask the database, build no objects
```

**Don't:** Split every row into a data bag, a repository, a mapper and a service for a simple app.

**Break it when:** Logic stops matching the table shape, or the thing has no table. Model behavior (validation, naming, conversion to a form) is a small protocol that table-less objects can implement too, with a conformance test. A badly named legacy table can be wrapped in a database view with conventional names instead of per-field mapping. Read-only reports skip objects entirely.

**Source:** Guides: https://guides.rubyonrails.org/active_record_basics.html (The Active Record Pattern); https://guides.rubyonrails.org/active_model_basics.html (API, Lint Tests); https://guides.rubyonrails.org/active_record_postgresql.html (Database Views); https://guides.rubyonrails.org/active_record_querying.html (pluck, Calculations). Code: activemodel/lib/active_model/lint.rb.
