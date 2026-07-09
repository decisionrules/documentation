# Time Series

Time Series visualizations show how a selected metric changes over time.

Audit logs are grouped into time intervals (for example, hours, days, or months), and a metric is calculated for each interval. Depending on the selected metric, the chart can display the number of audit logs, or the average, minimum, or maximum value of a numeric field.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 17.00.12.png" alt=""><figcaption></figcaption></figure>

Examples:

* Number of executions per day
* Average order amount over time
* Average response time by day
* Maximum execution time per hour
* Error rates across days

This visualization is useful for:

* Monitoring trends over time
* Detecting spikes, drops, and anomalies
* Comparing activity across different periods
* Identifying recurring patterns or seasonality
* Evaluating the impact of deployments, configuration changes, or incidents

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.55.30.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Visualization Limitation**

When more than **10,000** audit logs match the selected filters, statistics are calculated from a sampled subset of records to maintain performance. The sample is intended to be representative but may not perfectly reflect the full dataset.
{% endhint %}

{% hint style="info" %}
**Export Limitation**

Exports use the same sampled dataset as the visualization, so exported results reflect the same limitation of **10,000**.
{% endhint %}

