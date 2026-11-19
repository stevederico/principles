# Models own the domain

**Rule:** Business rules live in domain objects. Request handlers stay thin: read input, call the model, choose a response.

**Why:** Rules in handlers cannot be reused by jobs or scripts and need a web request to test. The guides name the practice "Fat Model, Skinny Controller".

**Do:**
```
handler.create:
  order = Order.place(input, user)
  respond(order)

Order.place: check stock, apply discount, save
Order.filter_by(params): starts from the current query so other filters still apply
```

**Don't:** Put pricing, filtering or validation logic in a handler or view.

**Break it when:** One object grows huge. Split it into smaller domain objects, never back into handlers. Concurrency-sensitive rules (uniqueness) also need a database constraint.

**Source:** Guides: https://guides.rubyonrails.org/wishlists.html (Refactoring Filters); https://guides.rubyonrails.org/layouts_and_rendering.html (Introduction); https://guides.rubyonrails.org/active_record_validations.html (Alternate Ways to Validate); https://guides.rubyonrails.org/sign_up_and_settings.html; https://guides.rubyonrails.org/product_reviews.html (Filtering reviews). Practice: "fat model, skinny controller".
