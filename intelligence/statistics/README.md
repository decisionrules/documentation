# Statistics

The Audit Statistics page transforms audit log data into visual insights that help you analyze rule behavior, monitor trends, identify anomalies, and evaluate rule performance over time. Statistics can be generated for individual rules within selected date ranges. You can also compare two rules side by side to better understand differences in their execution patterns and results.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 13.48.02.png" alt=""><figcaption></figcaption></figure>

## Selection Panel

### Rule Selection

Use the Rule Picker to select the rule you want to analyze.

Each rule displays an audit log availability indicator:

* 🟢 **Green dot** – Audit logs are available for the selected date range.
* 🟠 **Orange dot** – No audit logs are available for the selected date range.
* ( ⚪ **Gray dot** – Loading state. )

This allows you to quickly identify which rules contain analyzable data.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 13.46.02.png" alt=""><figcaption></figcaption></figure>

### Date Range Selection

Statistics support the same date selection options as the Audit Logs page, including relative and absolute date ranges.

The date selection is shared between the Audit Logs and Statistics tabs. When you change the date range in one tab, the same range is automatically applied to the other tab.

All visualizations and calculations are generated from the selected period.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 13.54.25.png" alt=""><figcaption></figcaption></figure>

### Data Dictionary (DD)

The Data Dictionary helps you explore the attributes available in audit logs and select the data you want to analyze.

Attributes are organized into three scopes:

* **Input** - Data sent to the rule during execution.
* **Output** - Data returned by the rule after execution.
* **Metadata** - Technical and execution-related information, such as rule ID, rule name, version, status, timestamp, execution time, user ID, solver key, and correlation ID.

You can search for a specific attribute and select it to load detailed statistics into the main analysis area.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.01.40.png" alt=""><figcaption></figcaption></figure>

#### (DD) Attribute types

Each attribute in the Data Dictionary has an **assigned type**. The type is detected automatically from a sample of audit logs, so it should be understood as a best estimate rather than a fixed schema definition.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.21.45.png" alt=""><figcaption></figcaption></figure>

Supported attribute types are:

* Number
* String
* Boolean
* Object
* Array
* Mixed
* Unknown
* Date

{% hint style="info" %}
**Attribute Type Limitation**

Because the type is inferred from sampled audit data, it may not always match every audit log in the selected range. For example, if an attribute appears as a number in most sampled records, it may be shown as Number. If different records contain different types for the same attribute, the attribute may be shown as Mixed. If the value is missing, empty, or cannot be reliably detected, it may be shown as Unknown.
{% endhint %}

#### (DD) Sampling and changed data models

The Data Dictionary is built from the latest matching audit logs in the selected date range and filters. To keep the page fast and responsive, the **dictionary is based on up to 500 audit logs**.

{% hint style="info" %}
**Sampling Limitation**

The available attributes and their detected types reflect the data found in that **500 audit log sample**. If your input or output model changed over time, the Data Dictionary may show attributes from the model version that appears in the selected audit logs. To inspect a specific model structure more accurately, narrow the date range or filter by a specific rule version.
{% endhint %}

#### (DD) Arrays and nested attributes

When an attribute contains an array, the Data Dictionary shows the array field itself and, when possible, also shows nested attributes found inside array items.

For example, if an input contains an array of customers, the dictionary may show the array field and also attributes found inside customer objects, such as customer ID, name, or status.

{% hint style="info" %}
**Array Inspection Limitation**

For performance and readability, array inspection is limited. The system samples only a small number of object items from arrays and only scans nested data up to a safe depth. This prevents very large or deeply nested arrays from slowing down the statistics page.
{% endhint %}

#### (DD) Bulk array behavior

For input data, top-level arrays are handled as bulk-style inputs. When you select an attribute inside a bulk array, statistics can count values from individual array items instead of treating the whole array as one single value.

For example, if one audit log contains an input array with multiple submitted records, selecting a field inside those records can include values from each item in the array. This helps analyze batch or bulk rule executions more naturally.

For output data, statistics use the first output object when the stored output is wrapped in an array. This keeps output analysis consistent with the main rule result structure.

## Main Visualizations

After selecting an attribute, multiple visualization types become available:

{% content-ref url="frequency-distribution.md" %}
[frequency-distribution.md](frequency-distribution.md)
{% endcontent-ref %}

{% content-ref url="time-series.md" %}
[time-series.md](time-series.md)
{% endcontent-ref %}

{% content-ref url="raw-data-table.md" %}
[raw-data-table.md](raw-data-table.md)
{% endcontent-ref %}

### Rule Comparison (RC)

Statistics support side-by-side comparison of two rules.

To enable comparison:

1. Enable the comparison switch.
2. Select a secondary rule.
3. Optionally choose a different date range for the secondary rule.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.41.50.png" alt=""><figcaption></figcaption></figure>

The system will display comparative visualizations whenever possible.

#### (RC) Attribute Compatibility

If the selected attribute does not exist in both rules, comparison cannot be performed for that attribute. In such cases, only the primary rule's statistics will be displayed.

### Summary Statistics

Three summary metrics are automatically generated based on the selected attribute type.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.49.02.png" alt=""><figcaption></figcaption></figure>

#### Number Attributes

* Minimum
* Maximum
* Average

#### Boolean Attributes

* True Count
* False Count
* True Rate

#### Date Attributes

* Earliest
* Latest
* Count

#### Object Attributes

* Filled Values
* Average Keys
* Max Keys

#### Array Attributes

* Filled Values
* Average Items
* Max Items

#### Mixed-Type Attributes

* Dominant Type
* Filled Values
* Missing Values

#### Unknown Attributes

* Filled Values
* Missing Values
* Total Records

#### String Attributes

* Unique Values
* Most Common
* Count

### Exporting Data

Statistics can be exported to CSV format for further analysis.

The export is downloaded as a ZIP file containing two files: one with the exported data and one with metadata describing the export.

**Supported exports include**:

* Frequency Distribution data
* Time Series data
* Raw Data Table data

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.50.01.png" alt=""><figcaption></figcaption></figure>
