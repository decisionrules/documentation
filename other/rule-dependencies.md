---
description: Discover how rules are connected
---

# Rule Dependencies

Rule dependencies show the hierarchical and interconnected relationships between rules depending on each other. Rule dependencies are crucial for understanding the logical flow of rules and ensuring that they are applied correctly.

## Dependencies tree overview

A dependency tree, which can be found in the **rule settings** shows the hierarchical relationship between rules. The tree structure illustrates which rules depend on others to be executed successfully. It's a valuable tool for preventing errors and ensuring the proper connection of rules in a system.

<figure><img src="../.gitbook/assets/Screenshot from 2023-08-02 12-45-24.png" alt=""><figcaption><p>Dependency tree in rule settings</p></figcaption></figure>

Each dependency in the structure is a clickable link to get to the rule details and solve errors.

### Possible errors

* **Rule not found -** rule with the identifier (id, alias) was not found&#x20;
* **Duplicity id / alias -** more rules with the same identifier (id, alias)&#x20;
* **Circular dependency -**  rules depend on each other in a loop
* **Rule not published -** rule is not published and cant be solved

Overall, a rule dependency tree acts as a preventive measure by providing an organized, visual representation of rule dependencies. This aids in maintaining the integrity of the rule-based system, reduces the likelihood of errors, and supports efficient development and troubleshooting processes.
