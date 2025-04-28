# Tree Designer

Decision Tree Designer is the interface for building Decision Trees. In this section, we describe how you can easily create your Decision Tree, link it to the input and output data and deploy it.

<figure><img src="../../.gitbook/assets/tree_designer.png" alt=""><figcaption><p>Decision Tree Designer</p></figcaption></figure>

#### Applying changes

For any changes to be applied, there is a need to save them by clicking the <img src="../../.gitbook/assets/Save btn.png" alt="" data-size="original"> button.

## About the Decision Tree Designer

When you open the Decision Tree Designer with an empty tree (by creating a new Decision Tree in the Decision Trees section and choosing Blank Decision Tree), you will see the initial empty screen. Create first condition by clicking the respective button. A new **IF block** will be added.

<figure><img src="../../.gitbook/assets/tree_designer_empty.png" alt=""><figcaption><p>Create first Tree condition</p></figcaption></figure>

### The IF Block

Every IF block consists of 2 parts. The left-hand part holds the conditions that have to be met in order for the right-hand part to take action.

![IF block](../../.gitbook/assets/tree_add_condition.png)

You can add conditions by clicking the Add button in the left-hand part of the block. By default, all conditions have logical **AND** between them. That is, if you add two conditions, the right-hand part of the IF block will activate if and only if both of them are satisfied. However, you can add the OR block. The OR block contains so-called OR groups which have logical **OR** between them. They are visually separated by a line with the word 'or' in the middle (see below). The OR block is evaluated as true whenever at least one of its OR groups is evaluated as true.

#### Example

To understand the above concept faster, see the following example. We provide our IF block with several conditions. Let us explore the conditions upon which the right-hand part of the block (empty for now) will take action.

Suppose that we require <mark style="color:purple;background-color:purple;">**permission**</mark> to equal true AND one (or both) of the following conditions to be satisfied: (a) <mark style="color:purple;background-color:purple;">**credit**</mark> is greater than 10 OR (b) <mark style="color:purple;background-color:purple;">**subscription**</mark> has value A1 AND <mark style="color:purple;background-color:purple;">**subscription\_active**</mark> is true.

For those who prefer logical pseudo-language: `permission = true AND (credit >= 10 OR (subscription = A1 AND subscription_active = true))`

This collection of conditions can be represented in our IF Block simply as follows.

{% hint style="info" %}
Note that, in order to be able to work with input properties like <mark style="color:purple;background-color:purple;">**permission**</mark> or  <mark style="color:purple;background-color:purple;">**credit**</mark>, these have to be set up in the [Input/Output Model](../common-rule-features/input-and-output/) in Rule Settings.
{% endhint %}

![AND & OR Tree conditions](../../.gitbook/assets/tree_if_conditions.png)

#### Manage OR groups

The OR groups can be easily managed. One can add OR groups by clicking the settings icon of the OR block and selecting Add OR group. On the other hand, OR groups can be removed by clicking the trash can icon at the bottom left corner of the OR group that you want to remove.

{% hint style="info" %}
Note that the conditions inside an OR group implicitly have logical AND between them
{% endhint %}

#### The right-hand side of the IF block

The right-hand side of the if block is triggered whenever the condition in the left-hand side is satisfied. It can hold two kinds of blocks: another IF blocks or THEN blocks. The IF blocks simply further branch out your Decision Tree. More interesting are the THEN blocks, which will be activated every time the conditions of their parent IF block are satisfied.

### The THEN Block

The THEN block represents our results. When all the conditions leading to some THEN block are satisfied, the THEN block is triggered. The rule then returns the results specified within this THEN block.

#### Back to our example

Let us provide our simple example with some result. We click the Add button in the right-hand part of our IF block and select Then. This will add a THEN block. Inside we will set up the results that we want to output whenever the provided conditions are satisfied. In our case, we want to simply take a property called <mark style="color:green;background-color:green;">**order\_accepted**</mark> and set it to true.

{% hint style="info" %}
Again, to add the <mark style="color:green;background-color:green;">**order\_accepted**</mark> as a result, we have to set up this property in the [Input/Output Model](../common-rule-features/input-and-output/) in Rule Settings. Our final Input/Output model is depicted below.
{% endhint %}

![Decision Tree Input & Output model](../../.gitbook/assets/tree_io_model.png)

![Adding new result into the Tree](../../.gitbook/assets/tree_add_result.png)

&#x20;Congratulations, your first Decision Tree (well, decision trunk) is complete!

### The ELSE Block

If you click the Add button in the right-hand part of any IF block or in the root (the one not contained in any block), you may select to add an ELSE block. This block will be triggered whenever none of the conditions of its preceding IF blocks is satisfied.

#### Back to our example

We can use the ELSE block in our example from above. In fact, it is very handy. By adding the ELSE block after our IF block, we can treat the case that the condition of the IF is not met. Here, we just add a THEN block where we set the <mark style="color:green;background-color:green;">**order\_accepted**</mark> property to false, because the order should not be accepted in this case.

<figure><img src="../../.gitbook/assets/tree_add_else.png" alt="" width="364"><figcaption><p>Adding ELSE block</p></figcaption></figure>

![Simple Tree with all types of blocks](../../.gitbook/assets/tree_complete.png)

#### The ELSE Block Behavior

As we said before, the ELSE block will be only triggered when no conditions in its preceding IF blocks are satisfied. In other words, the ELSE block will look for all IF blocks directly above it and check if at least one of them was triggered. If it was, the ELSE block is automatically skipped. If not, the logical structure inside the ELSE block will take action.

{% hint style="info" %}
Currently, it is allowed to place the ELSE block anywhere, even if there are no IF blocks above them. When placed in this way, the ELSE block will be always triggered. However, such placement makes little to no sense, and is therefore not recommended.
{% endhint %}

### Branching

You can branch your Decision Tree to arbitrary extent. Branching is done by nesting IF blocks in the right-hand part of other IF or ELSE blocks. This creates the familiar tree structure. Moreover, blocks can be also placed next to each other.

#### Multiple blocks

When multiple IF, THEN or ELSE blocks are placed below each other, they are evaluated successively from top to bottom. Therefore, if we have several THEN blocks in the Decision Tree setting the same property, and all of them happen to take effect, the respective property is eventually overwritten by the THEN block which is placed at the **lowest** position in the Decision Tree.

### Setting conditions and results

The basic structure for every condition is **operator + value**.

#### Operators and functions

For condition IF and OR blocks both operators and function can be used to build the condition, in THEN  block function or simple value (=) are used.

{% hint style="info" %}
Possible operators are specified in [Operators](../data-types-and-functions/operators/) section
{% endhint %}

To change the operator in IF block, click the operator/function label, and a selection modal will open. Select the desired operator or function to apply it to the cell.

<figure><img src="../../.gitbook/assets/tree_condition_operator_change.png" alt="" width="487"><figcaption><p>Change condition operator</p></figcaption></figure>

To change the operator in the THEN block, click the function/simple value label and small dropdown will show up. Select preferred option.

<figure><img src="../../.gitbook/assets/tree_result_operator_change.png" alt="" width="501"><figcaption><p>Change result operator</p></figcaption></figure>

{% hint style="warning" %}
**Note:** For function operators, selecting a new function operator will not overwrite the existing one in the cell, as function operators can be nested. This ensures that your existing functions are preserved.
{% endhint %}

## Designer bottom bar

### Test Bench

Test Bench allows you to test your Decision Tree to ensure that the rule is evaluating correctly. More about using Test Bench you can find in [dedicated documentation section](../common-rule-features/test-bench.md).

### Rule History & Undo/Redo

Every change made in this designer is recorded in a local history. You can undo or redo changes by clicking the <img src="../../.gitbook/assets/screenshoteasy (20).png" alt="" data-size="line"> or <img src="../../.gitbook/assets/screenshoteasy (21).png" alt="" data-size="line"> buttons on the right side of the designer bottom bar.

To view the rule history, click the <img src="../../.gitbook/assets/image (12) (1).png" alt="" data-size="line"> button located on the bottom bar. This opens a side menu with all available versions, where a new version is created every time you save the rule.

<figure><img src="../../.gitbook/assets/tree_history.png" alt=""><figcaption><p>Decision Tree history</p></figcaption></figure>
