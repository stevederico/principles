# Get it simple and working, then measure, then tune

**Rule:** Build a simple correct version first, optimize only where measurement shows one part dominates and only if the gain justifies the added local complexity, and prefer improving the order of growth or doing nothing over shaving constants.

**Why:** Bottlenecks appear in unexpected places, premature local tuning blocks larger changes and breeds bugs, a prototype teaches which features can go, and code never written cannot be slow. Hardware improvements and the cost of programmer time swamp linear gains. The best speedups are usually side effects of clean design.

**Do:**
```
v1 = simple_correct_version
profile(v1)
if requirement_unmet and one_part_dominates: optimize(that_part)
elif complexity_class_can_drop: change_algorithm()
else: leave_it
```

**Don't:** Guess at hot spots, obscure data layouts for tiny gains, or hand-tune loops nobody showed to be slow.

**Break it when:** A hard performance requirement exists up front, such as a latency budget; then bake it into the design early.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Optimization) ; http://www.catb.org/esr/writings/taoup/html/ch12s01.html (Don't Just Do Something, Stand There!) ; http://www.catb.org/esr/writings/taoup/html/optimizationchapter.html (Chapter 12 introduction). Book only.
