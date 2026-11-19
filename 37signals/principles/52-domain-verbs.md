# Controllers call one domain verb, then respond

**Rule:** An action loads the record, calls a model method named for the business event, and redirects or renders; guard filters are named by job (`set_*` loads, `ensure_*` rejects with a status), and flows that span models become small plain classes named for the operation.

**Why:** The same event is then reusable from jobs, scripts and other controllers, and tests target the model. Reading the top of any controller shows the chain in order: load, authorize, cache.

**Do:**
```
before: set_room ; ensure_can_administer (only update, destroy)
destroy: bot.deactivate ; redirect
update:  leaf.edit(leafable_params, leaf_params) ; respond
FirstRun.create(params): transaction { account ; admin ; grant membership }
```

**Don't:** Change several columns and send notifications in the action body, put orchestration in a user model or helper, or inline permission checks.

**Break it when:** The action only renders a view, or has a unique inline rule.

**Source:** https://github.com/basecamp/once-campfire app/controllers/accounts/bots_controller.rb, app/controllers/messages_controller.rb, app/models/first_run.rb, app/models/room/message_pusher.rb ; https://github.com/basecamp/writebook app/controllers/leafables_controller.rb, app/models/first_run.rb.
