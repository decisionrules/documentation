---
description: This tutorial will walk you through the creation of a simple Decision Tree.
---

# Create Simple Decision Tree

## How to create a simple decision tree

Let's advance one step at a time.

### 1. Log in

Becoming a superhero is a fairly straightforward process. After entering our [login page](https://app.decisionrules.io/auth/login), you will be able to pass your credentials and log in.

<figure><img src="../.gitbook/assets/image (12).png" alt=""><figcaption></figcaption></figure>

There are multiple options for user login. If you do not have an account yet, you can [create one](https://app.decisionrules.io/auth/register?type=true-registration). After logging in to the application, the[ Dashboard](../) will be displayed.

<figure><img src="../.gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

### 2. Go to Create rule

To display the rule creation pop-up click the  <img src="../.gitbook/assets/image (14) (1).png" alt="" data-size="original"> button on the sidebar.

<figure><img src="../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>

### 3. Create a New Decision Tree

You will be prompted to provide a name and choose between **SAMPLE RULE** or **EMPTY RULE.** For now, name the rule as you wish and choose the EMPTY RULE. The new rule will be created and its detail will be displayed. We will continue in the Rule Settings tab.

{% hint style="success" %}
In our case, we will choose an empty tree to walk you through the whole process.
{% endhint %}

### 4. Create First If Block

Click on create business condition.

![](<../.gitbook/assets/image (204).png>)

### 5. Specify Condition Inside If Block

1\. Click on the first add button inside the if block.&#x20;

![](<../.gitbook/assets/image (199).png>)

2\. Dropdown will be shown.

![](<../.gitbook/assets/image (154) (2).png>)

3\. Click on condition.

![](<../.gitbook/assets/image (206).png>)

4\. Click on the orange dropdown. Here you will choose an input attribute that will later be evaluated when solving the decision tree.

![](<../.gitbook/assets/image (166).png>)

5\. For simplicity sake, the only input attribute is the "Input attribute" created automatically, when choosing the empty decision tree. Click on the "Input attribute".

{% hint style="success" %}
To learn more about the Input/Output Model, click [here](../decision-tables/input-and-output/)
{% endhint %}

![](<../.gitbook/assets/image (177).png>)

6\. Now click on the empty... text to edit the value.

![](<../.gitbook/assets/image (175) (2).png>)

7\. Now type in a value to which we will compare the input once solving the decision tree. Let's write "learning" for example. To save the value either click on the save button or press enter.

![](<../.gitbook/assets/image (179).png>)

8\. Now click on the second add button inside the if block.

![](<../.gitbook/assets/image (173).png>)

9\. Click on then.

![](<../.gitbook/assets/image (181).png>)

10\. Click on add result.

![](<../.gitbook/assets/image (170).png>)

11\. Once again, click on the orange button saying "not set" and choose the only Output attribute which was automatically created and is called "Output attribute".

![](<../.gitbook/assets/image (184).png>)

12\. Click on the empty... text and fill in the result value as with the if condition.

![](<../.gitbook/assets/image (160).png>)

Great, you now know how to create a simple condition :tada:.

### 6. Create Second If Block

To simplify the process, you can click on the settings icon of the first If block and select clone.

![](<../.gitbook/assets/image (168) (1).png>)

This will create an exact copy of the If block down below.

The only thing to do now is to change the values inside the newly created If block.

![](<../.gitbook/assets/image (186).png>)

{% hint style="success" %}
These two If blocks are very similar to the If and Else If behavior, if you are familiar with programming concepts.
{% endhint %}

### 7. Create Else Block

Finally we create an Else block. The Else block will be executed whenever none of the above If blocks evaluate to true. In our case, if the Input Attribute is anything else than the value "learning" and "procrastinating".



Now click on the ![](<../.gitbook/assets/image (165).png>) button under the Else If block and add another Else block.

![](<../.gitbook/assets/image (205).png>)

Now inside the last Else block simply add Then block and fill it out with whatever value you like.

![](<../.gitbook/assets/image (193) (1).png>)

### 8. Test It!

Simply click on the test bench in the bottom bar ![](<../.gitbook/assets/image (158).png>).

Type "learning" in the Input Property and click on ![](<../.gitbook/assets/image (187) (2).png>).

![](<../.gitbook/assets/image (174).png>)

{% hint style="success" %}
You can see that the first block was evaluated.
{% endhint %}

Inputting the word "procrastinating" will return "mission failed".

![](<../.gitbook/assets/image (209).png>)

Finally inputting anything else than these two word will return "unexpected output".

![](<../.gitbook/assets/image (161).png>)

{% hint style="info" %}
More information can be found [here](../decision-trees/decision-tree-designer.md).
{% endhint %}

