# Create Simple Decison Table

## 1. Sign in

Becoming a superhero is a fairly straight forward process:

After entering the app.decisionrules.io page, the login screen will be displayed.

![](../.gitbook/assets/image%20%2863%29.png)

There are two options for user login. Sign in with: 

* email and password
* Google Account \(**SSO**\)

 After logging in to the application, the[ Dashboard](../dashboard.md) will be displayed.

Once you're strong enough, save the world!

![](../.gitbook/assets/application-page%20%281%29.png)

Once you're strong enough, save the world!

## 2. Go to Decision Table

To go to the Decision Table page on the left in the sidebar, click on the **Decision Table** link. After clicking on the link, a page with all already created decision tables will be displayed.

![](../.gitbook/assets/image%20%2866%29.png)

## 3. Create a new Decision Table

To create a new rule, click the button ![](../.gitbook/assets/screenshoteasy-2-%20%281%29.png) . After clicking, you can choose between **SAMPLE RULE** or **EMPTY RULE** to create**.** Choosing either one the new rule will be created and its detail will be displayed automatically.

{% hint style="info" %}
More information is [here](../decision-tables/manage-decision-tables.md#create-a-new-decision-table).
{% endhint %}

![](../.gitbook/assets/image%20%28110%29.png)

## 4. Set decision table information

When we are at the detail of the decision table, we first set some information. We will change the name of our decision table. To do this, click on his name. Then a field will appear where we can rename the name and click on the ![](../.gitbook/assets/screenshoteasy-15-.png) icon. To cancel the changes, click on the ![](../.gitbook/assets/screenshoteasy-16-%20%281%29.png) icon.

Since we do not want this decision table to be available yet, we will change its status to **"Pending"**. To do this, click on the current status **"Published"** and then select **"Pending"**.

For applying these changes, we have to click on the![](../.gitbook/assets/save.png) button on the bottom of the page.

![](../.gitbook/assets/image%20%28112%29.png)

## 5. Create an Input and Output model

We will now create an input and output model, which we will then use to set conditions and results. You must be in **Rule Settings.** There are 2 ways to create these models: 

* Simple editor: It is intended for inexperienced users who do not know the syntax of JSON files.
* JSON editor: It is intended for an experienced user.

### Create with a simple editor

{% hint style="warning" %}
After creating an input or output model, we must always confirm the changes with the ![](../.gitbook/assets/save.png)button
{% endhint %}

#### **Input model**

First, we delete all created objects by clicking on the icon. Then we will add our specified requirements \(**age, criminal history, mileage per year**\). In our case, we create a root for each request by clicking on the button.

{% hint style="info" %}
If our model were more complex, we would add descendants. More information is described [here](../decision-tables/input-and-output/simple-editor.md). 
{% endhint %}

#### **Input model Example:**

![](../.gitbook/assets/screenshoteasy-13-%20%281%29.png)

#### **Output model**

We set the output model similarly, where we set as root **eligibility** and **measure**.

**Output model Example:**

![](../.gitbook/assets/screenshoteasy-14-%20%281%29.png)

### Create using JSON editor

#### **Input model** 

First**,** we will create one object into which we will put other objects with our requirements. We will create one empty object for each request.

{% hint style="info" %}
Because our model is simple, these objects do not contain any others. For more complex models, more information is [here](../decision-tables/input-and-output/json-editor.md).
{% endhint %}

#### **Input model Example:**

```javascript
{
  "Age": {},
  "Criminal history": {},
  "Mileage per year": {}
}
```

#### **Output model**

We set the output model similarly, where we set as root **eligibility** and **measure**.

**Output model Example:**

```javascript
{
  "Eligibility": {},
  "Level": {}
}
```

## 6. Creating Conditions and Results

To create conditions and result you must go to the second tab - **Table Designer**.

Now let's move on to binding models to conditions and results and create individual rules.

### Creating Conditions and Results

For simplicity, we will remove all conditions and results by clicking on the icon![](../.gitbook/assets/screenshoteasy-28-.png) next to them.  
Next, we add **5 conditions** by clicking on the![](../.gitbook/assets/screenshoteasy-23-.png) icon. Although we have only 3 variables in the **input model**, we will want to compare the values in some range for the **age** and **mileage**. Therefore we have to add these conditions \(Age min, Age max, Criminal history, Mileage per year min, Mileage per year max\) ****and **2** **results** by clicking on the![](../.gitbook/assets/screenshoteasy-25-.png) icon because similarly, we have 2 variables in the **output model.**

{% hint style="info" %}
More information about creating conditions and results is [here](../decision-tables/decision-table-designer.md).
{% endhint %}

After adding conditions and results, we will set their names. ****To do this, click on his name. Then a field will appear where we can rename the name and click on the![](../.gitbook/assets/screenshoteasy-15-.png) icon. To cancel the changes, click on the![](../.gitbook/assets/screenshoteasy-16-%20%281%29.png) icon.

### Binding models to conditions and results

Now let's move on to binding values from models. To bind the value, click on the![](../.gitbook/assets/screenshoteasy-24-.png) icon. Then we will see a list of all available values and select one of them. This is how we bind the value for all conditions and results.

{% hint style="info" %}
More information about binding models to conditions/results is [here](../decision-tables/binding-to-model.md).
{% endhint %}

####  After performing these tasks, the Decision Table designer should look like this:

![](../.gitbook/assets/screenshoteasy-17-%20%281%29.png)

## 7. Creating rules

For simplicity, we will remove all rows of the table or conditions.

{% hint style="info" %}
Each **row** of the table corresponds to exactly one **rule**. When [Rule Solver](../api/rest-api.md) is called, it goes through the individual lines and compares their condition values with those specified in the request. If some values of the conditions in a row match, [Rule Solver](../api/rest-api.md) returns the values of the individual **results** of that row.
{% endhint %}

Now let's add one rule \(one line\). We do this by clicking on the ![](../.gitbook/assets/row.png)button. In this rule, we set that if the user is between the ages of 25 and 40, will not have a criminal record, and will have an annual mileage of more than 20,000 km, the user will be eligible to drive a taxi and will have a high level.

We will now start setting individual conditions and results. For the **"Age min"** condition, set the operator to  **"Greater than or equal**" and the value to **25**. To set the operator, click on the existing operator and a list will appear from which you can select.

For other conditions, we set operators and values similarly. For the condition **"Age max"** we set the operator **"Less than or equal"** and the value to **40**. For the condition **"Criminal history"** we set the operator to **"Equals"** and the value to **false**. For the condition **"Mileage per year min"** we set the operator to **"Greater than and equal"** the value to **25000** and for the condition **"Mileage per year max"** we set the condition to **"Anything"** because it does not matter what the value will be.

Set the value to **true** for the result **"Eligibility"** and set the value to **high** for the result **"Level".**

{% hint style="info" %}
An overview of all operators is [here](../decision-tables/operators/).  
An overview of all possible values is [here](../decision-tables/data-types.md).
{% endhint %}

#### After performing these tasks, the Decision Table designer should look like this:

![](../.gitbook/assets/screenshoteasy-20-%20%281%29.png)

We can similarly add other conditions.

## 8. Test created decision table

Now we can test our rule in Test Bench. Before testing the rule, we must change the status of the decision table to **"Published"**.

If we want to test a certain rule \(line\), we can click on the ![](../.gitbook/assets/screenshoteasy-29-.png)icon next to the line. After clicking on the icon, the values from the line will be pre-filled in the **Request Body in Test Bench,** which will show up at the bottom of the page. We can freely modify these values.

Then we can either click on the![](../.gitbook/assets/run.png) button and the result will be displayed in **Response** or we can copy the pre-prepared command to our library from the Library Usage Example.

#### Request body example:

```javascript
{
  "Age": 28,
  "Criminal history": false,
  "Mileage per year": 30000
}
```

#### Response body example:

```javascript
[
  {
    "Eligibility": true,
    "Level": "high"
  }
]
```

{% hint style="info" %}
More information about Test Bench is [here](../test-bench/test-bench.md).
{% endhint %}

