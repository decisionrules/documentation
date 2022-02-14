---
description: >-
  This tutorial describes how to connect DecisionRules data stored in MongoDB
  database from Power BI to visualize or analyze it.
---

# Connecting from Power BI

To aproach DecisionRules data (Rule Engine statistics, Rule Input/Output data etc.) seated in MongoDB database we recomend to use/setup BI Connector and MongoDB ODBC Driver for BI Connector.

![](<../.gitbook/assets/image (188).png>)

The MongoDB ODBC Driver for BI Connector provides connectivity between a SQL client and the MongoDB Connector for BI. The ODBC driver enables users to create a Data Source Name (DSN) and connect a variety of BI tools to the BI Connector. It includes the BI Connector authentication plugin, which implements the client side of MongoDB-supported authentication mechanisms.



### **Step 1 - BI Connector**

In MongoDB **create new** **User**, e.g. "dbReportUser" with Role "readAnyDatabase". In menu Security - Network Access **** also **setup IP address** of computer/server that will aproach data in MongoDB database. Finally edit configuration of MongoDB database (in Additional Settings - Advanced Settings) and **switch on** the option "**Enable Business Inteligence Connector**".

![](<../.gitbook/assets/image (186).png>)

Then choose option **Connect** - **Connect Business Intelligence Tool** and see the essential parameters for MongoDB ODBC Driver.

![](<../.gitbook/assets/image (182).png>)

### **Step 2 - ODBC Driver**

Download and **install** the suitable **ODBC Driver** for Mongo DB from:

{% embed url="https://github.com/mongodb/mongo-bi-connector-odbc-driver/releases" %}

Start the Microsoft ODBC Data Sources program (choose the program version, 64-bit or 32-bit,  which is appropriate for your system and ODBC driver version), select **System DSN**, then click **Add** and **choose** the **MongoDB ODBC** ... **Unicode Driver** from the list of available drivers. Click **OK**.

**The following ODBC parameters are required:**

* **Data Source Name:** A name of your choice
* **TCP/IP Server:** The Hostname specified in the MongoDB Connect BI Tool dialog
* **Port:** The Port number specified in the MongoDB Connect BI Tool dialog (the default is 27015)
* **Database:** The name of the DecisionRules database (the default is Decision)
* **User:** Enter either the user specified in the MongoDB Connect BI Tool dialog (in our example it is dbReportUser). The user is specified in the following format: Username?source=AuthDB where AuthDB is the authentication database for the user:\
  \- If AuthDB=admin you can omit "?source=admin" string\
  \- If you are using Username and Password (SCRAM-SHA-1) authentication, the expected authenticating database is "admin"\
  \- If you are using LDAP (PLAIN) authentication, the expected authenticating database is "$external" (EXAMPLE: myTestUser?source=$external)
* **Password:** The password that corresponds to the specified User (in our example it is dbReportUser).

Click **Test** to validate the ODBC connection. If the connection is successful, click **OK** to add the DSN. If the connection fails, check to make sure your database user is correctly authenticated for the database named in the connection.

![](<../.gitbook/assets/image (171).png>)

### Step 3 - Power BI Connection

Download the **Power BI Template File** made by eppTec - see bellow:

{% file src="../.gitbook/assets/eppTec_RuleEngine_Reports.pbix" %}

When you open this file, you will see following Warning: There are pending changes in your queries that haven't been applied. Choose "**Apply Changes**".

In the **Model** section you should see the following tables and their relationships:

![](<../.gitbook/assets/image (161).png>)

In the **Report** section you should see the prepared visualizations like "Dashboard", "API Calls per Time", "API Calls per Rule" or report of particular rule called "Client Profitability 2" (in this case of reporting a specific rule you will not see any data, this report and its data source are in template only for your inspiration how you can connect and visualize data about a particular rule). See bellow several expamples from the eppTec Power BI Template File:

![Dashboard overall](<../.gitbook/assets/image (183).png>)

![Dashboard for particular User](<../.gitbook/assets/image (151).png>)

![All API Calls in particulat Time Period](<../.gitbook/assets/image (170).png>)

![The most called Rules](<../.gitbook/assets/image (165).png>)

![Example of reporting output values for a particular Rule](<../.gitbook/assets/image (180).png>)

![Example of reporting dependencies between output and input values for a particular Rule](<../.gitbook/assets/image (160).png>)
