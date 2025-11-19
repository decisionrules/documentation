# Azure OAuth

### Azure AD OAuth 2.0 Client Credentials (M2M) Setup

This guide details the two-part setup required in **Microsoft Entra ID (Azure AD)** to use the OAuth Machine-to-Machine (M2M) flow for securing your DecisionRules Solver API Key.

### Part I: DecisionRules Resource Application Setup

The Resource Application represents the DecisionRules Solver API itself. This is where you define the custom scope that grants access to your specific Organization and Space.

#### Step 1: Register the DecisionRules Resource API

1. **Sign in** to the [Microsoft Entra admin center](https://www.google.com/search?q=https://entra.microsoft.com).
2. Navigate to **Identity** > **Applications** > **App registrations**.
3. Click **+ New registration**.
4. **Name:** Enter `DecisionRules Solver API Resource` (or similar).
5. **Supported account types:** Select your desired tenant option (e.g., `Accounts in this organizational directory only`).
6. Click **Register**.

#### Step 2: Define the Application ID URI (The AUD Claim)

This URI uniquely identifies the DecisionRules Resource API and will be used as the **Audience (AUD)** for validation.

1. From the new App Registration overview page, navigate to **Manage** > **Expose an API**.
2. Next to **Application ID URI**, click **Set**.
3. Accept the default URI format (e.g., `api://<Application (client) ID>`) or define your own (e.g., `https://decisionrules.io/solver-api`).
4. **RECORD THIS FULL URI.** This value is critical and must be provided to the DecisionRules platform during your Organization's OAuth setup.

#### Step 3: Create the Custom Scope

This scope embeds your specific Organization and Space identifiers, ensuring fine-grained authorization.

1. In the same **Expose an API** blade, scroll down to **Scopes defined by this API**.
2. Click **+ Add a scope**.
3. Configure the scope using your provided identifiers:

| Field                          | Value                                                                                                          |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| **Scope name**                 | `decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver` |
| **Who can consent?**           | Select **Admins only** (Recommended for M2M flow)                                                              |
| **Admin consent display name** | `Access DecisionRules Solver API for specific Org/Space`                                                       |
| **Admin consent description**  | `Allows machine clients to execute rules on the specified DecisionRules Organization and Space.`               |
| **State**                      | **Enabled**                                                                                                    |

4. Click **Add scope**.

### Part II: Client Application Setup

The Client Application represents your calling service (e.g., your ERP, microservice, or back-end automation). This application requests the token.

#### Step 1: Register the Client Application

1. Navigate back to **App registrations** and click **+ New registration**.
2. **Name:** Enter a name for your calling service (e.g., `My ERP Client Service`).
3. Click **Register**.
4. From the overview page, record the **Application (client) ID** (your **Client ID**) and the **Directory (tenant) ID** (your **Tenant ID**).

#### Step 2: Create Client Credentials

1. From the client's management menu, navigate to **Certificates & secrets**.
2. Click **+ New client secret**.
3. Add a description and set an appropriate expiration.
4. **IMMEDIATELY COPY AND SECURELY STORE THE SECRET VALUE.** You will not be able to retrieve it again. This is your **Client Secret**.

#### Step 3: Grant Application Permission and Admin Consent

You must grant the Client Application permission to use the custom scope defined in Part I.

1. From the client's management menu, navigate to **API permissions**.
2. Click **+ Add a permission**.
3. Select the **My APIs** tab.
4. Select the **DecisionRules Solver API Resource** you created in Part I.
5. Select **Application permissions** (for M2M/service-to-service calls).
6. Expand the permission and check the box next to your custom scope: `decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver`.
7. Click **Add permissions**.
8. Click the **Grant admin consent for \[Your Tenant]** button and confirm. The Status must show **"Granted"**.

### Final Step: Requesting the Access Token

Your client application must now use its credentials and the `.default` scope to request an Access Token that includes the granted custom permission.

| OAuth Parameter     | Source Value                                                                                                                                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`client_id`**     | Client Application ID (from Part II, Step 1)                                                                                                                                                                             |
| **`client_secret`** | Client Secret Value (from Part II, Step 2)                                                                                                                                                                               |
| **`grant_type`**    | `client_credentials` (Fixed value for M2M)                                                                                                                                                                               |
| **`scope`**         | <p><strong>example:</strong> <em>api://cdc128ef-09ca-46ca-a349-57c0c248cad7/.default</em></p><p><strong>Application ID URI</strong> (from Part I, Step 2) <strong>followed by</strong> <code>/.default</code>   <br></p> |

**Example Token Request:**

```ara
# Assuming the Application ID URI (AUD) from Part I is:
# RESOURCE_URI="api://cdc128ef-09ca-46ca-a349-57c0c248cad7"

CLIENT_ID="<Your Client Application ID>"
CLIENT_SECRET="<Your Client Secret Value>"
TENANT_ID="<Your Tenant ID>"
RESOURCE_URI="api://cdc128ef-09ca-46ca-a349-57c0c248cad7"

curl --location --request POST "[https://login.microsoftonline.com/$](https://login.microsoftonline.com/$){TENANT_ID}/oauth2/v2.0/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=${CLIENT_ID}" \
--data-urlencode "client_secret=${CLIENT_SECRET}" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "scope=${RESOURCE_URI}/.default"
```

**Example Response:**

```json
{
  "token_type": "Bearer",
  "expires_in": 3599,
  "ext_expires_in": 3599,
  "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6InJ0c0ZULWItN0x1
  WTdEVlllU05LY0lKN1ZuYyJ9.eyJhdWQiOiJjZGMxMjhlZi0wOWNhLTQ2Y2EtYTM0OS01N2MwYzI0
  OGNhZDciLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vOTY2MGFkMjYtOD
  k2ZC00NDM4LWEwMTMtZTNlZTIzYjU3YjdjL3YyLjAiLCJpYXQiOjE3NjM0NTg4NjAsIm5iZiI6MTc
  2MzQ1ODg2MCwiZXhwIjoxNzYzNDYyNzYwLCJhaW8iOiJrMkpnWUlqWWZsWFNjMnVMc0NwN3lvSWR3a
  WN2aThjWjMzMFZzWExPM3pxQkNnTmx6Yk1BIiwiYXpwIjoiMjk3NDkyNmEtMDgxOC00MDdiLWE4NmM
  tYjc2MTZjZTNhODFhIiwiYXpwYWNyIjoiMSIsIm9pZCI6ImE3NmFmMTQ1LWI4MGEtNGZkOS05Yzc2L
  WJmNTZmOGIzYjAwOSIsInJoIjoiMS5BUk1CSnExZ2xtMkpPRVNnRS1QdUk3VjdmTzhvd2MzS0NjcEd
  vMGxYd01KSXl0YzZBUUFUQVEuIiwicm9sZXMiOlsiU29sdmVyIiwiTWFuYWdlbWVudCIsImRlY2lza
  W9ucnVsZXM6b3JnSWQ6MTJiMDU3YjQtODY1Yi00NTQ1LTgxYzQtODg5OWQxZGEzNTM3OnNwYWNlSWQ
  6OGJhNmJhYzktMDhhOC1lNjQ4LThhMmMtMGIzOTkyYTliNGQ2OnNvbHZlciJdLCJzdWIiOiJhNzZhZ
  jE0NS1iODBhLTRmZDktOWM3Ni1iZjU2ZjhiM2IwMDkiLCJ0aWQiOiI5NjYwYWQyNi04OTZkLTQ0Mzgt
  YTAxMy1lM2VlMjNiNTdiN2MiLCJ1dGkiOiJEVEMxRzBpamhFU3oyZTNRa055WEFBIiwidmVyIjoiMi4
  wIiwieG1zX2Z0ZCI6IjdHd1NVVFZRRkpDWlRGQ0xJMTRLdVEzeHotSVNTWXR2M05FdVpBY3BsbmdCWl
  hWeWIzQmxibTl5ZEdndFpITnRjdyJ9.BouxeEV4SGFUq0Q9JvaxpZ-gxgUeyRw5Y8VDjAkMlNp3c-zX
  o65OOiulH8IK_Jdv1A28ZWAU-X3LEbvG_YifNjy9UnKrsnKMGvi8DmIN8ZoAsoUJTTfZD9CUEjxTjx1
  QwZc6njqGt8J-zfffGLvewMzNmijWaCdv81O8hDOYTV84xz2YSbIMvjZ65BZC4jnGunVmbgN9LXgQRQ
  xSncnOd2X8JDmG36YDknjlKyZUtSV8hE1kaAkApgQRvZKzaWFhqZoKotMcQRTnRhGuRbxHgIRKBI6KL
  R1fJTCVkywzDqTQdm84dJrERPp9Lg51EBeZPZ0Bqalg5RsNFWmqX0IA9Q"
}
```

**Example Decoded JWT Token Data:**

```jsonc
// JWT HEaders
{
  "typ": "JWT",
  "alg": "RS256",
  "kid": "rtsFT-b-7LuY7DVYeSNKcIJ7Vnc"
}

// Decoded Payload
{
  "aud": "cdc128ef-09ca-46ca-a349-57c0c248cad7",
  "iss": "https://login.microsoftonline.com/9660ad26-896d-4438-a013-e3ee23b57b7c/v2.0",
  "iat": 1763458860,
  "nbf": 1763458860,
  "exp": 1763462760,
  "aio": "k2JgYIjYflXSc2uLsCp7yoIdwicvi8cZ330VsXLO3zqBCgNlzbMA",
  "azp": "2974926a-0818-407b-a86c-b7616ce3a81a",
  "azpacr": "1",
  "oid": "a76af145-b80a-4fd9-9c76-bf56f8b3b009",
  "rh": "1.ARMBJq1glm2JOESgE-PuI7V7fO8owc3KCcpGo0lXwMJIytc6AQATAQ.",
  "roles": [
    "decisionrules:orgId:12b057b4-865b-4545-81c4-8899d1da3537:spaceId:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver"
  ],
  "sub": "a76af145-b80a-4fd9-9c76-bf56f8b3b009",
  "tid": "9660ad26-896d-4438-a013-e3ee23b57b7c",
  "uti": "DTC1G0ijhESz2e3QkNyXAA",
  "ver": "2.0",
  "xms_ftd": "7GwSUTVQFJCZTFCLI14KuQ3xz-ISSYtv3NEuZAcplngBZXVyb3Blbm9ydGgtZHNtcw"
}
```

The resulting Access Token will be valid and contain the necessary `roles` (scope) claim, allowing the client to access the DecisionRules Solver API.
