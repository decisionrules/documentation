---
description: >-
  Rule Testing lets you verify rule behavior against saved scenarios using fixed
  inputs and expected outputs. Use the Test Bench for quick, ad-hoc checks while
  editing, and use Rule Testing for automate
---

# Tests

#### Why Use It?

* Validate changes before releasing to production.
* Catch side effects and broken logic early.
* Recheck rules automatically after platform updates.
* Understand rules faster through real-world input/output examples.

#### Core Concepts

* Test: A single scenario (Input + Expected Output). You can choose to ignore dynamic values (like generated timestamps) so they don't cause false failures.
* Test Suite: A folder that groups related tests together. It is strictly linked to a specific rule version.
* Test Run: The execution record of your tests (Passed, Failed, Error, or Canceled).

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

more info here:&#x20;

{% content-ref url="../../api/rule-testing-api.md" %}
[rule-testing-api.md](../../api/rule-testing-api.md)
{% endcontent-ref %}

<figure><img src="../../.gitbook/assets/Tests Tab-Space.png" alt=""><figcaption></figcaption></figure>
