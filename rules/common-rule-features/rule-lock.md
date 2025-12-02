---
description: >-
  This feature further extends the control over the rules. In this article we
  will briefly explain how it works.
---

# Rule Lock

## Introduction

When you have a rule which you want to be visible to your colleagues and you also want it to be solvable, but you do not want anyone to change its logic, that’s where the Rule Lock enters the scene.

## Who can lock and unlock rules?

Considering the [3 basic roles](../../space/access.md#roles-and-permissions) in DecisionRules:

**Have** “Lock rule” permission:

* Admin
* Editor

**Do not have** “Lock rule permission”:

* Reader

You can of course create your own role and set its permissions however you want to fit your use cases. [Here](../../space/access.md#roles-and-permissions) is the part of our documentation dedicated to the topic.

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.11.54 (1).png" alt=""><figcaption></figcaption></figure>

## How to lock a rule?

You can lock a rule in three different places:

#### Folders

Just right click on the desired rule and lock / unlock the rule

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.15.19.png" alt=""><figcaption></figcaption></figure>

#### Rule settings

Go to the detail of the rule and lock / unlock the rule

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.19.39.png" alt=""><figcaption></figcaption></figure>

#### List of all rules

Go to the list of all rule and lock / unlock the rule

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.18.15 (1).png" alt=""><figcaption></figcaption></figure>

## How to tell if the rule is locked?

You can tell the rule is locked for the first sight by the presence of the lock symbol. You can see it in three different places:

#### Folders

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.24.25.png" alt=""><figcaption></figcaption></figure>

#### Rule detail

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.27.20 (1).png" alt=""><figcaption></figcaption></figure>

#### List of all rules

<figure><img src="../../.gitbook/assets/Screenshot 2023-12-14 at 12.28.23 (1).png" alt=""><figcaption></figcaption></figure>

## What can not the user do with the locked rule?

When you lock the rule it basically becomes read only. That means that no one can change its logic. That includes:

* Changing Tags
* Changing Rule Variables
* Changing I/O JSON Model
* Turning on/off Audit Logs
* Adding Notes
* Publishing / Unpublishing the rule
* Changing rule-alias
* Changing name
* Doing any changes in the rule’s designer
* Changing rule’s position in folders&#x20;
* Deleting the rule
* Creating new version
* Importing a version

{% hint style="info" %}
If you are familiar with [roles](../../space/access.md#roles-and-permissions), by locking the rule you change permissions for this rule to the same permissions the Reader role does have for all rules.
{% endhint %}

## What can the user do with the locked rule?

When the rule is locked everyone can still:

* Find the rule in the space&#x20;
* Solve it
* Compare it to other rule
* Export it

{% hint style="warning" %}
You can import a new version of the rule BUT you can not overwrite the original one.
{% endhint %}

## Does locking the rule affect something else then the rule itself?

Yes it does. You can not delete a folder with at least one locked rule in it. Also, you will not be able to change the rule alias or name of a rule if there is another version of that rule which is locked (this is because the rule alias and name always have to be the same for all versions).<br>
