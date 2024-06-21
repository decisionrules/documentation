---
description: The Business Intelligence API allows to get audit logs from the rule solver.
cover: ../../.gitbook/assets/photo-1551288049-bebda4e38f71.avif
coverY: 0
---

# Business Intelligence API

The Business Intelligence API is providing the business intelligence functionalities of DecisionRules. Most importantly, it allows to collect data from the rule solver.

## About the Business Intelligence API

The API allows you to get audits from database and delete them from the database when they are no longer needed. We describe both endpoints below.

{% hint style="info" %}
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../../regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

{% hint style="danger" %}
Please note that anyone with access to a Business Intelligence API Key can also inherently access your Solver keys, as Audit Logs keep record of the Solver key used for the Solver invocation.
{% endhint %}

{% hint style="info" %}
You need to copy paste your own Business Intelligence API Key after `Bearer` . If you do not have it yet, generate your Business Intelligence API Key [in the app](https://app.decisiongrid.io/api-keys).
{% endhint %}

The Business Intelligence API Key can be also included in a query parameter instead of the header. In that case, the same request would look as follows.

{% hint style="info" %}
The rule solver does not generate audit logs by default. If you want some rule to generate audits on each solve, you have to **turn on audit logs** in its Rule Settings. More information can be found on the [Audit Logging](../../business-intelligence/audit-logs.md) Page.
{% endhint %}

## Endpoints:

{% swagger src="https://bi.decisionrules.io/api/docs/json" path="/audit/v2" method="get" %}
[https://bi.decisionrules.io/api/docs/json](https://bi.decisionrules.io/api/docs/json)
{% endswagger %}

{% swagger src="https://bi.decisionrules.io/api/docs/json" path="/audit/v2/count" method="get" %}
[https://bi.decisionrules.io/api/docs/json](https://bi.decisionrules.io/api/docs/json)
{% endswagger %}

{% swagger src="https://bi.decisionrules.io/api/docs/json" path="/audit/v2" method="delete" %}
[https://bi.decisionrules.io/api/docs/json](https://bi.decisionrules.io/api/docs/json)
{% endswagger %}

{% hint style="warning" %}
This action results in permanent and irreversible disposal of the deleted audit logs. Please, use it carefully. More information can be found on the [Audit Logging](../../business-intelligence/audit-logs.md#deleting-audit-logs) page.
{% endhint %}

### Pagination <a href="#pagination" id="pagination"></a>

There can be a lot of audit logs in the database, of course. We therefore restrict the maximum page size, i.e., the number of audit logs that can be returned per one request, to 1.000.

To get the next page of your audit logs simply add the query parameter 'after' to your call and provide it with the cursor returned in the previous call.

**Page Size**

You can choose a custom page size smaller than 1.000 by defining the `page_size` query parameter. For example, if you set `page_size=100`, the API will always return maximum 100 audits per request, no matter how many matching audits there are in the database. If not set, the page size defaults to 1.000.

**After**

Each Audit Log has a unique identifier called "positionId." When you include the "after" query parameter in your request and set its value to a specific Audit Log's "positionId," the response will contain the set of Audit Logs that immediately follow the provided "positionId."

_Example:_ If you want to retrieve the Audit Logs that come after a specific log, use its "positionId" as the value for the "after" parameter in your request.

### Filters <a href="#filters" id="filters"></a>

The rest of the query parameters work as filters that help you specify the desired audits. These filters work the same for both the Retrieve and Count audit logs endpoints.

**Correlation IDs**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs, Delete Audit Logs`

When calling the [Rule Solver API](https://docs.decisionrules.io/doc/\~/changes/VuchuDyabVa3NSXAKjpZ/api/rule-solver-api), the solver provides the audit log with the so-called correlation ID. This can happen in two distinct ways. If the request to the solver contains the **X-Correlation-Id** header, the value of this header is simply passed to the correlation ID of the audit log. If the request to the solver does not contain such header, the solver generates its own (unique) correlation ID.

Note that, in both cases, the solver returns the correlation ID in the **X-Correlation-Id** header of the response.

The correlation ID can then be used to get the desired audit log related to a particular solver request. This can be done easily by including the `correlation_ids` parameter. It takes an array of correlation IDs separated by a comma, e.g. ., `correlation_ids=af4012bd-d492-92ec-ffa4-31fd2b70b1bc,197d5d5a-f6f7-35de-1afb-dc26237ebfc9`.

**Rules**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs, Delete Audit Logs`

If set, the `rules` parameter limits the audits to those produced by the specified rules. The individual rules are identified by ids separated by comma, i.e., `rules=af4012bd-d492-92ec-ffa4-31fd2b70b1bc,197d5d5a-f6f7-35de-1afb-dc26237ebfc9`. Moreover, one may further specify the allowed versions for each of the rules by including square brackets with the comma separated list of versions. For instance, `rules=af4012bd-d492-92ec-ffa4-31fd2b70b1bc[1,2],197d5d5a-f6f7-35de-1afb-dc26237ebfc9` will return audits for rules with id `af4012bd-d492-92ec-ffa4-31fd2b70b1bc` whose version is either 1 or 2 and audits for rules with id `197d5d5a-f6f7-35de-1afb-dc26237ebfc9` of any version.

It is also possible to filter solemnly by rule versions. To do that, use the square bracket expression without specifying rule IDs. For instance, `rules=[1,2]` will return audit logs for rules whose version is 1 or 2, no matter the rule ID.

**Solver Keys**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs`

If set, the `solver_keys` parameter limits the audits to those produced by calling rules with the specified Solver API Key. The individual keys are separated by comma.

**Tags**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs`

The `tags` query parameter allows you to filter the audits by tags present on the rules. For the audit to pass the filter, its rule needs to be decorated with **all the tags** specified in the query parameter. The tags are separated by comma. For example, a request with `tags=Pricing,Test` returns only audits from rules decorated by both the **Pricing** and the **Test** tag.

**Date**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs, Delete Audit Logs`

The `date_gte` and `date_lte` parameters allow to filter audit logs by date (and time). The former serves as a lower bound on the date of the solve, the latter serves as an upper bound. In other words, audits will match this filter only if they are older than `date_gte` and younger than `date_lte`. When specifying one or both of the parameters, you can choose from a number of supported formats, including ISO 8601 and RFC 2822 Date time. For example:

```
2013-02-08
2013-02
2013-02-08 09
2013-02-08 09:30
2013-02-08 09:30:26.123
2013-02-08 09+07:00
2013-02-08 09Z
2013-02-08 09:30:26.123+07:00
...
6 Mar 17 21:22 UT
d6 Mar 2017 21:22:23 GMT
Mon, 06 Mar 2017 21:22:23 +0000
...
```

Note that special characters have to be URL encoded when passed to the query parameter. Therefore, when writing your date, please replace these characters with their respective codes. We list the most useful characters and their codes below.

```
space    %20
:        %3A
+        %2B
```

**Order**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs`

The `order` parameter can take two values, `order=asc` or `order=desc`. It specifies the chronological order of the audits returned. For `order=asc`, the audits are sorted chronologically, starting with the oldest. For `order=desc`, they are sorted chronologically, starting with the latest. By default, the audits are returned in ascending order.

**Status Codes**

`Usable in endpoints: Retrieve Audit Logs, Count Audit Logs, Delete Audit Logs`

If set, the `status_codes` parameter limits the audit logs to those produced with the specified status code. The individual codes are separated by comma. For example, to get logs from rule solves that returned OK, use `status_codes=200`. To get audit logs from rule solves that returned some kind of rule error, use `status_codes=400, 401, 404, 406, 426`. Eventually, to get audit logs from rule solves that returned server error, use `status_codes=500`.

**Fields**

`Usable in endpoints: Retrieve Audit Logs`

If set, the `fields` parameter describes which fields of the audit logs to return. For example, if we only need the input data of each audit log we can set `fields=inputData`. Every field of audit logs can be filtered like this. If we want multiple fields to return we can separate the definitions with a comma. `fields=inputData, outputData, ruleAlias` - This example would return audit logs with only the input and output data as well as the ruleAlias.

(To specify the debugLog field, provide the "debugLogId" string)
