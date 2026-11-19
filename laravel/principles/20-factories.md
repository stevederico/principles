# Factories

**Rule:** Describe how to build a valid fake record once, with named variations. Tests and seed data call the factory.

**Why:** Test setup stays short and readable. When the model changes, you fix one factory instead of every test.

**Do:**
```
UserFactory:
  default: name: fake.name, email: fake.email, role: "member"
  state admin: role: "admin"

UserFactory.create()
UserFactory.admin().count(5).create()
```

**Don't:** Copy a 12-field record literal into every test.

**Break it when:** A test cares about exact values. Override just those fields.

**Source:** Laravel docs, database testing and factories.
