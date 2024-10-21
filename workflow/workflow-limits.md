---
description: >-
  Here we briefly describe the limits connected to workflow and how you can
  manage them.
---

# Workflow Limits

On our public cloud, workflow is subjected to a couple of plan-related limits. These limits are described below. In particular, you will learn how to enable workflow for your account and how the number of workflow nodes will be limited.

{% hint style="info" %}
This page applies primarily to public cloud. To find out about workflow limits in on-premise deployments, please contact our Sales team.
{% endhint %}

## Workflow Enabler

The most important limit related to workflow is the so-called workflow enabler. This limit determines whether you can use workflow at all. The easiest way to find out abut this is to go to Plans (clicking the account icon in the top right corner and choosing Current plan) -> Account Limits and find the Workflow item at the bottom of the table.

<figure><img src="../.gitbook/assets/image (4) (1) (4).png" alt=""><figcaption><p>This is how it looks when workflow is enabled</p></figcaption></figure>

Workflow is enabled in one of three ways. First, it is enabled in the free trial period. Therefore, if you have registered recently, you will have workflow enabled out of the box. Second, workflow is included by default in some of the plans. In particular, if you have Business plan or higher, you will have workflow enabled free of any additional charge.

For all other cases, there is the third option: the Workflow Addon. You can find it by going to Plans -> Addons. Upon switching on the Workflow Addon, you will have workflow enabled.

{% hint style="info" %}
The Workflow Addon has 2 months free trial. You can therefore try out workflow completely free of charge.
{% endhint %}

## Nodes Limit

The number of workflow nodes is limited in 2 ways.

First, there is a limit on the number of nodes in a single workflow. It is currently set to 150 nodes. This is a merely technical limit, ensuring that the workflow does not exceed the size supported by the platform.

The second way is putting an upper bound on workflow nodes as well. Notably, it works a little differently for new plans and old plans. For the new plans, the number of workflow nodes is limited by the shared Rule/Node limit. This limit can be found in Plans -> Account Limits. It works as follows. Consider all rules (including rule flows) and all workflows in all spaces owned by the account (including organization spaces). For each of the workflows, count all nodes except Business Rules, Start, End and Note. Then add up all the rules (including rule flows) and found workflow nodes. Compare this number to the Rule/Node limit. If the number is smaller then the limit, then you can create more nodes (otherwise not).

For older plans, the mechanism is similar but the role of the Rule/Node limit is here taken by the Rules and Rule Flows limits, in particular their sum. Also, the counting of rules, rule flows and workflow nodes is not done over the whole account, bot over individual spaces.

{% hint style="info" %}
If you need more information on the particular workflow node limit on your account, feel free to contact our support portal.
{% endhint %}

