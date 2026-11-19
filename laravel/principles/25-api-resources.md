# API resources

**Rule:** Put an explicit output layer between stored records and API output: it lists each exposed field, can vary by viewer, omits hidden fields entirely, includes relations only when already loaded, and wraps results in a named envelope.

**Why:** A raw dump exposes every column to everyone. A key that is absent leaks nothing, while null says the field exists. Loaded-only relations stop the output layer from firing hidden queries. A top-level data key leaves room for links and meta without breaking clients; paginated output is always wrapped.

**Do:**
```
class UserOutput(user, viewer):
  id: user.id
  secret: only_if(viewer.is_admin, user.secret)             # key omitted otherwise
  posts: only_if_loaded(user, "posts", PostOutput.many)     # never queries
respond({data: UserOutput.many(users), links: {...}, meta: {...}})
```

**Don't:** respond(user.to_json()), secret: is_admin ? secret : null, or touching user.posts inside the output layer.

**Break it when:** An internal tool may return the record directly if its model has an allow list (a deny list silently leaks later columns). Typed client SDKs may need explicit nulls. A required bare shape: switch wrapping off in one place.

**Source:** https://laravel.com/docs/eloquent-resources, https://laravel.com/docs/eloquent-serialization, https://laravel.com/docs/pagination, https://laravel.com/docs/responses ; code: src/Illuminate/Http/Resources/ConditionallyLoadsAttributes.php, src/Illuminate/Http/Resources/Json/ResourceResponse.php, src/Illuminate/Database/Eloquent/Concerns/HasAttributes.php
