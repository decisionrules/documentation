# Deprecated Endpoints

### Get Audit Logs

This endpoint allows you to fetch audit logs from your rule solver, including metadata of the solver run as well as the input and output data.

{% hint style="info" %}
The rule solver does not generate audit logs by default. If you want some rule to generate audits on each solve, you have to **turn on audit logs** in its Rule Settings. More information can be found on the [Audit Logging](../../business-intelligence/audit-logs.md) Page.
{% endhint %}

{% swagger src="https://bi.decisionrules.io/api/docs/json" path="/audit" method="get" %}
[https://bi.decisionrules.io/api/docs/json](https://bi.decisionrules.io/api/docs/json)
{% endswagger %}

{% swagger src="https://bi.decisionrules.io/api/docs/json" path="/audit" method="delete" %}
[https://bi.decisionrules.io/api/docs/json](https://bi.decisionrules.io/api/docs/json)
{% endswagger %}

### Pagination v1

There can be a lot of audit logs in the database, of course. We therefore enforce a maximum page size, e.g. the number of audit logs that can be returned per one request. The maximum page size is 1.000, which means that you can never get more audits than 1.000 per one call.

#### Page Size

You can choose a custom page size smaller than 1.000 by defining the `page_size` query parameter. For example, if you set `page_size=100`, the API will always return maximum 100 audits per request, no matter how many matching audits there are in the database. If not set, the page size defaults to 1.000.

#### Page

To get more audit logs than those that can fit on one page, you can use the `page` parameter. For example, if you set `page_size=100&page=2`, you will get audits 101 - 200, while a request with `page_size=100&page=3` yields audits 201 - 300. etc. If not set, page defaults to 1 so you get the first page.

#### Limit

You can also specify the total limit on the number of audits by setting the `limit` parameter. If set, the API will never fetch any further audits than that with index equal to the limit. For example, a request with `page_size=100&page=2&limit=150` yields only the audits 101 - 150, while `page_size=100&page=3&limit=150` returns just an empty array of audits because you have exceeded your limit. There is no limit by default.

Request example

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

#### BI Key

If you cannot send the Business Intelligence API Key inside the authorization header, you may use the `bi_key` query parameter; e.g. `bi_key=DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH`. In that case, the request could look as follows.

```http
URL
https://bi.decisionrules.io/audit?limit=1&bi_key=DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH

Headers:
Content-Type: application/json
```

If the `bi_key` query parameter is not set, the server will look for the authorization header as described above.

#### Response example

```javascript
{
    "audits": [
        {
            "correlationId": "7bac2e34-53c6-cbb0-d898-87f46ad50f77",
            "guid": "b88ba671-eae9-05e8-a547-f54d0cdedba7",
            "baseId": "d58e2518-57f6-a315-2458-b931b45cb543",
            "version": 1,
            "type": "decision-table",
            "status": "published",
            "outputSchema": {
                "finalPrice": {},
                "message": {}
            },
            "createdIn": "2022-06-28T13:22:11.875Z",
            "inputSchema": {
                "benefitCode": {},
                "promoCode": {},
                "price": {}
            },
            "tags": [
                "Benefit"
            ],
            "name": "Benefit Program",
            "lastUpdate": "2022-06-28T13:22:11.875Z",
            "solverKey": "QyjvIdGhdDgUP6_Lebo2DOyYaoSIA0axZlVcRrxbJzHazTOMn03GA5kiuIzgIw5z",
            "inputData": {
                "benefitCode": "SUMMER",
                "promoCode": {},
                "price": {}
            },
            "outputData": [
                {
                    "finalPrice": {},
                    "message": "discount 30%"
                },
                {
                    "finalPrice": {},
                    "message": "no discount"
                }
            ],
            "executionTime": 1,
            "statusCode": 200,
            "errorMessage": null,
            "debugData": null,
            "timestamp": "2022-06-28T13:22:28.579Z"
        }
    ]
}
```
