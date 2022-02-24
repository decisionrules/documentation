---
description: >-
  This tutorial describes how to connect DecisionRules data stored in MongoDB
  database from Power BI to visualize or analyze it.
---

# Connecting from Power BI

To aproach DecisionRules data (Rule Engine statistics, Rule Input/Output data etc.) seated in MongoDB database we recomend to use/setup BI Connector and MongoDB ODBC Driver for BI Connector.

![](<../.gitbook/assets/image (188).png>)

The MongoDB ODBC Driver for BI Connector provides connectivity between a SQL client and the MongoDB Connector for BI. The ODBC driver enables users to create a Data Source Name (DSN) and connect a variety of BI tools to the BI Connector. It includes the BI Connector authentication plugin, which implements the client side of MongoDB-supported authentication mechanisms.



### **Step 1 - MongoDB**

In section Security - Database Access **create new** **User**, e.g. "dbReportUser" with Role "readAnyDatabase".

In section Security - Network Access **** also **setup IP address** of host that will aproach your MongoDB database (value 0.0.0.0/0 means Any host).



### **Step 2 - BI Connector**

The MongoDB Connector for BI allows you to use your BI tool of choice to visualize, discover, and report against MongoDB data using standard SQL queries. There are two options how to put it between ODBC Driver and MongoDB:

#### A) MongoDB Cloud solution

If you run your DecisionRules on MongoDB Atlas (MongoDB Cloud Services), just edit configuration of MongoDB database (in Additional Settings - Advanced Settings) and **switch on** the option "**Enable Business Inteligence Connector**".

![](<../.gitbook/assets/image (186).png>)

Then choose option **Connect** - **Connect Business Intelligence Tool** and see the essential parameters for MongoDB ODBC Driver.

![](<../.gitbook/assets/image (182).png>)

#### **B)** MongoDB on-premis solution

If you run your DecisionRules on MongoDB on-premis installation, you have to first **download and install** (Prerequisite: [Visual C++ Redistributable for Visual Studio 2015](https://www.microsoft.com/en-us/download/details.aspx?id=48145) has been installed on your host) the suitable **BI Connector** for MongoDB from:

{% embed url="https://www.mongodb.com/try/download/bi-connector" %}

**Run the downloaded **_**.msi**_** file** and follow the wizard instructions to install the files. The binaries install into a _bin_ directory (e.g. _C:\Program Files\MongoDB\Connector for BI\2.14\bin_) inside the installation directory. If a prior version exists, you **might need to configure your system services** **to launch the new installation**. You can delete the old binaries.

To help you get started, a sample _mongosqld_ [configuration file](https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#std-label-config-format) named _example-mongosqld-config.yml_ is included with the installation package. To learn how to start BI Connector with a configuration file, refer to the _mongosqld_ documentation section on the [Configuration File](https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#std-label-config-format).

You are now ready to launch the BI Connector, but remember, if your MongoDB instance uses authentication, your BI Connector instance must also use authentication. The user that connects to MongoDB via the _mongosqld_ program must have permission to read from all the namespaces you wish to sample data from.

**BI Connector, when running as a system service, requires** a configuration file with the _mongosqld.systemLog.path_ setting specified. Using your preferred text editor, **create a **_**mongosqld.conf**_** file**. To review the configuration file options, see [Configuration File](https://docs.mongodb.com/bi-connector/master/reference/mongosqld/#std-label-config-format). For example:

_systemLog:_\
&#x20;   _path: 'C:\logs\mongosqld.log'_\
_net: bindIp: '127.0.0.1'_\
&#x20;   _port: 3307_

All the file paths in your configuration file must be absolute and wrapped in single quotes.\
**To install and run **_**mongosqld**_** as a system service, run the following commands**:

_"C:\Program Files\MongoDB\Connector for BI\2.14\bin\mongosqld.exe" install --config "\mongosqld.conf"_\
_net start mongosql_

Windows returns _mongosql service installed_ if your installation succeeded. Once BI Connector is up and running, you are ready to begin using it with your preferred BI tool.

### **Step 3 - ODBC Driver**

**Download and install** the suitable **ODBC Driver** for MongoDB from:

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

### Step 4 - Power BI Connection

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
