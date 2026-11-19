# Give templates an input contract

**Rule:** Let a view fragment declare exactly which inputs it takes, with defaults and required ones, so a wrong call fails at render time with a clear error.

**Why:** Without a declared signature a misspelled input is silently absent and renders nothing. A contract also documents the fragment and exposes dead inputs.

**Do:**
```
fragment product_card(product, theme = "light", **html_attrs)
render(product_card, product = p)                # ok
render(product_card, product = p, tehme = "dark")  # error: unknown input "tehme"
render(product_card)                             # error: missing input "product"
fragment with an empty signature: takes no inputs
```

**Don't:** Let fragments read ambient variables from whatever called them, or guess optional inputs from a bag.

**Break it when:** A throwaway prototype, or a wrapper that forwards arbitrary attributes (declare an explicit catch-all).

**Source:** Guides: https://guides.rubyonrails.org/action_view_overview.html (Strict Locals); https://guides.rubyonrails.org/7_1_release_notes.html (strict locals). Code: actionview/lib/action_view/template.rb:170-216,274-282; actionview/lib/action_view/template/error.rb:34-36.
