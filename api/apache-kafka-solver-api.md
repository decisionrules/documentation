---
coverY: 0
---

# Apache Kafka Solver API

![](../.gitbook/assets/apache_kafka-ar21.svg)

DecisionRules.io supports asynchronous calls to the Rule Solver. This option should be used if your infrastructure is based on asynchronous message processing.

## Setting up Apache Kafka Solver API

{% hint style="success" %}
Kafka Solver API is now available both in the cloud and on-premises.
{% endhint %}

### Before you start using the Kafka Solver API

{% hint style="info" %}
In the cloud, it is necessary to enable Kafka Solver for a specific customer manually. If you are interested, please contact us at sales@decisionrules.io
{% endhint %}

1. Request access rights for your client application to the DecisionRules Kafka Cluster at sales@decisionrules.io
2. Configure the connection of your client application to the Kafka cluster.
3. Register on the assigned Kafka topic, where you will receive the results.
4. Sending input data to the input Kafka Topic, from which DecisionRules takes it.

### How to communicate from a client application using Kafka Messsages

DecisionRules.io always uses two Kafka topics to communicate with the client application.

* **Response Topic (read-only)**
  * Topic on which your client application listens
  * You will receive the evaluated data in this topic
* **Request Topic (write)**
  * Kafka Topic into which you write data for evaluating DecisionRules
  * DecisionRules is listening on this topic

| Name           | Example Topic Name                  | Permissions |
| -------------- | ----------------------------------- | ----------- |
| Request Topic  | {company}-{random\_number}-request  | WRITE       |
| Response Topic | {company}-{random\_number}-response | READ        |

### Producing data to Request Topic

#### Message Headers

| Header                 | Description                                                                                                                         |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| api-key                | <p>(mandatory)</p><p>Solver API Key. Generate your api key in the <a href="https://app.decisionrules.io/api-keys">dashboard</a></p> |
| rule-id OR ruleflow-id | <p>(mandatory)</p><p>Rule or RuleFlow ID</p>                                                                                        |
| x-correlation-id       | <p>(optional)</p><p>User-generated ID to help you correlate input and output data.</p>                                              |
| version                | <p>(optional) </p><p>Version of the rule you want to solve.</p>                                                                     |

#### Message Data

| Message Attribute | Description                                                               |
| ----------------- | ------------------------------------------------------------------------- |
| Key               | \<empty>                                                                  |
| Value             | JSON object filled according to the data model called by Rule or RuleFlow |

#### Example Request Data

{% code title="Message Value Example (JSON Object)" %}
```json
{
  "client": {
    "age": 12
  }
}
```
{% endcode %}

#### Message Data Schema

{% code title="Request Schema" %}
```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {},
  "required": []
}
```
{% endcode %}

### Consuming Data from Response Topic

| Attribute     | Type   | Description                                                                                                                                                                                                                                                                  |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| data          | Array  | Field filled with data according to the rule evaluation. One element in the array means one result. For example, if multiple rows are matched when evaluating a decision table, they are returned as array items                                                             |
| errors        | Array  | <p>If an error occurs in the evaluation for any reason, each error is added to the error field.</p><p>If there are no errors in the evaluation, the "errors" attribute is not returned.</p><p>The contents of the "data" field will be empty when any error is returned.</p> |
| correlationId | String | <p>(optional) If the "x-correlation-id" header was filled in the input message, this value is available in the output message.</p><p>If "x-correlation-id" is not filled in the input, the attribute is not present in the output.</p>                                       |

#### Example Response Data

{% code title="Single data" %}
```json
{
  "data": [
    {
      "totalProducts": 2,
      "amountPerProduct": 500,
      "segment": "mass-market",
      "profitability": 1.2
    }
  ],
  "correlationId": "ef429e33-f2c4-41ad-b9f3-cad12ea3b95e"
}
```
{% endcode %}

{% code title="Multiple data" %}
```json
{
  "data": [
    {
      "totalProducts": 2,
      "amountPerProduct": 500,
      "segment": "mass-market",
      "profitability": 1.2
    },
    {
      "totalProducts": 1,
      "amountPerProduct": 300,
      "segment": "mass-market",
      "profitability": 1.53
    }
  ],
  "correlationId": "12429e33-f2c4-41ad-b9f3-cad12ea3b95e"
}
```
{% endcode %}

{% code title="Error response" %}
```json
{
  "errors": [
    {
      "code": 500,
      "message": "This Rule Flow belongs to another user OR Rule Flow not found"
    }
  ],
  "data": [],
  "correlationId": "ef429e33-f2c4-41ad-b9f3-cad12ea3b95e"
}
```
{% endcode %}

#### Message Data Schema

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "data": {
      "type": "array",
      "items": [
        {
          "type": "object"
        }
      ]
    },
    "correlationId": {
      "type": "string"
    },
    "errors": {
      "type": "array",
      "items": [
        {
          "type": "object",
          "properties": {
            "code": {
              "type": "integer"
            },
            "message": {
              "type": "string"
            }
          },
          "required": [
            "code",
            "message"
          ]
        }
      ]
    }
  },
  "required": []
}
```
