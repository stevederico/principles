# Policies and gates

**Rule:** Put "who may do what" in one named place per resource, not in handlers or views.

**Why:** Authorization rules change often. One policy file per resource means one edit and one test file, and every entry point obeys it.

**Do:**
```
class PostPolicy:
  update(user, post): user.id == post.author_id or user.is_admin
  delete(user, post): user.is_admin

authorize("update", post)      # handler
if user.can("update", post)    # view
```

**Don't:** Check `if user.role == "admin"` in many files.

**Break it when:** A one-off rule is not tied to any resource. Use a simple named gate.

**Source:** Laravel docs, authorization (gates and policies).
