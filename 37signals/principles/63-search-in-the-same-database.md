# Index text in the same database and quote every query token

**Rule:** Keep a full-text virtual table in the main database, maintain it from after-commit callbacks in a searchable module, join it to the permission-scoped relation, and turn user input into quoted literals.

**Why:** No search service to run or keep in sync. Bare AND, OR, NOT or unbalanced quotes raise syntax errors, and both apps note this.

**Do:**
```
after_create_commit: insert into index(rowid, body)
after_update_commit: update index if text changed
match_terms(q) = each word of q, quoted and escaped, joined by space
search = permission_scoped_relation joined to index
```

**Don't:** Pass raw user input to the match operator.

**Break it when:** You need typo tolerance or multi-node scale.

**Source:** https://github.com/basecamp/once-campfire app/models/message/searchable.rb ; https://github.com/basecamp/writebook app/models/leaf/searchable.rb, db/migrate/20240928005927_create_leaf_search_index_table.rb.
