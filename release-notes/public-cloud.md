---
description: DecisionRules public cloud release notes
cover: >-
  https://images.unsplash.com/photo-1517483000871-1dbf64a6e1c6?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxDbG91ZCUyMGNvbXB1dGluZ3xlbnwwfHx8fDE2NTU4MTc4MTk&ixlib=rb-1.2.1&q=80
coverY: -882.1114369501468
---

# Public Cloud

### Version 1.19.0 - 10/2024

* Major release with important new features and improvements
* Decision table design and functionality upgrade
* Calculation columns in decision tables
* Performance boost
* New workflow feature
* See changes in detail on a [dedicated page](../other/changes-in-version-1.19.0-10-2024.md)

{% hint style="info" %}
The release to regional clouds is currently under preparation and will follow in near future.
{% endhint %}

<div align="left">

<figure><img src="../.gitbook/assets/FinancovanoEU.png" alt="" width="188"><figcaption></figcaption></figure>

</div>

### Version 1.18.4 - 07/2024

* Bug fix in scripting rule solver. Should have no effect on rule evaluation.

### Version 1.18.3 - 07/2024

* Brand new plans
  * In response to the needs of our customers, we have prepared new plans.&#x20;
  * &#x20;If you are a customer and have already purchased a plan, your old plan remains the same. In case you need to upgrade/downgrade, you can choose from our new tariffs.
* New trial logic
  * We offer a free trial for 10 days with the Business plan.
  * At the end of the free trial, the account will be converted to the Starter+ plan for 10 days. After this period, the account will be transferred to our free Starter plan.
* Bug fixes

### Version 1.18.2 - 05/2024

* New Business Intelligence API version
  * v2 of the BI API consists of two new endpoints and a new way of paginating over your Audit Logs
* Minor visual updates
* Minor bug fixes

### Version 1.18.1 - 04/2024

* Folder API
  * New addition to our Management API that let's you programatically Create, Read, Update (move and rename) and Delete Folders (including their contents)
* Folder Path Functionality
  * The new Folder API and some of our older endpoints can now target rules and folders not only by their IDs or Aliases but by leveraging the ?path=/ query parameter.
* Minor bug fixes

### Version 1.18.0 - 03/2024

* Organizations
  * Organizations serve for managing users, spaces, and access control under one billing account. Read more [here](broken-reference).
* Design improvements
  * Sidebar
    * Menu item **Users & Roles** renamed to **Space Settings**
    * **New** menu item Organizations
  * Navigation bar
    * Indicator of **Current Space** moved to left side of navigation
  * Select space dialog. Read more [here](../team-work/spaces.md#change-your-space).
* Minor bug fixes

### Version 1.17.5 - 03/2024

* Discount codes&#x20;
  * Feature that allows new users to purchase a plan at a discounted price using a promo code
* Console logs
  * Refactored creating and saving console logs
  * Console logs now work in bulk solve
  * Note that format of console log data has been changed
* Minor bug fixes

### Version 1.17.4 - 02/2024

* Fixed a bug with billing date, causing an edge case problem with API calls renewal.
* Minor bug fixes

### Version 1.17.3 - 01/2024

* Import Decision Table - Fixed a bug with row number limit. In effect, the row limit is now enforced within decision table import (both through the UI or Management API). Read more [here](https://www.decisionrules.io/pricing/public-cloud).
* Portuguese language support - We are now fully supporting Portuguese.
* Minor bug fixes

### Version 1.17.2 - 12/2023

* Rule Lock - Added a feature that lets users with according permission lock / unlock rule. Read more [here](https://docs.decisionrules.io/doc/other/rule-lock)
* Minor bug fixes

### Version 1.17.1 - 12/2023

* **Decision Tree Comparison -** Added a feature that lets users compare two Decision Trees and easily identify the differences between them. Read more [here](../other/rule-comparison/decision-tree-comparison.md).
* A newly registered user has to validate their email first before setting up a password. This improves the security of the authentication mechanism
* Updated packages on both client and server, thus removing some known vulnerabilities
* Folders are now showing a duplicate and undefined rule alias warning
* Audit Logs are now sorted in descending order by default
* Added memory limit on folder export to prevent memory overflow
* Added excluded and included condition columns options in SOLVE function
* Minor bug fixes

### Version 1.17.0 - 11/2023

* New isolated virtual machine environment for scripting rules solver
* Improved error messages in scripting rules. **Note that this improvement involves a small change in behavior.**
* Rule evaluation timeout is now returning status code 400 instead of 408
* Vulnerability fixes

### Version 1.16.4.1 - 11/2023

* **Minor change in billing  -** When the plan is changed, the customer is charged immediately and also receives an invoice immediately

### Version 1.16.4 - 9/2023

* **Decision Table Comparison -** Added a feature that lets users compare two Decision Tables together to identify differences between the tables. Read more [here](../other/rule-comparison/decision-table-comparison.md).

### Version 1.16.3 - 9/2023

* **Export Folder -** exporting the selected folder and its contents to **JSON** format
* **Import Folder -** importing folder and its contents into the selected folder
* **Show Dependencies -** presents all dependencies in a tree-like structure. This visualization is providing providing a clear overview of how rules are interconnected
* Added new endpoints to Management API for export folder, import folder, show dependencies
* Minor bug fixes

### Version 1.16.2 - 8/2023

* Vulnerability fixes
* Improved error handling in Kafka Solver
* Small bug fixes

### Version 1.16.1 - 7/2023

* We added a Teamwork indicator for rules, which tells you who is currently viewing the same rule as you. This functionality allows you to avoid interference between changes made by multiple individual editors at the same time (BETA version)
* Added filter in folders - you can filter rules by state (published/unpublished)
* Added button Copy alias to sidebar rule item for faster referencing
* Improvements in the UI
* Notification toaster can now be closed by a click
* When a number of API calls reaches 80% of your limit, you’ll get an email alert

### Version 1.16.0 - 6/2023

* Improved security and performance, mostly regarding operations with rules (and rule flows), like getting, solving, and managing rules
* Introduced wide support for using rule alias instead of rule ID in almost all endpoints of Solver & Management API
* New improved server-side infrastructure for rule, rule-flow and APIs
* New test infrastructure and a number new automatic regression tests
* Added HTTP calls limit for decision trees and scripting rules (applies the same limit policy as decision tables)
* Decision table performance optimization (unsubscribing from observables, less rendering after changes)
* Minor bug fixes

### Version 1.15.4 - 6/2023

* Added the functionality of comparing scripting rules. It is now possible to view the differences between two scripting rules and edit the primary scripting rule, reflecting the differences in any way you like. This feature will greatly simplify handling conflicts between distinct versions of scripting rules.
* Updated Kafka solver
* Minor bug fixes

### Version 1.15.3 - 5/2023

* Bug fixes
* Changed solver call policy, where you are now able to call rules from the app itself without api keys read permissions.

### Version 1.15.2 - 5/2023

* Columns of Decision Tables are now resizable! Drag and drop the edges of column headers to resize their corresponding columns.
* Improved the search functionality of Decision Tables.
* Decision Tables now remember your scroll position and automatically scroll there when you refresh the application or leave and re-enter the table.&#x20;
* Minor bug fixes.

### Version 1.15.1 - 4/2023

* Added regional cloud functionality. What are regional clouds? Read more about them [here](broken-reference).
* Minor bug fixes.

### Version 1.15.0 - 3/2023

* Added internationalization and language support.
* Added Czech language.
* Minor bug fixes.
* Minor changes to the Test Bench.

### Version 1.14.5 - 3/2023

* Minor improvement of login & registration.
* Improvement in several functions, namely AND, OR, TEST, SOLVE & the HTTP functions. These now accept null and {} as valid inputs. This further expands their possible usage. **Note that this improvement involves a small change in behavior.**

### Version 1.14.3 - 3/2023

* Bug fix of the Rule Alias field and the Simple JSON editor.
* Bug fix concerning the interpretation of numbers in functions.
* Improvement in the evaluation of empty array. From now on, empty array is considered a valid value and can enter the evaluation of functions. This allows to work with empty array in the context of functions. **This improvement involves a change in behavior.** If there is a chance of passing an empty array as input data in one of your decision tables or decision trees, **please test the respective rule** to make sure the present change does not affect your logic.
* Improvement in the evaluation of the functions EQ, NE and ARRAY\_INCLUDES. These functions now accept null and {} as valid inputs. Thanks to this, you may for example check if a variable equals null. **This improvement involves a change in behavior.**
* New `REDIS_PING_INTERVAL` environment variable that allows to set the duration (in milliseconds) for which the server pings the Redis server.
* Fixed a bug in functions MAX and MIN. For an empty array or a value that cannot be parsed to a number, these now return null. This improvement involves a change in behavior.

### Version 1.14.1 - 2/2023

* Added support for using functional expressions (like functions or variables) inside JSON within functions. Thanks to this, you can freely combine objects, arrays and the DecisionRules functions to introduce custom logic. This is a very powerful tool when using integration functions like SOLVE or for advanced data transformations. [Read more about JSON and functions](../decision-tables/operators/functions/functions-and-json.md).
* Update in the evaluation of variables. We are no longer casting primitive values (e.g. numbers or boolean values) saved within variables to string; instead, we keep their original type. Together with this change, we have improved the ability of several functions to cast their arguments to the type they need for evaluation. Please beware that **this enhancement involves a change in behavior.**
* Multiple minor bug fixes.
* Small improvement in the rule flow designer layout.
* Bug fix in the Management API. Creating rule via Management API now returns an error when the rule with given `ruleId` and `version` already exists.
* Bug fix involving duplicate rule aliases on multiple spaces.
* Improved zoom in decision trees.
* Status of rules is now visible thanks to coloring in the folder menu.

### Version 1.14.0 - 1/2023

* Added folders. You can now organize your rules in folders, edit the folder structure and display rules based on their location. Folders are comfortably accessible in the folder menu.

<figure><img src="https://lh6.googleusercontent.com/BW79jbv5TYtUIXRyGgNOoyFDdsg3u3FlHxyCZVQPiaT5YVduAEgy1tbhK1MlH67EuyjoEHhRvv3gFi1I8KrbNC7RrZLrJHXnXsTT6XRxXikxQMSBic81OZVx6x2rheFIHOQAqpaz7E_-sNIjF_xjUpwZf8SXPA4OibOMS7u9KxvrgG2kOP1IUq4eYmvCLQ" alt=""><figcaption></figcaption></figure>

* Simplified side menu no longer shows rule lists divided according to rule types. You can newly access all rules by following the Business Rules item in the menu. Thanks to its simplicity, the side menu can be now used effectively in the collapsed mode.
* Simplified dialog for creating and importing rules of any type. Rules can be created or imported by clicking the corresponding button in the top right corner of the rule list, or alternatively from the folder menu.
* The user profile now shows the current tariff limits including all add-ons.
* New section Users & Roles allows users to quickly access the space settings.
* Improved design of the rule list. You can now filter rules by types and sort them more easily.
* Font in decision tables and decision trees was changed to monospace for better readability.

### Version 1.13.1 - 12/2022

* Added the [ELSE operator](../decision-tables/operators/general-operators.md#else-else) in decision tables which allows, among other things, to add the so called default row. The ELSE operator returns true if no row has been triggered before so it is useful for defining fallback rows.
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

### Version 1.11.1 - 9/2022

* Minor bug fixes&#x20;
* Fixed buggy date functions
* Enhanced function validations&#x20;
* Added option to omit quotes on simple strings, complex strings containing special characters \[+-,/%\*()] still need quotes at the beginning and at the end.
* Added support for arithmetic operations (,-,/,+,%) in functions, e.g. 1+1.&#x20;
* Functions SUM, AVG, MIN, MAX, COUNT, MEDIAN, CONCAT, CONCAT\_WS, AND, OR now accept arrays as parameters. Functions EQ and NEQ accept arrays and objects.
* Improved DecisionTable performance on big rules.
* Added new functions hinting in decision tables, decision trees and scripting rules.
* Added new HTTP functions that can be called within decision table or decision tree and perform basic HTTP calls with methods as GET, POST, PUT, PATCH, DELETE.  Documentation page: [integration-functions.md](../decision-tables/operators/functions/integration-functions.md "mention")
* New SOLVE function that can perform solving of other rules within decision tables, decision trees and scripting rules. Documentation page: [integration-functions.md](../decision-tables/operators/functions/integration-functions.md "mention")

<figure><img src="../.gitbook/assets/image (2) (2) (1).png" alt="DecisionTable with HTTP and SOLVE methods implemented"><figcaption><p>DecisionTable with HTTP and SOLVE methods implemented</p></figcaption></figure>

* Enhanced functions editor for decision tables and decision trees
* Enhanced visuals of decision table
* Enhanced visuals of Dashboard
* Fixed bug with decision table filter
* Fixed bug with moving rules to another space
* Support of async/await in scripting rules
* Added RE function that creates regular expression.
* Added new TEST, MATCH, REPLACE, SPLIT functions that accept RE function as argument
* Added new ABS, SUBSTR, NOT, INCLUDES functions

### Version 1.10.0 - 8/2022

#### Audit Logging

Completely new feature that allows users to audit their rule solves. If the audit logging is turned on a given rule, it will create a detailed audit log with useful information after every solve of that rule. Audits have information about the Input/Output, execution time, timestamp, rule metadata, debug data and other useful information.

![](<../.gitbook/assets/image (7) (2).png>)

{% hint style="success" %}
Click here to learn more about [Audit Logging](../business-intelligence/audit-logs.md).
{% endhint %}

* Bug fixes
* Improved design

### Version 1.9.0 - 6/2022

* Walkthrough tutorial
* New visual debug mode for Decision Tables and Decision Trees
* Easy copy/paste SDK examples in test bench
* Improved space statistics design
* Modified debug console outputs to be more human readable
* Bug fixes
* Improved solver performance
* RuleFlow is now callable within ScriptingRules

### Version 1.8.0 - 5/2022

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
* Password can be longer than 16 characters
* Import / Export RuleFlows with all rules in one package
* RuleFlow general improvement
* Minor bug fixes

### Version 1.6.0 - 03/2022

* Added event timeline for rules and spaces. Supported events are:&#x20;
  * rule created,&#x20;
  * rule edited,&#x20;
  * new rule version,&#x20;
  * rule renamed,&#x20;
  * rule moved,&#x20;
  * rule deleted,&#x20;
  * api key edited,&#x20;
  * api key renamed,&#x20;
  * api key deleted,&#x20;
  * space edited.
* Added new feature: import/export for CSV files.
* Minor fixes for DecisionTables
* You can now use non-ascii character in I/O model except &,|,$
* Bug fixes
* Improved table solver performance

### Version 1.5.0 - 02/2022

* [Added tags for all types of rules](../other/tagging.md)
* [Added rule tagging in rule management API](../api/management-api.md)
* Fixed bug with page redirecting
* Fixed bug with dates computation
* Better Rule Variables validations
* Fixed slow Decision Table loading on huge rules.
* Decision Table header is now sticky
* Added better SSO support
* New [Evaluate All strategy](../other/execution-strategy.md) for Decision Tables

### Version 1.4.0 - 11/2021

* User Variables
* Improved overview of functions and operators in decision tables
* Adjustable highlighting of columns and rows in the decision table
* Possibility to call other rules from scripting rule
  * This feature makes it possible to create more complex data transfer between individual rules and subsequent aggregation of output data.
* Major infrastructure changes that have brought greater scalability, performance and stability
* New pricing plans
* Advanced Permissions
* Bulk evaluation of Decision tables, Scripting rules and RuleFlows
* Improved Kafka API
* Small changes based on user requirements
* Bug Fixes

### Version 1.3.0 - 09/2021

* [Rule Flow](../rule-flow/rule-flow-designer.md)
* [Management API](../api/management-api.md)
* [Table operations](../decision-tables/table-operations/)
* [Sharing rules between spaces](../team-work/share-between-spaces.md)
* Minor bug fixes

### Version 1.2.0 - 06/2021

* Functions in decision tables
* Python SDK
* [.](../decision-tables/decision-table-designer.md#check-table)NET SDK
* Minor bug fixes

### Version 1.1.3 - 05/2021

* [New geo-locations](../api/geo-location/)
* Minor bug fixes

### Version 1.1.2 - 05/2021

* [Excel/Google Sheets import/export](../decision-tables/import-and-export-rule/)
* [New table designer view](../decision-tables/decision-table-designer.md)
* [Debug mode](../decision-tables/decision-table-designer.md#debug)
* [Check table](../decision-tables/decision-table-designer.md#check-table)
* Minor bug fixes

### Version 1.1.1 - 04/2021

* Complex scripting rules
* [Favorite rules](../other/favorite-rules.md)
* [Rules versioning](../broken-reference/)
* Minor bug fixes

### Version 1.1.0 - 02/2021

* [Team-work Spaces](../team-work/spaces.md)
* New [Operators](../decision-tables/operators/)
* New data type [Date](../decision-tables/operators/date-operators.md)
* New rule - Sample rule or Empty rule
* Improved[ Billing interface](../billing/change-billing-information.md)
* Improved [Solver](../api/rule-solver-api.md)
* Minor bug fixes

### Version 1.0.2 - 12/2020

* [Automatic type casting](../decision-tables/data-types.md)

### Version 1.0.1 - 12/2020

* Added Import and Export feature
* Minor bug fixes

### Version 1.0.0 - 11/2020

#### Added

* New rule versioning system

#### Fixed

* Error while creating new row
