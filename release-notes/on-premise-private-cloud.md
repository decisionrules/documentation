---
description: DecisionRules on-premise / private cloud release notes
cover: >-
  https://images.unsplash.com/photo-1494961104209-3c223057bd26?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwyfHxjb250YWluZXJ8ZW58MHx8fHwxNjU1ODE3OTYz&ixlib=rb-1.2.1&q=80
coverY: -886.6495601173019
---

# On-Premise / Private Cloud

Here you can find the release notes for the on-premise & private cloud version of DecisionRules.

## On-Premise / Private Cloud

### Version 1.9.3 - 8/2022

* Enhanced automatic vulnerability scanning
* Transition to Node.js 16 LTS

### Version 1.9.2 - 8/2022

* Added new functions ARRAY\_REDUCE, PICK and improved function DATE
* Removed vulnerabilities and reduced unnecessary packages

### Version 1.9.1 - 7/2022

* Fixed bug with importing rules in xlsx format
* Added new functions ARRAY\_MAP, ARRAY\_AND & ARRAY\_OR
* Bug fixes

### Version 1.9.0 - 7/2022

* Walkthrough tutorial
* New visual debug mode for Decison Tables and Decision Trees
* Easy copy/paste SDK examples in test bench
* Improved space statistics design
* Modified debug console outputs to be more human readable
* Bug fixes
* Improved solver performance
* RuleFlow is now callable within ScriptingRules

### Version 1.8.2 - 6/2022

* Fixed CosmosDB compability mode.
* Added new env. variables for specifiing database type
* Improved TELEMETRY, log now contains rule id

### Version 1.8.1 - 6/2022

* Added TELEMETRY
  * Telemetry enables measurement of [SOLVER API](../api/rule-solver-api.md) performance on request basis
  * Telemetry can be switched on using [environment variable](../on-premise-docker/containers-environmental-variables.md)
* Minor bug fix

### Version 1.8.0 - 6/2022

#### Decision Trees  <mark style="color:purple;">BETA</mark>

Brand new way to express your business rules. You can use IF, THEN, ELSE, CONDITIONS and RESULTS elements.  Everything is draggable! You can use Decision Trees with current Solver API, so you don't have to make integration changes. Decision Trees also works with Scripting rules and RuleFlow and of course Decision Trees are supported in [Management API](../api/management-api.md) and [new SDKs](broken-reference)

![](<../.gitbook/assets/Record Decision Trees.gif>)

* Redesigned app layout to better match current corporate design
* Generate PDF from Decision Tree
* New option to log in via Microsoft account
* Rules sorting  according name and last user attributes
* Preset Values in Test Bench
* Clear Debug console
* Minor bug fixes
* [Added ARM64 Support](https://www.decisionrules.io/articles/decisionrules-supports-arm64-in-on-premise-installations)

### Version 1.7.2 - 4/2022

* Non-technical user friendly Test bench
* Decision Tables
  * Ability to specify valid-from and valid-to on each row
* Management API Changes
  * Create RuleFlow
  * Update RuleFlow
  * Read RuleFlow
  * Delete RuleFlow
  * Export RuleFlow with all rules
  * Import RuleFlow with all rules
* Password can be longer than 14 characters
* Import / Export RuleFlows with all rules in one package
* You can restrict user registration and login within selected domains [#server-env-variables](../on-premise-docker/containers-environmental-variables.md#server-env-variables "mention")
* Swagger API Host domain changes according the ENV variable [#server-env-variables](../on-premise-docker/containers-environmental-variables.md#server-env-variables "mention") if needed
* RuleFlow general improvement
* Minor bug fixes
* New environmental variables for SSO
  * SAML\_CERT
  * SAML\_CALLBACK\_URL

### Version 1.6.3 - 4/2022

* minor bug fixes
* excel export now has data types in result columns

### Version 1.6.2 - 3/2022

* minor bug fixes

### Version 1.6.0 - 3/2022

* see version 1.11.0 of public cloud

### Version 1.5.1 - 02/2022

* New Login / Register / SSO Forms
* New [Evaluate All strategy](../other/execution-strategy.md) for decision tables
* Minor bug fix



### Version 1.5.0 - 01/2022

* Added tags for all types of rules
* Added rule tagging in rule management API
* Fixed bug with page redirecting
* Fixed bug with dates computation
* You can now delete user in on-premise version
* License key are now limited by number of users, not running instances
* Better Rule Variables validations
* Fixed slow DT loading on huge rules.
* DT header is now sticky
* Added better SSO support

### Version 1.4.0 - 12/2021

* Same changes as 1.9.0 cloud
* Improved performance
* Fixed rare bug with license key validation
