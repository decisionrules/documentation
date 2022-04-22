---
description: >-
  This page describes the process of importing and exporting rule flows. You can
  now export/import the whole rule flow with all the rules that are used within
  the rule flow.
---

# Import & Export

### Export

You can export the rule flow inside the rule flow setting or in the list of rule flows.

![Click on the export button to export the rule flow.](../.gitbook/assets/export-rf.png)

![Click on the export button from the dropdown menu to export the rule flow.](../.gitbook/assets/export-rf2.png)

### Import

You can export the rule flow inside the rule flow setting or in the import interface.

![Follow the instructions given in our app.](../.gitbook/assets/import-rf.png)

![Click on import version to import rule flow.](../.gitbook/assets/export-rf.png)

{% hint style="success" %}
Go to [import-decision-table.md](../decision-tables/import-and-export-rule/import-decision-table.md "mention") to learn more about the basics of importing.

The process of importing decision table is very similar to the process of importing a rule flow.
{% endhint %}

#### How does importing a rule flow affect other rules that are already in space? <a href="#warning" id="warning"></a>

1. If you have never imported a rule with the rule ID that you just imported into your space, it will create it as a completely new rule.
2. If there are any rules that have the same rule ID and also the version as the rule that you just imported through the rule flow, then it will OVERWRITE the all of the rule contents except for the rule ID.
3. If there are any rules with the same rule ID but none of them has the same version as the rule that you just imported through the rule flow, then it will create a rule with the rule ID that it currently has inside the space and it will import it as the version that it has.





