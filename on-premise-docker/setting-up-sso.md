# Setting up SSO

You can use SSO login in DecisionRules. This functionality is set using the `SAML_ENTRY_POINT` and `SAML_ISSUER` env. variables found in the docker-compose configuration file or added to the container before it is started using the command line.

| Variable         | Description                    |
| ---------------- | ------------------------------ |
| SAML_ENTRY_POINT | identity provider entry point  |
| SAML_ISSUER      | issuer string to supply to IdP |

**Saml entry point** is typically link provided by your IdP for login page that you gonna use when logging in with SSO.

**`Example:`**` https://devX.okta.com/app/name/HASH/sso/saml`

**Saml issuer** could be link with hash or just name to identify your SSO. 

**`Example:`**` okta.com/HASH_STRING`

After this, you can choose and use the SSO option on the login screen.
