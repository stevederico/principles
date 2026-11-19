# Allow-list input at the boundary

**Rule:** Name the fields you accept, make the shape part of the contract (required key present, expected types, else a client error), and set owner and privilege fields on the server so they are never taken from input.

**Why:** Users can send any field. "Pick these keys" alone still lets a missing or wrong-shaped payload through. An unpermitted request object refuses bulk assignment, so forgetting the filter fails loudly. A privilege flag kept only out of the list is one edit away from exposure.

**Do:**
```
fields = input.require_shape(review: [rating, body])   # 400 if the key or shape is wrong; scalars only
review = product.reviews.build(fields + {user: current_user})   # owner from the session
assign(record, raw_request_params)                 # raises: not permitted
User.admin is write-once; changing it raises
test: sign up with admin = true -> user is not admin
```

**Don't:** Pass the full payload to a model, put an owner key in the list "for convenience", use wildcard or permit-everything forms (they cover every future field), or repair bad input and carry on.

**Break it when:** Trusted internal code (jobs, scripts) passes plain maps, but write-once fields still need an explicit database update. A spam-style filter that cannot enumerate good values needs layered defenses.

**Source:** Guides: https://guides.rubyonrails.org/getting_started.html (Strong Parameters); https://guides.rubyonrails.org/action_controller_overview.html (Securing Submitted Parameters, expect, permit!); https://guides.rubyonrails.org/sign_up_and_settings.html (Readonly Attributes, Testing Sign Up); https://guides.rubyonrails.org/product_reviews.html (Creating Reviews); https://guides.rubyonrails.org/4_0_release_notes.html (Strong parameters). Code: actionpack/lib/action_controller/metal/strong_parameters.rb:765-813,1129-1134,1437-1451; activemodel/lib/active_model/forbidden_attributes_protection.rb:19-28; activerecord/lib/active_record/readonly_attributes.rb:4,29-32,71.
