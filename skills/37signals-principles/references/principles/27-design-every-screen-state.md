# Design every screen's states and words, for its own context

**Rule:** For each screen design and test the populated, first-use empty and failure states, write labels and messages in the audience's plain language, test with realistic hand-typed content, and let each screen show what its step needs even if it differs from others.

**Why:** Designers live in data-filled screens and rarely see the empty one, yet a new user judges the product by it; trust is made or lost in failure. Wording changes usability. Placeholder text hides long values and form friction. A repeated element that fits one place distracts in another. A recurring support question is a design defect, so put a short hint where it arises.

**Do:**
```
for screen in app: render(rich data) ; render(empty: explain, sample, next step) ; render(failed: what happened, what to do)
fixtures = realistic names and long values ; label = words the user uses
on repeated support topic T: add an inline hint at the control
```

**Don't:** Test only with seeded demo data, use lorem ipsum or internal jargon, or force uniform chrome for its own sake.

**Break it when:** Internal tools can skip an elaborate empty state (never the error state), privacy requires synthetic data, or muscle-memory controls (destructive actions) need to stay uniform.

**Source:** https://basecamp.com/gettingreal/09.3-three-state-solution ; https://basecamp.com/gettingreal/09.4-the-blank-slate ; https://basecamp.com/gettingreal/09.5-get-defensive ; https://basecamp.com/gettingreal/09.6-context-over-consistency ; https://basecamp.com/gettingreal/09.7-copywriting-is-interface-design ; https://basecamp.com/gettingreal/11.4-use-real-words ; https://basecamp.com/gettingreal/14.2-zero-training. Docs only.
