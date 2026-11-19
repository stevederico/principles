# Check conversation ownership

**Rule:** Before continuing or resuming a stored agent conversation from an id the client sent, verify that the current user owns it, using the owner's type and id together.

**Why:** The continue and paused-turn resume methods do not check the participant themselves, so another user's id would work. Pairing type with id keeps user 1 and team 1 apart, but the application still has to authorize.

**Do:**
```
abort_unless(store.belongs_to(conv_id, user.type, user.id), 403)
agent.continue(conv_id, as = user).prompt(message)
```

**Don't:** Trusting an id from the request body.

**Break it when:** Ids that are unguessable and hold nothing sensitive: still prefer the check.

**Source:** https://laravel.com/docs/ai-sdk ; code: docs only
