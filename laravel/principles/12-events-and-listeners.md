# Events and listeners

**Rule:** When something notable happens, announce it as a named event. Other code listens and reacts. The source does not know the listeners.

**Why:** "Order placed" can trigger email, stock update, analytics, and more. Adding one means adding a listener, not editing the order code.

**Do:**
```
place(order): order.save; emit OrderPlaced(order)

listen OrderPlaced -> SendReceipt
listen OrderPlaced -> UpdateStock
```

**Don't:** Call five unrelated services from the code that places the order.

**Break it when:** The flow is one clear step. A direct call is easier to follow.

**Source:** Laravel docs, events.
