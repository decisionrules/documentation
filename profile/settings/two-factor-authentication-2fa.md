# Two-factor Authentication (2FA)

Two-factor authentication (2FA) adds an authenticator code to your email-and-password sign-in. After entering your password, you confirm your identity with a code from an authenticator app.

Personal 2FA is available on DecisionRules Cloud and Docker / On-Premise.

## When 2FA applies

DecisionRules asks for your authenticator code when you sign in with **email and password** and 2FA is enabled for your account.

{% hint style="info" %}
Sign-ins through Google, Microsoft, environment SSO, or organization SSO do not ask for an additional DecisionRules authenticator code. Any verification required by an identity provider is managed by that provider.
{% endhint %}

On Docker / On-Premise, an Environment Manager can require 2FA for password sign-ins through [Environment Settings](https://docs.decisionrules.io/doc/environment/environment-settings). Cloud users can enable personal 2FA themselves.

## Enable 2FA

1. Open **Profile → Settings**.
2. Find **Two-factor authentication** and select **Enable 2FA**.
3. Open an authenticator app that supports time-based one-time passwords (TOTP) and add an account.
4. Scan the QR code displayed by DecisionRules. Alternatively, enter the **Manual setup key** in your authenticator app. Use the eye icon to reveal the key or the copy icon to copy it.
5. Enter the current six-digit code from the app in **6-digit authentication code**.
6. Select **Confirm setup**.

An enabled-status message confirms that setup is complete. You remain signed in on the current browser session; your other existing sessions require a new sign-in.

{% hint style="warning" %}
Keep the authenticator entry so you can use it the next time you sign in. Treat the QR code and manual setup key as private account credentials.
{% endhint %}

## Sign in with 2FA

1. Enter your email and password on the login page.
2. When **Two-factor authentication** appears, open the authenticator entry for your DecisionRules account.
3. Enter the current six-digit code and select **Continue**.

After successful verification, you can access the application.

### If your environment requires setup

If your environment requires 2FA and you have not enabled it, password sign-in opens **Set up two-factor authentication**. Add the account to your authenticator app using the displayed QR code or manual key, then enter the current code and select **Continue**.

You must complete setup before accessing the application. While **Enforce 2FA** is active, you cannot disable 2FA in your profile.

## Disable optional 2FA

If your environment does not require 2FA:

1. Open **Profile → Settings → Two-factor authentication**.
2. Enter the current code from your authenticator app in **Current 6-digit code**.
3. Select **Disable 2FA**.

You remain signed in on the current browser session. Other existing sessions require a new sign-in, and future password sign-ins no longer ask for an authenticator code.

### Managing 2FA after organization SSO

When signed in through **organization SSO**, you can view your 2FA status, but you cannot change account-wide 2FA settings. To manage them, sign in with your account credentials or through environment SSO, where available and permitted by your environment.

## Troubleshooting

| Situation                                     | What to do                                                                                                                                                                                                                              |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| The code is not accepted                      | Check that you selected the correct account in your authenticator app and enter its current code.                                                                                                                                       |
| The code has already been used                | Wait for the app to display a new code, then try that code.                                                                                                                                                                             |
| You are asked to wait before retrying         | Follow the message shown on the login page, then try again.                                                                                                                                                                             |
| Setup has expired                             | Select **Start Again**. In Profile Settings, this starts a new setup. During sign-in, sign in again to restart setup. If you added an authenticator entry for the unfinished setup, remove that unused entry before adding the new one. |
| Your security settings changed during sign-in | Sign in again and follow the current instructions.                                                                                                                                                                                      |
| You lost access to your authenticator app     | On Docker / On-Premise, contact an Environment Manager to [reset your 2FA](https://docs.decisionrules.io/doc/environment/users-management#reset-2fa). On Cloud, contact DecisionRules support for help with account access.             |

After an Environment Manager resets your 2FA, your existing sessions end. If your environment requires 2FA, your next password sign-in takes you through setup again. Otherwise, enable it again from Profile Settings.

If no Environment Manager can sign in to your private environment, contact your deployment administrator for recovery assistance.

## Related documentation

* [Environment Settings](https://docs.decisionrules.io/doc/environment/environment-settings)
* [Users management](https://docs.decisionrules.io/doc/environment/users-management)
* [Sign Up & Login on Cloud](https://docs.decisionrules.io/doc/access/cloud/sign-up-and-login-on-cloud)
* [Login on On Premise](https://docs.decisionrules.io/doc/access/on-premise/login-on-on-premise)
