# Create Simple Scripting Rule

## 1. Sign in

Becoming a superhero is a fairly straight forward process:

After entering the app.decisionrules.io page, the login screen will be displayed.

![](<../.gitbook/assets/image (63).png>)

There are two options for user login. Sign in with:&#x20;

* email and password
* Google Account (**SSO**)

&#x20;After logging in to the application, it will display the[ Dashboard](../).

Once you're strong enough, save the world!

![](<../.gitbook/assets/application-page (1).png>)

Once you're strong enough, save the world!

## 2. Go to Scripting Rules

To go to the Decision Table page on the left in the sidebar, click on the **Scripting Rules** link. After clicking on the link, a page with all already created scripting rules will be displayed.

![](<../.gitbook/assets/image (86).png>)

## 3. Create a new Scripting Rule

To create a new rule, click the button  ![](../.gitbook/assets/sr.png) . After clicking, a new scripting rule will be created, and its detail will be displayed automatically with the sample scripting rule.

![](<../.gitbook/assets/image (85).png>)

## 4. Set scripting rules information

When you click on RULE SETTINGS on the top left corner, the scripting rule's detail will appear first to set some information. We will change the name of our decision table. To do this, click on his name. Then a field will appear where we can rename the name and click on the ![](../.gitbook/assets/screenshoteasy-15-.png) icon. To cancel the changes, click on the ![](<../.gitbook/assets/screenshoteasy-16- (1).png>) icon.

Since we do not want this decision table to be available yet, we will change its status to **"Pending"**. To do this, click on the current status** "Published"** and then select** "Pending"**.

For applying these changes, we have to click on the ![](../.gitbook/assets/screenshoteasy-31-.png) button on the left.

![](<../.gitbook/assets/image (88).png>)

## 5. Create an Input and Output model

We will now create an input and output model, which we will then use to set conditions and results. We create this model with a **JSON editor**.

{% hint style="warning" %}
After creating an input or output model, we must always confirm the changes with the ![](../.gitbook/assets/screenshoteasy-31-.png) button.
{% endhint %}

#### **Input model**&#x20;

First, we delete all created objects. Then we will add our specified requirements (**value1, value2**) as empty objects.&#x20;

{% hint style="info" %}
Because our model is simple, these objects do not contain any others. For more complex models, more information is [here](../decision-tables/input-and-output/json-editor.md).
{% endhint %}

#### **Input model Example:**

```javascript
{
  "value1": {},
  "value2": {}
}
```

#### **Output model**

We set the output model similarly, where we set it as root **result **(empty object).

**Output model Example:**

```javascript
{
  "result": {}
}
```

## 6. Creating rules

Now let's move on to code editor by clicking on ![](../.gitbook/assets/code-button.png)  it in the right upper corner and create individual rules.

{% hint style="success" %}
Our code editor is based on **Monaco Editor,** using its features, like autocomplete, syntax highlight, line numbers, etc.

**Shortcut Keys **are also working, but you need to be with a cursor in the editor.

**CTRL/CMD + S** - save

**CTRL/CMD + R **- run

**CTRL/CMD + Z **- undo

**CTRL/CMD + SHIFT + Z** - redo

**CTRL/CMD + F** - find
{% endhint %}

{% hint style="warning" %}
Scripts must be written in **JavaSript **language.
{% endhint %}

For simplicity, we will remove the code from the code editor to create a new rule.

When to code editor is empty, we can start to create our own rule in **JavaScript. **It is straightforward, and you need to write your code which can look like below.

{% hint style="warning" %}
Input must always be entered as **input.**yourInputVariable.

Output must always be entered as **output.**yourOutputVariable.

To return an output, always enter **return output **at the end of your script!
{% endhint %}

{% hint style="danger" %}
**console.log()** is forbidden due to performance, but you can use **log() **instead.
{% endhint %}

{% hint style="success" %}
You can use** log() **to print values in the console, which is at the bottom of the code editor.
{% endhint %}

```javascript
/* 
    1.  Input variables
    Input body is set in input variable 
*/
let a = input.value1;
let b = input.value2;

/*
    2.  Define simple "multiply" function
*/
function multiply(a, b) {
    return a * b;
}

/*
    3.  Execute multiply function and store value result variable
*/
let resultMultiply = multiply(a, b);

/*
    4.  Set output model which is returned in REST API
*/
output.result = resultMultiply;

/*
    Optionally: It is possible print values to console
*/
log('Result multiply:', resultMultiply);

/*
    5.  Return output  
*/
return output;
```

{% hint style="info" %}
Always **save **your script using ![](<../.gitbook/assets/image (35).png>) (bottom of the page) or CTRL/CMD + S
{% endhint %}

## 7. Test created scripting rule

{% hint style="warning" %}
Don't forget to save your scripting rule!
{% endhint %}

Now we can test our rule. Before testing the rule, we must change the status of the rule to **"Published"**.

If we want to test a rule, we can click on the ![](<../.gitbook/assets/image (81).png>) icon at the bottom of the page. An input and output window will show up at the bottom of the page.

![](<../.gitbook/assets/image (125).png>)

{% hint style="success" %}
You can find more information about input and result at [Solver API](../api/rule-solver-api.md).
{% endhint %}

&#x20;We can either click on the run button between input and output windows or ![](<../.gitbook/assets/image (81).png>) the button on the top of the code editor. The result will be displayed in the **Output window (the right one)**.

{% hint style="info" %}
The debug mode can be turned on by clicking on ![](../.gitbook/assets/debug.png) . In scripting rules, it will enable to write** log()** in the console.
{% endhint %}

#### Request body example:

```javascript
{
  "value1": 2,
  "value2": 4
}
```

#### Response body example:

```javascript
{
  "result": 8
}
```

{% hint style="info" %}
More information about Test Bench is [here](../test-bench/test-bench.md).
{% endhint %}
