# Flow

In DecisionRules, **Flows** are a rule type used to connect multiple decision-making steps into a single process.\
They let you visually orchestrate rules, transform data, branch logic, and integrate with external systems, all in one execution path.

#### Flow rules exist to:

* Combine multiple rules (Decision Tables, Decision Trees, Scripting Rules, etc.).
* Control execution order and branching.
* Prepare and pass data between steps.
* Integrate with APIs, databases, or external services.

#### **Types of Flows**

* **Decision Flow** – More versatile nodes (scripts, conditions, API calls, DB connectors) for complex orchestration and branching. Future-ready for more integrations.
* **Integration Flow** – Runs as a background job with extended time limits. Ideal for large datasets, heavy API calls, and long-running logic.

#### **When to Use**

Use a Flow when:

* You need to combine multiple rules into one workflow.
* The logic spans several steps or depends on external data.
* You want to keep decision-making modular and reusable.
* You require both quick responses and heavy batch processing.

The following sections explain each Flow type in more detail, including their features, differences, and typical use cases:

{% content-ref url="flow-designer.md" %}
[flow-designer.md](flow-designer.md)
{% endcontent-ref %}

{% content-ref url="flow-nodes-overview.md" %}
[flow-nodes-overview.md](flow-nodes-overview.md)
{% endcontent-ref %}

{% content-ref url="flow-limits.md" %}
[flow-limits.md](flow-limits.md)
{% endcontent-ref %}
