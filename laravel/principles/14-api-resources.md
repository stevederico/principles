# API resources

**Rule:** Put a transformer between your domain objects and your API output. It decides exactly which fields and shapes go out.

**Why:** Database columns are not a public contract. A transformer lets you rename, hide, or reshape without breaking clients and avoids leaking private fields.

**Do:**
```
class UserOutput(user):
  id: user.id
  name: user.name
  joined: format(user.created_at)
  # no password hash, no internal flags

respond(UserOutput(user))
respond(UserOutput.collection(users))
```

**Don't:** Return the raw database object as JSON.

**Break it when:** The API is internal and private. Even then, hide secrets.

**Source:** Laravel docs, Eloquent API resources.
