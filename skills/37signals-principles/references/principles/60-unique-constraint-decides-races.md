# Let a unique constraint decide races

**Rule:** For one-time actions (first-run setup, signup with an existing email), write optimistically and handle the unique-violation by sending the loser to the sensible next page.

**Why:** Two concurrent requests both pass an "exists?" check; only the database can arbitrate.

**Do:**
```
try:
    create(...) ; start_session ; redirect home
on UniqueViolation:
    redirect home, or to sign-in with the email prefilled
```

**Don't:** Rely on "if not exists then create" as the only guard.

**Break it when:** The loser needs a distinct error message; re-read the row and report.

**Source:** https://github.com/basecamp/once-campfire app/controllers/first_runs_controller.rb, app/controllers/users_controller.rb ; https://github.com/basecamp/writebook app/controllers/first_runs_controller.rb, app/controllers/users_controller.rb.
