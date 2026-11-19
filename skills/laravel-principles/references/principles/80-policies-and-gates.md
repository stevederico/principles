# Policies and gates

**Rule:** Put "who may do what" in one named place per resource (a policy) and ask the same question from every entry point, and use a plain named gate for actions not tied to a record.

**Why:** Rules change often, so one place means one edit and one test file, and route layer, handler, template and user object all land on the same method. A before-hook handles admin bypass by returning allow or no opinion; an after-hook can only fill in a missing answer, never flip one. A denial can carry a message and status, and answering not-found hides that a record exists.

**Do:**
```
class PostPolicy:
  before(user, ability): if user.is_admin: return allow ; return no_opinion
  update(user, post): user.id == post.author_id or deny_as_not_found()
route PUT /posts/{post} requires can("update", post)
handler: authorize("update", post) ; template: if can("update", post): show_edit_button
```

**Don't:** Checking user.role == "admin" in many files, returning deny from a before-hook for non-admins, or rebuilding the owner check in a template.

**Break it when:** Compliance needs admins limited too: skip the hook and write explicit rules. Send coarse precomputed flags to the client, but still enforce on the server.

**Source:** https://laravel.com/docs/authorization, https://laravel.com/docs/sanctum, https://laravel.com/docs/horizon ; code: src/Illuminate/Auth/Access/Gate.php, src/Illuminate/Auth/Access/Response.php, src/Illuminate/Foundation/Exceptions/Handler.php
