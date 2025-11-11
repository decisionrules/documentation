# Flow Designer

{% hint style="info" %}
See our Decision Flow tutorial available in [DecisionRules Academy](https://app.gitbook.com/s/2kePaAlhzmPFZTjuxdCY/rule-types/decision-flow/create-a-decision-flow).
{% endhint %}

### Accessing Decision Flow

Let us create the first Decision Flow. Click the Create button in the Rule list. Here you can choose to create a blank Decision Flow (if you do not seem to have access to it, please see the [Flow Limits](flow-limits.md) page).

Upon creating a blank Decision Flow, you will be taken to the rule detail. Note the Settings and the Designer tab. You can review the Settings, which should not surprise any DecisionRules user. As mentioned above, the settings are (almost) the same as for regular business rules. In particular, pay attention to the input/output models. As usual, these models define the format of the input and output data of the Decision Flow at question. We can leave all the defaults here and turn our attention to the Designer tab.

The blank designer features the canvas with a single node: the Start. The designer window features the usual bottom bar, where we can open the test bench. Next, on the right hand side, there are several additional tabs. For now, we will focus to the most important one: the Palette.

{% hint style="info" %}
You can try one of our Decision Flow examples. Simply click on the Examples card on the Rule list. Exmaple window will show up. Select Rule examples section, then choose one of the examples with Decision Flow tag.
{% endhint %}

<figure><img src="../../.gitbook/assets/wf_designer.png" alt=""><figcaption><p>The Decision Flow designer</p></figcaption></figure>

## Flow Designer

### Canvas

You can think of the Flow canvas as a real canvas where you can place nodes, connect them to create from simple to complex processes. On the canvas there is a enough space for all your nodes and  branches.

#### Navigation

Navigation through the canvas is intuitive - move around by dragging your mouse, zoom in and out scrolling the mouse wheel.

#### **Editing and Saving Changes**

When editing a rule, you can make changes directly in the rule editor.\
Use the control buttons in the top-right corner of the editor to manage your edits:

* **Undo** ⟲ – reverts your last action
* **Redo** ⟳ – restores the reverted change
* **Save** 💾 – saves the current version of the rule

<figure><img src="../../.gitbook/assets/chrome_eEdPFBZBXY.png" alt=""><figcaption></figcaption></figure>

These actions help you safely adjust the rule before saving it.\
Each time you save, a new version of the rule is created and recorded in the **History** panel, where you can review or restore past versions. You will find more information about Rule History here on [dedicated page](../common-rule-features/rule-history.md).

### Sidebar

#### Palette

The palette has a simple purpose. It lists all the available node types with brief description. If you want to use any of the nodes in your Flow, just drag it from the palette and drop it on the canvas.

{% hint style="info" %}
The maximum number of nodes you can add to a Flow is determined by your plan, ensuring optimal performance tailored to your subscription level. To discover how Decison Flow limits works, please refer to [page](flow-limits.md#nodes-limit) dedicated to it.

In the Palette you can see how many nodes are in the Decision or Integration Flow.&#x20;
{% endhint %}

By clicking on the node in the list node description opened. You can find the functionality of such node there, along with common use cases.

<figure><img src="../../.gitbook/assets/wf_node_palette_hint.png" alt=""><figcaption><p>Node description in the Palette</p></figcaption></figure>

#### Inspect

On the Inspect tab you will find details of node evaluation once you run the Decision Flow in the Test Bench.

{% hint style="info" %}
See more information about Decision Flow Evaluation in the [section](flow-designer.md#workflow-evaluation) below.
{% endhint %}

<figure><img src="../../.gitbook/assets/wf_inspect_tab (1).png" alt=""><figcaption><p>Inspect tab detail</p></figcaption></figure>

### Nodes

Nodes in the Decision Flow act as containers for specific actions or steps. Each node represents a task, such as declaring and assigning values, processing data, evaluate other business rules or run custom code. These nodes help structure and visualize the Decision Flow.

Once present on the canvas, the node can be clicked in order to open its detail. Each node type has different configuration options, depending on its functionality. If you want to read more about individual node types and their configuration options, check out the [Flow Nodes Overview](flow-nodes-overview.md).

#### Node modal

As mentioned node represents a task. Such task can be set in the modal opened by clicking on the node on canvas. Depending on the node type in the modal, you can define new data sources and targets, along with their corresponding values, or utilize the existing ones.

In every open node modal you can find _Data Dictionary_, a collapsible section holding Decision Flow variables already declared. Their values can be used by simple dragging to desired field.

{% hint style="warning" %}
_Please note that by design some types of declared_ Decision Flow _variables cannot be used as a target to be overwritten._
{% endhint %}

You can also find a description of each node by clicking the ![](https://docs.decisionrules.io/~gitbook/image?url=https%3A%2F%2F437457296-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252F-MN4F4-qybg8XDATvios%252Fuploads%252FKYk6GEhI2GvXJ61JIkDj%252Fhint.png%3Falt%3Dmedia%26token%3Df0428c14-2dcb-452b-a5db-4f998c0299ce\&width=300\&dpr=4\&quality=100\&sign=626a0892\&sv=1) (How-To) icon in the node modal.

{% hint style="info" %}
Multiple node modals can be opened at the same time.
{% endhint %}

{% hint style="info" %}
Once the Decision Flow node is set in the modal, node on canvas shows details about the content and setting.

<img src="../../.gitbook/assets/wf_node_on_canvas.png" alt="workflow node on canvas showing details" data-size="original">
{% endhint %}

#### Node Interaction

Nodes can be moved around the canvas dragging them by their headers.&#x20;

Hovering or right-clicking on node shows context menu containing three options: Inpect, Clone and Delete.

* Inspect: Opens Inspect tab of selected node on the right side of the Designer.
* Clone: Creates a clone of selected node. Creating a clone will duplicate the content within the modal.
* Delete: Selected node is removed from the Decision Flow. Can be undone using Undo/Redo buttons.

#### Naming Nodes

To better fit you process, you can name your nodes on canvas. Node name have to be unique in your Decision Flow and only English letters, numbers and underscores are allowed to use.

### Connections

In your Decision Flow, connecting nodes together is essential for creating a logical flow of operations. By linking nodes, you enable the transfer of data and outcomes from one step to the next, allowing the Decision Flow to process complex conditions and make decisions based on prior results.

#### Connecting Nodes

To connect nodes in the Decision Flow, simply click and drag a connection from the right connector of one node to the left connector of another. This establishes a link between the two nodes, allowing them to interact and pass data.

<figure><img src="../../.gitbook/assets/wf_node_connecting.png" alt=""><figcaption><p>Creating node connections</p></figcaption></figure>

### Rule Bottom Bar

Located at the bottom of the rule designer, you'll find a set of additional tools:

* Test Bench: Here you can test your Decision Flow. Simply enter input data and click **Run**. More about Test Bench can be found [here](../common-rule-features/test-bench.md).
* Console: Here you can find all Decision Flow process data.
* Center: Allows you to quickly return to the starting point of the Decision Flow, making it easy to navigate back to the beginning
* Zoom: Use zoom buttons the adjust the view of your Decision Flow.

## Simple Decision Flow Example

Let us consider a simple example. Among other things, Decision Flows can do everything that rule flows can do, that is, call other rules. We can thus build a simple Decision Flow which calls a decision table and sends its results to the output. This should be easy enough.

First we need a decision rule to start with. Create a blank new table, call it Segment and go to its settings. We shall adjust the input/output models. Let us assume that this decision table will get client segment on the input and will return the segment name. The input model will thus have a single `segmentCode` attribute, while the output will have the `segmentName`.

{% file src="../../.gitbook/assets/Segment_v1.json" %}
Segment decision table
{% endfile %}

<figure><img src="../../.gitbook/assets/image (5) (1) (2).png" alt=""><figcaption><p>The Segment decision table I/O model</p></figcaption></figure>

As for the table itself, let us keep things simple and just add a couple of rows. Based on the matched segment code, we will return the corresponding segment name. The table can look e.g. as follows.

<figure><img src="../../.gitbook/assets/image (6) (1) (2).png" alt=""><figcaption><p>The Segment decision table</p></figcaption></figure>

Try to solve the table from the Test Bench to be sure it works as expected.&#x20;

We can now return to our Decision Flow. Assuming that we just want to call the Segment decision table and return its results, the input/output model of the Decision Flow can be exactly the same as that of the table. Open the Decision Flow Settings tab and edit the models to have `segmentCode` in the input and `segmentName` in the output.

We are ready to return to the Decision Flow designer. Upon opening the Designer tab of our blank Decision Flow, we see just empty canvas with the Start node. Open the palette on the right hand side menu, find the Business Rule node and drag it to the canvas.

<figure><img src="../../.gitbook/assets/image (7) (1) (3).png" alt=""><figcaption><p>Decision Flow designer with the Business Rule node</p></figcaption></figure>

The purpose of Business Rule is, well, to call a business rule. To make sure this actually happens, we have to connect the Start with the Business Rule. Notice the small circles on the side of the nodes: these are connectors. Dragging a line from one connector to another, create a so-called connection. Next thing, notice the little `rule` label at the bottom left corner of the Business Rule. This is the _node alias_. It is a unique name used for referencing this node elsewhere in the Decision Flow. To satisfy the best practices, edit the node alias to be more descriptive, rewriting it e.g. to `segments`. We will later use this keyword to map results of the table to output.

We have created the Business Rule node, now we have some configurations to do. Click the inside of the Business Rule box, opening its detail window.

<figure><img src="../../.gitbook/assets/image (9) (1) (2).png" alt=""><figcaption></figcaption></figure>

The detail of Business Rule has two main parts. In the first part one chooses the business rule to call. Open the dropdown and find the Segment decision table prepared beforehand. We can leave the default Standard strategy and skip to the second part. Here we have to define the rule input mapping, telling which data will be sent to the input of the decision table.

At this point, it is suitable to pay some attention to the Data Dictionary section on the left hand side of the window. Upon expanding the items, we shall see the predefined input and output attributes. Since we want to send the inputted `segmentCode` to the input of the decision table, we just drag and drop the `input.segmentCode` from the Data Dictionary next to the `segmentCode` item in the rule input mapping. Click the Save button and we are done! We have just configured our first Business Rule node.

Our Decision Flow will now be able to call the Segments table and get its results. However, we have not yet specified what to do with them. To actually get something useful in the Decision Flow output, we have to assign the result of the Business Rule node to the output of the Decision Flow. For this we can use the Assign node. Drag it to the canvas from the palette and connect it after the Business Rule. Then click in the middle of the node in order to review its configuration.

<figure><img src="../../.gitbook/assets/image (12) (1) (2).png" alt=""><figcaption><p>The desired Assign configuration</p></figcaption></figure>

The node detail window is already familiar to us. We just need to add a single assignment. See that the Assign configuration contains target and source. Under target, we will put `output.segment`, and in source we enter the result from our Business Rule. It can be found in the Data Dictionary by its node alias segments, and we are interested in its output, therefore using `segments.output`. Both these variables can be simply dragged and dropped from the Data Dictionary. Our Assign is complete.

Finally let us test the resulting Decision Flow. Open Test Bench, enter a `segmentCode` matching some segment code from the Segments decision table and click Run. If the configuration was done correctly, you should get the corresponding segmentName on the output.

<figure><img src="../../.gitbook/assets/image (14) (1) (2).png" alt=""><figcaption><p>Testing our Decision Flow</p></figcaption></figure>

Note that the `segment` attribute on the output actually contains an array `[]` with a single object `{}`, which in turn contains the `segmentName`. This rather complex data structure follows from how we set up our Assign. Under `segment`, we have mapped the whole output of the Segment table. Later we will see how the result can be simplified or transformed to any form you like.

This is it, you have your own first functioning Decision Flow! Of course, there is much more to Decision Flow: the inspect, the variables, the distinct nodes, loops, etc. Nevertheless, this example brought to light the most important principles, and showed the usual ways of work. You can use following Decision Flow as a reference.

{% file src="../../.gitbook/assets/Segment-Sample.json" %}

In the next section, we shall dive more deeply in how Decision Flow is evaluated.

## Decision Flow Evaluation

Although Decision Flow looks similarly to rule flow, it is fundamentally different. Decision Flow has the ability of running only some of its branches (sets of connected nodes) while leaving other branches to sleep. We call this ability _branching_. But before we show branching in action, we need to take a deeper dive into how Decision Flow is evaluated.

It is clear that each node has some specific functionality. One can imagine it as a black box that consumes some data, performs calculations, and returns some other data data on the output. It can also have side effects (like setting variables elsewhere in the Decision Flow), but about this later. Naturally, each node takes some time to evaluate. But what determines which nodes will run and when? Of course, it is the connections.

As we mentioned earlier, the connections in Decision Flow have a slightly different meaning than those in rule flow. A priori, they do not say much about how data are flowing through the graph. Instead, the connections in Decision Flow determine chronology. When node A is connected to node B (in that very order), it means that node B is supposed to run as soon as node A is finished. Moreover, when we add node A' and also connect it to B, then B will wait for signals from both nodes A and A', and will run as soon when both A and A' are finished.

There are four states in which node can be during the evaluation (solve) of a Decision Flow:

* Ready = waiting for signal(s) to run
* Done = finished successfully and sent a run signal to its successors
* Error = finished with an error and sent a cancel signal to its successors
* Canceled = got a cancel signal and resent it to its successors without running

Once you run the solve of the Decision Flow, the Start node sends a signal to run, and the Decision Flow evaluates along the connections of the graph according to this principle. Some branches might run successfully, some may get canceled (due to an error or intentionally). When all branches reach their last node, the Decision Flow evaluation ends and rule returns its outputs.

{% hint style="info" %}
The End node can be used at the end of a branch for clarity. However, it has no effect on the evaluation. The branch finishes with or without it.
{% endhint %}

When running a Decision Flow solve from the Test Bench, it is automatically evaluated in the so-called debug mode. Thanks to that, the application gets detailed data about the run and shows the final node states (as described above) in the top right corner of each node box on the canvas. To review details about the node evaluation, you can use the Inspect tool (click the icon of magnifying glass emerging above the top right corner of the node box). It shows relevant data from the node evaluation. The Decision Flow must be solved successfully at least once in order to use the Inspect.

We have described how the Decision Flow is evaluated and what can happen along the way. Of course, there are several special cases which make things more complicated, but the reader now has a good overall idea about the process.
