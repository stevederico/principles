# The menu is omakase

**Rule:** Ship a complete, opinionated default stack chosen by someone with taste. Let people swap parts later.

**Why:** Most people do not know enough to choose well on day one. A good chef's set menu beats a blank order form. Experts still get to change things.

**Do:**
```
new project =
  database + migrations + templates + jobs + mail + tests + auth helpers
  all wired together, all working, all swappable
```

**Don't:** Hand over ten libraries and a "choose your own adventure" guide.

**Break it when:** A team has strong needs. Swapping a part should be possible without fighting the framework.

**Source:** Rails Doctrine, "The menu is omakase".
