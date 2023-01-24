---
description: CDN geography.
cover: >-
  https://images.unsplash.com/photo-1451187580459-43490279c0fa?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxnbG9iZXxlbnwwfHx8fDE2MzkxNTA0MzI&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Datacenters & Locations

DecisionRules automatically scale performance within a single location and, in the event of a failure, can immediately redirect requests to the nearest location.

![DecisionRules Datacenter Locations](../.gitbook/assets/path30.png)

### Can I reach certain location?

Decision Rules automatically selects a specific data center according to the caller's position or VPN position if used.



| Datacenter                                                               | Status                                           | Location Shorcut |
| ------------------------------------------------------------------------ | ------------------------------------------------ | ---------------- |
| ![](<../.gitbook/assets/image (174) (1).png>) Central Europe (Frankfurt) | <mark style="color:green;">✓</mark> Online       | eu-central-1     |
| ![](<../.gitbook/assets/image (190) (1) (1).png>) US East (N. Virginia)  | <mark style="color:green;">✓</mark> Online       | us-east-1        |
| ![](<../.gitbook/assets/image (190) (1) (1).png>) US West (Oregon)       | <mark style="color:green;">✓</mark> Online       | us-west-2        |
| ![](<../.gitbook/assets/image (175) (1).png>) Brazil (São Paulo)         | <mark style="color:green;">✓</mark> Online       | sa-east-1        |
| ![](<../.gitbook/assets/image (160) (1).png>) Australia (Sydney)         | <mark style="color:green;">✓</mark> Online       | ap-southeast-2   |
| ![](<../.gitbook/assets/image (192) (1).png>) Sweden (Stockholm)         | <mark style="color:green;">✓</mark> Online       | eu-north-1       |
| ![](<../.gitbook/assets/image (152).png>) South Korea (Seoul)            | <mark style="color:green;">✓</mark> Online       | ap-northeast-1   |
| ![](<../.gitbook/assets/south-africa (1).png>) South Africa (Cape Town)  | <mark style="color:green;">✓</mark> Online       | af-south-1       |
| ![](<../.gitbook/assets/image (162) (2).png>) UK (London)                | <mark style="color:yellow;">●</mark> In Progress | eu-west-2        |
| ![](<../.gitbook/assets/image (170) (1).png>) India (Mumbai)             | <mark style="color:yellow;">●</mark> In Progress | ap-south-1       |

{% hint style="info" %}
For Rule Solver set up, check our guide [**here**](rule-solver-api.md).
{% endhint %}
