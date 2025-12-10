---
description: >-
  Article to help you setup an Googgle  SAML application for use with
  DecisionRules.
icon: google
---

# Set up Google SSO

**Create custom SAML Application**

In the Google admin portal navigate to **Apps** -> **Web and mobile apps** -> **Add app -> Add custom SAML app**.&#x20;

### App details

Once there choose a name for the app and optionally a description and icon. Click on Continue

### Google Identity Provider details

In the next step, you will see the SSO URL, Entity ID and Certificate. From these values, save the **SSO URL** and **Certificate** that we will need later. Click Continue.

### Service provider details

In the next step, set the necessary information and save it for later.

* For the **Entity ID** you can put in any easily identifiable name.
* For the **ACS URL** put the address of your server (API) container with "/saml/callback" following.&#x20;
  * example: "_https://api.sandbox.decisionrules.io/saml/callback"_
* For the **Name ID format** choose **EMAIL**
* For the **Name ID** choose **Basic Information > Primary email**

<figure><img src="../../../.gitbook/assets/image (367) (1).png" alt=""><figcaption></figcaption></figure>

Click Continue.

### Attribute mapping

Leave as is, no need to set anything up.

### Environment Variables

These are the environment variables you will have to provide to your server container. These environment variables are from previous steps. Alternatively, you can find them in the application details in the Service provider details and Manage certificates in this section

* SAML\_ISSUER - **Entity ID**
* SAML\_CALLBACK\_URL - **ACS URL**
* SAML\_CERT - **Certificate**
* SAML\_ENTRY\_POINT - **SSO URL**

{% hint style="warning" %}
The SAML\_CERT has to be provided as a single line argument without the&#x20;

\------ BEGIN/END Certificate ------

More about SSO Environment variables [here](../containers-environmental-variables.md#optional-server-environment-variables).
{% endhint %}

### Adding Groups&#x20;

In the created custom SAML application click on User Access.

* Click on Groups
* Search for a group a click on it.&#x20;
* Change **Service status** to **ON.**

You can find more basic information with examples here: [.](./ "mention")
