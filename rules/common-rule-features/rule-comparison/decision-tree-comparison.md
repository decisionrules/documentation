---
description: In this article, we will explain the decision tree comparison.
---

# Decision Tree Comparison

## Introduction

Comparing rules in general can be a very useful feature. Decision trees are among the rule types that support this feature.

{% hint style="info" %}
Decision tree comparison is most useful when used between two roughly similar rules. When used on two completely different rules, the result won't usually be very helpful.
{% endhint %}

### Common Use-Cases

* You want to review your changes before implementing a new rule version into production.
* Visualization of progress between versions of production rules.

## The Comparison View

Upon opening the comparison view, you should see a tree very similar to the tree you've originally opened the comparison on. The Reference tree will be superimposed onto the Original tree and discrepancies between the two will be shown by use of a color system, as described below.

{% hint style="info" %}
For decision trees, the diff view does not allow any editing. To make changes in either the Original or the Reference tree, you have to quit the diff view.
{% endhint %}

### The Color System

In comparison view, each tree is given a color. <mark style="background-color:green;">**Green**</mark> for the Original tree (the currently open one) and <mark style="background-color:blue;">**Blue**</mark> for the Reference tree (the tree we are comparing to). The color system actually identical to the color system used in decision table comparison.

* Tree nodes that are without additional coloring appear in both trees.
* If a tree node is colored in <mark style="background-color:green;">**Green**</mark>, this means that it appears **ONLY** in the Green (Original) tree
* If a tree node is colored in <mark style="background-color:blue;">**Blue**</mark>, this means that it appears **ONLY** in the Blue (Reference) tree
* Changes are displayed as two nodes, one <mark style="background-color:green;">**Green**</mark> and one <mark style="background-color:blue;">**Blue**</mark>, enclosed in a <mark style="background-color:yellow;">**Yellow**</mark> container. This means that the node was found in  **BOTH** trees, but it is not identical.

<figure><img src="../../../.gitbook/assets/image (282).png" alt=""><figcaption></figcaption></figure>

### Comparison Statistics

To quickly see how and how much the compared rules differ, you can click the chart icon in the top left to display a dropdown summarizing the amount of differences between the trees, enumerated by counting the identical and different tree nodes.
