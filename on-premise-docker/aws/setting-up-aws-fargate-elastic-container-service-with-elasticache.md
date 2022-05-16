---
description: >-
  On this page you can find information about how to set AWS Fargate with
  Elastic Cache.
cover: >-
  https://images.unsplash.com/photo-1613690399151-65ea69478674?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw1fHxjb250YWluZXJ8ZW58MHx8fHwxNjUyNjg0MTM5&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Setting up AWS Fargate / Elastic Container Service with ElastiCache

To run the DecisionRules you have to have a Redis. If you deploy the DecisionRules on the AWS you can use **AWS ElastiCache**.

AWS ElastiCache is a fully managed, in-memory caching service supporting flexible, real-time use cases. ElasticCache supports 2 engines: **Redis** and **Memcached**. In our case, we will use Redis Engine.

## Creating and using ElastiCache

### Before creating ElastiCache

Before you will create your ElastiCache. It is recommended to create a new ElastiCache parameter group with some changes.

For the best working it is recommended to change these values:

* maxmemory-policy: allkeys-lfu

### Creating ElastiCache

To create ElastiCache for DecisionRules, there are some recommended values:

* **Engine**: Redis
* **Engine version**: 6 and newer
* **Port**: 6379
* **Number of replicas**: 2
* **Multi-AZ**: Yes
* **Advanced Redis settings:**
  * Subnet group: Same as DecisionRules server app
  * **Availability zones placement**: No preference
* **Security:**
  * Security groups: Same as DecisionRules server app
  * **Encryption at-rest**: No
  * **Encryption in-transit**: No

### Mandatory values

You have to specify the same **Subnet group** and **Security group** which you use for your DecisionRules server app. As well ElastiCache has to be created in the same region as the DecisionRules server app.

### Use ElastiCache with DecisionRules

After you have created your ElastiCache, the DecisionRules is ready to be used. There is one last simple step, you need to copy ElastiCache **Primary Endpoint** and insert it into DecisionRules server app **REDIS\_URL** environmental variable in the following format `redis://primary_endpoint`
