---
description: Network prerequisites for Docker and On-Premise deployments.
---

# Prerequisites

## Docker Prerequisites

Before you deploy DecisionRules with Docker, make sure your environment allows outbound traffic to the required DecisionRules services.

### Required network access

Your server must be able to reach these endpoints:

{% hint style="warning" %}
If your environment uses a firewall, proxy, or outbound allowlist, you must allow traffic to both services before deployment.
{% endhint %}

#### License server

DecisionRules uses the license server to validate your license.

* URL: `https://license.decisionrules.io/`
* IP addresses:
  * `75.2.68.203`
  * `99.83.137.90`

**Offline license alternative**

If your environment cannot allow traffic to the license server, you can use an offline license instead.

See [Offline License](offline-license.md) for setup steps.

#### Distribution server

DecisionRules uses the distribution server to deliver the required distribution content.

* URL: `https://distribution.decisionrules.io/`
* IP addresses:
  * `166.117.101.202`
  * `166.117.209.110`
