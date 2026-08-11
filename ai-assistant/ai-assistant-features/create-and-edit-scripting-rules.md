---
description: Create and update Scripting Rules with AI
---

# Create and Edit Scripting Rules

## Create and Edit Scripting Rules

The Scripting Rule Architect helps you create new Scripting Rules and prepare changes to existing ones using natural-language instructions.

From the **Rules List**, it can generate a complete new Scripting Rule. From an existing **Scripting Rule Detail**, it works with the currently opened rule and prepares targeted changes to its script, Input Model, Output Model, or Rule Variables.

This feature is useful when your logic is procedural, calculation-heavy, requires iteration, calls another rule or external service, or cannot be represented clearly in a Decision Table.

### Creating a Scripting Rule

When you are on the Rules List, open the AI Assistant and select **Scripting Rule Architect**.

Describe your business case and provide:

* **Case description** – what the rule should do
* **Input properties** – the data received by the rule
* **Output properties** – the values returned by the rule
* **Expected behavior** – calculations, validations, branching logic, and relevant edge cases

The Assistant prepares a complete Scripting Rule and validates its structure. Review the generated proposal and click **Import Rule** to create it in your space.

<figure><img src="../../.gitbook/assets/image (436).png" alt=""><figcaption></figcaption></figure>

#### Prompt Examples

{% hint style="info" %}
Use this agent when your logic is procedural, calculation-heavy, or difficult to express clearly in a Decision Table.
{% endhint %}

1. Simple Shipping Price Calculation:

> _I want to calculate shipping price based on package weight and destination zone._\
> _&#x49;f weight is below 1 kg, shipping is 5._\
> _&#x49;f weight is between 1 and 5 kg, shipping is 10._\
> _&#x49;f weight is above 5 kg, shipping is 20._\
> _&#x49;f destination zone is "express", add 15._\
> _&#x49;nput model properties: `weight`, `zone`_\
> _&#x4F;utput model properties: `shippingPrice`_

2. Customer Discount Evaluation:

> _I want to calculate a discount for a customer based on loyalty status, total order amount, and whether a promo code is applied._\
> _&#x49;f the customer is VIP and order amount is above 500, give 20% discount._\
> _&#x49;f the customer is VIP and order amount is above 200, give 10% discount._\
> _&#x49;f a promo code is applied, increase the final discount by 5%._\
> _&#x54;he total discount must never be more than 25%._\
> _&#x49;nput model properties: `loyaltyStatus`, `orderAmount`, `hasPromoCode`_\
> _&#x4F;utput model properties: `discountPercent`_

3. Fraud Review Decision:

> _I want to evaluate whether a transaction should be approved, flagged for review, or rejected._\
> _&#x49;f the transaction amount is above 10000 and the customer is not verified, reject it._\
> _&#x49;f the amount is above 5000 and the country is in a risky region, flag it for manual review._\
> _&#x4F;therwise approve it._\
> _&#x49;nput model properties: `amount`, `isVerified`, `country`_\
> _&#x4F;utput model properties: `decision`_

If the AI Assistant cannot generate the scripting rule based on your prompt, try to simplify it or re-formulate it.&#x20;

### Editing an Existing Scripting Rule

Open the Scripting Rule you want to modify and open the AI Assistant. The Assistant automatically uses the currently opened rule as context.

Describe the change you want to make. For example:

> Add validation that returns an error when `amount` is zero or negative.

> Add a `taxRate` Rule Variable and use it when calculating the final price.

> Add `normalizedPrice` to the Output Model and update the script to calculate it.

The Assistant can prepare changes to:

* the rule script
* the Input Model
* the Output Model
* Rule Variables

The rule’s identity, name, alias, version, and other unchanged settings are preserved.

### Reviewing and Applying Changes

Before changing the rule, the Assistant displays a proposal containing a preview of the script and an indication of whether the Input Model, Output Model, or Rule Variables will also be updated.

Review the proposal and click **Apply Changes** to place the changes into the currently opened rule.

{% hint style="warning" %}
Applying the proposal does not save the Scripting Rule. Review and test the updated rule, and then click **Save** to persist the changes.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (437).png" alt=""><figcaption></figcaption></figure>

### Tips for Better Results

* Describe the required change and the expected result.
* Mention the exact input, output, or Rule Variable names when possible.
* Explain relevant edge cases and validation behavior.
* For targeted updates, describe only what should change.
* Ask for a complete rewrite only when the existing implementation should be replaced.
* Test AI-generated changes before saving or publishing the rule.
