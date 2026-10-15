---
description: >-
  Manage registered users in DecisionRules Docker / On-Premise. View roles,
  reset passwords, or delete users.
icon: users-gear
---

# Users management

{% hint style="info" %}
This section is available only in the **Docker / On‑Premise** deployment, and if you are an Environment Manager.
{% endhint %}

If you need access, contact your administrator or our sales team.

### Overview <a href="#overview" id="overview"></a>

Open **Environment → Users Management** to view registered users, their email addresses, names, roles, 2FA status, and whether they have a password set.

An orange **Not set** badge in the **2FA** column highlights an Environment Manager or License Owner who has a password but has not enabled 2FA.

The 2FA status refers to the user's DecisionRules authenticator setup.

### Actions per user <a href="#actions-per-user" id="actions-per-user"></a>

Open the **Actions** menu (three dots) on the user's row.

#### **Reset password**

Select **Change Password** to set a replacement password for the user's DecisionRules account. Share it with the user through your organization's approved process and ask them to change it in their profile.

{% hint style="warning" %}
Changing the password through Users Management signs that user out of their existing sessions. If you change your own password here, you are also signed out and must sign in again.
{% endhint %}

This action changes the DecisionRules account password; it does not change a password managed by an external SSO provider. It does not reset the user's 2FA.

#### **Reset 2FA**

Use this action when a user has lost access to their authenticator app or needs to replace their authenticator setup.

The user's 2FA setup is removed, their existing sessions are invalidated, and the **2FA** column changes to **Not set**.

* If **Enforce 2FA** is active, the user must set up 2FA again during their next password sign-in.
* Otherwise, the user can sign in with their password and enable 2FA again in **Profile → Settings**.

An Environment Manager signed in through **organization SSO** cannot reset account-wide 2FA. Use account credentials or environment SSO, where available and permitted, to perform the reset.

See [Two-factor authentication](https://docs.decisionrules.io/doc/profile/two-factor-authentication-2fa) for the user's setup instructions and [Environment Settings](https://docs.decisionrules.io/doc/environment/environment-settings) for enforcement settings.

{% hint style="warning" %}
If no Environment Manager can sign in to reset your two-factor authentication, a database administrator can perform an [Emergency 2FA Reset](emergency-2fa-reset.md).
{% endhint %}

#### Delete user

Deleting a user is permanent.

It deletes all rules, spaces, and organizations of that user.

{% hint style="danger" %}
Do this only when you are sure.
{% endhint %}
