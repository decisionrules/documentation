---
description: Create and update Decision Tables with AI
---

# Create and Edit Decision Tables

The AI Assistant can help you both create new Decision Tables and modify existing ones using natural-language instructions.

You can describe the business decision you want to automate, ask the Assistant to generate the initial table, or request targeted changes to a Decision Table that already exists.

| Task                    | Availability          |
| ----------------------- | --------------------- |
| Create a Decision Table | Rules List            |
| Edit a Decision Table   | Decision Table Detail |

{% hint style="info" %}
AI-assisted Decision Table editing requires DecisionRules App **1.26.1 or later** and AI Engine **1.2.0 or later**.
{% endhint %}

## Create a Decision Table

<figure><img src="../../.gitbook/assets/image (430).png" alt=""><figcaption></figcaption></figure>

Open the AI Assistant from the **Rules List** and describe the business decision you want to automate.

The Decision Table Architect analyzes your request and creates a structured Decision Table. If important information is missing, the Assistant may ask a follow-up question before generating the table.

### What to Include in Your Prompt

For the best result, describe:

* The decision the table should make
* The conditions that affect the decision
* The expected outcomes
* Important input properties
* Important output properties
* Any default or fallback behavior

You do not need to specify the complete technical table structure. The Assistant can propose suitable input and output fields when they can be safely inferred from your description.

### Creation Examples

1. Simple Loan Application Evaluation:

> _I want to evaluate a loan application based on the applicant's age and credit score._\
> _&#x49;f the age is under 21, the application should be declined._\
> _&#x49;f the credit score is below 600, also decline._\
> _&#x4F;therwise, approve._\
> _&#x49;nput model properties: `age`, `creditScore`_\
> _&#x4F;utput model properties: `approvalStatus`_

2. Fraud Risk Evaluation:

> _I want to assess the fraud risk of a transaction based on payment method, transaction amount, country, and customer verification status._
>
> * _If payment is "Crypto", amount > 5000, and not verified → High risk_
> * _If payment is "Card", country is in "High-Risk List", and not verified → High risk_
> * _If payment is "BankTransfer", amount > 10000 → Medium risk_
> * _If verified and amount < 1000 → Low risk_
> * _If payment is "Card" or "BankTransfer", country is "Trusted", verified → Low risk_
> * _If payment is "Crypto" and amount < 1000 → Medium risk_
> * _If not verified and country is not known → High risk_
> * _If payment is "Card", amount > 2000, and not verified → Medium risk_
> * _Else → Low risk_
>
> _Input model properties: `paymentMethod`, `amount`, `country`, `isVerified`_\
> _&#x4F;utput model properties: `riskLevel`_

When the table is ready, review the Assistant’s summary and select **Import Rule**. DecisionRules creates the rule and opens it in the editor, where you can inspect, test, and modify it.

## Edit an Existing Decision Table

<figure><img src="../../.gitbook/assets/image (433).png" alt=""><figcaption></figcaption></figure>

Open the Decision Table you want to modify and use the AI Assistant to describe the required change.

The Assistant prepares a proposal and displays it directly in the table for review. It does not save the proposed changes automatically.

### Editing Examples

> Change the approval threshold from 5,000 to 7,500.

> Add an ELSE row that returns “Manual review”.

> Disable all rows that return “Rejected”.

> Set the selected cells to return “High risk”.

> Add `customer.segment` to the input model and create a condition for premium customers.

> Add a rule variable named `minimumIncome` with the value `30000` and use it in the relevant conditions.

> Use the current Test Bench input to update the matching row.

### Select Cells for Additional Context

Before entering your prompt, you can select a cell or a range of cells in the Decision Table.

The Assistant receives the selection as additional context. This is useful for requests such as:

> Change the selected cells to use 7,500 instead of 5,000.

> Replace the values in this column with risk categories.

> Apply the same condition to all selected rows.

The Assistant can also use the current Test Bench input and output when your request refers to the values being tested or the rows that produced a result.

### Supported Changes

The AI Assistant can propose changes involving:

* Cell values and function expressions
* Adding, replacing, deleting, enabling, and disabling rows
* Adding, updating, and deleting columns
* Adding, updating, and removing rule variables
* Adding and removing input model fields
* Adding and removing output model fields

Input columns are kept before output columns to preserve a valid Decision Table structure.

### Review Proposed Changes

The proposal is displayed as a preview inside the Decision Table.

Added, removed, and modified content is highlighted so you can inspect the result before accepting it. When the proposal changes existing values, you can switch between **Show original** and **Show changes**.

Changes to input and output model fields or rule variables are also listed in the proposal summary because they may not be visible directly in the table grid.

{% hint style="warning" icon="triangle-exclamation" %}
Always review and test AI-generated changes before saving or publishing a Decision Table.
{% endhint %}

### Refine a Proposal

You can send another instruction while a proposal is pending.

For example:

> Keep the new row, but change its output to “Escalate”.

> Apply the change only to customers from the EU.

> Keep the column changes, but do not remove the rule variable.

The Assistant generates a revised proposal that replaces the previous pending proposal. Review the new version before applying it.

### Apply, Discard, Undo, and Save

Once you have reviewed the proposal:

* Select **Apply Changes** to place the changes into the current editor.
* Select **Discard** to restore the table to its previous state.
* Use **Undo** to revert an applied AI proposal as one editing step.
* Select **Save** to persist the applied changes.

{% hint style="info" %}
**Apply Changes** does not save the Decision Table. You must still select **Save** to persist the result.
{% endhint %}

### Outdated Proposals

A proposal may become outdated if the Decision Table is modified after the preview was generated.

When this happens, regenerate the proposal so it is based on the current version of the table.

If you navigate away while a proposal is pending, return to the original Decision Table to continue reviewing it.

### Troubleshooting

If the Assistant cannot create or edit the Decision Table:

* Make the requested business behavior more explicit.
* Include the relevant input and output fields.
* Break a large request into smaller changes.
* Answer any follow-up question from the Assistant.
* Confirm that you have permission to use the AI Assistant and edit the Decision Table.
* Confirm that the table is not locked.
