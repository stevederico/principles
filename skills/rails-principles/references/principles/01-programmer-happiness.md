# Programmer happiness

**Rule:** Optimize for how the code feels to write and read, not only for speed or purity.

**Why:** Joy is a design input. People who enjoy a tool work longer and more carefully, and a clumsy API taxes every future reader.

**Do:**
```
# write the call site you wish for first, then build it
recent_published_posts(user, limit = 5)

# not
q = PostQuery(user_id = user.id, status = 2)
q.order(created, desc).limit(5).run()
```

**Don't:** Choose the awkward API because it was easier to implement.

**Break it when:** A hot path needs raw speed. Isolate it, label it, and state what it gives up (Rails ships a bare endpoint base that skips routing and the controller layer, and says so).

**Source:** Doctrine: https://rubyonrails.org/doctrine (Optimize for programmer happiness). Guides: https://guides.rubyonrails.org/getting_started.html ("Autoloading in Development" names happiness as the reason for reload and no manual imports); https://guides.rubyonrails.org/2_3_release_notes.html ("Rails Metal"). Code: actionpack/lib/action_controller/metal.rb. The happiness claim itself is docs only.
