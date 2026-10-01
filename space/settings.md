# Settings

### Available Run Solver versions in the app

DecisionRules can run your rules on more than one solver engine. Newer versions add capabilities, and every version gives the same results for the rules it can run. To call a specific version from your own code, see [Rule Solver API](../api/rule-solver-api/).

Choose which solver versions can be used when working with rules in this space's UI.

* **One version selected** — everything in the UI runs on that version.
* **Two versions selected** — a picker offers those two. The lower version is the default.

You can select up to two versions at a time. New spaces start with V2 selected.

<figure><img src="../.gitbook/assets/Screenshot 2026-09-30 at 15.05.43 1.png" alt=""><figcaption></figcaption></figure>

#### What it affects

* **Test Bench** — the solver a rule runs on when you press Run.
* **Tests** — both the Tests tab of a rule and Space → Tests.
* **Jobs** — starting a job.
* **Integrations** — the solver version in the generated code samples.

{% hint style="warning" %}
It does **not** affect calls from your own code. Each API names its solver in the request, and get what it asks for whatever this setting says.
{% endhint %}

