---
description: >-
  Versioning allows you to manage multiple iterations of your rules, enabling
  safe testing and easy rollback capabilities.
---

# Versioning

## How Versioning Works

### Version Numbering

Version numbers are assigned automatically and increase sequentially (1, 2, 3, ...).\
Version numbers continue from the highest existing number, even if intermediate versions are deleted.

> Example: If you have versions 21, 22 and 24 (with 23 deleted), creating a new version from 22 will create version 25

### Version Limits

There is no limit to the number of versions you can create per rule.

## Manage rule versions

### Creating new version

You can create a new version of any rule type from folder view or inside rule.

When you have a rule open:

* Click the three-dot menu button in the top-right corner of the interface
* Select **New Version** from the dropdown menu

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-04 at 14.45.08.png" alt=""><figcaption><p>creating a new version of Decision Flow while in it</p></figcaption></figure>

When browsing your rules in a folder:

* Locate the rule you want to version
* Right-click on the rule to open the context menu (or use three-dot button on the far right)
* Select **New Version**

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-04 at 15.15.37.png" alt=""><figcaption><p>creating a new rule version from the folder view using the context menu</p></figcaption></figure>

A new version of the rule will create with the same **Rule Id** and **Rule alias** as the selected rule and sets the **version to 1 greater than the latest version.** The new rule has the **same structure** as the selected rule.

{% hint style="info" %}
All newly created versions start in **Pending** status. More about status options [here](https://docs.decisionrules.io/doc/rules/common-rule-features/rule-settings/rule-state)
{% endhint %}

### When to Create a New Version

Create a new version when making significant changes to your rule. New versions allow you to safely test changes while keeping the current production version intact.\
While each rule has change history, versioning provides cleaner rollback points for major updates.

### Version Comparison

You can compare different versions side-by-side to see what changed. \
See [Rule Comparison](https://docs.decisionrules.io/doc/rules/common-rule-features/rule-comparison) for details.

***

More info about using specific versions in:\
[REST API](https://docs.decisionrules.io/doc/api/api-introduction)\
[Decision Flow](https://docs.decisionrules.io/doc/rules/flow/flow-nodes-overview#business-rule)
