---
description: Learn more about plan limits
---

# Plan Limits Explained

{% hint style="info" %}
The following limits apply to new plans, starting from July 2024
{% endhint %}

This page provides detailed information about the various limits associated with your plan. Understanding these limits ensures you can make the most of your subscription without encountering unexpected restrictions.

Note that not all limits apply to every plan, higher-tier plans may have different limits or additional features that lower-tier plans do not include. Each limit is explained in terms of what it measures and how it impacts your usage.

Always refer to Account Limits section in your profile. There you can find actual limits according to the subscriptions you have.

## List of Limits

### Users

* Number of unique users invited to your spaces
* If you invite a user to N spaces, they are still counted as 1 user
* Limit on number of users is shared between spaces and organizations you own

Read more about users and space permissions [here](../../space/access.md#roles-and-permissions)

### Rules/Nodes

* Number of rules you can create
* The limit is shared in all your private spaces and spaces in organizations you own
* The distribution of the rules between spaces and organizations does not matter
* You can create all your rules in one space or distribute them in more spaces
* Individual versions of rules are counted separately
* In case you have workflows, the limit acts as the maximum for the sum of rules and workflow nodes for the whole account. For the detailed explanation of how this limit works, see [Workflow Limits](../../rules/workflow/workflow-limits.md).

Information about types of rules and their features can be found in dedicated [section](https://app.gitbook.com/s/2kePaAlhzmPFZTjuxdCY/rule-types)

### Solver API Calls

* Number of Solver API calls that you can do in 1 month
* Counted equally for all types of rules
* Includes calls made from test bench as well as from external systems
* Includes only external calls, i.e., when you call a rule from another rule, this call is not counted
* The limit resets on your plan's billing date, which can be found on your dashboard

Details how to solve rules using Solver API can be found [here](../../api/rule-solver-api.md)

### Rule Versioning

* The ability to create another version of your rule

More information about rule versioning can be found in dedicated [section](../../rules/common-rule-features/versioning.md)

### Rule Import / Export

* The ability to migrate your rules using export and import
* Applies equally to all export formats

Read more about supported rule formats in dedicated section [here](https://app.gitbook.com/s/2kePaAlhzmPFZTjuxdCY/rules/export-and-import-of-the-rules)

### Workflow

* The ability to create and manage workflow

More information about workflows can be found in dedicated [section](../../rules/workflow/)

### Organizations

* The number of organizations you can create and own
* There is no limit on the number of organizations that you can be invited to

Find out more about organization and its structure [here](broken-reference)

### Teams

* The number of teams you can create in each of your organizations

Information on how to create and manage team in organization you can find [here](../../organization/teams.md)

### Policies

* The number of policies you can create in each of your organizations

Read more about policies and permissions in organization's spaces in dedicated [section](../../organization/policies.md)

### Rule Comparison

* The ability to compare individual rules and versions of rules
* Applies to all rule types

Read more about rule comparison [here](../../rules/common-rule-features/rule-comparison/)

### Rule Timeout

* The maximum execution time for a rule solve
* Applies equally to all rule types
* If the execution time exceeded the limit, the solve will return an error

### Decision Tables Rows

* The maximum number of rows you can have in a decision table

Details about decision table as a rule type are available in dedicated [section](https://app.gitbook.com/s/2kePaAlhzmPFZTjuxdCY/rule-types/decision-tables)

### Max HTTP functions

* The maximum number of HTTP functions you can use in a rule

See [section](../../rules/data-types-and-functions/operators/functions/integration-functions.md#http-functions) dedicated to using http functions for more details

### BI and Audit API

* Allows to create a BI API key and collect data from the rule solver
* The number of Audit Logs API calls per 1 month
* limit resets on audit billing date, can be found in account dashboard
* can have different billing date from your plan billing date, depending on a date your Audit Logs add-on have been activated

See section [Audit Logs](../../business-intelligence/audit-logs.md) and [BI API](../../api/bi-api/) for information about creating audit logs and using BI and Audit API

### SSO

* Allows you to set up and use your custom single sign-on with DecisionRules

For more details about supported identity providers and set up tutorials please refer following sections: [Single Sign On](../../access/single-sign-on-sso.md), [Setup Single Sing On ](../../other-deployment-options/docker-and-on-premise/setting-up-sso/)

### Kafka API

* Allows you to use Solver API asynchronously using Apache Kafka Solver API

More details about setting Kafka Solver API can be found in documentation [article](../../api/apache-kafka-solver-api.md) dedicated to it

### Management API

* Allows you to use the Management API
* The ability to generate a Management API key&#x20;
* The ability to manage your rules and folders with external API calls

Information about how to use Management API and all its endpoints can be found [here](../../api/management-api.md) in section dedicated to it

### Availability

* Specifies the minimum guaranteed fraction of time during which the service responds to API calls
