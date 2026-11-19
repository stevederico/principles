# Interrupted actions are unknown

**Rule:** When an agent run fails part-way, store the completed steps, and on resume mark every action that has no recorded result as interrupted, because it may or may not have run.

**Why:** The framework cannot know whether the call executed. Pretending it did, or did not, risks a missed or a repeated side effect.

**Do:**
```
store(turn, status = failed, steps = completed_steps)
resume: for call in steps where call.result is none:
           tell_model(call, status = "interrupted")
```

**Don't:** Replaying the call blindly or dropping it silently.

**Break it when:** Idempotent actions, where replay is safe.

**Source:** https://laravel.com/docs/ai-sdk ; code: docs only
