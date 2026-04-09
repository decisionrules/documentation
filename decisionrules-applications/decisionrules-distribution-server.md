# DecisionRules Distribution Server

### Overview

The **DecisionRules Distribution Server** is a centralized service that provides **managed content and resources** for DecisionRules environments.

It serves as a single source of truth for reusable assets such as templates, functions, and learning materials, ensuring consistency across all users and deployments.

### Purpose

The Distribution Server is responsible for:

* Providing **predefined templates** for faster rule creation
* Distributing **reusable functions and components**
* Delivering **links to Documentation and  Academy**
* Centralizing access to managed content across environments

### MCP Server Integration

The Distribution Server exposes its content via an **MCP (Model Context Protocol) server**, allowing AI assistants and agents to access and use this content dynamically.

#### MCP Endpoint

* `https://distribution.decisionrules.io/mcp`

Through this endpoint, clients can:

* Discover available templates, functions, and resources &#x20;
* Retrieve structured content for AI workflows &#x20;
* Integrate DecisionRules knowledge into assistants and automation &#x20;

### Setup

To successfully run DecisionRules with a Distribution server, your infrastructure must allow outbound access to it

{% content-ref url="../other-deployment-options/docker-and-on-premise/prerequisites.md" %}
[prerequisites.md](../other-deployment-options/docker-and-on-premise/prerequisites.md)
{% endcontent-ref %}
