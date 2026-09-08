---
description: Create and update Decision Tables with AI
---

# Create and Edit Decision Tables

## Create and Edit Decision Tables

Decision Table Architect can create a new Decision Table or prepare targeted changes to a table that is already open.

| Task                    | Availability          |
| ----------------------- | --------------------- |
| Create a Decision Table | Rules List            |
| Edit a Decision Table   | Decision Table Detail |

{% hint style="info" %}
AI-assisted Decision Table editing requires DecisionRules App **1.26.1 or later** and AI Engine **1.2.0 or later**. Structured clarification, staged generation, requirements review, and process routing require App **1.26.2 or later** and AI Engine **1.3.0 or later**.
{% endhint %}

### Create a Decision Table

<figure><img src="../../.gitbook/assets/image (430).png" alt="Creating a Decision Table from AI Assistant on the Rules List"><figcaption><p>Describe the decision and review the generated Decision Table before importing it.</p></figcaption></figure>

Open AI Assistant from the **Rules List**, select **Decision Table Architect**, and describe the business decision you want to automate.

The Assistant first identifies the public inputs, outputs, and required decision behavior. It then creates and validates the table before presenting it for review.

#### What to Include in Your Prompt

For the best result, describe:

* The decision the table should make
* The conditions that affect the decision
* The expected outcomes
* Important input and output properties
* Thresholds, calculations, or mappings that must not be inferred
* Default or fallback behavior
* Relevant examples and edge cases

You do not need to describe the physical column or row structure. The Assistant can propose it when the business requirements are complete.

You can also attach a supported policy, specification, or spreadsheet and explain which content should be represented by the table.

#### Clarification Questions

If a core business choice is missing, the Assistant asks for it instead of silently inventing a threshold, formula, outcome, or fallback. A clarification can contain selectable options and an optional free-form answer.

Answer the question in the same chat to continue the current request.

#### Creation Examples

**Loan Application Evaluation**

> Evaluate a loan application using the applicant's age and credit score.
>
> Decline applicants younger than 21. Decline applications with a credit score below 600. Otherwise, approve the application.
>
> Inputs: `age`, `creditScore`\
> Output: `approvalStatus`

**Fraud Risk Evaluation**

> Assess transaction fraud risk from `paymentMethod`, `amount`, `country`, and `isVerified`.
>
> * Crypto above 5,000 for an unverified customer returns `High`.
> * Card payments from a high-risk country for an unverified customer return `High`.
> * Bank transfers above 10,000 return `Medium`.
> * Verified transactions below 1,000 return `Low`.
> * All remaining transactions return `Low`.
>
> Output: `riskLevel`

#### Generation and Requirements Review

The progress shown in AI Assistant can include:

1. Defining inputs, outputs, and decision logic
2. Drafting the Decision Table
3. Reviewing requirements coverage
4. Improving the draft when necessary
5. Validating the table structure
6. Preparing the preview

The requirements review checks whether the generated table represents the requested business behavior. A result that still cannot be represented reliably is not offered for import.

If the request actually requires several rules and their orchestration, the Assistant can recommend [Process Architect](design-and-build-a-complete-process.md). This keeps each business decision reviewable instead of forcing a complete process into one table.

#### Import the Table

When the proposal is ready, review its summary and select **Import Rule**. DecisionRules creates the rule and opens it in the editor.

The table is not created until you select **Import Rule**.

{% hint style="warning" %}
Review and test AI-generated logic before saving or publishing it.
{% endhint %}

### Edit an Existing Decision Table

<figure><img src="../../.gitbook/assets/image (431).png" alt="AI Assistant proposal for editing an existing Decision Table"><figcaption><p>Review the highlighted Decision Table changes before applying them.</p></figcaption></figure>

Open the Decision Table you want to change and describe the update in AI Assistant. The Assistant uses the complete current table as context and displays a proposal inside the editor. It does not save the proposal automatically.

#### Editing Examples

> Change the approval threshold from 5,000 to 7,500.

> Add an ELSE row that returns `Manual review`.

> Disable all rows that return `Rejected`.

> Set the selected cells to return `High risk`.

> Add `customer.segment` to the Input Model and add a condition for premium customers.

> Add a Rule Variable named `minimumIncome` with the value `30000` and use it in the relevant conditions.

> Use the current Test Bench input to update the matching row.

#### Select Cells for Additional Context

Before entering the prompt, select a cell or range of cells in the Decision Table. The selection is sent as additional context for requests such as:

> Replace 5,000 with 7,500 in the selected cells.

> Apply the same condition to all selected rows.

> Replace the selected outputs with risk categories.

The Assistant can also use the current Test Bench input and output when the request refers to tested values or the row that produced a result.

#### Supported Changes

The Assistant can propose changes involving:

* Cell values and function expressions
* Adding, replacing, deleting, enabling, or disabling rows
* Adding, updating, or deleting columns
* Adding, updating, or removing Rule Variables
* Adding or removing Input Model fields
* Adding or removing Output Model fields

Input columns remain before output columns so the result keeps a valid Decision Table structure.

#### Review Proposed Changes

Added, removed, and modified content is highlighted in the table preview. When existing values are changed, switch between **Show original** and **Show changes**.

Changes to the Input Model, Output Model, or Rule Variables are also listed in the proposal summary because they may not be visible in the grid.

#### Refine a Proposal

While a proposal is pending, send another instruction to refine it. For example:

> Keep the new row, but return `Escalate`.

> Apply the change only to customers from the EU.

> Keep the column changes, but do not remove the Rule Variable.

The revised proposal replaces the earlier pending proposal. Review it again before applying it.

#### Apply, Discard, Undo, and Save

After reviewing the proposal:

* Select **Apply Changes** to place it in the current editor.
* Select **Discard** to restore the table's previous state.
* Use **Undo** to revert an applied AI proposal as one editing step.
* Select **Save** to persist the applied changes.

{% hint style="info" %}
**Apply Changes** does not save the Decision Table. You must still select **Save**.
{% endhint %}

#### Outdated Proposals

A proposal becomes outdated when the Decision Table changes after the preview was generated. Regenerate it so the change is based on the latest table state.

If you navigate away while a proposal is pending, return to the original Decision Table to continue reviewing it.

### Troubleshooting

If the Assistant cannot create or edit the table:

* Make the required business behavior more explicit.
* Include the relevant input and output properties.
* Answer any pending clarification question.
* Use Process Architect when the request needs multiple rules and a flow.
* Confirm that your role can use AI Assistant and edit the Decision Table.
* Confirm that the table is not locked.
