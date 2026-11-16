# Rule Flow

**Rule Flow** is a powerful tool rule that allows you to visually connect and orchestrate multiple decision rules—such as Decision Tables, Scripting Rules, Decision Trees, and even other Rule Flows—into a single, cohesive logic process.

{% hint style="danger" %}
Rule Flow is an outdated rule, please use Decision Flows instead.
{% endhint %}

{% hint style="warning" %}
Rule Flows are not available in spaces with [Space Versioning](../../space/space-version-control/) enabled. Creating or importing a Rule Flow there is refused with "Rule flows are not supported in a space with Space Versioning enabled — rule flows are not versioned. Create or import it in a space without versioning, or disable Space Versioning on this space."

A space that contains a Rule Flow cannot enable Space Versioning. When you try, the dialog **Space Versioning cannot be enabled yet** lists the Rule Flows under **Rule Flows** with the hint "Convert each Rule Flow to a Decision Flow and delete the original, or delete it." Decision Flows are fully supported in versioned spaces.
{% endhint %}

### **Try Decision Flow**

While **Rule Flow** lets you connect and execute rules in a simple flow, **Decision Flow** takes this further, giving you more power, flexibility, and possibilities.

With Decision Flow, you can:

* Orchestrate multiple rules in one flow
* Perform data transformations and calculations
* Run conditional logic, inline scripts, or external API/DB calls
* Access more node types and advanced connections

**Why Decision Flow is better:**

* **More versatile:** supports a wider variety of decision scenarios
* **Dynamic and powerful:** can handle complex logic easily
* **Runs on the** [**latest solver**](../../api/rule-solver-api/rule-solver-api.md)**:** Decision Flows run on new solver engine, where performance improved.

#### Convert Rule Flows to Decision Flows

You can easily convert your existing Rule Flows to Decision Flows using the **Rule Flow Converter**. This allows you to take advantage of all the advanced features of Decision Flow while keeping your existing logic.

Learn more about the [rule-flow-convertor.md](rule-flow-convertor.md "mention")

#### What Rule Flow Enables

* **Modular Logic Design**: Break down complex decisions into smaller, reusable rule blocks that can be linked together visually.
* **Sequential Rule Execution**: Control the order in which rules are evaluated, allowing for multi-step decision processes.
* **Dynamic Data Handling**: Pass data between rules using input/output mappings to create flexible, context-aware workflows.

#### Key Features

* **Visual Rule Flow Designer**: Drag-and-drop interface for building workflows from existing rules.
* **Data Mapping Between Rules**: Define how data moves through the flow, enabling seamless input/output chaining.
* **Nested Rule Flows**: Use one Rule Flow inside another to keep your logic organized and scalable.
* **Import & Export**: Share Rule Flows easily via JSON, allowing for versioning, backup, and team collaboration.
