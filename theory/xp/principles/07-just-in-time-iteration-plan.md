# Plan each iteration just in time

**Rule:** Plan programming tasks only at the start of each iteration: the customer picks stories up to last velocity, and developers sign up for tasks and estimate them themselves.

**Why:** Planning late keeps pace with changing requirements. Tasks are in developer language, sized 1 to 3 ideal days (shorter ones grouped, longer split), and the person who does a task must estimate it since people are not interchangeable. Task days override story weeks because they are more accurate. If the total beats last velocity, the customer pushes stories out (snow plowing); if it is short, take another story.

**Do:**
```
customer: pick stories (and failed acceptance tests) summing to last velocity
team: break into task cards; remove duplicates
each developer: sign up, estimate own task in ideal days
if total task days > last velocity: customer defers stories
if total < last velocity: pull in one more story
```

**Don't:** Scheduling tasks beyond the current iteration, or letting someone else estimate a developer's task.

**Break it when:** When stories are consistently small, skip the step of turning them into tasks.

**Source:** http://www.extremeprogramming.org/rules/iterationplanning.html, http://www.extremeprogramming.org/rules/iterative.html, http://www.extremeprogramming.org/lessons.html
