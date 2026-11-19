# Confine privilege to a small trusted piece and narrow it step by step

**Rule:** Keep the security-critical work in the smallest possible program, run the rest with reduced authority, and where a flow has phases that cannot be re-entered, chain small steps that each check one thing and then hand over to the next with less authority.

**Why:** Strong boundaries between components keep a bug or an attack in one place. After a step drops its privilege and replaces itself with the next, the later stage cannot regain it and so need not be trusted. A new stage can be inserted without editing the others.

**Do:**
```
privileged_helper does the one privileged operation, small and audited
big_program runs unprivileged, talks to helper over a narrow channel
stage(args): if check(credentials): drop_privileges(); run(next_stage, args) else: exit_failure
```

**Don't:** Keep a high-privilege process alive for a whole session, or leave privilege separation to a later retrofit.

**Break it when:** A measured performance floor cannot be met otherwise; then document the risk and shrink the trusted part further. Stages needing two-way conversation or shared state do not chain.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch03s01.html (Internal Boundaries) ; http://www.catb.org/esr/writings/taoup/html/ch07s01.html (Separating Complexity Control from Performance Tuning) ; http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Security Wrappers and Bernstein Chaining). Book only.
