# Allow-list input at the boundary

**Rule:** Name the fields you accept from outside. Ignore or reject everything else.

**Why:** Users can send any field. Trusting all of them lets someone set `is_admin = true` on their own account.

**Do:**
```
allowed = params.pick("title", "body")
post.update(allowed)
```

**Don't:** Pass the full request payload straight into a model.

**Break it when:** Never for user input. Trusted internal code may relax this.

**Source:** Rails practice, strong parameters.
