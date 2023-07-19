---
description: Public roadmap
cover: >-
  https://images.unsplash.com/photo-1475666675596-cca2035b3d79?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw0fHxieWNpY2xlfGVufDB8fHx8MTY0MzgxNTc3Mg&ixlib=rb-1.2.1&q=85
coverY: -549.6070381231672
---

# Roadmap 🚲 🗺️

## What is the roadmap about?

This section will inform you about our future intention of making DecisionRules.io even a better application for your use adding new features regularly.

{% hint style="success" %}
Some of the features don't have to meet the dates we set. It can be added sooner or later. We aim to always focus on the most important things and customer needs.
{% endhint %}

### Q4 2023 <mark style="color:yellow;">-</mark> <mark style="color:purple;">Planning</mark>

*   #### Folder Export & Import

    Have you ever wondered why you cannot export multiple rules at once? Well, we will bring this capability soon. You will be able to export the whole folder with all its rules to a single file and import it back. This way, you will be able to simply create backup files or share rules between spaces or even environments with one click.
*   #### Intermediate Columns in Decision Tables

    We will extend decision tables with intermediate columns, which will allow for custom calculations. Thanks to this, you will be able to share data between conditions and results and build more concise, flexible and efficient decision tables.

### Q3 2023 <mark style="color:yellow;">-</mark> <mark style="color:purple;">Coming Soon</mark>

*   #### Decision Table Differences

    We will add the functionality of comparing two decision tables. The user will be able to see the table differences, merge the content from the secondary table or edit the primary table arbitrarily. This feature will greatly simplify handling conflicts between distinct versions of decision tables.
*   #### Decision Tree Differences

    We will add the functionality of comparing two decision trees. The user will be able to see the tree differences, merge the content from the secondary tree or edit the primary tree arbitrarily. This feature will greatly simplify handling conflicts between distinct versions of decision trees.
*   #### Teamwork Indicator

    We will let you know who is currently viewing the same rule as you. This will help you organize your teamwork and prevent problems stemming from mutual interference of rule editors.

### Q2 2023 <mark style="color:yellow;">-</mark> <mark style="color:purple;">In Progress</mark>

*   **24/7 Service Line - **<mark style="color:green;">**Delivered**</mark>

    We launched 24/7 service line support and we are now able to respond to critical issues in the matter of hours, day and night. This is mainly important for our larger customers who need robust and fast support all around the world.
*   **Regional Clouds - **<mark style="color:green;">**Delivered**</mark>

    In addition to our global cloud, we launched three individual regional clouds for Europe, the USA, and Australia. Each regional cloud has its own environment and database so it can be guaranteed that all data are stored only in the respective region. Thanks to this, you may now use DecisionRules as a service while still keeping aligned with your data residency policy.
*   **Scripting Rule Diffs - **<mark style="color:green;">**Delivered**</mark>

    We added the functionality of comparing two scripting rules. It is now possible to view the differences between two scripting rules and edit the primary scripting rule, reflecting the differences in the way you like. This feature will greatly simplify handling conflicts between distinct versions of scripting rules. Similar rule comparison features are planned for decision tables and decision trees.
*   **Languages - **<mark style="color:green;">**Delivered**</mark>

    We added support for languages and provided translations into Czech and Spanish.
*   **Rule Alias Support - **<mark style="color:purple;">**In Progress**</mark>

    We will add support for using rule alias instead of rule ID within Management API. Thanks to this, you will be able to use rule aliases for most operations concerning rules. Together with this, we will make a general revision of security and effectiveness within the business logic treating rules and spaces.

### Q1 2023 <mark style="color:yellow;">-</mark> <mark style="color:green;">Delivered</mark>

*   **Folders in spaces - **<mark style="color:green;">**Delivered**</mark>

    We will bring better organization of rules using folders for larger spaces. We would  like to enable user and automated transfer of folders between spaces or individual physically separated environments.
*   **Include or Exclude DecisionTable columns in Solver API - **<mark style="color:green;">**Delivered**</mark>

    Our customers requested the possibility of specifying which conditions columns will be activated when calling a decision table via the Rule Solver API. It is now possible to include or exclude columns, making the solve of decision table even more flexible. [https://docs.decisionrules.io/doc/api/rule-solver-api#options](https://docs.decisionrules.io/doc/api/rule-solver-api#options)
*   **Dynamic JSON in Decision Tables and Decision Trees - **<mark style="color:green;">**Delivered**</mark>

    This feature will make it possible to create parametrizable JSON objects and fundamentally expand the possibilities of decision tables and decision trees when using integration functions or changing output data in JSON format.
*   **Hiding the content of individual decision tree nodes - **<mark style="color:purple;">**Postponed**</mark>

    We would like to make decision tree nodes collapsible to improve the overall experience when editing decision trees.
*   **Simplifying the migration of rules between environments - **<mark style="color:green;">**Delivered**</mark>

    Migration of rules is a big topic for us lately. So far, one can only manage single rules via Management API. We therefore want to provide a free customizable migration tool for anyone to use.

### Q4 2022 <mark style="color:yellow;">-</mark> <mark style="color:green;">Delivered</mark>

* **Folders in spaces - **<mark style="color:green;">**Completed, Released in January 2023**</mark>\
  We will bring better organization of rules using folders for larger spaces. We would  like to enable user and automated transfer of folders between spaces or individual physically separated environments.
* **Simplifying the migration of rules between spaces / environments -** <mark style="color:green;">**Delivered**</mark>\
  We would like to enable easier transfer of multiple linked rules between spaces and environments. You will be able to prepare and test the entire rules release, which you can then easily transfer to another space or  environment.
* **Platform upgrade to new LTS version - **<mark style="color:green;">**Delivered**</mark>\
  Now is a good time to switch to the new major LTS versions of the AWS platform that power our public cloud.
* **Default match for Decision Table - **<mark style="color:green;">**Delivered**</mark>\
  We will simplify the possibility of returning the default output in the event that no row in the decision table is fulfilled.
* **Minor improvement of working with functions in Decision Table and Decision Tree - **<mark style="color:green;">**Delivered**</mark>
* **Minor improvement of main dashboard to add links to specific rule/s in history of changes** **-** <mark style="color:green;">**Delivered**</mark>\


### Q3 2022 **-** <mark style="color:green;">**Delivered**</mark>

* **External API call from scripting rules** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>\
  We would like to enable our customers to pull data from external sources in a rule using the REST API and do a simple data transformation on it.
* **RuleFlow in RuleFlow** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>\
  We would like to allow our customers to nest RuleFlows within other RuleFlows.
* **RuleFlow upgrade (planning and analysis)** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>\
  With the growing number of users, we have received a large number of requests to improve RuleFlow. We would like to clarify the requirements and then implement some of them. You definitely have something to look forward to.
* **Sector specific use-cases** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>\
  We come across many interesting use-cases in which you use DecisionRules. We would like to outline and describe the main trends in individual sectors in such a way that it is clear how to use DecisionRules and where it has the greatest added value. We believe that this will save you some time in implementation projects.
*   **Advanced Functions and Expressions** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>\
    Our advanced features are often used in Decision Tables and Decision Trees. We're taking our feature and expression editing to a whole new level. We'll let you edit rules using VS Code on the web.





    <figure><img src="https://uploads-ssl.webflow.com/62038ffc9cd2db6132e3c782/632331e4ac75d86ea86ae8a1_Screenshot%202022-09-15%20at%2016.07.30.png" alt=""><figcaption></figcaption></figure>
* **External API call from Scripting rules , Decision Tables and Decision Trees -** <mark style="color:green;">**Delivered**</mark>\
  We would like to enable our customers to pull data from external sources in a rule using the REST API and do a simple data transformation on it.
* **Strongly typed JS/TS SDK **<mark style="color:green;">**- Delivered**</mark>
* **Video tutorials - **<mark style="color:purple;">**Postponed to Q4/2022**</mark>\
  Simple and fast work is written in our DNA. Many customers write to us why we do not yet have a video tutorial to show how easy it is to work with DecisionRules. ... Working on it.



### Q2 2022 - <mark style="color:green;">**Delivered**</mark>

* **Decision Trees** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
  * The new structure of decision trees will make your rule to edit process easier and faster because of a tree structure.
* **User friendly way to test rules** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
  * We want non-technical users to feel good with us. That's why we're working on how to easily enter input data into rules and how to display them easily. The possibility of using the JSON format will of course be retained.
* **External API call from scripting rules** <mark style="color:purple;">-</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Postponed to Q3/2022**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
  * We are gradually expanding our platform to make it easier from an integration perspective. According to customer votes, this is also related to the possibility of calling external APIs from the scripting rule.
* **Public & Managed Cloud Advanced Monitoring - **<mark style="color:green;">**Delivered**</mark>
  * DecisionRules handles millions of rules per month. Related to this is the constant improvement of our monitoring so that we can better prevent problems before they occur.
* **DecisionRules on Azure & AWS Marketplace** <mark style="color:purple;">-</mark> <mark style="color:green;">**Azure Delivered**</mark>
  * We know that for many of you it is difficult to try DecisionRules in on-premise mode on your infrastructure. For new users who are about to try DecisionRules on AWS/Azure, we are trying to create a 1-click solution for installation from the Azure/AWS Marketplace.
* **RuleFlow available in Scripting Rules - **<mark style="color:green;">**Delivered**</mark>
* **Business Intelligence API **<mark style="color:purple;">**-**</mark>** **<mark style="color:green;">**Delivered / released as separate app / currently in closed beta testing**</mark>
  * Better Power BI integration for on-premise and cloud users
* **Reworked SDKs on GitHub** - <mark style="color:green;">**Delivered**</mark>
* **ARM64 Docker Container Support - **<mark style="color:green;">**Delivered**</mark>

### Q1 2022 - <mark style="color:green;">**Delivered**</mark>

* **Rule Tagging** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
* **Rule Tagging in Management API** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
* **Audit Change log** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
* **Monitoring log -** <mark style="color:green;">**Delivered**</mark>
* **Advanced management API -** <mark style="color:green;">**Delivered**</mark>
* **CSV Import/Export** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>
* **Rules Library - Postponed**
  * Each rule made by the user can be saved in the library. Those rules will be able within the space regarding permissions. It can be helpful for rules which are used more often, for example, client validation.
* **Decision Trees** <mark style="color:purple;">-</mark> <mark style="color:purple;">**will finish in Q2 2022 -**</mark> <mark style="color:green;">**Delivered**</mark>
  * The new structure of decision trees will make your rule to edit process easier and faster because of a tree structure.
* **Better SSO Support** <mark style="color:purple;">-</mark> <mark style="color:green;">**Delivered**</mark>

### Q4 2021 - <mark style="color:green;">**Delivered**</mark>

* **Advanced permissions** - <mark style="color:green;">**Delivered**</mark>
  * Ability to assign permissions to the user within the space. Permissions will be granular, so creating your own sets of permissions will be available.
* **Bulk decision making** - <mark style="color:green;">**Delivered**</mark>
  * Evaluate more rules simultaneously, for example sending 100 inputs, and the output will be for the same amount as input was.
* **Better operator & function visualization - Delivered**
  * General overview of decision tables and easier display of help for operators and functions.
* **User Variables** - <mark style="color:green;">**Delivered for Decision Tables**</mark>
  * Define variables in the rule settings, which you can then use indefinitely in the decision table
  * The variables are versioned together with the rule
* **Education videos**
  * Guide/how-to videos alongside our documentation.
* **Rule flow - smaller features**
  * Export/import rule flow, sharing in between the spaces, graphical changes, connecting rule flows through more spaces,...
* [**Apache Kafka Connector**](api/apache-kafka-solver-api.md) - <mark style="color:green;">**Delivered**</mark>
  * Asynchronous Kafka Messages Support for Cloud and On Premise Version ([apache-kafka-solver-api.md](api/apache-kafka-solver-api.md "mention"))
* **Advanced GeoCluster** - <mark style="color:green;">**Delivered**</mark>
  * Faster resolution of rules across the globe
  * Increased resistance to outages

### Q3 2021 - <mark style="color:green;">**Delivered**</mark>

* **Rule Flow** - <mark style="color:green;">**Delivered**</mark>
  * This feature will provide an ability to put rule after rule to make a "chain," which will be executed as one rule made of more.
* **Downloadable Docker containers** - <mark style="color:green;">**Delivered**</mark>
  * If you don't want to use our web app, you can download and configure the Docker container in your environment.
* **Decision Tables operations** - <mark style="color:green;">**Delivered**</mark>
  * Filter, order by, and search functions over decision tables in the application to a better overview and edit the tables.
* **Basic Management API** - <mark style="color:green;">**Delivered**</mark>
  * Management API allows making operation with spaces/rules even without a need of using UI of DecisionRules, such as retrieve the rule lists with the appropriate information.
* **Mass operations over the rules** - <mark style="color:green;">**Delivered**</mark>
  * Editing, adding or deleting more rows in the table at the same time.

