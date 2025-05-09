---
description: Public Roadmap of the DecisionRules platform
cover: >-
  https://images.unsplash.com/photo-1475666675596-cca2035b3d79?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw0fHxieWNpY2xlfGVufDB8fHx8MTY0MzgxNTc3Mg&ixlib=rb-1.2.1&q=85
coverY: -549.6070381231672
---

# Roadmap

## What is the Roadmap About?

The roadmap serves as a general plan of the future development. It includes new features as well as significant improvements of the software or services.

{% hint style="success" %}
Some of the features don't have to meet the dates set. They can be released sooner or later. We always focus on the most important things and customer needs.
{% endhint %}

### Q2 2025 <mark style="color:purple;">In Progress</mark>

#### AI Assistant <mark style="color:green;">**Delivered**</mark>

With the rapid advancement of language models, we are committed to bringing the power of AI to all our users. We're proud to introduce a simple yet groundbreaking feature: the **AI Assistant**. This tool can generate decision tables based on natural language prompts. Future updates will further enhance its capabilities.

#### Jobs <mark style="color:purple;">**In Progress**</mark>

Some customers need to perform extensive calculations over large data sets—processes that can take minutes or even hours. This powerful new feature will enable DecisionRules to support such use cases out of the box.

#### DB Connectors <mark style="color:purple;">**In Progress**</mark>

We are developing the ability to connect DecisionRules directly to your database. This will allow you to perform custom queries and read/write operations during decision execution. It’s a significant step for customers needing to compute over large data sets efficiently.

#### Rule Templates <mark style="color:purple;">**In Progress**</mark>

As part of our Q1 redesign, we introduced **Templates**, a library of pre-built rules that users can learn from, draw inspiration from, or use as starting points. In Q2, we’re expanding this library with new solution examples across industries such as finance, insurance, e-commerce, logistics, and more.

#### Portuguese Web Localization <mark style="color:purple;">**In Progress**</mark>

We’re adding Portuguese localization to our website to align with the existing localization of the DecisionRules application, helping us better serve Portuguese-speaking markets.

#### Security Improvements <mark style="color:purple;">**In Progress**</mark>

We remain deeply committed to maintaining and enhancing the security and resilience of our platform. This quarter, we are conducting disaster recovery and penetration testing, and we are establishing new internal standards for regular security testing moving forward.

<div align="left"><figure><img src="../.gitbook/assets/FinancovanoEU (1).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Q1 2025 <mark style="color:green;">Delivered</mark>

#### Workflow Performance <mark style="color:green;">**Delivered**</mark>

We will improve upon the workflow performance to increase the effectivity of the calculation for bulk payloads with large numbers of inputs. This will be achieved by improving workflow bulk solve logic and adding a couple of new features, like the ability to call business rules with bulk input and the so-called parallel foreach, which allows to loop over arrays and run the loop branches in parallel.

#### Jobs <mark style="color:purple;">**Continued to Q2**</mark>

Some of our customers need to make extensive calculations over large data sets which would take minutes and hours instead of seconds. Thanks to this ground-breaking feature, DecisionRules will support this use-case out of the box.

#### DB Connectors <mark style="color:purple;">**Continued to Q2**</mark>

We are working on the ability to connect DecisionRules directly with your database. With this feature, you will be able to make custom queries, reading and writing data during your decision-making process. This will greatly help our clients seeking the ability to perform computations over large data sets.

#### Design Improvements <mark style="color:green;">**Delivered**</mark>

We are constantly trying to make our app more user-friendly and easy to use. Driven by this effort, we would like to present an updated app layout with better and more logical structure and improved user experience.

<div align="left"><figure><img src="../.gitbook/assets/FinancovanoEU (1).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Q4 2024 <mark style="color:green;">Delivered</mark>

#### Performance/Redis  <mark style="color:green;">**Delivered**</mark>

We will prepare an update of the DecisionRules server with optimized queries to Redis and support Redis cluster mode. This will improve the performance of the solver for high-traffic applications and enable to use computation resources more effectively.

#### Workflow On-Premise  <mark style="color:green;">**Delivered**</mark>

We will release DecisionRules version 1.19.0+ for on-premise/private cloud, therefore bringing the new powerful features currently available in the public cloud to our on-premise customers. The most important features include workflow, calculation columns and UX improvements in decision tables and a significant performance boost.

#### Design Improvements  <mark style="color:green;">**Delivered**</mark>

We are dedicated to continuously improving the UX/UI of the application to make it more efficient and smooth for the end users. This time we preparing a couple of more significant changes, like an update of the login/registration forms, the layout, and some of the inner components of the app.

#### Offline License  <mark style="color:green;">**Delivered**</mark>

We will implement an offline licensing mechanism to make DecisionRules available to on-premise/private cloud customers who cannot use the standard online license for reasons specific to their environment.

<div align="left"><figure><img src="../.gitbook/assets/FinancovanoEU (1).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Q3 2024 <mark style="color:green;">Delivered</mark>

#### Workflow  <mark style="color:green;">**Delivered**</mark>

We will release a brand new rule type – the workflow – which will allow you to easily build complex flows of rules with support for branching, external API calls, in-rule scripting, possibility to call other rules with different strategies, data transformations, and much more.

#### Calculation Columns  <mark style="color:green;">**Delivered**</mark>

We will enrich the decision table with calculation columns so that you can perform custom calculations anywhere in the table, even in the conditions section.

#### Decision Table UI/UX Improvements  <mark style="color:green;">**Delivered**</mark>

We are committed to provide some important improvements of the decision table UI/UX to make to work with decision table more smooth and effortless. We will improve the behavior of individual cell and make its editing easier, and add ways for easier value transfer across cells.

#### **Excel Add-in** <mark style="color:green;">**Delivered**</mark>

We will release an Excel add-in that will allow Excel users to call DecisionRules and solve rule with data from a chosen Excel sheet. Upon one click, the add-in will call DecisionRules with the specified input data, and create a new sheet with the outputs.

#### **Power BI Connector** <mark style="color:green;">**Delivered**</mark>

We will build a Power BI connector which will simplify connecting Power BI to our Audit API. You will be able to simply choose the connector, enter the BI Key and the filter, and load the audit logs in question without writing any custom code.

<div align="left"><figure><img src="../.gitbook/assets/FinancovanoEU (1).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Q2 2024 <mark style="color:green;">Delivered in Q3</mark>

#### Workflow <mark style="color:purple;">**Continued to Q3**</mark>

We will release a brand new rule type – the workflow – which will allow you to easily build complex flows of rules with support for branching, external API calls, in-rule scripting, possibility to call other rules with different strategies, data transformations, and much more.

#### Calculation Columns <mark style="color:purple;">**Continued to Q3**</mark>

We will enrich the decision table with calculation columns so that you can perform custom calculations anywhere in the table, even in the conditions section.

#### Decision Table UI/UX Improvements <mark style="color:purple;">**Continued to Q3**</mark>

We are committed to provide some important improvements of the decision table UI/UX to make to work with decision table more smooth and effortless. We will improve the behavior of individual cell and make its editing easier, and add ways for easier value transfer across cells.

<div align="left"><figure><img src="../.gitbook/assets/FinancovanoEU (1).png" alt="" width="188"><figcaption></figcaption></figure></div>

### Q1 2024 <mark style="color:green;">Delivered</mark>

#### Organization <mark style="color:green;">**Delivered**</mark>

We will allow for centralized management of spaces, accounts, and permissions by an organization admin. The admin will be able to invite new members to the organization and perform actions like listing or removing the member accounts. Likewise, the admin will be able to manage the organization spaces and control the permissions of the members for the individual spaces.

#### Folders API <mark style="color:green;">**Delivered**</mark>

We will provide new endpoints for the Management API dedicated to managing folders. You will be able to perform all the basic CRUD operations over folders, and manage rules in the folder structure via the new API endpoints. These will naturally expand the Management API capabilities to folders and enable you to perform complex rule migrations.

#### Portuguese Translation <mark style="color:green;">**Delivered**</mark>

We are constantly trying to improve our accessibility for the international audience. After English and Spanish, we will provide a translation of the whole app to Portuguese. Fique atento!

### Q4 2023 <mark style="color:green;">Delivered</mark>

#### DecisionRules Academy <mark style="color:green;">**Delivered**</mark>

We will open a whole new platform for our business users to easily and effortlessly learn DecisionRules through a series of simple tutorials rich in screenshots and gifs.

#### Authentication via OAUTH <mark style="color:purple;">**Postponed**</mark>

We will enable to authenticate your calls to the Solver API via OAUTH as a more secure alternative to API Keys.

#### Dictionary <mark style="color:purple;">**Postponed**</mark>

We will introduce a new type of rule which will allow the user to set up a collection of constant values to be used in other rules within the space. These values will be easily editable and accessible. You will be able to use dictionary for storing configurations or as a simple lookup table.

#### Decision Tree Differences <mark style="color:green;">**Delivered**</mark>

We will add the functionality of comparing two decision trees. The user will be able to see the tree differences, merge the content from the secondary tree or edit the primary tree arbitrarily. This feature will greatly simplify handling conflicts between distinct versions of decision trees.

#### Rule Lock <mark style="color:green;">**Delivered**</mark>

Lately, our customers have been asking us about a way to lock an important / production rule to protect it from change or deletion. We will implement this feature for you. There will be special permissions needed for managing the lock, so you can easily prevent some users from editing the locked rules.

#### Custom Logo Branding <mark style="color:green;">**Delivered**</mark>

You can have the application show the logo of your company instead of the default DecisionRules logo. This is the first step of our custom branding, which will allow you to choose the logo, colors and types matching your company's visual identity. Available only for on-premise or private (managed) cloud solutions.

#### JS SDK Update <mark style="color:green;">**Delivered**</mark>

We will update our most used SDK to include the newest API endpoints, be aligned with the documentation and covered by automatic unit tests.

### Q3 2023 <mark style="color:green;">Delivered</mark>

#### Decision Table Differences <mark style="color:green;">**Delivered**</mark>

We will add the functionality of comparing two decision tables. The user will be able to see the table differences, merge the content from the secondary table or edit the primary table arbitrarily. This feature will greatly simplify handling conflicts between distinct versions of decision tables.

#### Decision Tree Differences <mark style="color:purple;">**Continued to Q4**</mark>

We will add the functionality of comparing two decision trees. The user will be able to see the tree differences, merge the content from the secondary tree or edit the primary tree arbitrarily. This feature will greatly simplify handling conflicts between distinct versions of decision trees.

#### Teamwork Indicator <mark style="color:green;">**Delivered**</mark>

We will let you know who is currently viewing the same rule as you. This will help you organize your teamwork and prevent problems stemming from mutual interference of rule editors.

#### Dependencies <mark style="color:green;">**Delivered**</mark>

We will allow users to view and search dependencies of all types of rules. Thanks to this, you will be able to quickly and easily see all the rules that enter a given process. The dependency search will also help when performing group operations over rules, e.g. to check whether a given operation does not break your process. The functionality will be available both in the app and via Management API.

#### Folder Export & Import <mark style="color:green;">**Delivered**</mark>

Have you ever wondered why you cannot export multiple rules at once? Well, we will bring this capability soon. You will be able to export the whole folder with all its rules to a single file and import it back. This way, you will be able to simply create backup files or share rules between spaces or even environments with one click.

### Q2 2023 <mark style="color:green;">Delivered</mark>

#### **24/7 Service Line&#x20;**<mark style="color:green;">**Delivered**</mark>

We launched 24/7 service line support and we are now able to respond to critical issues in the matter of hours, day and night. This is mainly important for our larger customers who need robust and fast support all around the world.

#### **Regional Clouds&#x20;**<mark style="color:green;">**Delivered**</mark>

In addition to our global cloud, we launched three individual regional clouds for Europe, the USA, and Australia. Each regional cloud has its own environment and database so it can be guaranteed that all data are stored only in the respective region. Thanks to this, you may now use DecisionRules as a service while still keeping aligned with your data residency policy.

#### **Scripting Rule Diffs&#x20;**<mark style="color:green;">**Delivered**</mark>

We added the functionality of comparing two scripting rules. It is now possible to view the differences between two scripting rules and edit the primary scripting rule, reflecting the differences in the way you like. This feature will greatly simplify handling conflicts between distinct versions of scripting rules. Similar rule comparison features are planned for decision tables and decision trees.

#### **Languages&#x20;**<mark style="color:green;">**Delivered**</mark>

We added support for languages and provided translations into Czech and Spanish.

#### **Rule Alias Support&#x20;**<mark style="color:green;">**Delivered**</mark>

We will add support for using rule alias instead of rule ID within Management API. Thanks to this, you will be able to use rule aliases for most operations concerning rules. Together with this, we will make a general revision of security and effectiveness within the business logic treating rules and spaces.

### Q1 2023 <mark style="color:green;">Delivered</mark>

#### **Folders in spaces&#x20;**<mark style="color:green;">**Delivered**</mark>

We will bring better organization of rules using folders for larger spaces. We would  like to enable user and automated transfer of folders between spaces or individual physically separated environments.

#### **Include or Exclude DecisionTable columns in Solver API&#x20;**<mark style="color:green;">**Delivered**</mark>

Our customers requested the possibility of specifying which conditions columns will be activated when calling a decision table via the Rule Solver API. It is now possible to include or exclude columns, making the solve of decision table even more flexible. [https://docs.decisionrules.io/doc/api/rule-solver-api#options](https://docs.decisionrules.io/doc/api/rule-solver-api#options)

#### **Dynamic JSON in Decision Tables and Decision Trees&#x20;**<mark style="color:green;">**Delivered**</mark>

This feature will make it possible to create parametrizable JSON objects and fundamentally expand the possibilities of decision tables and decision trees when using integration functions or changing output data in JSON format.

#### **Hiding the content of individual decision tree nodes&#x20;**<mark style="color:purple;">**Postponed**</mark>

We would like to make decision tree nodes collapsible to improve the overall experience when editing decision trees.

#### **Simplifying the migration of rules between environments&#x20;**<mark style="color:green;">**Delivered**</mark>

Migration of rules is a big topic for us lately. So far, one can only manage single rules via Management API. We therefore want to provide a free customizable migration tool for anyone to use.

### Q4 2022 <mark style="color:green;">Delivered</mark>

#### **Folders in spaces&#x20;**<mark style="color:green;">**Completed, Released in January 2023**</mark>

We will bring better organization of rules using folders for larger spaces. We would  like to enable user and automated transfer of folders between spaces or individual physically separated environments.

#### **Simplifying the migration of rules between spaces / environments** <mark style="color:green;">**Delivered**</mark>

We would like to enable easier transfer of multiple linked rules between spaces and environments. You will be able to prepare and test the entire rules release, which you can then easily transfer to another space or  environment.

#### **Platform upgrade to new LTS version&#x20;**<mark style="color:green;">**Delivered**</mark>

Now is a good time to switch to the new major LTS versions of the AWS platform that power our public cloud.

#### **Default match for Decision Table&#x20;**<mark style="color:green;">**Delivered**</mark>

We will simplify the possibility of returning the default output in the event that no row in the decision table is fulfilled.

#### **Minor improvement of working with functions in Decision Table and Decision Tree&#x20;**<mark style="color:green;">**Delivered**</mark>

#### **Minor improvement of main dashboard to add links to specific rule/s in history of changes** <mark style="color:green;">**Delivered**</mark>

### Q3 2022 <mark style="color:green;">**Delivered**</mark>

#### **External API call from scripting rules** <mark style="color:green;">**Delivered**</mark>

We would like to enable our customers to pull data from external sources in a rule using the REST API and do a simple data transformation on it.

#### **RuleFlow in RuleFlow** <mark style="color:green;">**Delivered**</mark>

We would like to allow our customers to nest RuleFlows within other RuleFlows.

#### **RuleFlow upgrade (planning and analysis)** <mark style="color:green;">**Delivered**</mark>

With the growing number of users, we have received a large number of requests to improve RuleFlow. We would like to clarify the requirements and then implement some of them. You definitely have something to look forward to.

#### **Sector specific use-cases** <mark style="color:green;">**Delivered**</mark>

We come across many interesting use-cases in which you use DecisionRules. We would like to outline and describe the main trends in individual sectors in such a way that it is clear how to use DecisionRules and where it has the greatest added value. We believe that this will save you some time in implementation projects.

#### **Advanced Functions and Expressions** <mark style="color:green;">**Delivered**</mark>

Our advanced features are often used in Decision Tables and Decision Trees. We're taking our feature and expression editing to a whole new level. We'll let you edit rules using VS Code on the web.

<figure><img src="https://uploads-ssl.webflow.com/62038ffc9cd2db6132e3c782/632331e4ac75d86ea86ae8a1_Screenshot%202022-09-15%20at%2016.07.30.png" alt=""><figcaption></figcaption></figure>

#### **External API call from Scripting rules , Decision Tables and Decision Trees** <mark style="color:green;">**Delivered**</mark>

We would like to enable our customers to pull data from external sources in a rule using the REST API and do a simple data transformation on it.

#### **Strongly typed JS/TS SDK&#x20;**<mark style="color:green;">**Delivered**</mark>

#### **Video tutorials&#x20;**<mark style="color:purple;">**Postponed**</mark>

Simple and fast work is written in our DNA. Many customers write to us why we do not yet have a video tutorial to show how easy it is to work with DecisionRules. ... Working on it.



### Q2 2022 <mark style="color:green;">**Delivered**</mark>

#### **Decision Trees** <mark style="color:green;">**Delivered**</mark>

The new structure of decision trees will make your rule to edit process easier and faster because of a tree structure.

#### **User friendly way to test rules&#x20;**<mark style="color:green;">**Delivered**</mark>

We want non-technical users to feel good with us. That's why we're working on how to easily enter input data into rules and how to display them easily. The possibility of using the JSON format will of course be retained.

#### **External API call from scripting rules** <mark style="color:green;">**Delivered**</mark>

We are gradually expanding our platform to make it easier from an integration perspective. According to customer votes, this is also related to the possibility of calling external APIs from the scripting rule.

#### **Public & Managed Cloud Advanced Monitoring&#x20;**<mark style="color:green;">**Delivered**</mark>

DecisionRules handles millions of rules per month. Related to this is the constant improvement of our monitoring so that we can better prevent problems before they occur.

#### **DecisionRules on Azure & AWS Marketplace** <mark style="color:green;">**Azure Delivered**</mark>

We know that for many of you it is difficult to try DecisionRules in on-premise mode on your infrastructure. For new users who are about to try DecisionRules on AWS/Azure, we are trying to create a 1-click solution for installation from the Azure/AWS Marketplace.

#### **RuleFlow available in Scripting Rules&#x20;**<mark style="color:green;">**Delivered**</mark>

#### **Business Intelligence API** <mark style="color:green;">**Delivered**</mark>

Better Power BI integration for on-premise and cloud users

#### **Reworked SDKs on GitHub** <mark style="color:green;">**Delivered**</mark>

#### **ARM64 Docker Container Support&#x20;**<mark style="color:green;">**Delivered**</mark>

### Q1 2022 <mark style="color:green;">**Delivered**</mark>

#### **Rule Tagging** <mark style="color:green;">**Delivered**</mark>

#### **Rule Tagging in Management API** <mark style="color:green;">**Delivered**</mark>

#### **Audit Change log** <mark style="color:green;">**Delivered**</mark>

#### **Monitoring log** <mark style="color:green;">**Delivered**</mark>

#### **Advanced management API** <mark style="color:green;">**Delivered**</mark>

#### **CSV Import/Export** <mark style="color:green;">**Delivered**</mark>

#### **Rules Library Postponed**

Each rule made by the user can be saved in the library. Those rules will be able within the space regarding permissions. It can be helpful for rules which are used more often, for example, client validation.

#### **Decision Trees** <mark style="color:green;">**Delivered**</mark>

The new structure of decision trees will make your rule to edit process easier and faster because of a tree structure.

#### **Better SSO Support** <mark style="color:green;">**Delivered**</mark>

### Q4 2021 <mark style="color:green;">**Delivered**</mark>

#### **Advanced permissions** <mark style="color:green;">**Delivered**</mark>

Ability to assign permissions to the user within the space. Permissions will be granular, so creating your own sets of permissions will be available.

#### **Bulk decision making** <mark style="color:green;">**Delivered**</mark>

Evaluate more rules simultaneously, for example sending 100 inputs, and the output will be for the same amount as input was.

#### **Better operator & function visualization&#x20;**<mark style="color:green;">**Delivered**</mark>

General overview of decision tables and easier display of help for operators and functions.

#### **User Variables** <mark style="color:green;">**Delivered for Decision Tables**</mark>

* Define variables in the rule settings, which you can then use indefinitely in the decision table
* The variables are versioned together with the rule

#### **Education videos**

Guide/how-to videos alongside our documentation.

#### **Rule flow Smaller Features**

Export/import rule flow, sharing in between the spaces, graphical changes, connecting rule flows through more spaces,...

#### [**Apache Kafka Connector**](../api/apache-kafka-solver-api.md) <mark style="color:green;">**Delivered**</mark>

Asynchronous Kafka Messages Support for Cloud and On Premise Version ([apache-kafka-solver-api.md](../api/apache-kafka-solver-api.md "mention"))

#### **Advanced GeoCluster** <mark style="color:green;">**Delivered**</mark>

* Faster resolution of rules across the globe
* Increased resistance to outages

### Q3 2021 <mark style="color:green;">**Delivered**</mark>

#### **Rule Flow** <mark style="color:green;">**Delivered**</mark>

This feature will provide an ability to put rule after rule to make a "chain," which will be executed as one rule made of more.

#### **Downloadable Docker containers** <mark style="color:green;">**Delivered**</mark>

If you don't want to use our web app, you can download and configure the Docker container in your environment.

#### **Decision Tables operations** <mark style="color:green;">**Delivered**</mark>

Filter, order by, and search functions over decision tables in the application to a better overview and edit the tables.

#### **Basic Management API** <mark style="color:green;">**Delivered**</mark>

Management API allows making operation with spaces/rules even without a need of using UI of DecisionRules, such as retrieve the rule lists with the appropriate information.

#### **Mass operations over the rules** <mark style="color:green;">**Delivered**</mark>

Editing, adding or deleting more rows in the table at the same time.



***
