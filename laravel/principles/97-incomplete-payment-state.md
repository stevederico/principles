# Incomplete payment is a state

**Rule:** When a payment needs extra customer action (strong customer authentication can interrupt any charge, including renewals), raise a specific incomplete-payment signal carrying the payment, keep the subscription in an incomplete or past-due state until confirmation, and send the customer to a confirmation page or tell them an email is coming.

**Why:** The subscription is not active until the customer confirms, and the library activates it when the provider's webhook reports completion. Folding the case into a generic failure loses the recovery path. An app may deliberately keep incomplete or past-due subscriptions counting as active, but that is an explicit setting.

**Do:**
```
try: subscription.create(price) catch IncompletePayment p: redirect(confirmation_page(p.payment))
alternative: let the provider email the customer; still tell the user to expect it
has_incomplete_payment(subscription)      # query the state
on webhook payment_confirmed: subscription.status = active
```

**Don't:** Treating the exception as a generic failure, or activating the plan before confirmation.

**Break it when:** A business that chooses to keep incomplete subscriptions active: set that explicitly and accept the risk.

**Source:** https://laravel.com/docs/billing ; code: docs only
