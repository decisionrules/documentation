---
description: >-
  Article to help you setup an Azure Enterprise application for use with
  DecisionRules. Microsoft Entra ID was previosly known as Azure Active
  Directory.
icon: microsoft
---

# Set up Microsoft Entra ID SSO

## **Create Enterprise Application**

In the Azure portal navigate to **Enterprise applications** -> **New application** -> **Create your own application**. Once there choose a name for the app and select "Integrate any other application you don't find in the gallery (Non-gallery)" option.

### Set up SSO&#x20;

Once the application has been created select **Manage**/**Single sign-on**. From the methods, select **SAML**.

<figure><img src="../../../.gitbook/assets/image (293).png" alt=""><figcaption></figcaption></figure>

You will be presented with **SAML-based Sign-on** settings. We will mostly focus on the first part of these settings, the Basic SAML Configuration. When first setting the application up you will be required to provide the **Identifier (Entity ID)** and the **Reply URL**.

Hit the three dots in the upper right corner of the Basic SAML Configuration card and then Edit.&#x20;

* For the **Identifier** (Entitiy ID) you can put in any easily identifiable name.
* For the **Reply URL** put the address of your server (API) container with "/saml/callback" following.&#x20;
  * example: "_https://api.sandbox.decisionrules.io/saml/callback"_

<figure><img src="../../../.gitbook/assets/image (295).png" alt=""><figcaption></figcaption></figure>

### Environment Variables

These are the environment variables you will have to provide to your server container and where to find them.

* SAML\_ISSUER - **Basic SAML Configuration / Identifier (Entity ID)**
* SAML\_CALLBACK\_URL - **Basic SAML Configuration / Reply URL**
* SAML\_CERT - **SAML Certificates / Certificate (Base64)**
* SAML\_ENTRY\_POINT - **Set up&#x20;**_**YOUR\_APP\_NAME**_**&#x20;/ Login URL**

{% hint style="warning" %}
The SAML\_CERT has to be provided as a single line argument without the&#x20;

\------ BEGIN/END Certificate ------

More about SSO Environment variables [here](../containers-environmental-variables.md#optional-server-environment-variables).
{% endhint %}

### Adding Users&#x20;

In the Enterprise Application go to Manage / Users and groups.&#x20;

* Add user/group&#x20;
* Select Users or Groups which should have access to the DecisionRules' SSO.&#x20;
* Click on Assign.

You can find more basic information with examples here: [.](./ "mention")
