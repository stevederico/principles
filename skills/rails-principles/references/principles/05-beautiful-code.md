# Exalt beautiful code

**Rule:** Treat readable, elegant code as a goal. When the code is ugly, change the design until it reads well.

**Why:** Ugly code signals a wrong abstraction. Code that reads well is easier to change and to teach.

**Do:**
```
# write the call site as you wish it read, then build the thing behind it
validate name: present, length 3 to 50

# not
registry.add(factory.create_name_validator(min = 3, max = 50))
```

**Don't:** Accept an API because it works. Rewrite the call site until it is pleasant.

**Break it when:** Never as a goal. Do not trade clarity for cleverness to reach it.

**Source:** Doctrine: https://rubyonrails.org/doctrine (Exalt beautiful code). Docs only: no guide page states this rule and no code enforces it.
