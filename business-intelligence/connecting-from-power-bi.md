---
description: >-
  This tutorial describes how to connect DecisionRules data stored in your own
  (on-premise) MongoDB database from Power BI to visualize or analyze it.
---

# Connecting from Power BI

## How to Connect PowerBI and DecisionRules

To aproach DecisionRules data (Rule Engine statistics, Rule Input/Output data etc.) seated in MongoDB database we recomend to use/setup BI Connector and MongoDB ODBC Driver for BI Connector.

![](<../.gitbook/assets/image (188) (1) (1).png>)

The MongoDB ODBC Driver for BI Connector provides connectivity between a SQL client and the MongoDB Connector for BI. The ODBC driver enables users to create a Data Source Name (DSN) and connect a variety of BI tools to the BI Connector. It includes the BI Connector authentication plugin, which implements the client side of MongoDB-supported authentication mechanisms.



### **Step 1 - MongoDB**

In section Security - Database Access **create new** **User**, e.g. "dbReportUser" with Role "readAnyDatabase".

In section Security - Network Access **** also **setup IP address** of host that will aproach your MongoDB database (value 0.0.0.0/0 means Any host).



### **Step 2 - BI Connector**

The MongoDB Connector for BI allows you to use your BI tool of choice to visualize, discover, and report against MongoDB data using standard SQL queries. There are two options how to put it between ODBC Driver and MongoDB:

#### A) MongoDB BI Connector running in Cloud

If you run your DecisionRules on MongoDB Atlas (MongoDB Cloud Services), just edit configuration of MongoDB database (in Additional Settings - Advanced Settings) and **switch on** the option "**Enable Business Inteligence Connector**".

![](<../.gitbook/assets/image (186) (1).png>)

Then choose option **Connect** - **Connect Business Intelligence Tool** and see the essential parameters for MongoDB ODBC Driver.

![](<../.gitbook/assets/image (182) (1).png>)

#### **B)** MongoDB BI Connector running localy

We prefer to run the MongoDB BI Connector localy (it means on your local server/PC). It does not matter if your DecisionRules MongoDB is installed in your Cloud or on your local server, you have to first **download and install** (Prerequisite: [Visual C++ Redistributable for Visual Studio 2015](https://www.microsoft.com/en-us/download/details.aspx?id=48145) has been installed on your host) the suitable **BI Connector for MongoDB** from:

{% embed url="https://www.mongodb.com/try/download/bi-connector" %}

**Run the downloaded **_**.msi**_** file** and follow the wizard instructions to install the files. The binaries install into a _bin_ directory (e.g. _C:\Program Files\MongoDB\Connector for BI\2.14\bin_) inside the installation directory. You can delete the old binaries.

To help you get started MongoDB BI Connector (_mongosqld.exe_ file), a sample of [configuration file](https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#std-label-config-format) named _example-mongosqld-config.yml_ is included with the installation package. To learn how to start BI Connector with a configuration file, refer to the _mongosqld_ documentation section on the [Configuration File](https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#std-label-config-format).

**To start BI Connector localy with necessary parameters** for connecting DecisionRules MongoDB **use following example of configuration file**:

{% file src="../.gitbook/assets/mongosqld-config-for-DecisionRules.yml" %}

**Inside this file you have to edit variable "mongodb: net: uri"** by string you will find in your MongoDB, where you have tu choose option **Connect** - **Connect your application** and select DRIVER "Node.js" and its VERSION "2.2.12 or later". **The underlined text** (see picture bellow) "mongodb://.....27017" **is the value you have to writedown into the variable "mongodb: net: uri"** (in the file "mongosqld-config-for-DecisionRules.yml" file). Do not forget to **edit also variable "username" and "password"** that you have created in Step 1. &#x20;

![](<../.gitbook/assets/image (165) (1).png>)

Last very important variable in "mongosqld-config-for-DecisionRules.yml" file is "schema: path". For DecisionRules MongoDB you can **use following template of database objects definition**:

{% file src="../.gitbook/assets/schemaDecisionRules.drdl" %}

You are now ready to launch the BI Connector, but remember, if your MongoDB instance uses authentication, your BI Connector instance must also use authentication. The user that connects to MongoDB via the _mongosqld_ program must have permission to read from all the namespaces you wish to sample data from.

**In Command Prompt go to the directory where the BI Connector has been installed** (and where you put also the "mongosqld-config-for-DecisionRules.yml" and "schemaDecisionRules.drdl" files) **and write "mongosqld --config mongosqld-config-for-DecisionRules.yml"** and **press Enter**. You should see something like this:

![](<../.gitbook/assets/image (184) (1) (1).png>)

### **Step 3 - ODBC Driver**

**Download and install** the suitable **ODBC Driver** for MongoDB from:

{% embed url="https://github.com/mongodb/mongo-bi-connector-odbc-driver/releases" %}

Start the Microsoft ODBC Data Sources program (choose the program version, 64-bit or 32-bit,  which is appropriate for your system and ODBC driver version), select **System DSN**, then click **Add** and **choose** the **MongoDB ODBC** ... **Unicode Driver** from the list of available drivers. Click **OK**.

**The following ODBC parameters are required:**

* **Data Source Name:** A name of your choice
* **TCP/IP Server:** The Hostname specified in the MongoDB Connect BI Tool dialog (MongoDB BI Connector running in Cloud) or IP address (_bindIp_ variable) defined in _momgosqld_ configuration file (MongoDB BI Connector running localy)
* **Port:** The Port number specified in the MongoDB Connect BI Tool dialog (in MongoDB BI Connector running in Cloud the default is 27015, in MongoDB BI Connector running localy it is defined by variable _port_ in n _momgosqld_ configuration file)
* **Database:** The name of the DecisionRules database (the default is Decision)
* **User:** Enter either the user specified in the MongoDB Connect BI Tool dialog (in our example it is dbReportUser). The user is specified in the following format: Username?source=AuthDB where AuthDB is the authentication database for the user:\
  \- If AuthDB=admin you can omit "?source=admin" string\
  \- If you are using Username and Password (SCRAM-SHA-1) authentication, the expected authenticating database is "admin"\
  \- If you are using LDAP (PLAIN) authentication, the expected authenticating database is "$external" (EXAMPLE: myTestUser?source=$external)
* **Password:** The password that corresponds to the specified User (in our example it is dbReportUser).

Click **Test** to validate the ODBC connection. If the connection is successful, click **OK** to add the DSN. If the connection fails, check to make sure your database user is correctly authenticated for the database named in the connection.

&#x20;

![Using MongoDB BI Connector running in Cloud](../.gitbook/assets/Connect\_to\_MongoDB\_from\_PowerBI\_step10\_inCloud.png)

![Using MongoDB BI Connector running localy](../.gitbook/assets/Connect\_to\_MongoDB\_from\_PowerBI\_step10\_onPremise.png)

### Step 4 - Power BI Connection

I you named your System DSN "DecisionRules\_MongoDB" or  "MongoDB\_via\_localBIconnector" (as mentioned above) you can immediately use our **Power BI Template Files** - see bellow:

{% file src="../.gitbook/assets/eppTec_RuleEngine_Reports_BIconn_running_in_Cloud.pbix" %}

{% file src="../.gitbook/assets/eppTec_RuleEngine_Reports_BIconn_running_localy.pbix" %}

**Just download one of these files** (depending of your BI Connector solution) **and open it**. If you will see following Warning: There are pending changes in your queries that haven't been applied. Choose "**Apply Changes**".

In the **Model** section you should see the following tables and their relationships:

![](<../.gitbook/assets/image (161) (1) (1).png>)

In the **Report** section you should see the prepared visualizations like "Dashboard", "API Calls per Time", "API Calls per Rule" or report of particular rule called "Client Profitability 2" (in this case of reporting a specific rule you will not see any data, this report and its data source are in template only for your inspiration how you can connect and visualize data about a particular rule). See bellow several expamples from the eppTec Power BI Template File:

![Dashboard overall](<../.gitbook/assets/image (183) (1).png>)

![Dashboard for particular User](<../.gitbook/assets/image (151).png>)

![All API Calls in particulat Time Period](<../.gitbook/assets/image (170) (1) (1).png>)

![The most called Rules](<../.gitbook/assets/image (165) (1) (1).png>)

![Example of reporting output values for a particular Rule](<../.gitbook/assets/image (180) (1) (1) (1).png>)

![Example of reporting dependencies between output and input values for a particular Rule](<../.gitbook/assets/image (160) (1) (1).png>)
