# Frequency Distribution

Frequency Distribution shows how often each unique value appears within the selected audit logs.

It groups audit logs by the selected field and counts the number of occurrences for each value, making it easy to understand the composition of your data and identify the most and least frequent values.

Examples:

* Distribution of HTTP status codes
* Distribution of customer segments
* Distribution of decision outcomes
* Distribution of rule aliases
* Distribution of users or API keys

This visualization is useful for:

* Identifying the most common values
* Detecting outliers or unexpected values
* Understanding the overall composition of audit data
* Comparing how values are distributed across different datasets or time periods

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.55.17.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Visualization Limitation**

When more than **10,000** audit logs match the selected filters, statistics are calculated from a sampled subset of records to maintain performance. The sample is intended to be representative but may not perfectly reflect the full dataset.
{% endhint %}

{% hint style="info" %}
**Export Limitation**

Exports use the same sampled dataset as the visualization, so exported results reflect the same limitation of **10,000**.
{% endhint %}

