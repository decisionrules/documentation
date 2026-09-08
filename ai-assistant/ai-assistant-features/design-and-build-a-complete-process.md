---
description: Design and Build a Complete Process with AI
---

# Design and Build a Complete Process

Process Architect turns a business requirement into a reviewed set of DecisionRules resources. It can plan and generate Decision Tables, Lookup Tables, Scripting Rules, optional subflows, and the main Decision Flow that connects them.

**Availability:** Rules List

{% hint style="info" %}
Process Architect requires DecisionRules App **1.26.2 or later** and AI Engine **1.3.0 or later** in self-hosted deployments.
{% endhint %}

The generated process is delivered as a folder containing rules and Decision Flows. A process is not a separate rule type.

### When to Use Process Architect

Use Process Architect when the business outcome requires multiple rule resources and their orchestration.

Use a specialized architect instead when the required result is only:

* One Decision Table
* One Scripting Rule
* One Lookup Table
* One Decision Flow, especially over rules that already exist

### Describe the Process

Open AI Assistant on the **Rules List**, select **Process Architect**, and describe the complete business outcome.

Include:

* The input received by the process
* The final output it should return
* The business decisions and reference data involved
* Required calculations, thresholds, and mappings
* The expected order and dependencies between decisions
* Branches, loops, and failure or fallback behavior
* Existing rules that may be reused
* Important examples and edge cases

#### Prompt Example

> Build a small-business loan decision process.
>
> The process receives applicant details, company age, annual revenue, requested amount, and credit score. Create separate decisions for basic eligibility, fraud risk, and pricing. Use a Lookup Table for the base interest rate by risk grade. The final Decision Flow must stop on an ineligible or high-fraud-risk application and otherwise return `decision`, `riskGrade`, `interestRate`, and `reason`.
>
> Reuse a compatible existing rule if one is found, but let me review the exact version before using it.

If a core policy is missing, Process Architect asks a clarification question before proposing or continuing the plan.

### Review the Plan

Process Architect does not start by creating resources. It first displays an ordered plan that can contain:

* Decision Tables for reviewable business conditions and outcomes
* Lookup Tables for fixed reference data
* Scripting Rules when a concrete procedural capability is required
* Optional Decision Flow subflows
* A final Decision Flow that connects the process

<figure><img src="../../.gitbook/assets/image (440).png" alt="Process Architect plan containing several DecisionRules resource types"><figcaption><p>Review every planned resource and its dependencies before generation.</p></figcaption></figure>

Each step shows its type, name, purpose, detailed assignment, and dependencies. Expand a step to review exactly what will be generated.

<figure><img src="../../.gitbook/assets/image (441).png" alt=""><figcaption><p>You can review the detail of every step by expanding the step.</p></figcaption></figure>

Before generation, you can:

* Rename a step
* Edit its purpose
* Remove an unnecessary step
* Enter an adjustment below the plan
* Refine the plan with a follow-up message in chat
* Discard the proposal

A refinement produces a new plan for review. Confirm the latest plan only after its inputs, outputs, dependencies, and responsibilities are correct.

### Reuse an Existing Rule

For a planned Decision Table, Lookup Table, or Scripting Rule, the plan can show compatible existing rules from the selected space.

A candidate must match the planned rule type and public Input and Output Models. Its name or description must also plausibly match the planned responsibility.

Reuse is never automatic. The selector starts with **Create a new rule**. When you select a candidate, the plan shows its exact alias, version, and status. The same identity and compatibility are checked again when generation starts.

{% hint style="warning" %}
Review the selected alias, version, status, and behavior. Candidate ordering does not indicate that a rule is selected or recommended for automatic reuse.
{% endhint %}

### Generate the Process

Select **Generate process** after reviewing the plan.

Process Architect generates new leaf rules first, then subflows and the main Decision Flow. The progress card shows which steps are waiting, running, generated, or reused.

Completed steps remain proposals during generation. No new rule or folder is added to the space at this stage.

#### Answer a Clarification During Generation

<figure><img src="../../.gitbook/assets/image (442).png" alt="Process generation paused on a structured clarification question"><figcaption><p>Answer the missing business question, then continue from the saved progress.</p></figcaption></figure>

A specialist may discover that a required business decision is missing while generating one step. The process pauses on that step and displays the question.

Enter the answer and select **Continue generation**. Completed steps are retained, the paused step continues from its saved progress, and later steps remain waiting until their dependencies are ready.

You can also return to plan editing when the missing detail requires a broader change.

#### Retry a Failed Step

If a technical or structural problem stops generation, use the retry action to continue from the last safe progress point. Successfully generated and explicitly reused steps are retained instead of being generated again.

#### Review a Split or Repair

If one planned Decision Table is too complex to represent reliably, the process can stop and offer **Review split**. The proposed replacement divides only the affected responsibility into smaller steps while preserving completed work. Generation continues only after you approve the revised plan.

After repeated structural failures, **Review repair** can propose a focused representation repair for the failed step. The step's business purpose and completed upstream work remain unchanged.

Use **Rebuild whole plan** when the required correction changes completed or upstream contracts and cannot be handled safely as a localized continuation.

### Import the Completed Process

<figure><img src="../../.gitbook/assets/image (443).png" alt=""><figcaption></figcaption></figure>

When every step is ready, the Assistant prepares one folder proposal. Generated Decision Flows are automatically arranged before persistence.

Review the completed result and select **Import process**. This is the action that writes the generated folder and resources to the selected space.

If import fails, the completed proposal remains available so the import can be retried without generating the process again.

{% hint style="warning" %}
After import, open and test every generated rule and Decision Flow. Verify reused rule versions, mappings, branches, public Input and Output Models, and representative end-to-end scenarios before publishing the process.
{% endhint %}

### Stop or Discard Work

You can stop an active generation or discard a plan that has not been imported. Stopping or discarding proposal work does not delete existing reusable rules and does not import generated resources.

Only one unfinished process can be actively reviewed or generated in the current AI Assistant context. Finish, edit, or discard it before starting another process.

### Tips for Better Results

* Describe business responsibilities, not a preferred technical split, unless that split is a requirement.
* State thresholds, formulas, mappings, and fallback behavior explicitly.
* Keep Decision Tables as the default for declarative business policy.
* Request scripting only when the behavior needs a concrete procedural capability.
* Review every existing-rule reuse selection before generation.
* Treat generation and import as separate approval points.
