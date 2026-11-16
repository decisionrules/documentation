# Webhooks

Webhooks are a way to receive notifications and output data from finished jobs running in DecisionRules. This information can either be retrieved manually via the provided [Jobs API endpoint](../api/jobs-api.md) or a webhook can be set up that receives the information automatically upon the Job’s completion.

Webhooks can also notify you about changes to rules and API keys and, on a space with [Space Versioning](space-version-control/), about the revision lifecycle. See [Event Logs, Service Logs and Notifications](event-logs-service-logs-and-notifications.md#webhooks) for the full list of events and the payload.

## How to define a webhook

A new webhook can be defined after navigating into the menu under Space → Webhooks and clicking the “+ Add Webhook” button, or while in an Integration Flow using the “Webhooks” button in the top-right corner.

<figure><img src="../.gitbook/assets/webhook_page.png" alt=""><figcaption><p>Access to Webhooks page</p></figcaption></figure>

<figure><img src="../.gitbook/assets/create_webhook_rule.png" alt=""><figcaption><p>Create a Webhook in the Integration Flow designer</p></figcaption></figure>

For any new webhook you can fill out the following:

* Endpoint URL _(Required)_
* Alias _(Required)_
  * Identification of the webhook inside DecisionRules
* Status
  * Switch to turn off the webhook without the need of deleting it
* Description _(Optional)_
* Events to send _(Required)_
  * You can select which type of events will this webhook be triggered for, for example you can have separate webhooks for successful executions and another one for cancellations and errors
  * Events are grouped into **Jobs**, **Rules**, **Revisions** and **API Keys**. API Key events (**API Key Created**, **API Key Updated**, **API Key Deleted**) report changes to the space's API keys.
  * Revision events are offered on every space but fire only on spaces with [Space Versioning](space-version-control/) — for example **Revision Published** for a deployment pipeline. **Versioning Enabled** fires when Space Versioning is switched on. See [Webhooks and Event Logs](space-version-control/api-and-integrations.md#webhooks-and-event-logs).

<figure><img src="../.gitbook/assets/create_webhook_modal.png" alt=""><figcaption><p>Create a new webhook screen</p></figcaption></figure>

### Secret

While setting up the webhook you are provided with a secret that can be used to verify incoming messages.

{% hint style="warning" %}
Please note that the secret is shown only in the creation of the webhook and **is not accessible anywhere else**.
{% endhint %}

### Validation Sample

In the webhooks creation screen you are also provided with implementation examples, that highlights the retrieval and verification of the message.

### Assigning webhook to specific rules

When you have your webhook created inside DecisionRules you then have to link it to specific rules so that their completion events are reported.

This can be done for any Integration Flow, using the top right menu “Webhooks” and checking all the created webhooks you want to send the events to.

<figure><img src="../.gitbook/assets/webhook_to_rule.png" alt=""><figcaption><p>Add Webhook to rule</p></figcaption></figure>

{% hint style="info" %}
On a space with [Space Versioning](space-version-control/), the webhooks you check are saved with the Integration Flow, so the selection belongs to the revision you edit. A finished job notifies the webhooks selected in the flow of the revision the job ran against. Jobs started through the API without a revision run against the published revision, so a selection made in a draft takes effect for them only after the draft is published. The job notification also carries `data.revisionId` and `data.revisionName` of that revision.
{% endhint %}

### Testing Webhook functionality

If you need to test the webhook functionality, or want to see the resulting messages without having to setup the webhook yourself, we would recommend one of the sites that allow you to setup a testing webhook online (e.g., webhook.site).

For this test all you need to do is to take the provided URL, set up a DecisionRules webhook using that URL (nothing else has to be set up), turn on the specific webhook for your Integration Flow and after running a Job you should see a message received with all of the provided data in the service that you are using.
