# Models own the domain

**Rule:** Business rules live in domain objects. Request handlers stay thin: read input, call the model, choose a response.

**Why:** Rules in handlers cannot be reused by jobs, scripts, or other entry points, and are hard to test without a web request.

**Do:**
```
handler.create:
  order = Order.place(params, user)
  respond(order)

Order.place: checks stock, applies discount, saves
```

**Don't:** Put pricing logic in a request handler or a view.

**Break it when:** A domain object grows huge. Split it into smaller domain objects, not back into handlers.

**Source:** Rails practice, "fat model, skinny controller".
