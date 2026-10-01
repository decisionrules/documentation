---
description: >-
  This page is for you if you already have something calling DecisionRules and
  you are thinking about moving it to new Solver.
---

# Rule Solver API Migration

### What to expect

Your rules give the same answers on both engines. This is not a rewrite of how rules are evaluated — it is a new engine running the same logic, and we test both against the same cases to keep it that way.

So the expected outcome of this migration is that nothing changes except which engine handled the request. That said, **we do not recommend switching production over in one go.**

Before you start, read [Invalid requests](rule-solver-api.md#invalid-requests) in Aero solver.

### Docker and On-Premise capacity

Before switching to V2, apply the [Aero server profile](../../decisionrules-applications/server-app.md#minimal-requirements). Aero can use more CPUs per replica while `WORKERS_NUMBER` remains set to `1`.

### Migration steps

#### **1. Make sure both versions are available**

Open **Space Settings** **→** [**Solver Versions**](../../space/settings.md#solver-versions) in the space you are migrating and check that both the versions you use today and the one you are moving to are selected.

With both selected, you can pick the solver for each run.

If you work under organization, the list of spaces in **Organization → Resources →** [**Spaces**](../../organization/resources/spaces.md) shows which versions each space has.

#### 2. Run your tests on V2

If you have tests for your rules, run them against the new engine before changing anything in your integration. Nothing else in your setup needs to change. You pick the version for each run: in the [Tests Tab](../../space/tests/tests-tab.md) or in [Test Bench](../../rules/common-rule-features/test-bench.md), and in the [Rule Testing API](../rule-testing-api.md) with `solverVersion` if you run tests from CI.

See [Rule testing](https://docs.decisionrules.io/doc/rules/common-rule-features/rule-testing) for how to set tests up and run them.

{% hint style="info" %}
**No tests yet?** This is a good moment to write a few, and our [AI assistant can generate them](../../ai-assistant/ai-assistant-features/#generate-test-data) for you from your existing rules.
{% endhint %}

#### 3. If something does not match

Both versions should give the same result for the same rule and input. If they don't, that's something for us to look into, and you shouldn't have to work around it. Before you contact us, a few quick checks will tell you whether the difference really comes from the solver, and they often find the cause straight away.

**Check the rule**

* **Reproduce it in Test Bench.** Run the same input on both versions in [Test Bench](../../rules/common-rule-features/test-bench.md#solver-version). If the results match there but not in your integration, the difference is in how your code calls us.

**Check the request**

* **Is it one of the documented differences?** A `400` on V2 that you never saw on V1 usually means the request body is one of the cases in [Invalid requests](rule-solver-api.md#invalid-requests).
* **Same input, same strategy.** Compare the exact body and the `X-Strategy` header of both calls. A different strategy gives a different result on either version.

**Check that the call went where you think it did**

* **The response header.** Look at `X-Solver-Version` in both responses. If both say the same version, the difference is not between solvers. If a call you sent to `/v2/` says `v1`, see [Exceptions](rule-solver-api.md#exceptions).
* **The rule version.** A call without a version uses the latest published one. If you compare a test against a call without a version, you may be comparing two different versions of the rule.
* **The space.** The API key decides which space the rule comes from. Make sure both calls use a key for the same space.

**If the difference is still there,** [**contact support**](https://support.decisionrules.io/support/home) **and send:**

* the rule which fails
* the input you sent
* what you expected and what you got instead

{% hint style="warning" %}
**Please, do not change your rule to make the V2 output match V1.**
{% endhint %}

#### 4. Switch over

Once your tests pass on V2, switch each place that calls DecisionRules:

* **Rule Solver API** — change the path:

```
POST /rule/solve/{ruleId}/{ruleVersion}        # before
POST /rule/v1/solve/{ruleId}/{ruleVersion}     # before, if you already name V1
POST /rule/v2/solve/{ruleId}/{ruleVersion}     # after
```

* **Jobs API** — add `"solverVersion": "v2"` to the request body. See [Jobs API](../jobs-api.md).
* **Rule Testing API** — if you run tests from CI, set `"solverVersion": "v2"` there too, so your tests keep running on the version production uses.

Move one integration at a time and watch it before doing the next. Every response carries `X-Solver-Version`, so log it during the switch.

**If something goes wrong, change the path back.** Nothing is stored, nothing is converted, and your rules are untouched — the engine is chosen per request. Switching to new version is not a commitment, and you can run one endpoint on new version while everything else stays on old one for as long as you like.

### What tests will not catch

Running your rules inside DecisionRules proves the two engines agree on your logic, and that is the important part. What it cannot check is how _your own code_ builds the request — a test suite sends a well-formed body every time.

So if you start seeing `400`s on V2 that you never saw on V1, the engine is not the problem. V2 is telling you about something your code was already doing, and V1 was accepting quietly.

The requests V2 rejects are listed in [Invalid requests](rule-solver-api.md#invalid-requests).
