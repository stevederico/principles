# Estimate in ideal time

**Rule:** Have developers estimate every story in ideal weeks, 1 to 3 each, splitting larger stories and merging smaller ones.

**Why:** An ideal week is the time to build the story, tests included, with no distractions, no other work and full knowledge of what to do. Over 3 weeks means the story is too vague to estimate; under 1 week means too fine. Around 80 stories, give or take 20, makes a good release plan.

**Do:**
```
for story in stories:
    weeks = ideal_weeks(story)        # includes writing its tests
    if weeks > 3: split(story)
    if weeks < 1: merge_with_neighbor(story)
target: ~80 stories (+/- 20) in the release plan
```

**Don't:** Estimating in calendar time, or leaving stories above three weeks unsplit.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/userstories.html, http://www.extremeprogramming.org/rules/planninggame.html
