# Table of contents

* [DecisionRules Documentation](README.md)

## API

* [API Introduction](api/api-introduction.md)
* [API Keys](api/api-keys/README.md)
  * [Solver API Keys](api/api-keys/solver-api-keys.md)
  * [Management API keys](api/api-keys/management-api-keys.md)
  * [BI API keys](api/api-keys/management-api-keys-1.md)
* [Rule Solver API](api/rule-solver-api.md)
* [Management API](api/management-api.md)
  * [Deprecated Endpoints](api/management-api/deprecated-endpoints.md)
* [Console Logs API](api/console-logs-api.md)
* [Business Intelligence API](api/bi-api/README.md)
  * [Deprecated Endpoints](api/bi-api/deprecated-endpoints.md)
* [Datacenters & Locations](api/geo-location/README.md)
  * [Global Cloud](api/geo-location/geo-location.md)
  * [Regional Cloud](api/geo-location/regional-cloud.md)
* [Apache Kafka Solver API](api/apache-kafka-solver-api.md)
* [Endpoint Settings](api/endpoints.md)
* [Archive](api/archive/README.md)
  * [Rule Flow Solver API (DEPRECATED)](api/archive/rule-flow-solver-api.md)

## Decision tables

* [Decision Tables Introduction](decision-tables/decision-tables-introduction.md)
* [Table Designer](decision-tables/decision-table-designer.md)
* [Input & Output JSON Model](decision-tables/input-and-output/README.md)
  * [Simple Editor](decision-tables/input-and-output/simple-editor.md)
  * [JSON Editor](decision-tables/input-and-output/json-editor.md)
  * [Binding to Model](decision-tables/input-and-output/binding-to-model.md)
* [Supported Data Types](decision-tables/data-types.md)
* [Operators](decision-tables/operators/README.md)
  * [Basic operators](decision-tables/operators/general-operators.md)
  * [Date operators](decision-tables/operators/date-operators.md)
  * [Functions](decision-tables/operators/functions/README.md)
    * [Logical Functions](decision-tables/operators/functions/logical.md)
    * [Math Functions](decision-tables/operators/functions/math.md)
    * [Date and Time Functions](decision-tables/operators/functions/date-and-time.md)
    * [Text Functions](decision-tables/operators/functions/text.md)
    * [Data Functions](decision-tables/functions/data.md)
    * [Array Functions](decision-tables/functions/array.md)
    * [Integration functions](decision-tables/operators/functions/integration-functions.md)
    * [Functions and JSON](decision-tables/operators/functions/functions-and-json.md)
* [Export & Import of Decision Tables](decision-tables/import-and-export-rule/README.md)
  * [Export Decision Table](decision-tables/import-and-export-rule/export-decision-table.md)
  * [Import Decision Table](decision-tables/import-and-export-rule/import-decision-table.md)
  * [File Structure of JSON Format](decision-tables/import-and-export-rule/file-structure-of-json-format.md)
  * [Managing Decision Table in Excel/Google Sheets](decision-tables/import-and-export-rule/managing-decision-table-in-excel-google-sheets.md)
  * [Deprecated Formats: XLSX v.1 and CSV](decision-tables/manage-tables-excel-gsheets.md)
* [Table Operations](decision-tables/table-operations/README.md)
  * [Filter Values](decision-tables/table-operations/filter.md)
  * [Valid Values](decision-tables/table-operations/valid-values.md)
  * [Sorting](decision-tables/table-operations/sort.md)

## Decision Trees

* [Decision Trees Introduction](decision-trees/decision-trees-introduction.md)
* [Decision Tree Designer](decision-trees/decision-tree-designer.md)
* [Export & Import Decision Trees](decision-trees/import-and-export-rule/README.md)
  * [Export Decision Tree](decision-trees/import-and-export-rule/export-decision-tree.md)
  * [Import Decision Tree](decision-trees/import-and-export-rule/import-decision-tree.md)

## Scripting Rules

* [Custom functions in Scripting Rules](scripting-rules/custom-functions-in-scripting-rules.md)
* [Calling external API within ScriptingRules](scripting-rules/calling-external-api-within-scriptingrules.md)
* [Use Rule Variables in Scripting Rules](scripting-rules/use-rule-variables-in-scripting-rules.md)
* [Call Embedded Rules in Scripting Rules](scripting-rules/call-embedded-rules-in-sr.md)
* [Export & Import Scripting Rules](scripting-rules/import-and-export-rule/README.md)
  * [Export Scripting Rule](scripting-rules/import-and-export-rule/export-scripting-rule.md)
  * [Import Scripting Rule](scripting-rules/import-and-export-rule/import-scripting-rule.md)
* [Tips](scripting-rules/tips.md)

## Rule Flow

* [Rule Flow Designer](rule-flow/rule-flow-designer.md)
* [Rule Flow Mapping](rule-flow/mapping.md)
* [Rule States in Rule Flow](rule-flow/warnings-and-errors.md)
* [Warnings & Errors](rule-flow/warnings-and-errors-1.md)
* [Rule Flow Limits](rule-flow/rule-flow-limits.md)
* [Export & Import Rule Flows](rule-flow/import-and-export-rule/README.md)
  * [Export Rule Flow](rule-flow/import-and-export-rule/export-rule-flow.md)
  * [Import Rule Flow](rule-flow/import-and-export-rule/import-rule-flow.md)

## Workflow

* [Workflow Introduction](workflow/workflow-introduction.md)
* [Workflow Nodes Overview](workflow/workflow-nodes-overview.md)
* [Workflow Limits](workflow/workflow-limits.md)

## Other

* [Rule Alias](other/rule-alias.md)
* [Execution Strategy](other/execution-strategy.md)
* [Rule State](other/rule-state.md)
* [Rule Versioning](other/versioning.md)
* [Favorite Rules](other/favorite-rules.md)
* [Rule Variables](other/rule-variables.md)
* [Rule Comparison](other/rule-comparison/README.md)
  * [Decision Table Comparison](other/rule-comparison/decision-table-comparison.md)
  * [Decision Tree Comparison](other/rule-comparison/decision-tree-comparison.md)
  * [Scripting Rule Comparison](other/rule-comparison/scripting-rule-comparison.md)
* [Rule Tags](other/tagging.md)
* [Rule Dependencies](other/rule-dependencies.md)
* [Test Bench](other/test-bench.md)
* [Single Sign-On (SSO)](other/single-sign-on-sso.md)
* [Event timeline](other/event-timeline.md)
* [Rule Lock](other/rule-lock.md)
* [Rule Migration Strategies](other/rule-migration-strategies.md)
* [Changes in Version 1.19.0 (10/2024)](other/changes-in-version-1.19.0-10-2024.md)

## Organizations

* [Introduction](organizations/introduction/README.md)
  * [Access to Organization](organizations/introduction/access-to-organization.md)
* [Structure](organizations/structure/README.md)
  * [Organization Roles](organizations/structure/organization-roles.md)
  * [Members](organizations/structure/members.md)
  * [Teams](organizations/structure/teams.md)
  * [Spaces](organizations/structure/spaces.md)
  * [Space Roles](organizations/structure/space-roles.md)
  * [Policies](organizations/structure/policies.md)
  * [Settings](organizations/structure/settings.md)

## Teamwork

* [Dashboard](teamwork/dashboard.md)
* [Folders](teamwork/folders.md)
* [Spaces](team-work/spaces.md)
* [Manage Spaces](team-work/create-and-manage-your-spaces.md)
* [Share Rules Between Spaces](team-work/share-between-spaces.md)
* [Users & Roles](teamwork/users-and-roles.md)
* [Teamwork Indicator](teamwork/teamwork-indicator.md)

## SDK and Integrations

* [Languages / Frameworks](sdk-and-integrations/languages-frameworks/README.md)
  * [SQL Server](sdk-and-integrations/languages-frameworks/sql-server.md)
  * [Oracle PL/SQL](sdk-and-integrations/languages-frameworks/oracle-pl-sql.md)
  * [PostgreSQL](sdk-and-integrations/languages-frameworks/postgresql.md)
  * [JavaScript](sdk-and-integrations/languages-frameworks/javascript.md)
  * [Java Spring Example](sdk-and-integrations/languages-frameworks/java.md)
  * [PHP Library](sdk-and-integrations/languages-frameworks/php.md)
  * [Python Library](sdk-and-integrations/languages-frameworks/python.md)
  * [.NET Library](sdk-and-integrations/languages-frameworks/.net.md)
  * [Google Tag Manager](sdk-and-integrations/languages-frameworks/google-tag-manager.md)
* [Excel Add-in](sdk-and-integrations/excel-add-in.md)

## Business Intelligence

* [Audit Logs](business-intelligence/audit-logs.md)
* [Create a Power BI Report](tutorials/create-a-power-bi-report.md)
* [Connect Power BI to Business Intelligence API](business-intelligence/connect-power-bi-to-business-intelligence-api.md)
* [Connecting from Power BI (deprecated)](business-intelligence/connecting-from-power-bi-deprecated.md)
* [Connect DecisionRules to Power BI Using Our Custom Connector](business-intelligence/connect-decisionrules-to-power-bi-using-our-custom-connector.md)

## Billing

* [Invoices & Billing](billing/invoices.md)
* [Change Product Plan](billing/change-product-plan.md)
* [Billing Information](billing/change-billing-information.md)
* [Plan Limits Explained](billing/plan-limits-explained.md)

## Regional Cloud

* [Regional Cloud](regional-cloud/regional-cloud.md)
* [Region Specific API URLs](regional-cloud/region-specific-api-urls.md)

## On-Premise / Docker

* [Environment Variables](on-premise-docker/containers-environmental-variables.md)
* [Setup Single Sign-On (SSO)](on-premise-docker/setting-up-sso/README.md)
  * [Set up Microsoft Entra ID SSO](on-premise-docker/setting-up-sso/set-up-microsoft-entra-id-sso.md)
  * [Set up Google SSO](on-premise-docker/setting-up-sso/set-up-google-sso.md)
* [DecisionRules Application](on-premise-docker/decisionrules-application/README.md)
  * [Minimal Requirements](on-premise-docker/requirements.md)
  * [DecisionRules Server](on-premise-docker/server-app.md)
  * [DecisionRules Client](on-premise-docker/client-app.md)
  * [DecisionRules Business Intelligence](on-premise-docker/decisionrules-application/decisionrules-business-intelligence.md)
  * [Client/Server Commpatibility](on-premise-docker/environment-variables.md)
  * [Networking Between Docker Containers](on-premise-docker/manual-networking-between-containers.md)
* [Docker Showcase App](on-premise-docker/showcase-client-server-app/README.md)
  * [Showcase](on-premise-docker/showcase-client-server-app/showcase.md)
  * [Showcase + Business Intelligence](on-premise-docker/showcase-client-server-app/showcase-+-business-intelligence.md)
* [AWS Setup](on-premise-docker/aws/README.md)
  * [AWS ECS/Fargate](on-premise-docker/aws/aws-ecs-fargate.md)
  * [Cache - Amazon ElastiCache](on-premise-docker/aws/cache-amazon-elasticache.md)
* [Microsoft Azure Setup](on-premise-docker/azure/README.md)
  * [Database - Azure CosmosDB](on-premise-docker/microsoft-azure-setup/database-azure-cosmosdb.md)
  * [Cache - Azure Cache for Redis](on-premise-docker/microsoft-azure-setup/cache-azure-cache-for-redis.md)
  * [Azure Container Apps](on-premise-docker/microsoft-azure-setup/azure-container-apps.md)
* [Azure Red Hat OpenShift](on-premise-docker/azure-red-hat-openshift.md)
* [Google Kubernetes Engine (GKE)](on-premise-docker/google-kubernetes-engine-gke.md)
* [Kubernetes Setup](on-premise-docker/kubernetes-setup/README.md)
  * [Kubernetes Setup with Business Intelligence](on-premise-docker/kubernetes-setup/kubernetes-setup-with-business-intelligence.md)
* [Logging options](on-premise-docker/logging-options.md)
* [CD/CI Pipelines](on-premise-docker/cd-ci-pipelines/README.md)
  * [Azure DevOps CICD Pipelines](on-premise-docker/cd-ci-pipelines/azure-devops-pipelines.md)
  * [Using Migration script (old way)](on-premise-docker/cd-ci-pipelines/using-migration-script-old-way.md)

## Terms & Conditions

* [Terms and Conditions](terms-and-conditions/terms-and-conditions.md)
* [Privacy Policy](terms-and-conditions/privacy-policy.md)
* [Service Level Agreement](terms-and-conditions/sla/README.md)
  * [Community Support](terms-and-conditions/sla/community-support-and-standard-cloud.md)
  * [Standard Cloud (SaaS)](terms-and-conditions/sla/standard-cloud.md)
  * [Silver SLA](terms-and-conditions/sla/silver\_SLA.md)
  * [Gold SLA](terms-and-conditions/sla/gold\_SLA.md)
  * [Custom SLA](terms-and-conditions/sla/custom-sla.md)
* [Sub-Processor List](terms-and-conditions/sub-processor-list.md)

***

* [Roadmap 🚲 🗺️](roadmap.md)
* [Release Notes](release-notes.md)
  * [Public Cloud](release-notes/public-cloud.md)
  * [On-Premise / Private Cloud](release-notes/on-premise-private-cloud.md)
