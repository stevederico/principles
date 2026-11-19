# Value integrated systems

**Rule:** One person should be able to build the whole product, from database to screen, with one coherent toolkit that treats every entry point the same way.

**Why:** Splitting a team by layer adds handoffs. A small team that owns everything ships faster and understands the product. One toolkit also means one wrapper, one config lookup and one error path for requests, jobs and scripts.

**Do:**
```
one framework covers: data, routing, views, jobs, mail, files, cache, tests, deploy
request, job, and one-off script all run inside the same wrapper
one reporter sees every error; one lookup serves every secret
an API-only app keeps the ORM, jobs, mail and cache; only the HTML layer is removed
```

**Don't:** Split a simple app into three services with three teams before it has users.

**Break it when:** Scale or team size forces a split. Do it later, for a measured reason.

**Source:** Doctrine: https://rubyonrails.org/doctrine (Value integrated systems). Guides: https://guides.rubyonrails.org/getting_started.html; https://guides.rubyonrails.org/api_app.html (Why Use Rails for APIs?); https://guides.rubyonrails.org/error_reporting.html; https://guides.rubyonrails.org/testing.html. Code: actionpack/lib/action_dispatch/middleware/executor.rb:30,46.
