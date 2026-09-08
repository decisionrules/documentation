---
description: Create and Edit Decision Flows with AI
---

# Create and Edit Decision Flows

## Create and Edit Decision Flows

Decision Flow Architect creates and updates visual workflows from natural-language instructions. It can orchestrate existing DecisionRules resources together with branches, iterations, data transformations, variables, configuration values, and other supported Decision Flow nodes.

| Task                   | Availability         |
| ---------------------- | -------------------- |
| Create a Decision Flow | Rules List           |
| Edit a Decision Flow   | Decision Flow Detail |

{% hint style="info" %}
Decision Flow Architect requires DecisionRules App **1.26.2 or later** and AI Engine **1.3.0 or later** in self-hosted deployments.
{% endhint %}

### Decision Flow or Process Architect?

Use **Decision Flow Architect** when the result should be one Decision Flow, especially when the rules it needs to orchestrate already exist.

Use [Process Architect](design-and-build-a-complete-process.md) when the request requires several new or reused rules plus the Decision Flows that connect them. Process Architect plans and generates the complete set of resources together.

### Create a Decision Flow

<figure><img src="../../.gitbook/assets/image (438).png" alt="Decision Flow Architect selected with a complete flow prompt"><figcaption><p>Describe the workflow and select Decision Flow Architect.</p></figcaption></figure>

Open AI Assistant from the **Rules List**, select **Decision Flow Architect**, and describe the workflow you want to create.

#### What to Include in Your Prompt

Describe:

* The outcome of the flow
* The public inputs received by the flow
* The public outputs returned by the flow
* The sequence of business decisions and transformations
* Existing rules that should be called, preferably by name or alias
* Branch conditions and fallback paths
* Arrays that should be iterated, collected, merged, or combined
* Values that should remain configurable after generation
* Any external HTTP request and its expected data

Be explicit about formulas, mappings, branch conditions, and required output fields. The Assistant asks a clarification question when a flow-shaping choice cannot be inferred safely.

#### Self-Contained Example

> Create a Decision Flow named Application Routing.
>
> Its only public input is `application.score`, a Number. Its only public output is `decision.route`, a String.
>
> Add an editable global configuration value named `highTouchThreshold` with a default of `80`. Start with one branch that compares `application.score` with this value. When the score is greater than or equal to `highTouchThreshold`, assign `HIGH_TOUCH` to `decision.route`. In the default branch, assign `STANDARD` to `decision.route`. End both branches after assigning the output.
>
> Do not call any existing rules or external services.

#### Using Existing Rules

When the flow contains business-rule nodes, the Assistant inspects the selected space and binds them to existing resources by rule alias. It uses the bound rule's Input and Output Models when preparing mappings and downstream references.

If the requested rule is missing or several candidates could satisfy the same purpose, clarify which exact rule should be used. Decision Flow Architect creates the flow itself; it does not create a missing child rule as part of the same request.

{% hint style="info" %}
The example on this page uses only flow-native nodes so it can be followed in any space. Decision Flow Architect can also orchestrate existing rules, but a reusable example would depend on rules and Input and Output Models specific to the reader's space. For that workflow, include the exact rule alias and version in the prompt and describe how the flow inputs and prior node outputs map to the rule's saved Input Model.
{% endhint %}

#### Review the Proposal

The generated preview summarizes:

* Flow name and description
* Public inputs and outputs
* Main workflow steps
* Editable configuration values

Adjust any exposed configuration values before importing. Review the proposed steps and ensure that the correct existing rules are referenced.

Select **Import Rule** to create the Decision Flow. DecisionRules validates the flow and applies automatic layout before it is persisted.

The flow is not created until you select **Import Rule**.

{% hint style="warning" %}
Open and test the generated Decision Flow after import. Verify every rule binding, input mapping, branch, iteration, and output before publishing it.
{% endhint %}

### Edit an Existing Decision Flow

<figure><img src="../../.gitbook/assets/image (439).png" alt="Applied AI Assistant edit proposal on Decision Flow Detail"><figcaption><p>Inspect the proposed flow changes before selecting Apply Changes.</p></figcaption></figure>

Open the Decision Flow you want to change and select **Editing Decision Flow** in AI Assistant. The Assistant loads the complete current flow and prepares a proposal for the requested update.

#### Editing Examples

> Add a branch that sends applications with `fraudRisk = "High"` directly to manual review.

> Rebind the `Eligibility` node to rule alias `loan-eligibility-v2`.

> Rename the `Calculate price` node to `Calculate premium` and preserve its mappings.

> Add `manualReviewReason` to the Output Model and map it from the review branch.

> Remove the obsolete HTTP request and connect the validation node directly to the pricing node.

#### Supported Changes

The Assistant can prepare changes to:

* Workflow nodes and their configuration
* Connections and branch cases
* Existing-rule bindings
* The Input Model
* The Output Model

It prefers targeted changes for a localized request so unrelated nodes remain unchanged. A broad request can produce a wider workflow update.

The flow's identity, alias, version, and other unchanged settings are preserved.

#### Review, Apply, Undo, and Save

The proposal indicates whether the workflow, Input Model, or Output Model will change and includes a structured preview of the update.

* Select **Apply Changes** to place the proposal in the current editor.
* Use **Undo** to revert the applied proposal as one editing step.
* Select **Save** to persist the updated flow.

{% hint style="info" %}
**Apply Changes** does not save the Decision Flow. You must still select **Save**.
{% endhint %}

### Generate Test Input

On Decision Flow Detail, **Generate Input** can create data that follows the flow's public Input Model. It can also use the contents of bound Decision Tables and Lookup Tables as supporting context when choosing useful scenarios.

Review the result before applying it to Test Bench, especially when the flow calls external services or depends on data outside the generated input.

### Troubleshooting

If the Assistant cannot create or edit the flow:

* Name the exact existing rules that should be bound.
* Specify missing branch conditions, formulas, and public outputs.
* Answer any pending clarification question.
* Use Process Architect if child rules also need to be created.
* Confirm that referenced rules still exist with the expected Input and Output Models.
* Confirm that your role can use AI Assistant and edit the Decision Flow.
* Confirm that the flow is not locked.
