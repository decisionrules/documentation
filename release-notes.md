---
cover: >-
  https://images.unsplash.com/photo-1573376670774-4427757f7963?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw5fHxkZWxpdmVyeSUyMGJveHxlbnwwfHx8fDE2MzgxODE1MzQ&ixlib=rb-1.2.1&q=85
coverY: 570.8797653958944
---

# Release Notes

## Public Cloud

### 1.12.0 - 4/2022

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

### 1.11.0 - 03/2022

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

### 1.10.0 - 02/2022

* [Added tags for all types of rules](other/tagging.md)
* [Added rule tagging in rule management API](api/management-api.md)
* Fixed bug with page redirecting
* Fixed bug with dates computation
* Better Rule Variables validations
* Fixed slow Decision Table loading on huge rules.
* Decision Table header is now sticky
* Added better SSO support
* New [Evaluate All strategy](other/execution-strategy.md) for Decision Tables

### 1.9.0 - 11/2021

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

### 1.8.0 - 09/2021

* [Rule Flow](rule-flow/rule-flow-designer.md)
* [Management API](api/management-api.md)
* [Table operations](decision-tables/table-operations/)
* [Sharing rules between spaces](team-work/share-between-spaces.md)
* Minor bug fixes

### 1.7.0 - 06/2021

* Functions in decision tables
* Python SDK
* [.](decision-tables/decision-table-designer.md#check-table)NET SDK
* Minor bug fixes

### 1.6.1 - 05/2021

* [New geo-locations](api/geo-location.md)
* Minor bug fixes

### 1.6.0 - 05/2021

* [Excel/Google Sheets import/export](decision-tables/import-and-export-rule/)
* [New table designer view](decision-tables/decision-table-designer.md)
* [Debug mode](decision-tables/decision-table-designer.md#debug)
* [Check table](decision-tables/decision-table-designer.md#check-table)
* Minor bug fixes

### 1.5.0 - 04/2021

* [Complex scripting rules](tutorials/code-editor.md)
* [Favorite rules](other/favorite-rules.md)
* [Rules versioning](broken-reference/)
* Minor bug fixes

### 1.4.0 - 02/2021

* [Team-work Spaces](team-work/spaces.md)
* New [Operators](decision-tables/operators/)
* New data type [Date](decision-tables/operators/date-operators.md)
* New rule - [Sample rule or Empty rule](decision-tables/manage-decision-tables.md)
* Improved[ Billing interface](billing/change-billing-information.md)
* Improved [Solver](api/rule-solver-api.md)
* Minor bug fixes

### 1.3.0 - 12/2020

* [Automatic type casting](decision-tables/data-types.md)

### 1.2.0 - 12/2020

* Added Import and Export feature
* Minor bug fixes

### 1.1.0 - 11/2020

#### Added

* New rule versioning system

#### Fixed

* Error while creating new row

## On-Premise / Private Cloud

### 1.7.2 - 4/2022

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
* You can restrict user registration and login within selected domains [#server-env-variables](on-premise-docker/containers-environmental-variables.md#server-env-variables "mention")
* Swagger API Host domain changes according the ENV variable [#server-env-variables](on-premise-docker/containers-environmental-variables.md#server-env-variables "mention") if needed
* RuleFlow general improvement
* Minor bug fixes



### 1.6.3 - 4/2022

* minor bug fixes
* excel export now has data types in result columns

### 1.6.2 - 3/2022

* minor bug fixes

### 1.6.0 - 3/2022

* see version 1.11.0 of public cloud

### 1.5.1 - 02/2022

* New Login / Register / SSO Forms
* New [Evaluate All strategy](other/execution-strategy.md) for decision tables
* Minor bug fix



### 1.5.0 - 01/2022

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

### 1.4.0 - 12/2021

* Same changes as 1.9.0 cloud
* Improved performance
* Fixed rare bug with license key validation
