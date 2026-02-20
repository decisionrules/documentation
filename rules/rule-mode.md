# Rule Mode

**Rule Mode** is where you edit and configure individual rules. When you open a rule from the Rule List, it loads into Rule Mode - an interactive editor that gives you all the tools you need to build, adjust, and test your decision logic in one place.

## Main Layout

### Central Part

The central part of Rule Mode is the **Designer**. This is where the rule body lives. It's the core space where you define overall logic. The layout and available tools in the Designer vary depending on the rule type (table grid, tree structure, flow canvas, code editor..)

<figure><img src="../.gitbook/assets/Screenshot 2026-02-19 at 8.13.18.png" alt=""><figcaption></figcaption></figure>

Alongside the Designer, there is a **Model** tab where you define your rule's [Input and Output Model](common-rule-features/input-and-output/) - the data structure your rule expects to receive and produce.

<figure><img src="../.gitbook/assets/Screenshot 2026-02-19 at 8.17.16.png" alt=""><figcaption></figcaption></figure>

### Top Panel

At the top of the screen, you'll find a control panel with several key sections:

<figure><img src="../.gitbook/assets/Screenshot 2026-02-19 at 8.23.12.png" alt=""><figcaption></figcaption></figure>

#### **Integrations:**

* Access API code examples in multiple languages.
* Excel integration and Swagger documentation.

#### **Rule Actions Menu:**&#x20;

This dropdown includes additional rule-specific actions such as:

* **Clone** - Create a duplicate copy of the current rule.
* [**Share with Space**](common-rule-features/cross-space-rule-sharing.md) - Share this rule with other spaces in your organization.
* [**Export / Import Version**](common-rule-features/rule-export-and-import/) - Download / Upload the rule as a file.
* [**Compare versions**](common-rule-features/rule-comparison/) - View differences between rule versions.
* [**Lock / Unlock**](common-rule-features/rule-lock.md) **-** Prevent or allow editing of the rule to protect important versions.
* **Delete** - Permanently remove the rule from your space.

#### **Action Buttons:**

* **Undo / Redo** - Navigate changes while editing the rule.
* **Save** - Save your progress manually.
* [**AI Assistant**](/broken/pages/mYHNsVjs1qps152cbIHo) - Access AI-powered help (Beta).

### Left Panel

On the left side, you'll find a dynamic panel with tools that support rule editing and navigation.

<figure><img src="../.gitbook/assets/Screenshot 2026-02-19 at 12.33.16.png" alt=""><figcaption></figcaption></figure>

#### **Common Tools (Available for All Rule Types):**

* **Folders** - Quick view of the Rule List, allowing you to jump to another rule without leaving Rule Mode.
* [**Settings**](common-rule-features/rule-settings/) - Configure rule name, alias, status, and other rule-specific settings.
* [**History**](common-rule-features/rule-history.md) - View all saved versions of the rule, compare changes, or revert to previous states.
* [**Dependencies**](common-rule-features/rule-dependencies.md) - Shows on which rules this one depends, or which rules this one is using.

#### **Rule-Specific Tools:**

Depending on the rule type, additional panels may appear:

* [**Rule Variables**](common-rule-features/rule-variables.md) - Define and manage custom variables used in the rule logic: _Decision Table, Decision Tree, Scripting Rule._
* [**Palette**](flow/flow-nodes-overview.md) - Drag-and-drop node library for building flows: _Decision Flows, Integration Flows._
* [**Inspect**](flow/flow-designer.md#inspect) - View and inspect flow execution details: _Decision Flows, Integration Flows._
* [**Jobs**](../space/jobs.md) - Manage scheduled or long-running jobs: _Integration Flows._

### Bottom Panel

#### **Common Tools (Available for All Rule Types):**

* [**Test Bench**](common-rule-features/test-bench.md) - Built-in testing area for real-time rule validation.

#### **Rule-Specific Tools:**

* [**Console**](decision-table/decision-table-designer/#console) - View execution logs and debug information: _Decision Table, Decision Tree, Scripting Rule._
* [**Search**](decision-table/decision-table-designer/#search) - Find specific values in rule or search row: _Decision Table, Flows, Lookup Table, Scripting Rule._
* [**Go to Row**](decision-table/decision-table-designer/#go-to-row) - Quickly navigates to the desired row: _Decision Table, Lookup Table._
* **+ Row** - Add new rows: _Decision Table, Lookup Table._
* [**+ Else Row** ](decision-table/decision-table-designer/#else-row)- Add ELSE row for default conditions: _Decision Table._
* [**Check duplicates**](decision-table/decision-table-designer/#check-table-for-duplicates) - Detect duplicate rows: _Decision Table;_ built-in for primary key in _Lookup Table._
* **Zoom controls** - Zoom in, out, or reset canvas view: _Decision Trees, Flows._
* **Text Wrap in JSON Editor** - Enable/disable text wrapping inside JSON editor: _Decision Table, Decision Tree, Flows, Scripting Rule._
* **Shrink cells** - Compact cell display: _Decision Tree._
* **Format code** - Auto-format JavaScript code: _Scripting Rule._
* **Font size** - Adjust editor font size: _Scripting Rule._
