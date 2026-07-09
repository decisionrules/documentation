# Audit Logs

The Audit Logs page provides a detailed view of all rule executions within the selected time period. It allows you to search, filter, sort, inspect, and manage audit records while giving full visibility into rule inputs, outputs, debug data, and metadata. Audit logs help you troubleshoot issues, validate business decisions, and understand how rules behave in production.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.33.43.png" alt=""><figcaption></figcaption></figure>

## Enabling or disabling audit logging

Audit log creation can be enabled or disabled in the Rule detail settings.

When Audit Logging is turned on, executions of the rule are stored as audit logs and can be reviewed later in the Audit Logs section. When it is turned off, new executions of the rule are not saved as audit logs.

You can also configure related audit log settings here, such as debug data, propagation to child rules, and audit lifespan.

## Search, Sort and Filtering

Audit logs can be narrowed down using several filtering options:

### Search

Use the search bar to quickly find audit records containing specific values.&#x20;

You can search by rule ID, rule name, rule alias, solver API key, or rule type, such as “decision table,” “decision tree,” or “decision flow.”

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.35.48.png" alt=""><figcaption></figcaption></figure>

### Sort

Audit logs can also be sorted by **Timestamp** to quickly identify the newest or oldest executions.

{% hint style="info" %}
Timestamps in the audit logs table and detail view are displayed in your local time zone.
{% endhint %}

### Column Selector

Choose which columns are displayed in the audit log table. This allows you to focus on the data most relevant to your investigation.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.39.47.png" alt=""><figcaption></figcaption></figure>



### Rule Filter

Filter audit logs by one or more rules to analyze executions for specific rules.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.43.29.png" alt=""><figcaption></figcaption></figure>



### Additional Filters

The **Other Filters** section provides additional filtering capabilities, including:

* HTTP Status Code
* Rule Status
* Correlation ID

These filters help isolate specific executions, failures and requests.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.45.04.png" alt=""><figcaption></figcaption></figure>



### Date Range Selection

Audit logs can be filtered using either:

* **Relative date ranges** (1 Day, 7 Days, This calendar month etc.)
* **Absolute date ranges** (custom start and end date/time)

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.46.20.png" alt=""><figcaption></figcaption></figure>

## Audit Log Details

Selecting a row opens a detailed side panel containing all information related to the selected execution.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.47.22.png" alt=""><figcaption></figcaption></figure>

Data is organized into the following sections:

* **Input** - Displays the input payload received by the rule.
* **Output** - Displays the result returned by the rule execution.
* **Debug** - Contains diagnostic information useful for troubleshooting and understanding rule evaluation behavior.
* **Metadata** - Displays execution metadata such as timestamps, status information, correlation identifiers, and other system-generated details including measurements.

### Delete Audit Logs

Audit data can be removed directly from the Audit Logs page.

* **Delete Selected** - Deletes only the audit records currently selected in the table.
* **Delete All / Filtered** - Deletes all audit records matching the currently applied filters and date range.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.55.11.png" alt=""><figcaption></figcaption></figure>

### Large Data Handling

{% hint style="info" %}
## Cursor Pagination

For large audit log datasets, the table uses cursor-based pagination to keep browsing fast and reliable, even when there are many records.

To protect performance, the total count is therefore capped at 100,000 records. If the selected filters match more than 100,000 audit logs, the table shows 100,000+ instead of the exact total. You can still continue browsing the results page by page, or narrow the date range and filters to work with a smaller, more specific dataset.

<img src="../.gitbook/assets/Screenshot 2026-07-09 at 12.56.06.png" alt="" data-size="original">
{% endhint %}
