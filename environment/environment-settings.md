---
icon: gear
---

# Environment Settings

Use **Environment → Settings** to configure environment SSO, password sign-in protection, and allowed email domains for your DecisionRules installation.

{% hint style="info" %}
These settings are available to **Environment Managers** on **Docker / On-Premise**. They apply across the environment. Organization SSO is configured separately in [Organization Settings](https://docs.decisionrules.io/doc/organization/settings#single-sign-on-sso).
{% endhint %}

## Open the settings

1. Sign in as an Environment Manager.
2. Open **Environment → Settings**.
3. Review the current configuration, then select **Edit**.

The editor contains **SSO**, **Allowlist**, and **Login Options** tabs. You can move between tabs without losing your unsaved changes.

The overview shows the saved configuration. It also displays warnings when neither environment SSO nor an email-domain allowlist is configured, or when neither login restriction is enabled.

## Recommended setup for Environment Managers <a href="#recommended-setup-for-environment-managers" id="recommended-setup-for-environment-managers"></a>

Follow one of these workflows when setting up your environment. Save your changes in **Environment Settings** and sign in again when prompted.

### With environment SSO <a href="#with-environment-sso" id="with-environment-sso"></a>

1. Register the account designated as an **Environment Manager** for your installation and sign in.
2. Open **Environment → Settings** and configure the **Allowlist** with the allowed email domains. Include your own domain and those of administrators who need password access.
3. Open **Profile → Settings → Two-factor authentication** and [enable personal 2FA](https://docs.decisionrules.io/doc/profile/settings/two-factor-authentication-2fa).
4. Configure **environment SSO** in **Environment → Settings → SSO**, save the configuration, and test **Sign in with SSO**.
5. Enable **Only SSO** in **Login Options** and save the change.

Standard users then sign in through environment SSO. Manage their SSO access in your identity provider; the email-domain allowlist does not restrict SAML SSO.

Environment Managers and License Owners can still sign in with email and password. We recommend personal 2FA for these accounts so that their password sign-ins also require an authenticator code.

### Without environment SSO <a href="#without-sso" id="without-sso"></a>

1. Register the account designated as an **Environment Manager** for your installation and sign in.
2. Open **Environment → Settings** and configure the **Allowlist** with the allowed email domains, including your own.
3. Enable **Enforce 2FA** in **Login Options** and save the change.
4. Users from the allowed domains register and sign in with email and password. At their first password sign-in, they must [set up two-factor authentication](https://docs.decisionrules.io/doc/profile/settings/two-factor-authentication-2fa) before accessing the application.

The requirement also applies to Environment Managers and License Owners signing in with a password.

## Configure environment SSO

Environment SSO connects your installation to a SAML identity provider. Have the provider's issuer, sign-in URL, and signing certificate available before starting.

1. In the **SSO** tab, select **Custom Configuration**.
2. Complete the provider details:

| Field            | What to enter or copy                                                                                                                                                |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Issuer**       | The issuer value for your SAML integration. It must match the corresponding identity-provider configuration.                                                         |
| **Entry Point**  | The identity provider's SAML sign-in URL.                                                                                                                            |
| **Callback Url** | Copy the displayed URL to your identity provider's ACS / reply URL setting. This field is read-only. It normally has the form `https://your-api-host/saml/callback`. |
| **Certificate**  | Enter the identity provider's signing certificate, or use **Select certificate file** to import it.                                                                  |

3. Select **Save** and confirm the change.
4. Sign in again and test **Sign in with SSO** before enabling **Only SSO**.

The ACS / reply URL configured at the identity provider must match the displayed **Callback Url** exactly. Use the API address shown by the application.

When editing an existing configuration, the saved certificate is filled in and masked. Leave it in place to keep it, or replace it with the new certificate. A certificate is required to save a custom configuration.

### Environment and organization SSO

| Source                                           | How it is used                                                                                          |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| **Custom Configuration** in Environment Settings | Saves an environment SSO provider in the application.                                                   |
| **Not set** in Environment Settings              | Removes the environment SSO configuration saved in the application. Organization SSO remains available. |
| **Organization SSO**                             | Uses the provider configured for an organization, identified by its **SSO Name**.                       |

A new **Custom Configuration** starts with empty provider fields.

Choosing **Not set** also turns off **Only SSO** in the editor. Review **Login Options** before saving.

### How users select SSO

On Docker / On-Premise, **Sign in with SSO** selects the only provider configured in the application automatically. When several providers are configured, users see the SSO form:

* Enter an organization's **SSO Name** to use that named provider.
* Leave **SSO Name** blank to use environment SSO saved through **Custom Configuration**.

If the selected provider is missing or its name is incorrect, users see an error and should check the configuration with their administrator.

See [Login on On Premise](https://docs.decisionrules.io/doc/access/on-premise/login-on-on-premise) for the complete sign-in flow.

## Set login options

Open the **Login Options** tab to configure either or both of these settings.

### Only SSO

**Only SSO** requires users to sign in through SAML SSO. **Environment Managers and License Owners retain the option to sign in with email and password.**

{% hint style="warning" %}
We recommend that Environment Managers and License Owners [enable personal 2FA](https://docs.decisionrules.io/doc/profile/two-factor-authentication-2fa), because **Only SSO** still allows them to sign in with a password.
{% endhint %}

To enable this option, complete **Custom Configuration** in the SSO tab. Organization SSO alone does not satisfy this requirement.

### Enforce 2FA

**Enforce 2FA** requires two-factor authentication for **email-and-password sign-ins**. Users who have not enabled 2FA must set it up during their next password sign-in. Users who already have it enabled enter their authenticator code.

While this setting is enabled, users cannot disable 2FA themselves. An Environment Manager can still reset it to help a user regain access; the user must set it up again at the next password sign-in.

Sign-ins through Google, Microsoft, and SAML SSO do not request an additional DecisionRules authenticator code. Identity-provider verification is managed by the provider. These methods remain subject to the environment's other login restrictions.

### Use both settings together

You can enable **Only SSO** and **Enforce 2FA** together. SSO remains the required method for standard users, while Environment Managers and License Owners using their password fallback must also complete 2FA.

See [Two-factor authentication (2FA)](https://docs.decisionrules.io/doc/profile/two-factor-authentication-2fa) for user setup instructions.

## Configure the email-domain allowlist

The **Allowlist** tab controls which email domains can register or sign in using email/password, Google, or Microsoft where those methods are available. It does not control SAML SSO.

Select **Custom Configuration** to manage allowed domains in the application. **Disabled** allows all email domains.

To enter a custom list:

1. Select **Custom Configuration**.
2. Enter a domain, such as `example.com`, and press **Enter**.
3. Repeat for each additional domain. Use the remove control on a domain to delete it.
4. Include the domains used by administrators who need password access.
5. Select **Save** and confirm the change.

Use complete domains for exact matching. For example, `example.com` does not also allow `team.example.com`; add that subdomain separately if needed.

An empty custom list allows all domains, just like **Disabled**. It does not block registration.

{% hint style="danger" %}
**Before saving:** the allowlist also applies to administrator password sign-ins. If your own domain is not allowed, you can lose password access after the change.
{% endhint %}

## Save or discard changes

**Save** applies the changes from all tabs together after confirmation. If a setting is invalid, correct it before saving. **Cancel** or closing the editor discards the unsaved changes from every tab.

{% hint style="warning" %}
Saving an authentication change invalidates existing sign-ins across the environment, including your own. Save your work and let other users save theirs before changing these settings. After saving, sign in again using a method allowed by the new configuration.
{% endhint %}

## Related documentation

* [Users management](https://docs.decisionrules.io/doc/environment/users-management)
* [Two-factor authentication (2FA)](https://docs.decisionrules.io/doc/profile/two-factor-authentication-2fa)
