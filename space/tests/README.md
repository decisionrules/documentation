---
description: >-
  Rule Testing lets you verify rule behavior against saved scenarios using fixed
  inputs and expected outputs. Use the Test Bench for quick, ad-hoc checks while
  editing.
---

# Tests

#### Why Use It?

* Validate changes before releasing to production.
* Catch side effects and broken logic early.
* Recheck rules automatically after platform updates.
* Understand rules faster through real-world input/output examples.
* Compare results between solver versions before switching.

#### Core Concepts

* Test: A single scenario (Input + Expected Output). You can choose to ignore dynamic values (like generated timestamps) so they don't cause false failures.
* Test Suite: A folder that groups related tests together. It is strictly linked to a specific rule version.
* Test Run: The execution record of your tests (Passed, Failed, Error, or Canceled).

{% hint style="info" %}
The number of tests you can save is limited by your plan; the Lite plan, for example, allows 15. See [Plan Limits Explained](../../profile/limits/plan-limits-explained.md).
{% endhint %}

{% hint style="info" %}
On a space with [Space Versioning](../space-version-control/), test suites belong to a revision: you see the suites of the revision you have switched to and tests run against it. Suites can be changed only in a draft revision. See [Working in a Revision](../space-version-control/working-in-a-revision.md#tests-and-test-runs).
{% endhint %}

#### Two Ways to Manage Tests

1. Rule-Level (Inside a rule): Create, edit, and debug tests for the specific rule you are actively working on.
2. Space-Level (Main menu): Manage bulk actions, move tests between rules, and view execution history across your entire space.

The interface is divided into two main tabs: [**Tests** ](tests-tab.md)and [**Test Runs**](test-runs-tab.md)**.**

### API Automation

Rule Testing can be fully automated via the DecisionRules API, making it easy to integrate testing directly into your CI/CD pipelines or external systems.

Authentication To authenticate requests, use a Bearer token with a valid Solver API key: `Authorization: Bearer YOUR_SOLVER_API_KEY`

Key Endpoints

* Start a Test Run (`POST /testRun/start`): Starts a new execution job. You must provide an array of `testSuiteIds` and/or `testIds` in the JSON body. The response returns a `testRunId`.
* Get Test Run Job (`GET /testRun/{testRunId}`): Retrieves the overall execution state, timing context, and results of a specific test run.

{% hint style="warning" %}
On a space with [Space Versioning](../space-version-control/), `POST /testRun/start` must name the revision to test with `?revisionIdentifier=` (a tag name, `PUBLISHED` or a revision ID). Without it the call is refused with HTTP 400; unlike jobs, test runs have no default revision. See [API and Integrations](../space-version-control/api-and-integrations.md).
{% endhint %}

More info [here](../../api/rule-testing-api.md).

<figure><img src="../../.gitbook/assets/Tests Tab-Space.png" alt=""><figcaption></figcaption></figure>
