# Rule Export

You can export rules individually, an entire folder containing multiple rules, or export the entire space.

### **Method 1: Export from Rule List**

#### **For Individual Rules:**

1. Navigate to the **Rule List** section.
2. Right-click on the rule or click the **three dots** menu.
3. Select **Export.**
4. Choose your format: **JSON** or **XLSX** (if available for that rule type).
5. The file will be downloaded automatically.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 9.15.35.png" alt=""><figcaption></figcaption></figure>

{% hint style="danger" %}
Flows can reference other rules via aliases. When exporting them individually, be aware that:

* The exported Flow will contain references to other rules by their aliases, **but not to the rules themselves**.
* If referenced rules are missing during import, the Flow may not work correctly.
{% endhint %}

{% hint style="success" %}
Export Flow rules together with their dependencies in a folder, or export the entire space to ensure all referenced rules are included.
{% endhint %}

#### **For Entire Folders:**

1. Navigate to the **Rule List** section.
2. Right-click on the folder or click the **three dots** menu.
3. Select **Export Folder.**
4. All rules within the folder will be exported.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 9.10.11.png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
When exporting folders, all rules are exported in the JSON format.
{% endhint %}

#### **For Entire Space:**

1. Navigate to the **Rule List** section.
2. Click the **three dots** menu next to the **Create** button in the top right corner.
3. Select **Export Space.**
4. The export includes all rules, folders, and their structure.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 9.42.17.png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
When exporting space, all rules are exported in the JSON format.
{% endhint %}

### **Method 2: Export from the Rule Itself**

1. Open the rule you want to export.
2. Click the **three dots** in the top right corner to open **Rule Actions.**
3. Select **Export.**
4. Choose your format: **JSON** or **XLSX** (if available for that rule type).
5. The file will be downloaded automatically.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 9.06.11.png" alt=""><figcaption></figcaption></figure>
