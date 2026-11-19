# Settle arguments with running software, not paper

**Rule:** Put a real, running thing in front of people as early as possible, replace the functional spec with a one-page story plus a real interface, produce only artifacts that become the product, and test new features inside the live app with a few users.

**Why:** Mockups, specs and stories approximate; people agree over the real thing, and parts assumed trivial turn out crucial. A functional spec gives false agreement, forces big decisions when you know least, and rewards adding bullets without cost. Separate documents go stale. A separate beta build gets only a superficial pass; real data and workflows reveal real problems. A public "beta" label shifts responsibility to users.

**Do:**
```
write(one_page_story, limit = 1 day) ; sketch -> html screens -> clickable
if artifact will not evolve into the product: prototype the thing instead
release behind a switch to chosen users in the real app; widen from feedback
if good enough for the public: call it a release and own its quality
```

**Don't:** Argue over diagrams, sign off a long spec before building, or keep a parallel beta product.

**Break it when:** Trying is dangerous or irreversible (hardware, money settlement), a contract demands a document (keep it thin), or the document is a durable runbook or API contract kept beside the code.

**Source:** https://basecamp.com/gettingreal/06.1-race-to-running-software ; https://basecamp.com/gettingreal/11.1-theres-nothing-functional-about-afunctional-spec ; https://basecamp.com/gettingreal/11.2-dont-do-dead-documents ; https://basecamp.com/gettingreal/06.6-test-in-the-wild ; https://basecamp.com/gettingreal/15.3-better-not-beta. Docs only.
