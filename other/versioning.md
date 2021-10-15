---
description: '*Applies to all Rule types - Decision Rules, Scripting Rules and Rule Flows.'
---

# Versioning

## Creating new version

A new version of the rule can be created either by clicking on ![](../.gitbook/assets/newversion.png)button in the Rule Settings.

The button creates a new version of the decision table with the same **Rule Id **as the selected rule and sets the** version to 1 greater than the maximal version.** The new decision table has the **same structure** as the selected rule.

{% hint style="warning" %}
By creating a new version of a rule the Rule ID remains the same, only the version is changing. To call the certain version of the rule we use **/:ruleId/:version**
{% endhint %}

## Rule versions

When you are in the list of rules, you can see all rules you have in your space. If your rule has more than one version, the **latest **one is shown. For example, the **Sample rule** has 4 versions. That's why version 4 is shown. 

![](<../.gitbook/assets/image (96).png>)

If you want to see all the versions click on ![](../.gitbook/assets/more-rules.png)the versions of the rules that will show up.

![](<../.gitbook/assets/image (98).png>)
