# Build small, scoped components wired in readable markup

**Rule:** Give each client component one concern and a scope limited to its own subtree (excluding nested components of the same kind), declare its wiring in the markup with names that say what happens, ask for style hooks by logical name, and coordinate through events rather than direct references.

**Why:** Many instances can coexist without cross-talk, and a reader can predict a template's behavior without opening the script. Event-named handlers hide intent. Logical class names keep behavior independent of the styling convention. Events keep components decoupled and cancelable; looking up a sibling couples concrete instances and load order.

**Do:**
```
markup: element(action = "click -> profile.showDialog", loading-class = "search--busy")
scope(c) = elements whose nearest component root is c.root
emit("clipboard:copy", {content}) bubbling, cancelable ; others subscribe in markup
server helpers emit the attributes; script takes only what it uses from its parts
```

**Don't:** Search the whole document by selector, name handlers after the raw event, hard-code class strings, or call another instance's methods when an event works.

**Break it when:** A parent must command many named peers (use a declared reference that is checked for presence), or a class is purely internal.

**Source:** https://stimulus.hotwired.dev/reference/controllers ; https://stimulus.hotwired.dev/reference/actions ; https://stimulus.hotwired.dev/reference/css-classes ; https://stimulus.hotwired.dev/reference/outlets ; code: https://github.com/hotwired/stimulus src/core/scope.ts ; https://github.com/basecamp/once-campfire app/helpers/messages_helper.rb.
