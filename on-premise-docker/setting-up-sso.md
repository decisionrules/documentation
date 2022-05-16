# Setting up SSO

## How to set up the SSO

You can use SSO login in DecisionRules. This functionality is set using the `SAML_ENTRY_POINT` and `SAML_ISSUER` env. variables found in the docker-compose configuration file or added to the container before it is started using the command line.

| Variable           | Description                    |
| ------------------ | ------------------------------ |
| SAML\_ENTRY\_POINT | identity provider entry point  |
| SAML\_ISSUER       | issuer string to supply to IdP |
| SAML\_CERT         | certificate as a string        |

**Saml entry point** is typically link provided by your IdP for login page that you gonna use when logging in with SSO.

**`Example:`**` `` ``https://devX.okta.com/app/name/HASH/sso/saml `

**Saml issuer** could be link with hash or just name to identify your SSO.

**`Example:`**` `` ``okta.com/HASH_STRING `

After this, you can choose and use the SSO option on the login screen.

**Reply URL / Single sign-on URL**

It is the URL that which provider call with the callback. Need to be set **** up on the provider. Something like: api.decisionrules.io/saml/callback
