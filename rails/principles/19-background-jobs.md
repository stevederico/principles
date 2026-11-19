# Slow work goes to a queue

**Rule:** If it can be slow, can fail, or does not need to finish before the response, run it as a background job.

**Why:** Users should not wait on email, file processing, or third-party APIs. A queue gives retries and keeps requests fast.

**Do:**
```
handler.create:
  order.save
  enqueue SendReceipt(order.id)    # pass an id, not the object
  respond 201
```

**Don't:** Call a slow external API inside the request. Don't pass whole objects into the queue; pass ids and reload.

**Break it when:** The result is needed in the response. Then keep it inline with a timeout.

**Source:** Rails practice, Active Job.
