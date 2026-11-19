# Form requests

**Rule:** Give each action its own input object that declares who may call it and what valid data looks like. Handlers receive only checked data.

**Why:** Validation leaves the handler, so the handler stays short and the rules are easy to find and test. Bad input never reaches the logic.

**Do:**
```
class CreatePostInput:
  authorize(user): user.can("create", Post)
  rules: title: required, max 100
         body:  required

handler.create(input: CreatePostInput):
  Post.create(input.validated())
```

**Don't:** Validate with a pile of `if` checks inside the handler.

**Break it when:** A check depends on business state not known to the input. Do it in the domain layer.

**Source:** Laravel docs, form request validation.
