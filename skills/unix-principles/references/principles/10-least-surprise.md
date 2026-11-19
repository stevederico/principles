# Do the least surprising thing

**Rule:** Model a new interface on ones the audience already knows, obey platform conventions, and when a function exists in a familiar tool, let users delegate to it or imitate a recognizable subset of it.

**Why:** A person can attend to one thing at a time; every surprise pulls attention from the task to the tool, and novelty is an entry barrier. Delegating to a user-chosen tool is cheaper for you and empowering for them. The rule is a bias, not conservatism, because designers tend to be too clever and poor design is painful for ever.

**Do:**
```
if familiar_tool_does(function):
    call(user_configured_tool)        # delegate
else:
    implement(recognizable_subset_of(familiar_tool))
```

**Don't:** Reuse a familiar symbol or option for something subtly different; make a different thing look plainly different instead.

**Break it when:** The familiar model is truly poor for your problem when judged from the user's side.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Least Surprise) ; http://www.catb.org/esr/writings/taoup/html/ch11s01.html (Applying the Rule of Least Surprise) ; http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Handing off Tasks to Specialist Programs). Book only.
