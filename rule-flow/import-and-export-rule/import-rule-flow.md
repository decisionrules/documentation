# Import Rule Flow

### Importing a Rule Flow

Importing Rule Flows is a bit more complicated than with other Rule types. This is due to Rule Flows import files containing all rules within said Rule Flow.

## Importing a Rule

First, make sure you're logged in and navigate to the **Bussiness Rules** category on the sidebar. &#x20;

Importing a rule can have one of two meanings:

* [Importing a new Rule](import-rule-flow.md#1.-importing-a-new-rule)
* [Importing a new version of an existing Rule](import-rule-flow.md#2.-importing-a-new-version-of-an-existing-rule)&#x20;

### 1. Importing a new Rule

To import a new Rule navigate to the **Bussiness Rules** category through the sidebar or select a folder you want the rule imported into in the **Folders** manager.

Click the **Import Rule** button on the top right. Shown in the image below.

<figure><img src="../../.gitbook/assets/image (35).png" alt=""><figcaption></figcaption></figure>

You will be prompted to drop or choose a file on your system containig the rule.

<figure><img src="../../.gitbook/assets/image (121).png" alt=""><figcaption></figcaption></figure>

Drag and drop your rule file into the dashed area or click within it to open a File Explorer. For Decision Trees, the rule file can only have the format of JSON.

<figure><img src="../../.gitbook/assets/image (84).png" alt=""><figcaption></figcaption></figure>

Once your rule file has been selected, click the **Import** button.



### 2. Importing a new version of an existing Rule

To import a new version of an existing Rule

<figure><img src="../../.gitbook/assets/image (251).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (68).png" alt=""><figcaption></figcaption></figure>

You will be prompted with the following window.

<figure><img src="../../.gitbook/assets/image (120).png" alt=""><figcaption></figcaption></figure>

First, select whether you would like:

* To import the rule as a new version of the existing rule.

or

* To **overwrite** the latest version of the existing rule.

{% hint style="danger" %}
Overwriting the latest version **cannot be undone**. The overwritten version will be permanently lost.
{% endhint %}

After selecting the method of import, drag and drop your rule file into the dashed area or click within it to open a File Explorer. For Scripting Rules, the rule file can only have the format of JSON.

<figure><img src="../../.gitbook/assets/image (32).png" alt=""><figcaption></figcaption></figure>

Once your rule file has been selected, click the **Import** button.

{% hint style="danger" %}
Importing a new version of a Rule Flow overwrites existing rules, which are part of the imported Rule Flow.&#x20;

e.g. Importing a Rule Flow which contains a Decision Table will overwrite the Decision Table in your Folders (If the RuleId and Version match).
{% endhint %}

### How does importing a rule flow affect other rules that are already in space specifically? <a href="#warning" id="warning"></a>

1. If you have never imported a rule with the rule ID (through the rule flow import) that you just imported into your space, it will create it as a completely new rule.
2. If there are any rules that have the same rule ID and also the version as the rule that you just imported through the rule flow, then it will OVERWRITE all of the rule contents except for the rule ID.
3. If there are any rules with the same rule ID but none of them has the same version as the rule that you just imported through the rule flow, then it will create a rule with the rule ID that it currently has inside the space and it will import it as the version that it has.
