# Spike solutions

**Rule:** When a technical or design problem is hard or a story estimate is shaky, put a pair on a small throwaway program that addresses only that question.

**Why:** The goal is to cut the risk of a technical problem or sharpen a story estimate. The spike ignores everything else, and most are not good enough to keep. A pair gets a week or two when a difficulty threatens progress. At project start, spend a few weeks on stories and spikes for risky items before release planning. The coffee-maker spike asks whether hardware can be driven as easily as thought; a yes lowers estimates and risk.

**Do:**
```
name one question: "can we interface to the hardware as easily as we think?"
pair builds the smallest program that answers it, 1 to 2 weeks max
record the answer, adjust story estimates, delete the code
```

**Don't:** Letting a spike grow to cover other concerns or shipping the spike code.

**Break it when:** Keep the spike only in the rare case it turns out good enough; most are not.

**Source:** http://www.extremeprogramming.org/rules/spike.html, http://www.extremeprogramming.org/start.html, http://www.extremeprogramming.org/example/spike.html
