# Defer problems you do not have, and offer only what you can run

**Rule:** Postpone scale, headcount, hardware and billing machinery until real data and a real deadline demand them, and do not launch a plan or promise whose operation and cost you cannot carry.

**Why:** Most apps never reach the load; load problems are rarely all-or-nothing; measured data beats guesses. A first deployment on one server took a week rather than months. Promises are easy and keeping them is hard: storage, payouts and accounting need systems behind them.

**Do:**
```
run on the simplest setup that serves current load; watch real metrics
when a metric crosses its threshold: fix that part and tell users plainly
before offering x: check(can_operate(x), can_afford(x), can_support(x)) ; start small
```

**Don't:** Build a cluster for traffic you may never get, or copy a competitor's free tier without capacity.

**Break it when:** The cost of fixing later is catastrophic or irreversible (data loss, money handling, one-way schema choices), or a capped, known loss-leader is a deliberate strategy.

**Source:** https://basecamp.com/gettingreal/04.3-its-a-problem-when-its-a-problem ; https://basecamp.com/gettingreal/04.5-scale-later ; https://basecamp.com/gettingreal/05.5-can-you-handle-it. Docs only.
