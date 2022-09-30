# Set up Azure Active Directory SSO

## **Create Enterprise Application**

In the Azure portal find Azure Active Directory.&#x20;

* Go to Enterprise applications. Create a New application.&#x20;
* Create your own application.&#x20;
* Insert name of application and select “(Non-gallery) app”.



### Set up SSO&#x20;

In the Enterprise Application go to Single sign-on.&#x20;

* Select SAML.&#x20;
* Edit Basic SAML Configuration.&#x20;
* Add identifier -> Fill identifier (For example: ​​urn:auth0:decisionrules)&#x20;
* Add reply URL -> Fill reply URL, it is URL of DecisionRules server container + /saml/callback (For example: _https://api.decisionrules.io/saml/callback_)&#x20;
* Click on Save.&#x20;

### Adding Users&#x20;

In the Enterprise Application go to Users and groups.&#x20;

* Add user/group&#x20;
* Select Users or Group which you would like to use DecisionRules.&#x20;
* Click on Assign.

In DecisionRules SSO is set by environmental variables in the DecisionRules server container.&#x20;

You can find basic information here: [.](./ "mention")

* **SAML\_ENTRY\_POINT:**  Set up test -> Login URL
* **SAML\_ISSUER:** Basic SAML Configuration -> Identifier (Entity ID)
* SAML\_CALLBACK\_URL: Basic SAML Configuration -> Reply URL (Assertion Consumer Service URL)
* **SAML\_CERT:** SAML Signing Certificate -> Certificate (Base64) as a single line without -----BEGIN CERTIFICATE----- and -----END CERTIFICATE-----
