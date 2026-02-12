---
description: Binding Input and Output model to Decision Table in decision table designer.
---

# Binding to Model

After creating the [input and output models](../common-rule-features/input-and-output/), you need to bind these models to your Decision Table. The binding determines which data fields are used in your rule logic.

**Basic Binding:**

* **Input Model** → Bound to **condition columns**.
* **Output Model** → Bound to **result columns**.

## **Understanding Model Binding**

### **What Can Be Bound**

You can select any **leaf field** from the input/output model as a condition or result variable.

{% hint style="warning" %}
You cannot select a parent/root field that contains children as a condition/result variable. Only leaf fields (fields with no children) can be bound.
{% endhint %}

### **Use Case Example**

Consider the following model structure:

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-12 at 12.07.27.png" alt="" width="563"><figcaption></figcaption></figure>

From this model structure, here's what can and cannot be bound to columns:

#### **Can be bound:**

**Input:**

* `delivery.distance.car`
* `delivery.distance.ship`
* `delivery.distance.plane`
* `delivery.tariff`
* `package.weight`
* `package.longestSide`

**Output:**

* `shippingCost`
* `deliveryMethod`
* `status`

#### **Cannot be bound:**

* `delivery` (has children: `distance`, `tariff`)
* `delivery.distance` (has children: `car`, `ship`, `plane`)
* `package` (has children: `weight`, `longestSide`)

### **Flexible Usage**

**You don't need to use every field as a column.** Model fields can be used in different ways:

* As column bindings (condition or result columns).
* In calculations and expressions without being bound to a column.
* Referenced multiple times in different columns or cells.

This flexibility applies to both input and output models.

## **How to Bind Models**

### **Binding Input Model to Condition Columns**

1. Navigate to the **Decision Table Model**.
2. Create new input field.
3. Navigate to the **Decision Table Designer**.
4. Create a new **condition column**.
5. In the column header dropdown, select the input field you want to bind.

<figure><img src="../../.gitbook/assets/Screen Recording 2026-02-12 at 12.32.27.gif" alt=""><figcaption></figcaption></figure>

### **Binding Calculation field to Condition Columns**

1. Navigate to the **Decision Table Designer**.
2. Create new **calculation column** (rename it for better readability)
3. Create a new **condition column**.
4. In the column header dropdown, select the calculation field you want to bind.

<figure><img src="../../.gitbook/assets/Screen Recording 2026-02-12 at 12.52.32 (1).gif" alt=""><figcaption></figcaption></figure>

### **Binding Output Model to Condition Columns**

1. Navigate to the **Decision Table Model**.
2. Create new output field.
3. Navigate to the **Decision Table Designer**.
4. Create a new **result column**.
5. In the column header dropdown, select the output field you want to bind.

<figure><img src="../../.gitbook/assets/Screen Recording 2026-02-12 at 12.36.41.gif" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Condition columns can also be bound to [Rule variables](../common-rule-features/rule-variables.md)
{% endhint %}
