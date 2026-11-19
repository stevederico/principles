# Everything is a resource

**Rule:** Model the app as things (resources) with a small fixed set of actions: list, show, new, create, edit, update, delete. Need a new action? Make a new resource.

**Why:** A small vocabulary is predictable. URLs, controllers, and tests all follow one pattern, so anyone can find anything.

**Do:**
```
POST /posts/5/publish   # not: custom verb on posts
->
POST /posts/5/publication   # "publication" is a resource; create it
```

**Don't:** Grow a controller with twenty custom actions.

**Break it when:** The domain really is an operation, not a thing (search, login). Keep the exception small.

**Source:** Rails practice, REST resource routing.
