---
description: >-
  Learn how DecisionRules supports multi-tenancy with flexible shared and
  dedicated deployment options for Cloud, self-hosted, and embedded
  applications.
icon: hotel
---

# Multi-Tenancy

DecisionRules fully supports **organization-based logical multi-tenancy** in both Cloud and self-hosted deployments. Partners and software vendors can serve multiple customers from a single DecisionRules environment, giving each customer its own Organizations, Spaces, rules, and access permissions.

A **tenant** represents a customer or another independently managed group. In DecisionRules, an Organization provides the tenant’s administrative boundary, while Spaces provide the working context for rules and their execution.

### How tenant separation works

DecisionRules uses Organizations and Spaces together to separate customer resources and control access.

| Level            | Purpose                                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Environment**  | The DecisionRules deployment hosting Organizations, Spaces, and shared application services.                                                      |
| **Organization** | The customer’s administrative context, including members, teams, roles, access policies, and organization SSO configuration.                      |
| **Space**        | A context for managing rules, assigning resource permissions, and accessing rules through APIs. Space always belongs to exactly one organization. |

The typical arrangement is **one Organization per customer**, with multiple Spaces inside that Organization. A customer can also have several Organizations when separate administrative structures are needed.

For example, a partner serving ten customers can operate one DecisionRules environment containing ten Organizations. Each customer can maintain separate Spaces for its applications or for development, testing, and production.

Access is enforced through backend authorization. Users require the relevant membership and permissions to access Organization and Space resources. An account can be authorized to work across several Organizations, allowing partner administrators to manage multiple customers.

Learn more about [Organizations](https://app.gitbook.com/s/-MN4F4-qybg8XDATvios/organization).

### Supported deployment models

| Model                                 | Arrangement                                                                                   | Separation                                                                                                                                 |
| ------------------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **Shared deployment**                 | Multiple customers use one DecisionRules environment, with separate Organizations and Spaces. | Logical separation through membership, roles, policies, and scoped API access. Application infrastructure and database storage are shared. |
| **Dedicated deployment per customer** | The partner operates a separate self-hosted DecisionRules environment for each customer.      | Deployment separation, with infrastructure and dependencies configured according to each customer’s requirements.                          |
| **Hybrid**                            | A combination of shared and dedicated deployments.                                            | Depends on the deployment assigned to each customer.                                                                                       |

A shared deployment provides application-level multi-tenancy without requiring a separate installation for every customer. Dedicated deployments provide additional operational separation, with corresponding infrastructure and maintenance costs.

### What logical isolation provides

In a shared deployment, customer separation is enforced through resource ownership and access controls. Separate Organizations do not require separate databases or application servers.

Customers share the environment’s compute capacity, database infrastructure, and operational lifecycle. Organization separation therefore does not imply dedicated performance capacity, independent upgrades, or separate backup and recovery infrastructure.

Partners requiring those additional boundaries can use dedicated deployments and separate the relevant infrastructure and dependencies.

### Multi-tenancy for embedded applications

DecisionRules supports partners who embed rule management or rule execution into their own products.

Each customer can have its own rules, rule versions, and Space configuration. The partner’s application executes the appropriate rules using credentials associated with the customer’s Space.

DecisionRules provides different API key types for different purposes:

* **Solver API keys** authorize rule execution within a Space.
* **Management API keys** support rule-management operations within a Space.
* **Business Intelligence API keys** provide access to analytical and reporting data.

The partner’s backend maps its authenticated customer to the appropriate DecisionRules Space and credentials. This preserves the customer context when requests pass from the partner’s application to DecisionRules.

Learn more about [API keys](https://docs.decisionrules.io/doc/space/api-keys).

### Customer access to the authoring interface

Customers do not always need access to the DecisionRules authoring interface.

Partners can manage rules on their customers’ behalf and expose only the functionality required through their own application. Rule execution and management can take place through the DecisionRules APIs.

Where customers need direct authoring access, partners can invite them to the relevant Organization and grant permissions to selected Spaces. Organization roles, teams, and policies support delegated administration and collaboration.

### Cloud and self-hosted support

The Organization and Space model supports logical multi-tenancy in both DecisionRules Cloud and self-hosted environments.

In **Cloud**, DecisionRules operates the infrastructure, and customers manage their Organizations, Spaces, and access permissions.

In **self-hosted deployments**, the operator controls the infrastructure and deployment topology. A partner can host several customers in one environment or provision dedicated environments for individual customers. Self-hosted deployments can run on-premises or in the partner’s chosen cloud infrastructure.

### Conclusion

DecisionRules fully supports logical multi-tenancy in both Cloud and self-hosted deployments. Organizations provide customer administration and access controls, while Spaces scope rule management and execution. This enables partners to serve multiple customers within a single environment, each with its own rules and authorized access.

The deployment model is flexible: partners can share one environment across customers, operate dedicated environments, or combine both approaches. They can also manage rules entirely through APIs or give customers controlled access to the authoring interface. This allows the same platform to support different customer requirements for integration, administration, and infrastructure separation.
