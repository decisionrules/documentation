# Single Sign-On (SSO) on Cloud

## How to Login to DecisionRules using Single Sign-On (SSO) <a href="#how-do-i-sign-into-contentful-with-my-corporate-credentials" id="how-do-i-sign-into-contentful-with-my-corporate-credentials"></a>

If your organization has the single sign-on (SSO) option enabled, on the Login page click on the “SSO” link at the bottom.

![How to login to DecisionRules using Single Sign-On (SSO)](<../../../.gitbook/assets/image (193) (2).png>)

Next, provide your email address with the SSO of your organization.

![DecisionRules Single Sign-On (SSO) Login Form](<../../../.gitbook/assets/image (162) (1).png>)

Enter your corporate email. You will be redirected to your provider's webpage to enter your credentials - **Username** and **Password**. After you have successfully entered them and logged in, will be redirected back to DecisionRules on your **Dashboard**.

{% hint style="info" %}
If you already have an account with corporate email, and the provider is in our database, there will be no change for you.
{% endhint %}

### Is the single sign-on feature available for all customers? <a href="#is-the-single-sign-on-feature-available-for-all-customers" id="is-the-single-sign-on-feature-available-for-all-customers"></a>

The single sign-on feature (SSO) is available for **on-premise**, **private cloud** and **public cloud** (large and higher) also for the current plans. To enable SSO for your organization, go to [organization settings](../../../organization/settings.md).

### What Identity Providers (IdP) does DecisionRules support?

DecisionRules SSO works with all Identity Providers that support the SAML 2.0 protocol.

* Google SSO
* Keycloak
* Microsoft Entra ID
* Okta
* OneLogin
* Ping Identity

### How do I set up a single sign-on access for my organization?

To edit SSO for your organization, go to [organization settings](../../../organization/settings.md).

| Variable         | Description                                                                                                                                               |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **SSO Name**     | Domain in the email address - has to be unique                                                                                                            |
| **Entry Point**  | Identity provider entry point                                                                                                                             |
| **Issuer**       | Issuer string to supply to IdP                                                                                                                            |
| **Callback Url** | It is the URL that which provider call with the callback. Need to be set up on the provider. Something like: api.decisionrules.io/saml/callback           |
| **Certificate**  | Single line certificate string without the ------ BEGIN/END Certificate ------. You can simple use drop area and certificate will be parsed automatically |

{% hint style="info" %}
For more information contact us at <mark style="color:green;">**sales@decisionrules.io**</mark>
{% endhint %}
