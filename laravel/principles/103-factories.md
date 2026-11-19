# Factories

**Rule:** Describe how to build a valid fake record once, with named states that combine in any order, and tests and seed data call the factory and override only what they assert on.

**Why:** Setup stays short, and a model change means one fix. Factories skip the mass-assignment guard. Related records are declared lazily in the default, and one shared instance can be reused when two paths reach the same entity.

**Do:**
```
UserFactory:
  default: name: fake.name, email: fake.email, role: "member"
  state admin: role: "admin"
UserFactory.admin().count(5).create()
Ticket.default: airline = AirlineFactory, flight = FlightFactory
Ticket.reuse(existing_airline).create()      # one airline wherever it is needed
```

**Don't:** Pasting a 12-field record into every test, or creating parents eagerly in each test.

**Break it when:** A test needs two distinct parents, or exact values: override those fields.

**Source:** https://laravel.com/docs/eloquent-factories, https://laravel.com/docs/seeding, https://laravel.com/docs/database-testing ; code: src/Illuminate/Database/Eloquent/Factories/Factory.php
