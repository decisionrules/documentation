---
description: >-
  DecisionRules offers different types of SLA. Community Support, Standard
  Cloud, Large Cloud, and in case we are not matching with your expectations,
  there is also the possibility of the Custom SLA
cover: >-
  https://images.unsplash.com/photo-1517048676732-d65bc937f952?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw1fHxjb21tdW5pdHl8ZW58MHx8fHwxNjM4OTU0NDM0&ixlib=rb-1.2.1&q=85
coverY: -78.33128834355828
---

# Standard Cloud (SaaS)

{% hint style="info" %}
Other SLA: [Community Support](community-support-and-standard-cloud.md) and [Custom SLA](custom-sla.md).
{% endhint %}

Standard Cloud SLA are described in the table below.

|                   Severity                   |        Response        |                 Resolution                |
| :------------------------------------------: | :--------------------: | :---------------------------------------: |
|                                              | **Max. response time** |          **Max. resolution time**         |
|                 **Critical**                 |           24h          |                     3d                    |
|                   **High**                   |           24h          |                     5d                    |
|                  **Medium**                  |           48h          |                    10d                    |
|                    **Low**                   |           48h          |                    21d                    |
|                                              |                        |                                           |
| **Available in Business hours (in Czechia)** |        \*\*\*\*        | **8 am - 6pm CET and CEST** (GMT+1/GMT+2) |

1. **Critical (priority 1)**
   * is a failure that results in a complete crash of the application, ie. a malfunction of the application as a whole or its module, which does not allow users to work or communicate with the application.
   * Examples of Critical failure:
     1. The application does not allow the user to log in (except for the incorrect DB function).
     2. The solver does not return the required (correct) results.
     3. Incorrect CRUD functionality of the space.
     4. Incorrect CRUD functionality of the rules.
2. **High (priority 2)**
   * is a fault that results in the malfunction of any of the functions declared in the manual available at [Dashboard](https://docs.decisionrules.io/doc/) and causes restrictions on the operation and services of the application, but does not prevent the use of the application as a whole; the failure could affect the accuracy of existing or acquired data and calculations performed.
   * Example of High failure:
     1. Non-functional import and export of rules to XLSX and JSON format.
     2. The application does not allow new users to be registered (except for the incorrect DB function).
     3. The application cannot create new API keys and API calls only work from existing ones.
3. **Medium (priority 3)**
   * is a failure that results in a violation of any of the functions declared in the manual available at [Docs](https://docs.decisionrules.io/docs/), but does not cause a restriction on the operation and services of the application; the failure could affect the accuracy of existing or acquired data and calculations performed.
   * Examples of Medium failure:
     1. Viewing the history of rules does not respond.
     2. Rule duplication does not work.
     3. Creating new versions of a rule does not work.
     4. Inability to invite new members to the CRUD space.
     5. The dashboard cannot preview graphs.
4. **Low (priority 4)**
   * are faults that do not limit the functionality of the application and do not prevent the operation of the application as a whole or any of its parts, but they are not the documented state of the application.
   * Examples of low failure:
     1. Faults exclusively on the front-end = changes and fixes are displayed after the update (refresh).
     2. Autocomplete failure in scripting rules.
     3. Color separation and autocomplete functions in the decision table do not work.

{% hint style="warning" %}
The list of examples is only for better orientation of what belongs to which category.
{% endhint %}
