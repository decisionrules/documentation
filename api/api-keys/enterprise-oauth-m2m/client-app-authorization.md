# Client App Authorization

To authorize your requests to the DecisionRules API using OAuth 2.0, you can include your generated access token directly in the `Authorization` header of your HTTP request.

***

#### Header Format

The `Authorization` header must be formatted as follows, using the prefix `oauth:` followed immediately by your access token:

`Authorization: oauth:<access_token>`

* `<access_token>`: Replace this placeholder with the actual OAuth 2.0 access token you received during the authorization process.

***

#### Example

If your access token is `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eW91ckFjY2Vzc1Rva2Vu`, the complete header would look like this:

| **Header**      | **Value**                                                         |
| --------------- | ----------------------------------------------------------------- |
| `Authorization` | `oauth:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eW91ckFjY2Vzc1Rva2Vu` |

This format is typically used when making calls to secure endpoints, ensuring that the request is properly authenticated.

```ara
curl --request POST \
  --url http://api.decisionrules.io/rule/solve/my-rule-alias/1 \
  --header 'Authorization: oauth:eyJ0eXAiOiJKV1QiLCJhbGc.....' \
  --header 'Content-Type: application/json' \
  --header 'X-Strategy: STANDARD' \
  --data '{
  "data": {
    "productType": "medium",
    "period": "year",
    "promoCode": "SUMMER SALE"
  }
}'
```





Would you like to see an example of an API call using this authorization method?
