---
description: DecisionRules public cloud release notes
cover: >-
  https://images.unsplash.com/photo-1517483000871-1dbf64a6e1c6?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxDbG91ZCUyMGNvbXB1dGluZ3xlbnwwfHx8fDE2NTU4MTc4MTk&ixlib=rb-1.2.1&q=80
coverY: -882.1114369501468
---

# Public Cloud

### Version 1.11.1 - 9/2022

* Minor bug fixes&#x20;
* Fixed buggy date functions
* Enhanced function validations&#x20;
* Added option to omit quotes on simple strings, complex strings containing special characters \[+-,/%\*()] still need quotes at the beginning and at the end.
* Added support for arithmetic operations (,-,/,+,%) in functions, e.g. 1+1.&#x20;
* Functions SUM, AVG, MIN, MAX, COUNT, MEDIAN, CONCAT, CONCAT\_WS, AND, OR now accept arrays as parameters. Functions EQ and NEQ accept arrays and objects.
* Improved DecisionTable performance on big rules.
* Added new functions hinting in decision tables, decision trees and scripting rules.
* Added new HTTP functions that can be called within decision table or decision tree and perform basic HTTP calls with methods as GET, POST, PUT, PATCH, DELETE.  Documentation page: [integration-functions.md](../decision-tables/functions/integration-functions.md "mention")
* New SOLVE function that can perform solving of other rules within decision tables, decision trees and scripting rules. Documentation page: [integration-functions.md](../decision-tables/functions/integration-functions.md "mention")

<figure><img src="../.gitbook/assets/image (2).png" alt="DecisionTable with HTTP and SOLVE methods implemented"><figcaption><p>DecisionTable with HTTP and SOLVE methods implemented</p></figcaption></figure>

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

![](../.gitbook/assets/image.png)

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

* [New geo-locations](../api/geo-location.md)
* Minor bug fixes

### Version 1.1.2 - 05/2021

* [Excel/Google Sheets import/export](../decision-tables/import-and-export-rule/)
* [New table designer view](../decision-tables/decision-table-designer.md)
* [Debug mode](../decision-tables/decision-table-designer.md#debug)
* [Check table](../decision-tables/decision-table-designer.md#check-table)
* Minor bug fixes

### Version 1.1.1 - 04/2021

* [Complex scripting rules](../tutorials/code-editor.md)
* [Favorite rules](../other/favorite-rules.md)
* [Rules versioning](../broken-reference/)
* Minor bug fixes

### Version 1.1.0 - 02/2021

* [Team-work Spaces](../team-work/spaces.md)
* New [Operators](../decision-tables/operators/)
* New data type [Date](../decision-tables/operators/date-operators.md)
* New rule - [Sample rule or Empty rule](../decision-tables/manage-decision-tables.md)
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
