# Value integrated systems

**Rule:** One person should be able to build the whole product, from database to screen, with one coherent toolkit.

**Why:** Splitting a team by layer (database, API, frontend) adds meetings and handoffs. A small team that owns everything ships faster and understands the product.

**Do:**
```
one framework covers: data, routing, views, jobs, mail, files, tests
one developer ships a feature end to end
```

**Don't:** Split a simple app into three services with three teams before it has users.

**Break it when:** Scale or team size forces a split. Do it later, for a measured reason.

**Source:** Rails Doctrine, "Value integrated systems".
