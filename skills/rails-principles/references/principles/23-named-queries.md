# Name your queries

**Rule:** Give common filters a name on the domain object and chain them. The body is a function evaluated per use, an empty result is still chainable, and "first" always has a defined order.

**Why:** Names turn query detail into intent, defined and tested once. A body computed at load freezes time-based filters. A missing result that is null breaks the chain, and an unordered "first" varies by engine.

**Do:**
```
scope published = () -> where(status = "published")
scope recent    = () -> order(created desc)
scope recent_if(flag) = () -> flag ? where(...) : all()    # never null
published.recent.first(5)
default filter merges with chained conditions; drop it by name: unscope(status)
first() with no order sorts by primary key; no usable key -> error
no rows: return an empty chainable query, not null
```

**Don't:** Repeat the same condition across ten files, define a scope as a value computed at load, or hide tenant or visibility rules in a default filter.

**Break it when:** A query is used once and never changes: inline it. When any one row will do, say so with "take", not "first".

**Source:** Guides: https://guides.rubyonrails.org/active_record_querying.html (Scopes, Using Conditionals, Null Relation, first, take); https://guides.rubyonrails.org/4_0_release_notes.html (scopes must be callable); https://guides.rubyonrails.org/3_1_release_notes.html (default scopes evaluated late); https://guides.rubyonrails.org/8_1_release_notes.html (order-dependent finders); https://guides.rubyonrails.org/wishlists.html (Refactoring Filters). Code: activerecord/lib/active_record/scoping/named.rb:89-90,197-217; activerecord/lib/active_record/relation/finder_methods.rb:693-731; activerecord/lib/active_record/relation/query_methods.rb:1027,1602-1615.
