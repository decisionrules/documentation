# Setting up SSO

You can use SSO login in DecisionRules. This functionality is set using the `SAML_ENTRY_POINT` and `SAML_ISSUER` parameters found in the docker-compose configuration file or added to the container before it is started using the command line.

| Variable | Description |
| :--- | :--- |
| SAML\_ENTRY\_POINT | identity provider entry point |
| SAML\_ISSUER | issuer string to supply to IdP |

After this, you can choose and use the SSO option on the login screen.

