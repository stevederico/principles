# Convention over configuration

**Rule:** Pick one default for every common decision. Only ask for settings when someone deviates.

**Why:** Each choice a developer must make costs time and creates a different answer per project. A shared default removes the decision and makes every project look the same.

**Do:**
```
class Post           -> table "posts"
file  post.<ext>     -> lives in models/
route /posts/5       -> PostsController.show(id=5)
# zero config files for any of the above
```

**Don't:** Ship a framework where the first hour is filling out a config file.

**Break it when:** The default truly does not fit. Allow an override, keep it small, and let it be unusual.

**Source:** Rails Doctrine, "Convention over Configuration".
