---
description: This tutorial will walk you through the creation of a Rule Flow.
---

# Create Simple Rule Flow

## How to create a simple decision tree

Let's advance one step at a time.

{% hint style="info" %}
In this tutorial, you need to have knowledge of [Decision Tables](create-simple-decison-table.md) or [Scripting Rules](code-editor.md).
{% endhint %}

### 1. Create Decision Tables

We have already learned how to create rules in previous tutorials, so let's skip it now and import these decision tables:

{% file src="../.gitbook/assets/Clients_v1 (1).json" %}
Clients
{% endfile %}

* **Clients -** a rule that determines the maximum loan according to the client's age and salary

{% file src="../.gitbook/assets/Loan_Type_v1 (1).json" %}

* **Loan Type -** a rule that determines the maximum loan tax according to how much and for what the client wants to borrow

{% file src="../.gitbook/assets/Bank_Solver_v1 (2).json" %}

* **Bank Solver -** a rule that calculates how much the client pays in total

{% hint style="warning" %}
How to import [Decision Tables](broken-reference)
{% endhint %}

### 2. Go to Create rule

To display the rule creation pop-up click the  <img src="../.gitbook/assets/image (14) (1).png" alt="" data-size="original"> button on the sidebar.

<figure><img src="../.gitbook/assets/image (16) (1).png" alt=""><figcaption></figcaption></figure>

### 3. Create a new Rule Flow

You will be prompted to provide a name and choose between **SAMPLE RULE** or **EMPTY RULE**. The new rule will be created and its detail will be displayed. We will continue in the Rule Settings tab.

{% hint style="info" %}
In our case, we recommend you select the empty rule.
{% endhint %}

### 4. Set Rule Flow settings

When you click on RULE SETTINGS on the top left corner, the scripting rule's detail will appear first to set some information. We will change the name of our script. To do this, click on it's name, enter one you like and press Enter.&#x20;

Since we do not want this rule to be available yet, we will change its status to **"Pending"**. To do this, click on the current status **"Published"** and then select **"Pending"**.

To apply these changes, we have to click on the![](../.gitbook/assets/save.PNG) button at the bottom of the page.

### 5. Create an Input and Output model

We will now create an input and output model, which will then be used to set conditions and results. You must be in **Rule Flow Settings.** There are 2 ways to create these models:

* **Simple editor:** It is intended for inexperienced users who do not know the syntax of JSON files.
* **JSON editor:** It is intended for an experienced user, with JSON knowledge.

#### Create with a simple editor

{% hint style="warning" %}
After creating an input or output model, we must always confirm the changes with the ![](../.gitbook/assets/save.PNG)button
{% endhint %}

#### **Input model**

First, we delete all created objects by clicking on the icon (in case you chose Sample Rule Flow). Then we will add our specified requirements (**age, salary, loan, loanType**). In our case, we create a root for each request by clicking on the button.

{% hint style="info" %}
If our model were more complex, we would add descendants. More information is described [here](../decision-tables/input-and-output/simple-editor.md).
{% endhint %}

#### **Input model Example:**

<figure><img src="../.gitbook/assets/image (178).png" alt=""><figcaption></figcaption></figure>

#### **Output model**

We set the output model similarly, where we set as root **loan**, **tax**, **totalPay** and **message**.

**Output model Example:**

<figure><img src="../.gitbook/assets/image (212).png" alt=""><figcaption></figcaption></figure>

#### Create using JSON editor

#### **Input model**

First, we will create one object into which we will put other objects with our requirements. We will create one empty object for each request.

{% hint style="info" %}
Our model is simple, these objects do not contain any others (embedded attributes). For more complex models, more information is [here](../decision-tables/input-and-output/json-editor.md).
{% endhint %}

#### **Input model Example:**

```javascript
{
  "age": {},
  "salary": {},
  "loanType": {},
  "loan": {}
}
```

#### **Output model**

We set the output model similarly, where we set as root **loan**, **tax**, **totalPay** and **message**.

**Output model Example:**

```javascript
{
  "loan": {},
  "tax": {},
  "totalPay": {},
  "message": {}
}
```

### 6. Creating Rule Flow schema

1. To create Rule Flow schema go to the Rule Flow Designer tab. At the start the canvas is empty. Add there input, output, and three empty rules with buttons in the top-right corner: ![](../.gitbook/assets/addInput.PNG),![](../.gitbook/assets/addOutput.PNG),![](<../.gitbook/assets/addRule (2).PNG>).
2. Click on the Empty rule to display the sidebar. By button![](../.gitbook/assets/selectRule.PNG)choose a rule, that will be in place of the empty rule.
3. Connect rules together and to input box and output box. In this case, the correct connect is as follows:

![](../.gitbook/assets/NonMappedTutorial.PNG)

{% hint style="warning" %}
The rule should look as in the picture above.
{% endhint %}

### 7. Map data

To know, which data has to go where we have to map the data.

{% hint style="warning" %}
If the rule has no inputs mapped. It borders in orange and displays a warning icon![](../.gitbook/assets/warningError2.png)
{% endhint %}

The example Rule Flow - **Clients** and **Loan type** works with user input data and subsequently, **Bank solver** works with input of user data and with outputs from previous rules makes the decision and sends final outputs to the output box.

#### 7.1 Data mapping Clients

Open data mapping by clicking on ![](../.gitbook/assets/dataMapping2.PNG) .

![](<../.gitbook/assets/mapping (2).PNG>)

**Global variable** means where the rule takes data from and **output** means what data. Because this rule is connected immediately after the input box, only **user input data** can enter it.

Correct mapping of **Clients** from example:

![](../.gitbook/assets/correctMappingClients.PNG)

#### 7.2 Data mapping Loan type

The loan type is also directly connected after the input box, so only **input user data** will also enter it.

Correct mapping of Loan type from example:

![](<../.gitbook/assets/correctMappingLoanType (1).PNG>)

#### 7.3 Data mapping Bank solver

The **bank solver** is the final rule, that takes data from both the **previous rules** and the **input box.**

Correct mapping of Bank solver from example:

![](../.gitbook/assets/correctMappingBankSolver.PNG)

#### 7.4 Data mapping Output box

The final output can be data from any rule, so it is necessary to map the Output as well. In this example we want the following data to be in the output:

* **Loan** - the amount the customer wants to borrow
* **Tax** - tax of the loan
* **TotalPay** - the amount the customer pays
* **Message** - that confirming the loan or explaining its refusal

Correct mapping for output:

![](../.gitbook/assets/correctMappingOutput.PNG)

### 8. Test of created Rule Flow

Now we can test our Rule Flow in Test Bench. Before testing the rule, we must change the status of the decision table to **"Published"** or have to **debug mode ON**. Debug mode allows you to test Rule Flow even when it is pending and at the same time writes data information to the debug mode console.

Now you can test your Rule Flow as you like, but for a positive result, it is necessary to have loanType set on **"household", "car"** or **"vacation"** because our bank does not lend to anything else.

{% hint style="info" %}
You can add new loanType variables in the Loan Type rule via [Preset values.](../decision-tables/table-operations/valid-values.md)
{% endhint %}

{% hint style="success" %}
You can find more information about input and result at [Solver API](../api/rule-solver-api.md).
{% endhint %}

#### Request body example:

```javascript
{
  "age": 30,
  "salary": 4000,
  "loanType": "household",
  "loan": 30000
}
```

#### Response body example:

```javascript
[
  {
    "loan": 30000,
    "tax": 1.15,
    "totalPay": 34500,
    "message": "eligible for the loan"
  }
]
```

{% hint style="info" %}
More information about Test Bench is [here](broken-reference).
{% endhint %}
