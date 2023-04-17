---
description: >-
  You can find here how to set up the Database (Azure Cosmos DB) on Azure for
  working with DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Database / Azure Cosmos DB

## How to connect DecisionRules to Cosmos DB

{% hint style="info" %}
If you use Cosmos DB you need to specify the DB\_TYPE environmental variable. More information you can find here: [containers-environmental-variables.md](../containers-environmental-variables.md "mention")
{% endhint %}

### Select API option <a href="#37899927-b338-4654-8ab6-f91693c87229" id="37899927-b338-4654-8ab6-f91693c87229"></a>

* **Azure Cosmos DB API for MongoDB**

### Basics

* **Resource group:** same as used for DecisionRules WebApp
* **Account Name:** any
* **Location:** same as used for DecisionRules WebApp
* **Capacity mode:** Provisioned throughput / Serverless
* **Version:** 4.2 OR 4.0

Recommended Capacity mode is Serverless due to the lower operating costs.\
If you choose Provisioned throughput variant then the Throughput Limit has to be set to minimum 12 000 RU

### Global Distribution

* **Geo-Redundancy:** any
* **Multi-region Writes:** any

### Networking

* **Connectivity method:** any

### Backup policy

* **Backup policy:** any
* **Backup interval:** any
* **Backup retention:** any
* **Copies of data retained:** any
* **Backup storage redundancy:** any

### Encryption

* **Data Encryption:** any

## Connecting string for Environmental Variables

#### Where to find a connection string

* Settings -> Connection String -> PRIMARY CONNECTION STRING / SECONDARY CONNECTION STRING

