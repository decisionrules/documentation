---
description: Manual to setting decisionrules in AWS Fargate
cover: >-
  https://images.unsplash.com/photo-1613690399151-65ea69478674?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw3fHxDb250YWluZXJ8ZW58MHx8fHwxNjM4MTgxNzEy&ixlib=rb-1.2.1&q=85
coverY: 0
---

# AWS Fargate/Elastic Container Service

## Decisionrules/server container settings

### Technical requirements

* RAM: 200Mb for 1 Worker

### Container Settings

#### Port Mapping

Set port mappings to 8080 and protocol TCP.

![](<../../.gitbook/assets/image (151) (1) (1) (1).png>)

#### Health check

{% code title="Command" %}
```shell
CMD-SHELL curl -s --fail http://localhost:8080/health-check || exit 1
```
{% endcode %}

|   Variable   | Recommended value |
| :----------: | :---------------: |
|   Interval   |         30        |
|    Timeout   |         5         |
| Start period |         30        |
|    Retries   |         3         |

![](<../../.gitbook/assets/image (149).png>)

### Cluster Service settings

For successful deploy is necessary to change the Cluster Service Health check grace period.

#### Settings

1. Go to Elastic Container Service in AWS Management Console
2. Select cluster
3. Select service
4. Click on Update
5. Go to Step 2: Configure Network
6. Set Health check grade period to **30**

![](<../../.gitbook/assets/image (152) (1) (1) (1).png>)

### Load Balancer

For successful deploy is necessary to change the Load Balancer Target Group health check.

#### Settings

1. Go to EC2 in AWS Management Console
2. In Load Balancing choose Target Groups
3. Select specific Target Group
4. Select Health Checks tab
5. Click on Edit
6. Enter Health check path: `/health-check`

![](<../../.gitbook/assets/image (148) (1).png>)

## Decisionrules/client container settings

### Technical requirements

* RAM: 100Mb

### Container Settings

#### Port Mapping

Set port mappings to 80 and protocol TCP.

![](<../../.gitbook/assets/image (153) (1).png>)

#### Health Check

{% code title="Command" %}
```
CMD-SHELL curl -s --fail http://localhost/ || exit 1
```
{% endcode %}

|   Variable   | Recommended value |
| :----------: | :---------------: |
|   Interval   |         30        |
|    Timeout   |         5         |
| Start period |         30        |
|    Retries   |         3         |

![](<../../.gitbook/assets/image (150) (1).png>)
