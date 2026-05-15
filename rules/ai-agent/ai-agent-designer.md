# AI Agent Designer

The AI Agent designer is split into two areas:&#x20;

* **Left sidebar** for model and infrastructure configuration
* **Main panel** with four tabs:
  * **Prompt / Instruction**
  * **Annotations**
  * **Explainable AI**
  * **Attachments**

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-02 at 11.42.02 (1).png" alt=""><figcaption></figcaption></figure>

## Left Sidebar

The sidebar contains settings that **apply to the entire rule.**

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-02 at 11.41.04.png" alt="" width="136"><figcaption></figcaption></figure>

### **AI Model**

Select the LLM that will execute the agent. Use the dropdown to browse available models. Once a model is selected, the **Connector** dropdown below is automatically filtered to show only connectors that are compatible with that model.

### **Connector**&#x20;

A Connector provides the authenticated link between DecisionRules and the LLM provider. Select an existing connector from the dropdown or click **+ Create** to add one without leaving the designer.\
For details on setting up AI model connectors see [Connectors](../../space/connectors.md).

### **Cache AI Response**

When enabled, identical inputs return the cached result instead of calling the model again. Useful when the same input is likely to repeat and a fresh inference is not required every time. \
Covered in detail on the [Caching](caching.md) page.

### **Explainable AI**

When enabled, a system-defined `explanation` object is automatically added to the rule output. The **Explainable AI** tab becomes active and shows the fields that will be included. \
Covered in detail on the [Explainable AI](explainable-ai.md) page.

### **Data Dictionary**&#x20;

**Data Dictionary** A live reference panel showing all data available to the prompt, organized into three groups:

* **Input**: all fields from the rule's [Input Model](../common-rule-features/input-and-output/), shown in their path hierarchy
* **Rule Variables**: static values defined at the rule level, versioned with the rule. See [Rule Variables](../common-rule-features/variables/rule-variables.md) for how to create and manage them
* **Attachments**: available when one or more files are attached to the rule

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-08 at 15.47.20 1 (1).png" alt=""><figcaption></figcaption></figure>

All three groups are searchable in the Data Dictionary. Drag any variable directly into the prompt editor to insert it as a `{variable}`.

{% hint style="info" %}
Keep your prompt lean. Reference only the fields the model genuinely needs to produce the output. This reduces token usage and keeps the model focused.
{% endhint %}

## Prompt / Instruction Tab

The prompt is the full instruction sent to the model at execution time. Write it as a single text, there is no separate instruction field. Inputs and variables are highlighted in purple in the editor so they are easy to spot at a glance.

<figure><img src="../../.gitbook/assets/Frame 12.png" alt=""><figcaption></figcaption></figure>

A **Prompt Templates** button in the top-right corner provides pre-built prompt structures for common use cases.

<figure><img src="../../.gitbook/assets/Mask group (1) (1).png" alt="" width="465"><figcaption></figcaption></figure>

### Prompt Variables

Variables reference fields from the Input Model using curly braces and dot-path notation:

```
// Input
{fieldName}
{parent.child}

// Rule Variable
{variables.globalTaxRate}

// Attachments
{attachments.NDA_Standards.pdf}
```

At execution time each `{variable}` is replaced with the actual value.

{% hint style="warning" %}
**Only data that appears in the prompt as a variable is actually sent to the model at execution time**, fields defined in the Input Model but not referenced in the prompt are ignored.
{% endhint %}

## Annotations Tab

Annotations describe what each output field should contain. They are the primary way to control what the model returns, not the prompt. Every field defined in your [Output Model](../common-rule-features/input-and-output/) has a corresponding annotation row in this tab.

<figure><img src="../../.gitbook/assets/Mask group (2).png" alt=""><figcaption></figcaption></figure>

Each annotation row has three elements:

* **Field name**: the output field path, matching the Output Model structure
* **Field type**: the expected data type for this field. For parent objects this is set to `Object` automatically and cannot be changed, only leaf fields have a type you select
* **Description**: a plain text instruction telling the model exactly what value to produce for this field

### Field Type

<table><thead><tr><th width="139.920166015625">Type</th><th>What's returning</th></tr></thead><tbody><tr><td><strong>Text</strong></td><td>A string value</td></tr><tr><td><strong>Number</strong></td><td>An integer or decimal number (using decimal point)</td></tr><tr><td><strong>Boolean</strong></td><td><code>true</code> or <code>false</code></td></tr><tr><td><strong>Object</strong></td><td>A nested object (sets automaticaly for parent fields)</td></tr><tr><td><strong>Array</strong></td><td>A list of values</td></tr><tr><td><strong>Auto</strong></td><td>The model decides the type at runtime based on the value it returns</td></tr></tbody></table>

All field types are nullable. Instruct the model to return `null` in the annotation description when a value cannot be determined, see [Handling Missing or Uncertain Data](ai-agent-designer.md#handling-missing-or-uncertain-data) section below.

{% hint style="info" %}
Use **Auto** sparingly. When the type is unpredictable, downstream rules that depend on that field may behave inconsistently. Prefer an explicit type wherever you know what the field should return.
{% endhint %}

### Description

The description is the most important part of an annotation. It is not a label or a comment, it is a direct instruction to the model. The clearer and more specific it is, the more consistent and reliable the output will be.

A good description tells the model two things:&#x20;

* **what** the value represents
* **how** to determine it

#### Handling Missing or Uncertain Data

If the model cannot determine a value from the input, instruct it to return `null` rather than a placeholder string like `"N/A"` or `"unknown"`. Returning `null` is cleaner and far easier to catch in a downstream Decision Table using a `IS_NULL` operator.

{% hint style="info" %}
Be consistent across all fields in the same rule. If you choose `"unknown"` as the fallback, apply it everywhere, mixing `null` with `"unknown"` or empty strings will make downstream conditions harder to write and maintain.
{% endhint %}

## Explainable AI Tab

This tab is active only when the **Explainable AI** toggle is enabled in the sidebar. It shows the four system-defined fields that will be added to every response: `probability`, `reason`, `source_fragments`, and `warnings`. These fields are injected automatically.

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-08 at 10.40.17 1.png" alt=""><figcaption></figcaption></figure>

See [Explainable AI](explainable-ai.md) for a full description of each field and guidance on how to use them.

## Attachments Tab

The Attachments tab lets you embed documents into the agent. The model can reason against a fixed reference document — a policy file, a contract template, a scoring rubric, or a regulatory guideline.

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-07 at 13.08.54 1 (1).png" alt=""><figcaption></figcaption></figure>

**To add an attachment:**

1. Open the **Attachments** tab and click **Add Attachment**.
2. Upload a file. It appears in the list and [**Data Dictionary**](ai-agent-designer.md#data-dictionary) with its filename.
3. To remove it, click the **×** button next to the file.

Once attached, the document is part of the rule definition and is versioned with it. Just like input variables, **only attachments that are referenced in the prompt are actually sent to the model**.

<figure><img src="../../.gitbook/assets/Frame 13.png" alt="" width="245"><figcaption></figcaption></figure>

Reference an attachment in your prompt using the same variable syntax as input fields — drag it directly from the Data Dictionary or type it manually:

```
{attachments.Return_Policy.pdf}
{attachments.NDA_Standards.pdf}
```

#### **Supported file formats**

Most common formats work across all models:

* PDF
* Plain text (.txt)
* Markdown (.md)
* CSV

Some models support additional formats such as Excel (.xlsx) or Word (.docx) — support varies by provider.

#### Models without file support

If the selected model does not support file input, a warning will appear on the tab and **the rule cannot be executed until the issue is resolved**, either by removing the attachments or switching to a model that supports them.

<figure><img src="../../.gitbook/assets/Screenshot 2026-04-07 at 13.23.44 1.png" alt=""><figcaption></figcaption></figure>
