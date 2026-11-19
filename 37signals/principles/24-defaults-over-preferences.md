# Make the call yourself; prefer general concepts to options

**Rule:** Decide small things (page size, sort order, counts) as constants, and offer a simple general mechanism rather than a special field per use, so users can invent their own conventions.

**Why:** Preferences push work onto users and multiply code paths, tests and unseen combinations that hide bugs. Specific features such as a due-date or category column serve a few and clutter everyone else; free-text conventions cost nothing to maintain. Defaults can be adjusted later after real complaints.

**Do:**
```
page_size = 25 ; sort = newest_first            # no settings
item = { text }                                  # users write "[Books] due 7 Apr" themselves
add a setting only if many users need it AND it is worth testing every permutation
```

**Don't:** Add an option to avoid a hard decision, or add a column per use case.

**Break it when:** Accessibility or locale needs make one choice wrong, or many users keep reinventing the same convention and need sorting or integrity free text cannot give.

**Source:** https://basecamp.com/gettingreal/06.4-avoid-preferences ; https://basecamp.com/gettingreal/05.6-human-solutions. Docs only.
