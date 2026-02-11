# Cross-Space Rule Sharing

The **Share with Space** feature allows you to share rules across multiple spaces, enabling collaborative editing while maintaining a single source of truth.

**Key difference from Export/Import:**

* **Export/Import:** Creates an independent copy of the rule
* **Share with Space:** Creates a shared reference to the same rule instance

## **How Shared Rules Work**

When you share a rule with another space, the rule becomes accessible in both the original space and the shared space. However, it is still the same rule instance - not a copy.

{% hint style="warning" %}
**Share with Space** does not work with Flows because they are based on different rules in space.
{% endhint %}

### **Synchronized Changes**

Any changes made to the rule in any space where it's shared will be reflected in all other spaces.\
This includes:

* Rule logic and structure
* Input/Output models
* Rule variables
* Settings and configuration
* All version history

### Version Synchronization

When you create a new version of a shared rule in any space, that version is automatically created in **all other spaces** where the rule is shared.

**What this means:**

* Version history is identical across all shared spaces.
* New versions propagate instantly.
* Version status syncs.
* You cannot have different versions in different spaces.

{% hint style="danger" %}
**Publishing New Versions Affects All Spaces**

When someone creates a new version of a shared rule, it starts in pending status across all spaces. However, if any user with publish permissions in any shared space publishes that version, it becomes active everywhere immediately. If a Flow in your main space uses the `latest version` of that shared rule, its logic will change the moment someone publishes the new version.&#x20;

**Carefully control both version creation and publish permissions in all spaces where rules are shared.**
{% endhint %}

More about permissions you can find in section [Space Roles](../../organization/space-roles.md)

## **When to Use Share with Space**

**Share with Space** is particularly useful when you want dedicated users to have permission to edit rules in their own spaces, while their changes impact a larger project they don't have direct access to.

**Example Scenario:**

* **Main Project Space:** "Production Pricing Engine" (restricted access)
* **Regional Spaces:** "EU Pricing Team", "US Pricing Team", "APAC Pricing Team".
* All spaces are within the same organization.

**How it works:**

1. Share pricing rules from Production space to regional team spaces.
2. Regional teams can edit rules within their own space.
3. Changes are automatically reflected in the Production space.
4. Regional teams never need access to the main Production space.

## How to Share a Rule

### Requirements and Prerequisites

Before you can share a rule with another space:

* You must **be a member** of both the source spaces.
* You must **have sharing permissions** in the source space.
* You must **have permission to create rules** in the target space.
* Spaces must be in the **same organization**
  * You cannot share rules between different organizations
  * You can share between your private spaces regardless of organization

### Sharing Process

#### **Method 1: From Rule List**

1. Navigate to the **Rule List** section.
2. Right-click on the rule or click the **three dots** menu.
3. Select **Share with Space.**
4. Choose the target space from the dropdown (only spaces in your organization will appear)

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-10 at 16.51.51.png" alt=""><figcaption></figcaption></figure>

#### **Method 2: From the Rule Itself**

1. Open the rule you want to share.
2. Click the **three dots** in the top right corner to open **Rule Actions.**
3. Select **Share with Space.**
4. Choose the target space from the dropdown.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-10 at 16.54.56.png" alt=""><figcaption></figcaption></figure>
