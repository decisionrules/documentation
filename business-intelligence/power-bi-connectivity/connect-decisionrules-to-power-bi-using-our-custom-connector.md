---
description: >-
  This page describes the proces of using the DecisionRules custom Power Query
  connector to import Audit Logs from DecisionRules to Power BI.
---

# Connect DecisionRules to Power BI Using Our Custom Connector

We will walk you through the process of using our custom power query connector to connect your DecisionRules instance to Power BI. DecisionRules provides the Audit Logs functionality which allows it to store detailed information from each run of the rule server. The audit logs can be then accessed through our[ Business Intelligence API](https://docs.decisionrules.io/doc/api/bi-api), in particular its `/audit/v2` endpoint, and used as a base for further analysis performed with the help of an arbitrary BI tool. In this tutorial we shall start to learn how to get the DecisionRules connector, add it to your Power BI desktop application and use it to get the desired data on which you can build a Power BI report.

## Get the DecisionRules Connector

Start by downloading the DecisionRules Connector here as .mez file:

{% file src="../../.gitbook/assets/DecisionRulesIntegration (4).mez" %}
Compiled Connector
{% endfile %}

After you have downloaded the file you have to place it in a specific location for Power BI to find the file and use it to create a custom connector. In windows place the file in the following location:

`C:\Users\[userName]\Documents\Power BI Desktop\Custom Connectors\.`

In some cases the following loaction is also acceptable as it references the same path:

<figure><img src="../../.gitbook/assets/image (23).png" alt=""><figcaption><p>Folder path</p></figcaption></figure>

{% hint style="info" %}
Please note that the folders might not exist. In that case create the required folders spelled exactly as above. If your Power BI Desktop application is open during this process you will have to restart it so that it will recognize the file.
{% endhint %}

After inserting the file in the desired location Power BI will recognize the connector and list it as an available data source.\


<figure><img src="../../.gitbook/assets/image (206).png" alt=""><figcaption></figcaption></figure>

## Get Your Data From DecisionRules Data Source

### Choose Your Hosting Region

When you choose to connect to the DecisionRules Data Source in Power BI you wil be welcomed with a window prompting for your Hosting Region Url wich is a required parameter and optional Self-Hosting Url.

<figure><img src="../../.gitbook/assets/image (248).png" alt=""><figcaption><p>Hosting Url prompt window</p></figcaption></figure>

You can choose your Hosting region from a dropdown list containing all provided hosting options. In case you are self-hosting DecisionRules Engine you wil have to select that option from the dropdown menu and additionaly provide a value for the Self-Hosting Url parameter. In case you choose a valid hosting region and enter a value for Self-Hosting Url that value will be ignored by the connector.

### Authentication

In the next step after entering your hosting url you will be asked for a Busines Intelligence API Key. You can find your key in the API Keys section of your DecisionRules Client. Create a key or use an existing one and copy and paste the value of the desired key in the Bussines Intelligence API key filed of the connector prompt window.

<figure><img src="../../.gitbook/assets/image (263).png" alt=""><figcaption><p>Authentication prompt window</p></figcaption></figure>

### Navigation

Next you will be asked to choose at least one of our two predefined functions that import Audit Logs into Power BI.

<figure><img src="../../.gitbook/assets/image (264).png" alt=""><figcaption><p>Navigation</p></figcaption></figure>

You will be provided with preview to decide wether you would like to transform data further or to load them directly into the Power BI Data Model. We suggest you choose the transform option and further work on your data. In the next paragrafs  we will provide you with additional information on how to work with your data and details on the format the data comes in.

## Transform Imported Data

### Understand Structure

If you are familiar with the Audit Logs section in the DecisionRules Client you should grasp the structure the data imorted to Power Query easily.  We will give you a brief description of the structure of the data and the values they hold to help you decide on transformations.

#### Structure of Input and Output data

After importing the Input/Output data you will find a table in the structure as shown on the picture bellow.

<figure><img src="../../.gitbook/assets/image (265).png" alt=""><figcaption><p>Input Output Data</p></figcaption></figure>

First three columns are id columns that we discused in the paragraph [#understand-structure](connect-decisionrules-to-power-bi-using-our-custom-connector.md#understand-structure "mention"). Other columns related to rule description are `ruleAlias` and `positionID`. `ruleAlias` holds a unique alias for each rule and can be changend in the DecisionRules Client. It serves as a better readable substitue for `ruleId`. `positionId` is a numerical value that describes the position of an Audit Log within all audit logs. Finaly there are the `inputs` and `outputs` columns wich contain a type [record ](https://learn.microsoft.com/en-us/powerquery-m/m-spec-types#record-types)value. It can be unwrapred as it contains additional columns wich are a identical to your input or output model as defined in DecisionRules Client. Each output is in row with its input. Our connector ensures that no matter how many rules were called and how many inputs and outputs were present in one call each row represents only one input and its output value.

#### Structure of Technical Data

If you choose to import Technical Data you will find a table that holds a structure as shown on the picture.&#x20;

<figure><img src="../../.gitbook/assets/image (266).png" alt=""><figcaption><p>Technical Data</p></figcaption></figure>

Note that the picture doesn't show the entire table. That is because technical data describe everithing there is to know about a call and a rule. You will find our standard id columns as well as descriptive information about rules like `ruleType`, `version`, `tags`, `createdIn`, `lastUpdate`. You will also be able to see information about each call made by the solver engine such as `status`, `executionTime`, `errorMessage` or `timestamp`. Technical data also hold information about the user who is responsible for the call like `userId` or `solverKey`.&#x20;

#### Create a Relationship

To crate a relationship between these two queries in the Data Model in Power BI we suggest you use the `correlationId` column as it contains an identifier unique to any Audit Log or `Id` wich is a unique identifier to each rule solve. This realy depends on the purpose of your analysis.

#### Visualize Data

When you are satisfied with the loaded data, click Close & Apply. This will bring you back to the Power BI Desktop. Here you can add graphs and create various visualizations of any part of the audit logs you desire.
