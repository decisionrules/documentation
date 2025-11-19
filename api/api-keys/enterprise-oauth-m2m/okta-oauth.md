# Okta OAuth

### Okta OAuth 2.0 Client Credentials (M2M) Setup

This guide details the two-part setup required in **Okta** to use the OAuth Machine-to-Machine (M2M) flow for securing your DecisionRules Solver API Key.



### Part I: DecisionRules Resource API (Custom Authorization Server)

The Resource API is defined by an Okta **Custom Authorization Server**, which mints the JWT Access Tokens and validates the custom scope.

#### Step 1: Create the Custom Authorization Server

1. **Sign in** to your Okta Admin Console.
2. Navigate to **Security** > **API**.
3. Select the **Authorization Servers** tab.
4. Click **Add Authorization Server**.
5. **Name:** Enter `DecisionRules Solver API` (or similar).
6. **Audience:** Enter a unique identifier for this server, such as: `https://decisionrules.io/solver-api`
   * **RECORD THIS VALUE.** This is your **Audience (AUD)** and will be the **Issuer (ISS)** URI when requesting tokens.
7. Click **Save**.

#### Step 2: Configure Claims

You must configure the Authorization Server to include a custom scope in the access token.

1. Stay in the new **DecisionRules Solver API** Authorization Server and navigate to the **Scopes** tab.
2. Click **Add Scope**.
3. Configure the scope using your provided identifiers:

| Field             | Value                                                                                                          |
| ----------------- | -------------------------------------------------------------------------------------------------------------- |
| **Name**          | `decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver` |
| **Display Name**  | `DecisionRules Solver Access`                                                                                  |
| **Description**   | `Allows machine clients to execute rules on the specified DecisionRules Organization and Space.`               |
| **Default Scope** | Leave unchecked.                                                                                               |
| **Consent**       | Select **No Consent Required**.                                                                                |

4. Click **Create**.

**Key URLs from Authorization Server:**

* **ISS (Issuer):** Found under the **Settings** tab (e.g., `https://{your-okta-domain}/oauth2/ausxxxxxxxxxx`)
* **JWKS URL:** Found under the **Settings** tab. DecisionRules requires this URL for token signature verification.

### Part II: Client Application Setup

The Client Application is the machine or service that will authenticate and request the access token.

#### Step 1: Create the Service Application

1. Navigate to **Applications** > **Applications** in the Okta Admin Console.
2. Click **Create App Integration**.
3. **Sign-in method:** Select **API Services** (or Service).
4. **Application Type:** Select **Client Credentials**.
5. Click **Next**.
6. **App integration name:** Enter a name for your calling service (e.g., `My ERP Client Service`).
7. Click **Save**.
8. From the **General** tab, record the following critical values:
   * **Client ID**
   * **Client Secret**

#### Step 2: Grant Client Access via an Access Policy

You must configure the Custom Authorization Server to allow the new Client Application to access the custom scope.

1. Navigate back to **Security** > **API** > **Authorization Servers** and select the **DecisionRules Solver API** server.
2. Go to the **Access Policies** tab.
3. If no policy exists, click **Add New Policy**.
   * **Policy Name:** E.g., `M2M Client Credentials Policy`.
   * **Assign to:** Set **The following clients** and add your **My ERP Client Service** application.
4. Within the new policy, click **Add Rule**.
   * **Rule Name:** E.g., `Client Credentials Grant`.
   * **If Grant Type is:** Check **Client Credentials**.
   * **If User is:** Set **The user assigned to the application**.
   * **THEN:** Ensure the **Access Token lifetime** is set (e.g., 3600 seconds/1 hour).
   * **Access Token with the following scopes:** Include the full custom scope: `decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver`.
5. Click **Create Rule**.

### Final Step: Requesting the Access Token

In the Okta Client Credentials flow, you explicitly request the custom scope name.

| OAuth Parameter        | Source Value                                                                                                                                                                                                                     |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Token Endpoint URL** | Authorization Server metadata (e.g., `https://{your-okta-domain}/oauth2/ausxxxxxxxxxx/v1/token`)                                                                                                                                 |
| **`client_id`**        | Client Application ID (from Part II, Step 1)                                                                                                                                                                                     |
| **`client_secret`**    | Client Secret Value (from Part II, Step 2)                                                                                                                                                                                       |
| **`grant_type`**       | `client_credentials` (Fixed value for M2M)                                                                                                                                                                                       |
| **`scope`**            | <p><strong>The full, specific custom scope name (from Part I, Step 2)</strong><br><br><strong>example:</strong> decisionrules:orgId:12b057b4-865b-4545-81c4-8899d1da3537:spaceId:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver</p> |

**Example Token Request:**

```ara
AUTH_SERVER_URL="https://{your-okta-domain}/oauth2/ausxxxxxxxxxx"

curl --location --request POST "${AUTH_SERVER_URL}/v1/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=<Your Client ID>" \
--data-urlencode "client_secret=<Your Client Secret>" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "scope=decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver"
```

**Example Response:**

```jsonc
// Some code
{
  "token_type": "Bearer",
  "expires_in": 3600,
  "access_token": "eyJraWQiOiJvNzI0LTVhZXV5X2hnZTd1bE1mYXU2Nk1OZEFDeENNcV9GWGEyc002VD
  M0IiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULlEtOTc5eWVlMzJydUkteEFvOVpKZkFyU
  3VzMnAwNXVsNFh1R0xGcjNhd0UiLCJpc3MiOiJodHRwczovL3RyaWFsLTM2OTc5ODUub2t0YS5jb20vb2F
  1dGgyL2F1c3g1NnJrd3ZmOXVDVUNjNjk3IiwiYXVkIjoiaHR0cHM6Ly9hcGkubXljb21wYW55LmNvbS9yZ
  XNvdXJjZS1hcHAiLCJpYXQiOjE3NjM0NTk2NDAsImV4cCI6MTc2MzQ2MzI0MCwiY2lkIjoiMG9heDU2dDV
  zY0JSMG90U3A2OTciLCJzY3AiOlsiZGVjaXNpb25ydWxlczpvcmdJZDoxMmIwNTdiNC04NjViLTQ1NDUtO
  DFjNC04ODk5ZDFkYTM1Mzc6c3BhY2VJZDo4YmE2YmFjOS0wOGE4LWU2NDgtOGEyYy0wYjM5OTJhOWI0ZDY
  6c29sdmVyIl0sInN1YiI6IjBvYXg1NnQ1c2NCUjBvdFNwNjk3In0.wo6RIZWNvl_H0u5ghTgwPX126vB-n
  aZzWiNhAISbgwXkIEeR142eQ47Ew-8iCVw24O6lQWiZS0eSUWxHZLpHD_cM-NIbGw-xuGc__VgFDa-mqu
  gWMLqXiRgGSKzQfZNl6b77TXtf6PRIrUwMveIdNwHWjqCaTXGyiw-Veu9tPZjdsvYNKwVwq-BVP0VWaeY
  tblyFmao7A2TexYA0W3FOU7L180tbWHKSh2L4yURz59l3evOVbRktCvCi8NNqFNtYTh2c9Z6KCRkMzmi2
  O9RDjKlFd_fu5F1uokkueJw-lqmOk1kNTJUBIDgOzw9APgWJOd41L7zFOLx9NNUMVmC53g",
  "scope": "decisionrules:orgId:12b057b4-865b-4545-81c4-8899d1da3537:spaceId:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver"
}
```

**Example Decoded Access Token Data:**

```jsonc
// Decoded headers
{
  "kid": "o724-5aeuy_hge7ulMfau66MNdACxCMq_FXa2sM6T34",
  "alg": "RS256"
}

// Decoded payload
{
  "ver": 1,
  "jti": "AT.Q-979yee32ruI-xAo9ZJfArSus2p05ul4XuGLFr3awE",
  "iss": "https://trial-3697985.okta.com/oauth2/ausx56rkwvf9uCUCc697",
  "aud": "https://api.mycompany.com/resource-app",
  "iat": 1763459640,
  "exp": 1763463240,
  "cid": "0oax56t5scBR0otSp697",
  "scp": [
    "decisionrules:orgId:12b057b4-865b-4545-81c4-8899d1da3537:spaceId:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver"
  ],
  "sub": "0oax56t5scBR0otSp697"
}
```

The resulting Access Token will be a JWT containing the custom scope in the `scp` (scope) claim, which the DecisionRules Solver API will use to authorize the execution.
