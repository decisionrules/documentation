---
description: >-
  The DecisionRules Solver API Key is a specific type of API key used for
  accessing the Rule Solver API provided by DecisionRules.
---

# Solver API Keys

To use [Rule Solver API](../rule-solver-api.md) in your application, you need to have solver API keys.

{% hint style="info" %}
#### OAuth Solver API Authentication

Using the Solver API key is simple, but Enterprise clients often prefer OAuth with an external Identity provider. For detailed guidance on implementing **Enterprise OAuth**, please refer to our [OAuth documentation](enterprise-oauth-m2m/).
{% endhint %}

### Introduction

Here is a breakdown of what it is and its purpose:

* Purpose: The Solver API Key is essential for rule execution. It allows your application to send requests to DecisionRules to solve rules, such as decision tables, decision trees, or rule flows, and receive the calculated output data.
* Authentication: When making a call to the Rule Solver API, the Solver API Key is typically included in the authorization header (e.g., `Authorization: Bearer <Solver API Key>`) to authenticate the request and grant access to execute the rules within your space.
* Context: DecisionRules offers different types of API keys for various functionalities:
  * Solver API Key: Used for executing rules (solving).
  * Management API Key: Used for administrative actions like managing, creating, or updating rules via the API.
  * Business Intelligence (BI) API Key: Used to get analytical and reporting data about rule solver activity.

### Getting the Solver API key

You can find all your solver API keys on the API key page. On this page, you can copy, delete, or create a new solver API key.



To create a solver API key navigate: `Space -> API Keys -> Add API Key`

![](<../../.gitbook/assets/Screenshot 2025-11-18 at 9.36.23 AM.png>)

