# Create User Variables

User variables are used to simplify the editing of a large amount of data.

{% hint style="info" %}
In this tutorial on how to create user variables, you need to have knowledge of [Decision Tables](https://docs.decisionrules.io/doc/tutorials/create-simple-decison-table).
{% endhint %}

## **How to create User Variable**

Settings of User Variable could be found in the middle of the page of Rule Settings in DecisionTables.

{% hint style="danger" %}
User variables are bonded with the version of the Ruleset.
{% endhint %}

![](<../.gitbook/assets/image (155).png>)

When you want to create new variable, click to the button ![](<../.gitbook/assets/image (158).png>) , so the User Variable table will show up. Then write a name of the variable, specify its value and hit the button ![](<../.gitbook/assets/image (160) (1).png>) . In case the variable is not useful, you can delete  ![](<../.gitbook/assets/image (153).png>)it or rewrite its value ![](<../.gitbook/assets/image (151).png>).

![](<../.gitbook/assets/image (162) (1).png>)

#### Examples of User Variables

* Ticket\_price          350
* City                        Rome
* city\_tax                  5

{% hint style="info" %}
The created variables are locked for the changes. In order to change the value of the variable, click on the button ![](<../.gitbook/assets/image (152).png>).
{% endhint %}

## Value of the User Variables

The name of the variable has to be always unique, otherwise, the variable cannot be saved. The format of the value could be TRUE/ FALSE, text or number. It is not possible to use the objects, for example, the empty set.

{% hint style="warning" %}
Each time save your changes – otherwise, the changed value of the user variable will not be updated in Decision Table Designer.
{% endhint %}

{% hint style="info" %}
The name of the variable has to be one word. If not, do not use spaces between word, or use – or \_ (examples of format: Ticketprice / Ticket\_price / Ticket-price)
{% endhint %}

## How to use User Variable

There are many ways how the User variables could be used in the Decision Table Designer. The variables could be used in the input, the same as in the output.

* A single value in the condition
* User Variable in the functions
* User Variable in the text

### Single value in Conditions

Go to the Decision Table Designer and start to create your conditions. When you want to use your predefined User Variable, first choose the type of operator, and then click on the button ![](<../.gitbook/assets/image (156).png>).

![](../.gitbook/assets/arff.png)

After clicking on the button, the window with predefined User variables will show up. Select there the variable you want to you and save.

### User variable in the functions

User Variables can be applied while using the function during counting as you can see in the column Final Price.

{% hint style="info" %}
Need help during applying the variables inside the function? Press **CTRL+ Space** and the app will show you all the variables which are already specified in the Rule Settings
{% endhint %}

![](<../.gitbook/assets/image (148).png>)

### User Variables in the text

Another possible manipulation with User variables is to display the name od User variable in the text/ message.

![](<../.gitbook/assets/image (163).png>)

## Test of created rules

In the last step, a test created rules in Test Bench. Before testing the rule, we must change the status of the decision table to **"Published"** or have to **debug mode ON**. Debug mode allows you to test rules even when it is pending and at the same time writes data information to the debug mode console.

{% hint style="warning" %}
After creating an input or output model, we must always confirm the changes with the ![](../.gitbook/assets/save.png)button.
{% endhint %}

#### Input model Example

![](<../.gitbook/assets/image (159) (1).png>)

#### Output model Example

![](<../.gitbook/assets/image (161) (1).png>)

#### Request body example

```
{
  "Price": 1550
}
```

#### Response body example

```
[
  {
    "Final Price": 1322.5,
    "Discount": 0.85,
    "tax": 5,
    "message": "The price for the way to Rome is 1322.5."
  }
]
```
