---
description: DecisionRules on-premise / private cloud release notes
cover: >-
  https://images.unsplash.com/photo-1494961104209-3c223057bd26?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwyfHxjb250YWluZXJ8ZW58MHx8fHwxNjU1ODE3OTYz&ixlib=rb-1.2.1&q=80
coverY: -886.6495601173019
---

# On-Premise / Private Cloud

Here you can find the release notes for the on-premise & private cloud version of DecisionRules.

## On-Premise / Private Cloud

### Version 1.20.4 - 8/2025 <a href="#version-1.20.4-8-2025" id="version-1.20.4-8-2025"></a>

* New endpoint added to the Management API for **creating a new version of an existing rule** – see details: [https://app.gitbook.com/o/-MN4G-7P\_ExsN1x1n9Mp/s/-MN4F4-qybg8XDATvios/api/management-api#create-new-rule-version](https://app.gitbook.com/o/-MN4G-7P_ExsN1x1n9Mp/s/-MN4F4-qybg8XDATvios/api/management-api#create-new-rule-version "mention")​
* **New TEXT function**: Converts any input (number, string, object) into text, simplifying text creation without the need for other functions ([read more](https://app.gitbook.com/o/-MN4G-7P_ExsN1x1n9Mp/s/-MN4F4-qybg8XDATvios/rules/data-types-and-functions/operators/functions/text#text-text))
* **Improved folder and rule filtering**: Filter by latest version, hide published, hide pending, or filter by rule type
* **Decision Table update**: Condition cells now support empty values
* Minor bug fixes

<div align="left"><figure><img src="../../.gitbook/assets/image (370).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.20.3 - 7/2025

* **Rule Variables**: Displayed as plain text instead of parsed JSON to reduce confusion (no functional changes).
* **Function Validation**: Added warnings for:
  * Leading/trailing commas
  * undefined values (including for nested functions)
* **Permissions**: Fixed warning alerts when changing permissions for Spaces.
* **Rule Locking**: Locked rules can no longer be forked or overwritten by new imports. ([read more](../../rules/common-rule-features/rule-lock.md#what-can-not-the-user-do-with-the-locked-rule))
* **Search Fixes**: Resolved partially broken search in _Organizations → My Org → Statistics_
* **Google Login**: Your profile picture is now displayed upon login with a Google account.
* **Other**: Minor bug fixes and UI improvements.

### Version 1.20.2.1 - 6/2025

* Removed an unnecessary health-check call that could potentially cause delays in certain environments.

### Version 1.20.2 - 6/2025

* Minor bug fixes

### Version 1.20.0 - 5/2025

* Major app redesign — read more on a [1.20.0 dedicated page](../major-updates/changes-in-version-1.20.0-4-2025.md)
* New AI Assistant — see the [AI Assistant](broken-reference) docs and [AI Assistant Setup](../../ai-assistant/assistant-setup/) to configure it in your environment
* Reorganization of Documentation — if you are reading this, you are in version 2 of the Docs. You can switch to version 1 at the top of the menu.
* Updated logo placement in the new layout — to align with the new interface design, the logo area now has fixed dimensions. Please ensure your custom logo follows the updated [Brand Logo Guidelines](../../other-deployment-options/docker-and-on-premise/white-labeling.md) for optimal display.
* Improved indexing strategy for Azure Cosmos DB
* New configurable partition key for audit logs — see the extended [Environment Variables](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#optional-server-environment-variables) list.

<div align="left"><figure><img src="../../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.19.5 - 2/2025

* Added new Environment variable IN\_MEMORY\_RULE\_COUNT
* New NUMHASH function in Decision Tables and Decision Trees
* Minor bug fixes

### Version 1.19.4 - 2/2025

* Improve performance for bulk solve in Workflow
* New [Debug node](../../rules/flow/flow-nodes-overview.md#debug) in Workflow
* Search functionality in Workflow
* Minor Bug fixes

<div align="left"><figure><img src="../../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.19.3 - 12/2024

* Offline Licensing capability
* UI performance and usability improvements
* Bug fixes

<div align="left"><figure><img src="../../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.19.2 - 11/2024

* Improving the usage of Redis when solving rules.&#x20;
* Added support for Redis cluster mode. This mode can be enabled using an environment variable: REDIS\_MODE. More information can be found here: [https://docs.aws.amazon.com/whitepapers/latest/database-caching-strategies-using-redis/redis-cluster-modes-enabled-and-disabled.html](https://docs.aws.amazon.com/whitepapers/latest/database-caching-strategies-using-redis/redis-cluster-modes-enabled-and-disabled.html)
* Added support for Redis read replicas. It is now possible to specify a Redis connection string for write replicas and read replicas. Connections for write replicas use an existing environment variable: REDIS\_URL. A new environment variable has been created for read replica connections: READER\_REDIS\_URL.
* Added a new option to specify a Redis TLS certificate using a file path. This is possible using the new environment variable: REDIS\_CACERT\_PATH.
* Added the ability to terminate the Redis connection if the specified certificate verification fails. This is possible using a new environment variable: REDIS\_REJECT\_UNAUTHORIZED

<div align="left"><figure><img src="../../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.19.1 - 11/2024

* Major release with important new features and improvements
* New workflow feature
* Decision table design and functionality upgrade
* Calculation columns in decision tables
* New "Integrations" section accessible for each rule. It contains ready-to-use code snippets for all the [DecisionRules' SDKs](https://docs.decisionrules.io/doc/sdk-and-integrations/languages-frameworks), as well as two new additions:
  * Excel Add-in ([read more](https://docs.decisionrules.io/doc/sdk-and-integrations/excel-add-in))
  * Swagger implementation
* Redesign of the user authentication and onboarding pages (functionality remains the same)
* Minor redesign of the DecisionRules app - font, button and icon changes
* Performance boost
* Minor bug fixes
* See changes in detail on a [dedicated page](../major-updates/changes-in-version-1.19.0-10-2024.md)

<div align="left"><figure><img src="../../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure></div>

### Version 1.18.4.5 - 10/2024

* Minor bug fixes for organization spaces

### Version 1.18.4.4 - 10/2024

* Support for defining TLS certificate when connecting to mongo DB. More information: [https://www.mongodb.com/docs/drivers/node/current/fundamentals/connection/tls/#provide-certificate-filepaths](https://www.mongodb.com/docs/drivers/node/current/fundamentals/connection/tls/#provide-certificate-filepaths)

### Version 1.18.4.3 - 10/2024

* Add support for measurement. Adds the ability to enable measurement using the new env variable: **MEASUREMENTS**. If measurement is enabled, we get advanced statistics on how long it took to solve the rule.

### Version 1.18.4.2 - 10/2024

* Updated packages on both client and server, thus removing some known vulnerabilities.
* Redis performance improvement
* Minor bug fixes

### Version 1.18.4 - 08/2024

* Bug fix in scripting rule solver. Should have no effect on rule evaluation.
* Fixed minor issues with CosmosDB

### Version 1.18.1 - 04/2024

* Organizations
  * Organizations serve for managing users, spaces, and access control under one billing account. Read more [here](../../organization/organization-introduction.md).
* Design improvements
  * Sidebar
    * Menu item **Users & Roles** renamed to **Space Settings**
    * **New** menu item Organizations
  * Navigation bar
    * Indicator of **Current Space** moved to left side of navigation
  * Select space dialog. Read more [here](https://docs.decisionrules.io/doc/teamwork/spaces#change-your-space).
* Folder API
  * New addition to our Management API that let's you programatically Create, Read, Update (move and rename) and Delete Folders (including their contents)
* Folder Path Functionality
  * The new Folder API and some of our older endpoints can now target rules and folders not only by their IDs or Aliases but by leveraging the ?path=/ query parameter.
* Console logs
  * Refactored creating and saving console logs
  * Console logs now work in bulk solve
  * Note that format of console log data has been changed
* Minor bug fixes

### Version 1.17.4 - 02/2024

* Fixed edge case bug in DecisionTree solver - automated retesting of decision trees recommended
* Minor bug fixes

### Version 1.17.3 - 02/2024

* **Decision Tree Comparison -** Added a feature that lets users compare two Decision Trees and easily identify the differences between them. Read more [here](../../rules/common-rule-features/rule-comparison/decision-tree-comparison.md).
* Rule Lock - Added a feature that lets users with according permission lock / unlock rule. Read more [here](https://docs.decisionrules.io/doc/other/rule-lock).
* Added excluded and included condition columns options in SOLVE function.
* Portuguese language support - We are now fully supporting Portuguese.
* Updated packages on both client and server, thus removing some known vulnerabilities.
* Minor bug fixes.

### Version 1.17.0 - 11/2023

* New isolated virtual machine environment for scripting rules solver
* Improved error messages in scripting rules. **Note that this improvement involves a small change in behavior.**
* Rule evaluation timeout is now returning status code 400 instead of 408
* Vulnerability fixes
* Decision Table Comparison - Added a feature that lets users compare two Decision Tables together to identify differences between the tables. Read more here.
* Export Folder - exporting the selected folder and its contents to JSON format
* Import Folder - importing folder and its contents into the selected folder
* Show Dependencies - presents all dependencies in a tree-like structure. This visualization is providing providing a clear overview of how rules are interconnected
* Added new endpoints to Management API for export folder, import folder, show dependencies
* Minor bug fixes

### Version 1.16.2 - 8/2023

* Bug fixes
* We added a Teamwork indicator for rules, which tells you who is currently viewing the same rule as you. This functionality allows you to avoid interference between changes made by multiple individual editors at the same time (BETA version)
* Added filter in folders - you can filter rules by state (published/unpublished)
* Improvements in the UI
* Notification toaster can now be closed by a click
* Change of format in the default string logger
* Added Spanish language
* Improved error handling in Kafka Solver
* Verbose logging
* Added ability to set pool size for db
* Changed solver call policy, where you are now able to call rules from the app itself without api keys read permissions.
* Added the functionality of comparing scripting rules. It is now possible to view the differences between two scripting rules and edit the primary scripting rule, reflecting the differences in any way you like. This feature will greatly simplify handling conflicts between distinct versions of scripting rules.
* Decision table performance optimization (unsubscribing from observables, less rendering after changes)
* Added HTTP calls limit for decision trees and scripting rules (applies the same limit policy as decision tables)
* New improved server-side infrastructure for rule, rule-flow and APIs
* Introduced wide support for using rule alias instead of rule ID in almost all endpoints of Solver & Management API
* Improved security and performance, mostly regarding operations with rules (and rule flows), like getting, solving, and managing rules

### Version 1.15.3 - 5/2023

* Bug fixes.
* Revised Kafka integration for the solver.
* Changed solver call policy, where you are now able to call rules from the app itself without API keys read permissions.
* Columns of Decision Tables are now resizable! Drag and drop the edges of column headers to resize their corresponding columns.
* Improved the search functionality of Decision Tables.
* Decision Tables now remember your scroll position and automatically scroll there when you refresh the application or leave and re-enter the table.

### Version 1.15.0 - 4/2023

* Added support for languages and a translation to Czech
* Minor changes of the test bench
* Change docker containers to rootless. Now the server and BI containers run under a non-root user. The client container is released in two types with respect to this option. The type can be selected using the tag.
* Bug fixes and improved performance

### Version 1.14.5 - 3/2023

* New `REDIS_CACERT` environment variable that allows setting a ca certificate for TLS connection with Redis.

### Version 1.14.4 - 3/2023

* Improvement in several functions, namely AND, OR, TEST, SOLVE & the HTTP functions. These now accept null and {} as valid inputs. This further expands their possible usage. **Note that this improvement involves a small change in behavior.**

### Version 1.14.3 - 3/2023

* Bug fix of the Rule Alias field and the Simple JSON editor.
* Bug fix concerning the interpretation of numbers in functions.
* Improvement in the evaluation of empty array. From now on, empty array is considered a valid value and can enter the evaluation of functions. This allows to work with empty array in the context of functions. **This improvement involves a change in behavior.** If there is a chance of passing an empty array as input data in one of your decision tables or decision trees, **please test the respective rule** to make sure the present change does not affect your logic.
* Improvement in the evaluation of the functions EQ, NE and ARRAY\_INCLUDES. These functions now accept null and {} as valid inputs. Thanks to this, you may for example check if a variable equals null. **This improvement involves a change in behavior.**
* New `REDIS_PING_INTERVAL` environment variable that allows to set the duration (in milliseconds) for which the server pings the Redis server.

### Version 1.14.2 - 2/2023

* Fix docker image vulnerabilities
* New `LOGGER_TIMESTAMP_UTC` environment variable that allows setting whether the timestamp in the logs will be in UTC or not

### Version 1.14.1 - 2/2023

* Added support for using functional expressions (like functions or variables) inside JSON within functions. Thanks to this, you can freely combine objects, arrays and the DecisionRules functions to introduce custom logic. This is a very powerful tool when using integration functions like SOLVE or for advanced data transformations. [Read more about JSON and functions](../../rules/data-types-and-functions/operators/functions/functions-and-json.md).
* Update in the evaluation of variables. We are no longer casting primitive values (e.g. numbers or boolean values) saved within variables to string; instead, we keep their original type. Together with this change, we have improved the ability of several functions to cast their arguments to the type they need for evaluation. Please beware that **this enhancement involves a change in behavior.**
* Multiple minor bug fixes.
* Small improvement in the rule flow designer layout.
* Bug fix in the Management API. Creating rule via Management API now returns an error when the rule with given `ruleId` and `version` already exists.
* Bug fix involving duplicate rule aliases on multiple spaces.
* Improved zoom in decision trees.
* Status of rules is now visible thanks to coloring in the folder menu.
* New logger now allows to have logs in JSON format.

### Version 1.13.1 - 01/2023

* Added the [ELSE operator](../../rules/data-types-and-functions/operators/general-operators.md#else-else) in decision tables which allows, among other things, to add the so called default row. The ELSE operator returns true if no row has been triggered before so it is useful for defining fallback rows.
* Bug fix involving duplicate rule aliases on multiple spaces of the same user.

### Version 1.13.0 - 12/2022

* Improved hinting for functions, in particular their arguments. You can now see the hint as you write the function.
* Bugfix involving calling of rules in foreign spaces of the same user.
* Bugfix in the interpretation of the backslash character. **This bugfix involves a change in behavior.** Please consult our documentation of [Functions](https://docs.decisionrules.io/doc/decision-tables/functions#values) for details about the current behavior. If you were not using double backslash or backslash in combination with the double or single quotes character, you do not need to worry about this change.
* Bugfix involving the situation in which an input cell of type function is evaluated to a non-boolean value. From now on, such a case will result in an error and the condition will be interpreted as false. **This bugfix involves a change in behavior.** However, it only affects ill-defined rules.
* Enhancement in the behavior of OR function. When a single argument is found to be true, the other values are not validated anymore (they do not even need to be boolean) and the result is automatically casted to true. **This enhancement involves a small change in behavior.**
* New `options` property allowing to configure the rule solver. For a decision table, it is now possible to include or exclude specific condition columns when calling the solver. See the documentation of [Rule Solver API](https://docs.decisionrules.io/doc/api/rule-solver-api) for details.
* Audit is now active in Trial by default so new users can freely test this feature.
* Adjusted message when owner of teammate space does not have activated Audit.
* Added the `ruleAlias` property to all the rules and rule flows. Rule alias works the same way as rule ID but can be edited by the user and is better human-readable. It can be used to refer to rules in other rules as well as in API calls. It stays untouched when the rule is cloned or exported and imported which greatly simplifies manipulation with rules.
* Changing invitation to Space. You can select from users which you have in other spaces now.
* Shrunk cells now have the same width for all columns. This allows for better scrolling of Decision Tables without horizontal jumps.

### Version 1.12.1 - 11/2022

* Bugfix in getting right limits when saving RuleFlow.
* Bugfix with invite users into space. Now is validation case insensitive.
* Bugfix debug data on DecisionTree
* Bugfix defining and solving RuleFlow&#x20;
* Bugfix invitations Bugfix import rules from xslx and csv Improve function validation&#x20;
* Added ROUNDE DecisionRules function that rounds number to even&#x20;
* Fix docker image vulnerabilities

### Version 1.12.0 - 10/2022

* bug fixes
* added functionality where you can add rule of type RuleFlow to the vertex in another RuleFlow rule
* improved DecisionTable solver performance

### Version 1.11.4 - 12/2022

* Fixed the bug when the function did not display its value if it was a simple integer (1, 10, etc.).

### Version 1.11.0 - 9/2022

* minor bug fixes&#x20;
* fixed buggy date functions added&#x20;
* enhanced DecisionRules table function validations&#x20;
* added option to omit quotes on simple strings, complex string expressions (more than 2 words or string containing special characters \[+,-,_,/]) still needs quotes on the start and on the end._
* _added support for arithmetic operations (_,-,/,+,%) in functions (1+1).&#x20;
* functions SUM, AVG, MIN, MAX, COUNT, MEDIAN, CONCAT, CONCAT\_WS, AND, OR now can accept array as parameter. functions EQ and NEQ now accepts arrays and objects.&#x20;
* improved DecisionTable performance on big rules.&#x20;
* added new functions hinting in DecisionRules tables, trees and SccriptingRules new HTTP functions that can be called within DecisionTable or DecisionTree and perform basic HTTP calls with methods as GET, POST, PUT, PATCH, DELETE.  Documentation page: [integration-functions.md](../../rules/data-types-and-functions/operators/functions/integration-functions.md "mention")
* new SOLVE functions that can perform solving of other rules within DecisionTable, DecisionTrees and ScriptingRules. Documentation page: [integration-functions.md](../../rules/data-types-and-functions/operators/functions/integration-functions.md "mention")

<figure><img src="../../.gitbook/assets/image (2) (2) (1).png" alt="DecisionTable with HTTP and SOLVE methods implemented"><figcaption><p>DecisionTable with HTTP and SOLVE methods implemented</p></figcaption></figure>

* enhanced functions editor for DecisionTable and DecisionTrees&#x20;
* enhanced visuals of DecisionTable&#x20;
* enhanced visuals of DecisionRules dashboard panel&#x20;
* Added possibility to perform an offline invitation to the space.&#x20;
* fixed bug with DecisionTable filter&#x20;
* fixed bug with moving rules to another space&#x20;
* support of async/await in ScriptingRules&#x20;
* added RE function that creates ReGex expresion.&#x20;
* added TEST, MATCH, REPLACE, SPLIT that accepts RE functions as arguments

### Version 1.10.0 - 8/2022

#### Audit Logging

Completely new feature that allows users to audit their rule solves. If the audit logging is turned on a given rule, it will create a detailed audit log with useful information after every solve of that rule. Audits have information about the Input/Output, execution time, timestamp, rule metadata, debug data and other useful information.

![](<../../.gitbook/assets/image (7) (2).png>)

{% hint style="success" %}
Click here to learn more about [Audit Logging](../../business-intelligence/audit-logs.md).
{% endhint %}

* Bug fixes
* Improved design

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
  * Telemetry enables measurement of [SOLVER API](../../api/rule-solver-api.md) performance on request basis
  * Telemetry can be switched on using [environment variable](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md)
* Minor bug fix

### Version 1.8.0 - 6/2022

#### Decision Trees  <mark style="color:purple;">BETA</mark>

Brand new way to express your business rules. You can use IF, THEN, ELSE, CONDITIONS and RESULTS elements.  Everything is draggable! You can use Decision Trees with current Solver API, so you don't have to make integration changes. Decision Trees also works with Scripting rules and RuleFlow and of course Decision Trees are supported in [Management API](../../api/management-api.md) and [new SDKs](broken-reference)

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
* You can restrict user registration and login within selected domains [#server-env-variables](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#server-env-variables "mention")
* Swagger API Host domain changes according the ENV variable [#server-env-variables](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#server-env-variables "mention") if needed
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

* see version 1.6.0 of public cloud

### Version 1.5.1 - 02/2022

* New Login / Register / SSO Forms
* New [Evaluate All strategy](../../rules/common-rule-features/execution-strategy.md) for decision tables
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

* Same changes as 1.4.0 cloud
* Improved performance
* Fixed rare bug with license key validation
