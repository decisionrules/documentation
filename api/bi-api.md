---
description: The Business Intelligence API allows to get audit logs from the rule solver.
cover: ../.gitbook/assets/photo-1551288049-bebda4e38f71.avif
coverY: 0
---

# Business Intelligence API

{% hint style="warning" %}
This feature is coming soon!
{% endhint %}

The Business Intelligence API is providing the business intelligence functionalities of DecisionRules. Most importantly, it allows to collect data from the rule solver.

## About the Business Intelligence API

Currently, the API has a single endpoint called audit.

### Audit

This endpoint allows you to fetch audit logs from your rule solver, including metadata of the solver run, the input and output data.

{% hint style="info" %}
The rule solver does not generate audit logs by default. If you want some rule to generate audits on each solve, you have to **turn on audit logs** in its Rule Settings.
{% endhint %}

{% swagger src="../.gitbook/assets/audit swagger.json" path="audit" method="get" %}
[audit swagger.json](<../.gitbook/assets/audit swagger.json>)
{% endswagger %}

#### Request example

```http
URL
https://bi.decisionrules.io/audit?limit=1

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

{% hint style="info" %}
You need to copy paste your own Business Intelligence API Key after `Bearer` . If you do not have it yet, generate your Business Intelligence API Key [in the app](https://app.decisiongrid.io/api-keys).
{% endhint %}

The Business Intelligence API Key can be also included in a query parameter instead of the header. In that case, the same request would look as follows.

```http
URL
https://bi.decisionrules.io/audit?limit=1&bi_key=DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH

Headers:
Content-Type: application/json
```

#### Response

```javascript
{
    "audits": [
        {
            "correlationId": "a3bc1efd-fa7a-6690-c6bc-049b0d4490bf",
            "guid": "f5264aa3-bb40-a18b-ea72-d27de936cf46",
            "baseId": "3f15a167-8425-16df-e27d-eae074894dfb",
            "version": 1,
            "type": "decision-table",
            "status": "published",
            "outputSchema": {
                "prices": {
                    "original": {},
                    "service": {},
                    "total": {},
                    "final": {}
                },
                "message": {}
            },
            "createdIn": "2022-05-13T07:40:07.433Z",
            "inputSchema": {
                "period": {},
                "productType": {},
                "promoCode": {},
                "price": {}
            },
            "tags": [
                "Audit"
            ],
            "name": "Audit Sample",
            "lastUpdate": "2022-05-26T09:58:20.212Z",
            "apiKey": "QyjvIdGhdDgUP6_Lebo2DOyYaoSIA0axZlVcRrxbJzHazTOMn03GA5kiuIzgIw5z",
            "inputData": {
                "productType": "basic",
                "period": "year",
                "promoCode": "SUMMER SALE",
                "price": 320
            },
            "outputData": [
                {
                    "prices": {
                        "original": 320,
                        "service": 72,
                        "total": 392,
                        "final": 274.4
                    },
                    "message": "30% discount"
                }
            ],
            "timestamp": "2022-06-01T11:44:21.005Z"
        }
    ]
}
```

### Query Parameters

There is a number of optional query parameters that can be used to filter the audit logs (audits). Their list and meaning is provided blow.

| **Query parameter name** | **Meaning**                                                       |
| ------------------------ | ----------------------------------------------------------------- |
| bi\_key                  | The Business Intelligence API Key                                 |
| page                     | The index of the page of audits                                   |
| page\_size               | The size of the page (number of audits)                           |
| limit                    | The total limit of audits requested                               |
| correlation\_ids         | The list of correlation IDs                                       |
| rules                    | The list of ids of the solved rules and optionally their versions |
| solver\_keys             | The solver keys used to call the rules                            |
| tags                     | The tag list of the solved rules                                  |
| date\_gte                | Lower bound on the date of the solve                              |
| date\_lte                | Upper bound on the date of the solve                              |
| order                    | The chronological order of audits                                 |

The exact meaning of the parameters is explained in the following sections.

### Authorization

Every request to the Business Intelligence API needs to be authorized by the Business Intelligence API Key.

#### BI Key

If you do not want to send the Business Intelligence API Key inside the authorization header, you may use the `bi_key` query parameter; e.g. `bi_key=DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH`. If not set, the server will look for the authorization header as described above.

### Pagination

There can be a lot of audits in the database, of course. We therefore enforce a maximum page size, e.g. the number of audits that can be returned per one request. The maximum page size is 1.000, which means that you can never get more audits than 1.000 per one call.

#### Page Size

You can choose a custom page size smaller than 1.000 by defining the `page_size` query parameter. For example, if you set `page_size=100`, the API will always return maximum 100 audits, no matter how many matching audits there are in the database. If not set, the page size defaults to 1.000.

#### Page

To get more audit logs than those that can fit on one page, you can use the `page` parameter. For example, if you set `page_size=100&page=2`, you will get audits 101 - 200, while a request with `page_size=100&page=3` yields audits 201 - 300. etc. If not set, page defaults to 1 so you get the first page.

#### Limit

You can also specify the total limit on the number of audits by setting the `limit` parameter. If set, the API will then never fetch any further audits than that with index equal to the limit. For example, a request with `page_size=100&page=2&limit=150` yields only the audits 101 - 150, while `page_size=100&page=3&limit=150` returns just an empty array of audits.

### Filters

The rest of the query parameters work as filters that help you specify the desired audits.

#### Correlation IDs

When calling the [Rule Solver API](rule-solver-api.md), the solver provides the audit log with the so-called correlation ID. This can happen in two distinct ways. If the request to the solver contains the **X-Correlation-Id** header, the value of this header is simply passed to the correlation ID of the audit log. If the request to the solver does not contain such header, the solver generates its own (unique) correlation ID.

{% hint style="info" %}
Note that, in both cases, the solver returns the correlation ID in the **X-Correlation-Id** header of the response.
{% endhint %}

The correlation ID can then be used to get the desired audit log related to a particular solver request. This can be done easily by including the `correlation_ids` parameter. It takes an array of correlation IDs separated by a comma, e.g. ., `correlation_ids=af4012bd-d492-92ec-ffa4-31fd2b70b1bc,197d5d5a-f6f7-35de-1afb-dc26237ebfc9`.

#### Rules

If set, the `rules` parameter limits the audits to those produced by the specified rules. The individual rules are identified by ids separated by comma, i.e., `rules=af4012bd-d492-92ec-ffa4-31fd2b70b1bc,197d5d5a-f6f7-35de-1afb-dc26237ebfc9`. Moreover, one may further specify the allowed versions for each of the rules by including square brackets with the comma separated list of versions. For instance, `rules=af4012bd-d492-92ec-ffa4-31fd2b70b1bc[1,2],197d5d5a-f6f7-35de-1afb-dc26237ebfc9` will return audits for rules with id  `af4012bd-d492-92ec-ffa4-31fd2b70b1bc` whose version is either 1 or 2 and audits for rules with id `197d5d5a-f6f7-35de-1afb-dc26237ebfc9` of any version.

#### Solver Keys

If set, the `solver_keys` parameter limits the audits to those produced by calling rules with the specified Solver API Key. The individual keys are separated by comma.

#### Tags

The `tags` query parameter allows you to filter the audits by tags present on the rules. For the audit to pass the filter, its rule needs to be decorated with **all the tags** specified in the query parameter. The tags are separated by comma. For example, a request with `tags=Pricing,Test` returns only audits from rules decorated by both the <mark style="background-color:green;">**Pricing**</mark> and the <mark style="background-color:purple;">**Test**</mark>**  **<mark style="background-color:yellow;">****</mark> tag.

#### Date

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

{% hint style="info" %}
Note that special characters have to be URL encoded when passed to the query parameter. Therefore, when writing your date, please replace these characters with their respective codes. We list the most useful characters and their codes below.
{% endhint %}

```
space    %20
:        %3A
+        %2B
```

#### Order

The `order` parameter can take two values, `order=asc` or `order=desc`. It specifies the chronological order of the audits returned. For `order=asc`, the audits are sorted chronologically, starting with the oldest. For `order=desc`, they are sorted chronologically, starting with the latest. By default, the audits are returned in ascending order.

#### Request example with query parameters

Finally let us give an example of a request to the Business Intelligence API with a few optional query parameters.

```http
URL
https://bi.decisionrules.io/audit?page_size=100&page=2&tags=Pricing&date_gte=2022-01-01&date_lte=2022-31-12

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

{% hint style="info" %}
You need to copy paste your own Business Intelligence API Key after `Bearer` . If you do not have it yet, generate your Business Intelligence API Key [in the app](https://app.decisiongrid.io/api-keys).
{% endhint %}

The above request will get audit logs from all solver runs in the given time period (year 2022) of all rules with tag <mark style="background-color:green;">**Pricing**</mark> . We specify that the page size is 100 and we want the second page, i.e., we get audits 101 - 200 (if they are in the database, of course).
