# Redirect on success, re-render with an error status on failure

**Rule:** After a successful write, redirect to a readable page (303 when the original was not a plain read). After a failed validation, re-render the same form with the user's input and a 422 status. A handler produces exactly one response.

**Why:** A redirect makes refresh safe. The 422 status lets the client library and tests tell failure from success. A second render attempt raises, which catches the branch that forgot to return.

**Do:**
```
if record.save():  redirect(show_url(record), status = 303, notice)
else:              render(form, record, status = 422)     # same object keeps the fields
redirect_back(fallback = home)     # the fallback is a required argument
```

**Don't:** Return 200 with the error form, render a page straight from a successful POST, or rely on "the last render wins".

**Break it when:** A JSON API with no form to re-show: return 201 or 422 with an error body.

**Source:** Guides: https://guides.rubyonrails.org/getting_started.html (Handling Errors); https://guides.rubyonrails.org/layouts_and_rendering.html (Rendering Templates, Avoiding Double Render Errors); https://guides.rubyonrails.org/using_hotwire_with_rails.html (Turbo Streams); https://guides.rubyonrails.org/5_0_release_notes.html (redirect_back needs a fallback). The layouts guide mislabels 422 as "303 Unprocessable Content"; the generator uses 422. Code: railties/lib/rails/generators/rails/scaffold_controller/templates/controller.rb.tt:28-46; actionpack/lib/action_controller/metal/rendering.rb:174-175; actionpack/lib/action_controller/metal/redirecting.rb:153,170-204.
