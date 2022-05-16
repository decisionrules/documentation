# Setting up SSO

## How to set up the SSO

You can use SSO login in DecisionRules. This functionality is set using the `SAML_ENTRY_POINT` and `SAML_ISSUER` env. variables found in the docker-compose configuration file or added to the container before it is started using the command line.

{% hint style="warning" %}
From version 1.7.0 needs to be set up SAML\_CALLBACK\_URL.
{% endhint %}

| Variable            | Mandatory          | Description                    |
| ------------------- | ------------------ | ------------------------------ |
| SAML\_ENTRY\_POINT  | Yes                | identity provider entry point  |
| SAML\_ISSUER        | Yes                | issuer string to supply to IdP |
| SAML\_CERT          | No                 | certificate as a string        |
| SAML\_CALLBACK\_URL | From version 1.7.0 | Reply URL / Single sign-on URL |

**SAML\_ENTRY\_POINT**&#x20;

Is typically a link provided by your IdP for the login page that you gonna use when logging in with SSO.

**`Example:`**`https://devX.okta.com/app/name/HASH/sso/saml`

**SAML\_ISSUER**&#x20;

Could be linked with hash or just name to identify your SSO.

**`Example:`**`okta.com/HASH_STRING`

**SAML\_CERT**

Public certificate of the provider. In a RAW format as a single line without BEGIN CERTIFICATE and END CERTIFICATE**.**

**`Example:`**`MIIC8DCCAdigAwIBAgIQap4GhMRA26tJGFD3fdTuNjANBgkqhkiG9w0BAQsFADA0MTIwMAYDVQQDEylNaWNyb3NvZnQgQXp1cmUgRmVkZXJhdGVkIFNTTyBD.......`

**SAML\_CALLBACK\_URL**

It is the URL that which provider call with the callback. Need to be set **** up on the provider.

**`Example:`**`https://api.decisionrules.io/saml/callback`
