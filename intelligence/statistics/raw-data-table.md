# Raw Data Table

The Raw Data Table displays the individual audit logs used for the current analysis, allowing you to inspect the underlying records behind aggregated visualizations.

Unlike charts, the Raw Data Table does not support comparison mode. It always displays audit logs for the **primary selected rule**.

Columns are generated from the selected **attributes in the Data Dictionary** and can be customized in the same way as the Audit Logs table by choosing which columns to display.

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 17.07.53 (2).png" alt=""><figcaption></figcaption></figure>

This view is useful for:

* Inspecting individual audit logs
* Verifying aggregated statistics
* Investigating specific records
* Exporting the displayed data

<figure><img src="../../.gitbook/assets/Screenshot 2026-07-09 at 14.56.19.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Visualization Limitation**

* Searching is performed on the latest **5,000** matching audit logs to ensure responsive query performance.
* Sorting by fields that cannot be efficiently indexed is also limited to the latest **5,000** matching audit logs to maintain system performance.
{% endhint %}

{% hint style="info" %}
**Export Limitation**

Exports use the same dataset as the table. If search or sorting is limited to **5,000** audit logs, the exported data reflects the same limitation. Otherwise, exports contain the latest **5,000** matching audit logs.
{% endhint %}
