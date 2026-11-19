# Choose a system metaphor

**Rule:** Pick a simple picture or naming scheme for the system so newcomers can grasp the design quickly and names are consistent and guessable.

**Why:** The term stands for a simple design with two qualities: you can explain it to new people without dumping huge documents, and it makes naming of classes and methods consistent. Good names help understanding and reuse; guessing a name correctly saves time. C3 was a production line and VCAPS a bill of materials, chosen easily only because those teams already knew the systems deeply. The site also says it is just a way of saying use good names.

**Do:**
```
choose a naming system everyone can relate to without hard-won knowledge
name new objects from that system
test it: can a newcomer guess a name and be right most of the time?
```

**Don't:** Explaining the system to newcomers by handing them large documents.

**Break it when:** When the domain is simple and generally understood, use the domain itself as the metaphor (the naive metaphor, in the coffee-maker example).

**Source:** http://www.extremeprogramming.org/rules/metaphor.html, http://www.extremeprogramming.org/lessons.html, http://www.extremeprogramming.org/example/simmet.html
