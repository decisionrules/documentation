---
icon: rotate-reverse
layout:
  width: default
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# Rule Flow Convertor

The **Rule Flow Converter** allows you to **convert an existing Rule Flow into a Decision Flow**, making it easy to take advantage of all the advanced features of Decision Flow.

Decision Flow offers **greater flexibility, more node types, and powerful decision logic**, enabling scenarios that go beyond the capabilities of Rule Flow. By converting your Rule Flows, you can continue using your existing logic while unlocking these enhanced possibilities.

Learn more about [decision-flow.md](../flow/decision-flow.md "mention")

### How it Works

When you run the conversion:

* A new **Decision Flow** rule is created.
* The new rule inherits the same **input/output model, name, version, description, status, and audit log settings** as the original Rule Flow.
* If the Rule Flow contains any rules without defined aliases, the converter will automatically generate them.

### Where to Find It

The **Convert to Decision Flow** button is available directly in the **Rule Flow Designer**.

<div data-full-width="false"><figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure></div>

### Availability

The **Convert to Decision Flow** option is visible only if the user has the necessary **permission to create rules**.

This option is **disabled** if:

* The user has reached their rule limits.
* Decision Flow is not enabled in the current plan.
* The Rule Flow contains warnings or errors.
* The Rule Flow has not been saved.
* The Rule Flow is locked.

### Conversion Mapping

During conversion, nodes are mapped as follows (Rule Flow -> Decision Flow):

* **Start** → **Start node**
* **Rule** → **Business Rule node**
* **End** → **Assign node**
