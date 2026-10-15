# Sign Up on On Premise

### Sign up in on-premise installations

This page describes how user registration works in self-hosted (on-premise) installations of DecisionRules.

The sign-up process depends on whether the application is already running with existing users, or whether it is a brand-new installation with no registered users yet.

### Existing installation

<figure><img src="../../.gitbook/assets/image (2) (5) (1).png" alt=""><figcaption></figcaption></figure>

If the Decision Rules application is already running and at least one user is registered, the sign-up process works the same way as in the Cloud version.

Users can register through the registration form available on the login page. After completing registration, the user can sign in and access the application according to assigned invitations and roles.

No email verification is required unless explicitly configured by your organization.

### Initial registration (first user)

<figure><img src="../../.gitbook/assets/on_prem_registration.png" alt=""><figcaption></figcaption></figure>

When Decision Rules is deployed for the first time and no users exist yet, the first registered user plays a special role.

In this case, the first user must be registered by one of the **license owners**.

The initial registration establishes the first administrative access to the application and allows further configuration, including inviting additional users and managing access.

Once the first user is registered, the application switches to the standard sign-up behavior used for existing installations.

### Authentication requirements after registration <a href="#authentication-requirements-after-registration" id="authentication-requirements-after-registration"></a>

Your environment's email-domain allowlist may restrict which accounts can register or sign in. If your domain is not allowed, contact your Environment Manager.

When **Enforce 2FA** is enabled, a new user signing in with email and password must set up an authenticator app before accessing the application. Follow the displayed setup instructions, or see [Two-factor authentication](https://docs.decisionrules.io/doc/profile/two-factor-authentication-2fa).

When **Only SSO** is enabled, standard users must use SAML SSO to access the application. Follow your administrator's sign-in instructions.

If the form displays an image CAPTCHA, enter its characters and submit the form again. Use the new image if it is replaced after an unsuccessful attempt.

If your account was created but the application returns you to login, sign in with that account instead of submitting registration again. See [Login on On Premise](https://docs.decisionrules.io/doc/access/on-premise/login-on-on-premise).

***

### Important notes

* Only one initial registration is possible when the system has no users.
* The first registered user should always be a license owner.
* After the initial setup is completed, all further registrations follow the standard sign-up flow.
