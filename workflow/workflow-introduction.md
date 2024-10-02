---
description: >-
  This page introduces the DecisionRules Workflow feature and gives a high-level
  overview of its features and possible applications.
---

# Workflow Introduction

Workflow is a brand new feature brought in version 1.19.0 of DecisionRules. It allows to design complex decisioning processes. It can be used to orchestrate other rules, make data transforms and calculations, run inline scripts, perform conditional branching, call external API, and more. The list is not final. Workflow will be given even more capabilities in the future, like DB connectors, integrations to 3rd party tools, etc.

## Workflow Basics

Looking at its versatility and potential, workflow can be considered a whole new feature category within the DecisionRules universe. After all, with workflow in its repertoire, DecisionRules are gaining some of the major capabilities of a workflow engine. On the other hand, from the user's perspective, workflow fits perfectly into the same picture as other rules. It is listed as an item in the folder structure, it has the same settings, and it has a designer tab for editing the workflow.

Like its predecessor, the [rule flow](broken-reference), workflow is built by placing boxes on canvas and connecting them with lines. The boxes are called nodes (as in a graph), and the lines are called connections. Unlike in rule flow, there are numerous types of nodes, and the connections also have slightly different meaning, which will be explained later.

Let us create the first workflow. Click the Create button in the main menu and switch to the Workflow tab. Here you can choose to create a blank workflow (if you do not seem to have access to it, please see the [Workflow Limits](workflow-limits.md) page).

<figure><img src="../.gitbook/assets/image (3) (1).png" alt=""><figcaption><p>The create dialog</p></figcaption></figure>

Upon creating the workflow, you will be taken to the blank workflow detail. Note the Settings and the Designer tab. You can review the settings, which should not surprise any DecisionRules user. As mentioned above, the settings are (almost) the same as for regular business rules. In particular, pay attention to the input/output models. As usual, these models define the format of the input and output data of the workflow at question. We can leave all the defaults here and turn our attention to the Designer tab.

The blank designer features the canvas with a single node: the Start. The designer window features the usual bottom bar, where we can open the test bench. Next, on the right hand side, there are several additional tabs. For now, we will focus to the most important one: the palette.

<figure><img src="../.gitbook/assets/image (2) (1).png" alt=""><figcaption><p>The workflow designer</p></figcaption></figure>

The palette has a simple purpose. It lists all the available node types with brief description. If you want to use any of the nodes in your workflow, just drag it from the palette and drop it on the canvas.

Once present on the canvas, the node can be clicked in order to open its detail. Each node type has different configuration options, depending on its functionality. If you want to read more about individual node types and their configuration options, check out the [Workflow Nodes Overview](workflow-nodes-overview.md).

## First Workflow

Let us consider a simple example. Among other things, workflows can do everything that rule flows can do, that is, call other rules. We can thus build a simple workflow which calls a decision table and sends its results to the output. This should be easy enough.

First we need a decision table to start with. Create a blank new table, call it Segment and go to its settings. We shall adjust the input/output models. Let us assume that this decision table will get client segment on the input and will return the segment name. The input model will thus have a single `segmentCode` attribute, while the output will have the `segmentName`.

<figure><img src="../.gitbook/assets/image (5) (1).png" alt=""><figcaption><p>The Segment decision table I/O model</p></figcaption></figure>

As for the table itself, let us keep things simple and just add a couple of rows. Based on the matched segment code, we will return the corresponding segment name. The table can look e.g. as follows.

<figure><img src="../.gitbook/assets/image (6) (1).png" alt=""><figcaption><p>The Segment decision table</p></figcaption></figure>

Try to solve the table from the Test Bench to be sure it works as expected.

We can now return to our workflow. Assuming that we just want to call the Segment decision table and return its results, the input/output model of the workflow can be exactly the same as that of the table. Open the workflow settings and edit the models to have `segmentCode` in the input and `segmentName` in the output.

We are ready to return to the workflow designer. Upon opening the Designer tab of our blank workflow, we see just empty canvas with the Start node. Open the palette on the right hand side menu, find the Business Rule node and drag it to the canvas.

<figure><img src="../.gitbook/assets/image (7) (1).png" alt=""><figcaption><p>Workflow designer with the Business Rule node</p></figcaption></figure>

The purpose of Business Rule is, well, to call a business rule. To make sure this actually happens, we have to connect the Start with the Business Rule. Notice the small circles on the side of the nodes: these are connectors. Dragging a line from one connector to another, create a so-called connection. Next thing, notice the little `rule` label at the bottom left corner of the Business Rule. This is the _node alias_. It is a unique name used for referencing this node elsewhere in the workflow. To satisfy the best practices, edit the node alias to be more descriptive, rewriting it e.g. to `segments`. We will later use this keyword to map results of the table to output.

We have created the Business Rule node, now we have some configurations to do. Click the inside of the Business Rule box, opening its detail window.

<figure><img src="../.gitbook/assets/image (9) (1).png" alt=""><figcaption></figcaption></figure>

The detail of Business Rule has two main parts. In the first part one chooses the business rule to call. Open the dropdown and find the Segment decision table prepared beforehand. We can leave the default Standard strategy and skip to the second part. Here we have to define the rule input mapping, telling which data will be sent to the input of the decision table.

At this point, it is suitable to pay some attention to the Data Dictionary section on the left hand side of the window. Upon expanding the items, we shall see the predefined input and output attributes. Since we want to send the inputted `segmentCode` to the input of the decision table, we just drag and drop the `input.segmentCode` from the Data Dictionary next to the `segmentCode` item in the rule input mapping. Click the Save button and we are done! We have just configured our first Business Rule workflow node.



Our workflow will now be able to call the Segments table and get its results. However, we have not yet specified what to do with them. To actually get something useful in the workflow output, we have to assign the result of the Business Rule node to the output of the workflow. For this we can use the Assign node. Drag it to the canvas from the palette and connect it after the Business Rule. Then click in the middle of the node in order to review its configuration.

<figure><img src="../.gitbook/assets/image (12) (1).png" alt=""><figcaption><p>The desired Assig configuration</p></figcaption></figure>

The node detail window is already familiar to us. We just need to add a single assignment. See that the Assign configuration contains target and source. Under target, we will put `output.segment`, and in source we enter the result from our Business Rule. It can be found in the Data Dictionary by its node alias segments, and we are interested in its output, therefore using `segments.output`. Both these variables can be simply dragged and dropped from the Data Dictionary. Our Assign is complete.



Finally let us test the resulting workflow. Open Test Bench, enter a `segmentCode` matching some segment code from the Segments decision table and click Run. If the configuration was done correctly, you should get the corresponding segmentName on the output.

<figure><img src="../.gitbook/assets/image (14) (1).png" alt=""><figcaption><p>Testing our workflow</p></figcaption></figure>

Note that the `segment` attribute on the output actually contains an array `[]` with a single object `{}`, which in turn contains the `segmentName`. This rather complex data structure follows from how we set up our Assign. Under `segment`, we have mapped the whole output of the Segment table. Later we will see how the result can be simplified or transformed to any form you like.

This is it, you have your own first functioning workflow! Of course, there is much more to workflow: the inspect, the variables, the distinct nodes, loops, etc. Nevertheless, this example brought to light the most important principles, and showed the usual ways of work.

In the next section, we shall dive more deeply in how workflow is evaluated.

## Workflow Evaluation

Although workflow looks similarly to rule flow, it is fundamentally different. Workflow has the ability of running only some of its branches (sets of connected nodes) while leaving other branches to sleep. We call this ability _branching_. But before we show branching in action, we need to take a deeper dive into how workflow is evaluated.

It is clear that each node has some specific functionality. One can imagine it as a black box that consumes some data, performs calculations, and returns some other data data on the output. It can also have side effects (like setting variables elsewhere in the workflow), but about this later. Naturally, each node takes some time to evaluate. But what determines which nodes will run and when? Of course, it is the connections.

As we mentioned earlier, the connections in workflow have a slightly different meaning than those in rule flow. A priori, they do not say much about how data are flowing through the graph. Instead, the connections in workflow determine chronology. When node A is connected to node B (in that very order), it means that node B is supposed to run as soon as node A is finished. Moreover, when we add node A' and also connect it to B, then B will wait for signals from both nodes A and A', and will run as soon when both A and A' are finished.

There are four states in which node can be during the evaluation (solve) of a workflow:

* Ready = waiting for signal(s) to run
* Done = finished successfully and sent a run signal to its successors
* Error = finished with an error and sent a cancel signal to its successors
* Canceled = got a cancel signal and resent it to its successors without running

Once you run the solve of the workflow, the Start node sends a signal to run, and the workflow evaluates along the connections of the graph according to this principle. Some branches might run successfully, some may get canceled (due to an error or intentionally). When all branches reach their last node, the workflow evaluation ends and workflow returns its outputs.

{% hint style="info" %}
The End node can be used at the end of a branch for clarity. However, it has no effect on the evaluation. The branch finishes with or without it.
{% endhint %}

When running a workflow solve from the Test Bench, it is automatically evaluated in the so-called debug mode. Thanks to that, the application gets detailed data about the run and shows the final node states (as described above) in the top right corner of each node box on the canvas. To review details about the node evaluation, you can use the Inspect tool (click the icon of magnifying glass emerging above the top right corner of the node box). It shows relevant data from the node evaluation. The workflow must be solved successfully at least once in order to use the Inspect.

We have described how the workflow is evaluated and what can happen along the way. Of course, there are several special cases which make things more complicated, but the reader now has a good overall idea about the process.

