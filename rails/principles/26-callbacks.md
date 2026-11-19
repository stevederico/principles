# Callbacks with restraint

**Rule:** Use lifecycle hooks for rules about the object's own data and cheap derived upkeep. The hook chain runs inside the write transaction, so outside effects wait for commit, halting is explicit, and errors propagate.

**Why:** Hooks run invisibly. An effect done mid-chain survives a later rollback (the guide's example: the file is gone but the row is back). After-commit hooks run only for durable data, but their errors cannot undo the write, so hiding them hides failures.

**Do:**
```
before_save: strip and lowercase email              # own field, inside the transaction
after_commit: product.average = avg(reviews.rating) # derived data, written without firing hooks
after_commit on update, only if stock went 0 -> positive: enqueue notify(product.id)
halt only through abort(); a falsy return value does nothing
hooks are private; never call save() inside a hook
```

**Don't:** Delete a file, charge a card, send mail or call an API from a hook that runs before commit; swallow errors inside after-commit hooks; fire a commit hook on every update with no guard.

**Break it when:** Another row in the same database must succeed or fail with the write: do it in a pre-commit hook so an exception rolls both back.

**Source:** Guides: https://guides.rubyonrails.org/active_record_callbacks.html (Halting Execution, after_commit and after_rollback, Skipping Callbacks, Registering Callbacks); https://guides.rubyonrails.org/getting_started.html (In Stock Email Notifications); https://guides.rubyonrails.org/product_reviews.html (Updating the Average Rating Cache); https://guides.rubyonrails.org/5_0_release_notes.html (explicit abort, commit hooks not swallowing errors); https://guides.rubyonrails.org/4_0_release_notes.html (observers extracted). Code: activerecord/lib/active_record/transactions.rb:197-208,460-474.
