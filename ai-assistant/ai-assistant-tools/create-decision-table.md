---
description: Create Business Rules with AI
---

# Create Decision Table

When you are on the rules list, you can access the Create Decision Table tool within the AI Assistant. It allows you to generate custom Decision Table based on written human-readable instructions.

Instead of manually building a rule row by row, you can simply describe your business case, and the assistant will generate a ready-to-use decision table for you. This feature aims to simplify rule creation, especially for users who are new to the platform or working with repetitive decision logic.

<figure><img src="../../.gitbook/assets/image (1) (6).png" alt=""><figcaption></figcaption></figure>

## How the Prompt Works

Inside the prompt window, enter your business case and provide some basic information:

* **Your case description** – be as specific and clear as possible, include all important conditions and expected outcomes
* **Input Properties** – the attributes the rule will evaluate (e.g. `age`, `amount`, `status`)
* **Output Properties** – the attributes of the output model (e.g. `approvalStatus`, `interestRate`)

Once this information is provided, the assistant begins building the rule. When the rule is ready, you will see a message confirming it is complete. Click the confirmation button to finalize the creation – then you will be redirected directly to the new rule for review or editing.

## Prompt Examples

{% hint style="info" %}
AI Assistant is limited to generating decision tables with a maximum of **10 rows**. If your described case results in more scenarios, consider simplifying the logic.
{% endhint %}

1. Simple Loan Application Evaluation:

> _I want to evaluate a loan application based on the applicant's age and credit score._\
> _If the age is under 21, the application should be declined._\
> _If the credit score is below 600, also decline._\
> _Otherwise, approve._\
> _Input model properties: `age`, `creditScore`_\
> _Output model properties: `approvalStatus`_

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
> _Output model properties: `riskLevel`_

If the AI Assistant cannot generate the Decision Table based on your prompt, try to simplify it or re-formulate it. You may also try to change the mode (from Fast to Precise or vice versa).
