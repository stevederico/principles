# Normalize at assignment and in lookups

**Rule:** Declare per-field cleanup (trim, lowercase, strip punctuation) once on the domain object. It runs when a value is assigned and again when the field appears in a lookup, so stored and searched values always match.

**Why:** Cleanup in a request handler is skipped by jobs and scripts, and a lookup with messy input would miss the cleaned stored value. A declared rule covers both sides.

**Do:**
```
User.normalize email: strip + lowercase
create(User, email = " BOB@X.COM ")        # stored "bob@x.com"
find_one(User, email = "\tBOB@X.COM ")      # matches
normalize_value_for(User, email, raw)      # callable from outside the model
```

**Don't:** Clean input only in the handler, or search with a raw SQL string and expect normalization (structured queries only).

**Break it when:** A field must keep its exact original bytes (passwords, signatures).

**Source:** Guides: https://guides.rubyonrails.org/7_1_release_notes.html (normalizes); https://guides.rubyonrails.org/sign_up_and_settings.html (Adding Names To Users). Code: activemodel/lib/active_model/attributes/normalization.rb:60-70,117-123,142-144.
