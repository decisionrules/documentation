# DecisionRules License Server

### Overview

The **DecisionRules License Server** is a component responsible for validating and managing licenses for your DecisionRules instance.

It ensures that every running instance is properly authorized and can operate according to the licensing terms. During startup, the application verifies the license before allowing full operation.

### Purpose

The main purpose of the License Server is to:

* Validate that the provided license key is correct and active
* Authorize the DecisionRules instance to run
* Enforce licensing rules and limits
* Ensure compliance with contractual terms
* Control and monitor usage of the software

### Setup

To successfully run DecisionRules with online licensing, your infrastructure must allow outbound access to the License Server.

{% content-ref url="../other-deployment-options/docker-and-on-premise/prerequisites.md" %}
[prerequisites.md](../other-deployment-options/docker-and-on-premise/prerequisites.md)
{% endcontent-ref %}
