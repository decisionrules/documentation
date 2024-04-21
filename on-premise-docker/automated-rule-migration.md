---
description: >-
  On this page, we describe the official DecisionRules tool for automated rule
  migration between environments.
---

# Automated Rule Migration

## Migration script

We prepared a migration CLI script called `dr-migrate` which is completely free to download and use for anyone. Find the script in its respective [GitHub repository](https://github.com/decisionrules/dr-migrate). In order to install it locally, follow the steps described in the README file.

The tool can be used to migrate rules in one command, or export the rules from a given environment and import them to another one. Use the latter approach if you cannot access both your environments from one location. The rules are always exported to a JSON file. You can choose from a list of several migration strategies, which determine the way of handling conflicts upon import.

{% hint style="info" %}
Use the migration script with great caution. Be sure to know the effects of the used strategy before you use it in production. You may easily delete or rewrite the rules in the target environment.
{% endhint %}

Under the hood, the migration script uses the [Management API](../api/management-api/) to send requests to the source and target environment. All you need to do is set your environment URLs and Management API keys in an automatically generated `config.json` file, as described in the README. Then you can start to easily and freely migrate your rules between environments.

