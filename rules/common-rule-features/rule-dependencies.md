---
description: Discover how rules are connected
---

# Rule Dependencies

Rule dependencies show the hierarchical and interconnected relationships between rules depending on each other. Rule dependencies are crucial for understanding the logical flow of rules and ensuring that they are applied correctly.

## Dependencies tree overview

The **rule dependency view** displays a hierarchical tree structure showing how rules are linked to one another. The rule you're currently viewing is at the top of the tree, and each rule listed beneath it represents a **direct dependency**—meaning the current rule relies on the output or execution of the rule immediately below it. This relationship continues down the structure, forming a chain of dependent rules. Understanding this hierarchy helps you trace how logic flows across multiple rules and ensures that all required inputs or results are properly defined before a rule is executed.

<figure><img src="../../.gitbook/assets/Screenshot from 2023-08-02 12-45-24.png" alt=""><figcaption><p>Dependency tree in rule settings</p></figcaption></figure>

Each dependency in the structure is a clickable link to get to the rule details and solve errors.

### Possible errors

* **Rule not found -** rule with the identifier (id, alias) was not found&#x20;
* **Duplicity id / alias -** more rules with the same identifier (id, alias)&#x20;
* **Circular dependency -**  rules depend on each other in a loop
* **Rule not published -** rule is not published and cant be solved

{% hint style="warning" %}
Rule dependencies won't be found when rules point to each other dynamically (e.g., using for loop).
{% endhint %}

Overall, a rule dependency tree acts as a preventive measure by providing an organized, visual representation of rule dependencies. This aids in maintaining the integrity of the rule-based system, reduces the likelihood of errors, and supports efficient development and troubleshooting processes.
