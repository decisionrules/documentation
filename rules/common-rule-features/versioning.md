# Versioning

## Manage rule versions

### Creating new version

A new version of the rule can be created either by clicking on the **New Version** button in the Folder manager, the Bussiness Rules tab or in a rule's settings.

<figure><img src="../../.gitbook/assets/image (31) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (67) (1).png" alt=""><figcaption></figcaption></figure>

The button creates a new version of the decision table with the same **Rule Id** and **Rule alias** as the selected rule and sets the **version to 1 greater than the latest version.** The new decision table has the **same structure** as the selected rule.

{% hint style="info" %}
Creating a new version doesn't change the rule's id or **alias**. To call the certain version of the rule we use **/:ruleId/:version**
{% endhint %}

### Rule versions

When you are in the list of rules, you can see all rules you have in your space. If your rule has more than one version, the **latest** one is shown. For example, the **Branching tree** has 3 versions. That's why version 3 is shown.

<figure><img src="../../.gitbook/assets/image (149).png" alt=""><figcaption></figcaption></figure>

If you want to see all the versions click on ![](<../../.gitbook/assets/more rules.PNG>)the versions of the rules that will show up.

<figure><img src="../../.gitbook/assets/image (76).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Rule versions **behave as if they were separate rules** except for their equivalence in ruleId, alias and name.&#x20;

So if you wish to create a new version of a rule, simply [GET the rule](../../api/management-api.md#get-rule) and **manually change the rule version** to the desired number. Then [POST the rule](../../api/management-api.md#create-rule) to create it.

To manually change the rule version, find the attribute titled `"version"`in the response bodyand change it's value.
{% endhint %}
