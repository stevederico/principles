# Scale review to demonstrated trust and the risk of the change

**Rule:** Review substantial work before it ships, but shrink the depth as track record grows: close back-and-forth at first, approach-only review next, independent shipping for the most trusted. Reviews of high-impact changes stay mandatory.

**Why:** Review buys quality and learning; applying it equally to everyone creates a bottleneck. Leads still check the approach of substantial projects and review on-call handoffs. Managers of one choose their own next valuable task, and need fewer status checks as they progress.

**Do:**
```
review_depth = f(author_trust, change_risk)
substantial change: lead checks the approach first
critical or cross-team change: senior reviewer regardless of author
no direction given: pick the most valuable next thing, pitch it, do it
```

**Don't:** Demand identical review from everyone and everything, or none from anyone.

**Break it when:** Critical systems, where trust does not waive review.

**Source:** https://github.com/basecamp/handbook/blob/main/titles-for-programmers.md (Programming Management, Trust) ; https://github.com/basecamp/handbook/blob/main/how-we-work.md (managers of one). Docs only.
