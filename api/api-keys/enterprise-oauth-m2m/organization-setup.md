# Organization Setup

### OAuth Setup for DecisionRules Organization

{% hint style="success" %}
First OAuth setup is done with the deployment with **DecisionRules Engineers.**&#x20;
{% endhint %}

For **OAuth Machine-to-Machine (M2M)** authentication to function within your DecisionRules Organization, you must configure the platform to correctly validate the JSON Web Tokens (JWTs) issued by your external **Identity Provider (IdP)**.

This setup transforms DecisionRules into a Resource Server that trusts tokens signed by your IdP, ensuring only authenticated machines from your ecosystem can access the Solver API.

**Navigate to:  `Organizations -> Select Organization -> Settings -> Enterprise Oauth API Settings`**

<figure><img src="../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

#### 1. OAuth Identity Provider

This setting tells DecisionRules which industry-standard IdP you are using. This selection helps ensure compatibility and may pre-fill standard endpoints.

* Options:
  * Azure: Refers to Azure Active Directory (now Microsoft Entra ID).
  * Okta: A major independent identity and access management provider.
  * Auth0: A popular, flexible identity platform (now part of Okta).

***

#### 2. JSON Web Key Sets URL

The JWKS URL is arguably the most critical component for token validation.

* What it is: JSON Web Key Set (JWKS) is a standardized JSON object that contains the public keys used by the Identity Provider to digitally sign the JWT Access Tokens it issues.
* What it means: When DecisionRules (the Resource Server) receives an Access Token from your client application, it must verify the token's signature. It does this by:
  1. Fetching the public keys from the JWKS URL.
  2. Finding the correct public key (typically by matching the `kid`—Key ID—in the token's header).
  3. Using that public key to cryptographically verify the token's signature.
* Purpose: This mechanism proves that the token was genuinely created and signed by the trusted Identity Provider and hasn't been tampered with. It also simplifies key management, as the IdP can rotate its private signing keys without requiring manual updates in DecisionRules—DecisionRules automatically fetches the updated public keys from this URL.
* Typical Format: `https://your-idp-domain.com/.well-known/jwks.json`

***

#### 3. Token Issurer (iss)

The `iss` claim in the JWT identifies the principal that issued the token.

* What it is: A case-sensitive string or URI representing the Identity Provider (Authorization Server) that generated and signed the Access Token.
* What it means: DecisionRules will check the `iss` claim inside every incoming Access Token. If the value does not exactly match the `ISS` value configured in the Organization settings, the token will be rejected. This is a crucial security check to ensure tokens are only accepted from your designated, trusted IdP.
* Example Value: `https://your-idp-domain.com/oauth2/default`

***

#### 4. Audience (aud)

The `aud` claim in the JWT identifies thee intended recipient of the token.

* What it is: A case-sensitive string or URI that represents the specific resource (API) the token is meant to be used for.
* What it means: DecisionRules (the Solver API) acts as the Audience. When the IdP issues the token to your machine client, it includes the API's unique identifier in the `aud` claim. DecisionRules checks this claim and will only accept a token if the configured `AUD` value is present in the token's audience list. This prevents a token issued for, say, a document API from being mistakenly used to access the DecisionRules Solver API.
* Example Value: `https://api.decisionrules.io` or a custom identifier configured in your IdP.
