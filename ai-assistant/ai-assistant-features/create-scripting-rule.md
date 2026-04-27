---
description: Create Scripting Rules with AI
---

# Create Scripting Rule

When you are on the rules list, you can access the Scripting Rule Architect within the AI Assistant. It lets you generate a custom scripting rule from written, human-readable instructions.

Instead of writing the whole script manually, you can describe your business case, expected behavior, input properties, and output properties, and the assistant will prepare a ready-to-use scripting rule for you. This feature is useful when your logic is better expressed as code than as a Decision Table.

<figure><img src="../../.gitbook/assets/image (410).png" alt=""><figcaption></figcaption></figure>

### How the Prompt Works

Inside the prompt window, enter your business case and provide some basic information:

* **Your case description** – describe what the rule should do, including important conditions, calculations, validations, or branching logic
* **Input Properties** – the attributes the rule will receive and evaluate (e.g. `customerAge`, `amount`, `country`, `isVerified`)
* **Output Properties** – the attributes the rule should return (e.g. `approvalStatus`, `riskLevel`, `discount`, `message`)

You can also describe how the result should be computed, what should happen in edge cases, and whether the output should contain one or more calculated values.

Once this information is provided, the assistant begins building the scripting rule. When the rule is ready, you will see a message confirming it is complete. Click the confirmation button to finalize the creation and continue with review or editing.

### Prompt Examples

{% hint style="info" %}
Use this agent when your logic is procedural, calculation-heavy, or difficult to express clearly in a Decision Table.
{% endhint %}

1. Simple Shipping Price Calculation:

> _I want to calculate shipping price based on package weight and destination zone._\
> &#xNAN;_&#x49;f weight is below 1 kg, shipping is 5._\
> &#xNAN;_&#x49;f weight is between 1 and 5 kg, shipping is 10._\
> &#xNAN;_&#x49;f weight is above 5 kg, shipping is 20._\
> &#xNAN;_&#x49;f destination zone is "express", add 15._\
> &#xNAN;_&#x49;nput model properties: `weight`, `zone`_\
> &#xNAN;_&#x4F;utput model properties: `shippingPrice`_

2. Customer Discount Evaluation:

> _I want to calculate a discount for a customer based on loyalty status, total order amount, and whether a promo code is applied._\
> &#xNAN;_&#x49;f the customer is VIP and order amount is above 500, give 20% discount._\
> &#xNAN;_&#x49;f the customer is VIP and order amount is above 200, give 10% discount._\
> &#xNAN;_&#x49;f a promo code is applied, increase the final discount by 5%._\
> &#xNAN;_&#x54;he total discount must never be more than 25%._\
> &#xNAN;_&#x49;nput model properties: `loyaltyStatus`, `orderAmount`, `hasPromoCode`_\
> &#xNAN;_&#x4F;utput model properties: `discountPercent`_

3. Fraud Review Decision:

> _I want to evaluate whether a transaction should be approved, flagged for review, or rejected._\
> &#xNAN;_&#x49;f the transaction amount is above 10000 and the customer is not verified, reject it._\
> &#xNAN;_&#x49;f the amount is above 5000 and the country is in a risky region, flag it for manual review._\
> &#xNAN;_&#x4F;therwise approve it._\
> &#xNAN;_&#x49;nput model properties: `amount`, `isVerified`, `country`_\
> &#xNAN;_&#x4F;utput model properties: `decision`_

If the AI Assistant cannot generate the scripting rule based on your prompt, try to simplify it or re-formulate it.&#x20;
