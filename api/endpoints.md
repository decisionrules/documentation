---
description: This guide shows you how to change your endpoints.
---

# Endpoint Settings

{% hint style="danger" %}
This section is for users who created an account before 06. April 2021
{% endhint %}

{% hint style="info" %}
The reason to change your endpoints is due to our name change to **DecisionRules.io**
{% endhint %}

{% hint style="warning" %}
Everything remains the same, just the name is different.

That means all the settings you already have are going to work, but we strongly recommend you to do the changes from below.
{% endhint %}

## Endpoints in API

The only thing you should do is to change the endpoint in your API.

The URL is in a format **https://api.decisionrules.io/rule/solve/:ruleId/:version** where you should replace ~~decisiondrig.io~~ with **decisionrules.io**

{% hint style="info" %}
If you're using the Regional Cloud version of DecisionRules, prepend the URL with your region shortcut.

Read more about Regional Cloud API calls [here](../regional-cloud/region-specific-api-urls.md).
{% endhint %}

```http
URL
https://api.decisionrules.io/rule/solve/:ruleId/:version

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

## Angular library

If you are using our Angular library to connect [Decisionrules.io](https://decisionrules.io) from your web application \*\*\*\* [**npm package**](https://www.npmjs.com/package/@decisionrules/decisionrules) \*\*\*\* was changed as well.

{% hint style="danger" %}
The old[ **npm package**](https://www.npmjs.com/package/@decisionrules/decisionrules-js) \*\*\*\* will be still available, but no longer supported.

We recommend you download the new version from \*\*\*\* [**npm**](https://www.npmjs.com/package/@decisionrules/decisionrules) \*\*\*\* which will be supported.
{% endhint %}

{% hint style="info" %}
Please make sure your Angular settings are correct to have your application always up to date.
{% endhint %}
