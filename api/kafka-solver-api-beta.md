# Kafka Solver API (beta)

DecisionRules.io supports asynchronous calls to the Rule Solver. This option should be used if your infrastructure is based on asynchronous message processing.

{% hint style="info" %}
Kafka Solver API is currently in Beta state and is available only in the cloud version of DecisionRules.io
{% endhint %}

### Before you start using the Kafka Solver API

{% hint style="info" %}
In Beta version it is necessary to enable Kafka Solver for a specific customer manually at sales@decisionrules.io
{% endhint %}

1. Request access rights for your client application to the DecisionRules Kafka Cluster at sales@decisionrules.io
2. Configure the connection of your client application to the Kafka cluster.
3. Register on the assigned Kafka topic, where you will receive the results.
4. Sending input data to the input Kafka Topic, from which DecisionRules takes it.

### Information for connecting to Kafka Cluster

| Key                | Value                                           |
| ------------------ | ----------------------------------------------- |
| **broker**         | pkc-lq8v7.eu-central-1.aws.confluent.cloud:9092 |
| **ssl**            | true                                            |
| **sasl.mechanism** | plain                                           |
| sasl.username      | contact us on sales@decisionrules.io            |
| sasl.password      | contact us on sales@decisionrules.io            |

### Example Connection Config

Java Configuration

{% code title="config.properties" %}
```properties
# Required connection configs for Kafka producer, consumer, and admin
bootstrap.servers=pkc-lq8v7.eu-central-1.aws.confluent.cloud:9092
security.protocol=SASL_SSL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule   required username='{{ CLUSTER_API_KEY }}'   password='{{ CLUSTER_API_SECRET }}';
sasl.mechanism=PLAIN
# Required for correctness in Apache Kafka clients prior to 2.6
client.dns.lookup=use_all_dns_ips

# Best practice for Kafka producer to prevent data loss
acks=all

```
{% endcode %}

#### Python Configuration

{% code title="config.py" %}
```python
# Kafka
bootstrap.servers=pkc-lq8v7.eu-central-1.aws.confluent.cloud:9092
security.protocol=SASL_SSL
sasl.mechanisms=PLAIN
sasl.username={{ CLUSTER_API_KEY }}
sasl.password={{ CLUSTER_API_SECRET }}
```
{% endcode %}

### How to communicate from a client application using Kafka Messsages

DecisionRules.io always uses two Kafka topics to communicate with the client application.

* **Response Topic**
  * Topic on which your client application listens
  * You will receive the evaluated data in this topic
* **Request Topic**
  * Kafka Topic into which you write data for evaluating DecisionRules
  * DecisionRules is listening on this topic

| Name           | Example Topic Name                 | Permissions |
| -------------- | ---------------------------------- | ----------- |
| Request Topic  | {company}-{random_number}-request  | WRITE       |
| Response Topic | {company}-{random_number}-response | READ        |



