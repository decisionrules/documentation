---
description: >-
  These instructions describe how to connect Power BI to the Business
  Intelligence API.
---

# Connect Power BI to Business Intelligence API

DecisionRules allow to generate logs from each rule solver run and get them via the [Business Intelligence API](../api/bi-api/). The obtained data can be then used in BI tools to build analyses and visualizations. In this article, we describe this process for the case of Power BI.

## How to Connect Power BI to Business Intelligence API?

There are a couple of steps to follow.

{% hint style="info" %}
If you would like to go step by step or download a sample report, you may also take advantage of our [Power BI Tutorial](../tutorials/create-a-power-bi-report.md).
{% endhint %}

### Create  the query

Open new project in Power BI Desktop and click the **Get data -> Blank query** button in the top menu (under the Home tab).&#x20;

<figure><img src="../.gitbook/assets/image (274).png" alt=""><figcaption></figcaption></figure>

In the new window that opens, you will need to create two parameters using the Manage Parameters option in the Home ribbon, name these parameters BI\_API\_KEY and RULE\_ID and set their current values to the values of API key and Rule ID that you got from DecisionRules.



### Extracting Input and Output data from audit logs

For this step we have a query prepared that is functionally divided into the 4 following parts

#### Part1

In this part of the code we query the DecisionRules Business intelligence API and we extract a parameter `matchedCount` from the call ( the call itself uses a limit=1 setting because we do not need any data yet ).  This parameter tells us, how many logs are there for us to load, we store it in the iterations variable.

#### Part  2

Here we prepare a function that takes in an argument in the form of a number an loads the audit log, that is present at that position

#### Part 3

Now we create a loop going from 1 to iterations ( which hold the number of logs to load ) and for each iteration we call the function `FnGetOnePage` from the previous part and we connect all the logs together into one table

#### **Part 4**

In this part we extract the relevant data from the audit logs. In our case we extract the input data, output data and an Id that links these two structures together

#### Full query Code

Now right-click the new Query1 item and select Advanced Editor from the drop-down menu and copy paste the following code.

```dax
// Part 1
// Get Count of relevant Audit Logs
let
	Source = () => let
iterations = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=" & BI_API_KEY & "&rules=" & RULE_ID & "&limit=1"))[matchedCount],

// Part 2
// Prepare a function that loads one auditlog
FnGetOnePage =
(Page)  =>
let
Source = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=" & BI_API_KEY & "&rules=" & RULE_ID & "&page_size=1&page="&Number.ToText(Page)))[audits]
in
Source,
// Part 3
// Load all available logs into a table
GeneratedList =
List.Generate(
    ()=>[i=1, res = FnGetOnePage(i)],
    each [i]<=iterations,
    each [i=[i]+1, res = FnGetOnePage(i)],
    each [res]),
// Part 4
// Get Input and Output data from logs
   	 // Load data into table
   	 #"Converted to Table" = Table.FromList(GeneratedList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   	 #"Expanded Column1" = Table.ExpandListColumn(#"Converted to Table", "Column1"),
   	 // Expand Input and Output data
   	 #"Expanded Column2" = Table.ExpandRecordColumn(#"Expanded Column1", "Column1", {"outputData","inputData","id"}, {"Column1.outputData","Column2.inputData","id"}),
   	 // Additional formatting of Output and Input data accounting for the possibilities of multiple outputs and Bulk Input
   	 
   	 #"Added Custom" = Table.AddColumn(#"Expanded Column2", "Custom", each Table.FromColumns({[Column2.inputData],[Column1.outputData]})),
    	#"Add indices" = Table.AddColumn(#"Added Custom","CustomWithIndex", each if Value.Is([Custom], type table) then Table.AddIndexColumn([Custom],"index") else [Custom]),
    	#"Replaced Errors" = Table.ReplaceErrorValues(#"Add indices", {{"CustomWithIndex", null}}),
    	#"Expanded Custom" = Table.ExpandTableColumn(#"Replaced Errors", "CustomWithIndex", {"index","Column1", "Column2"}, {"CustomWithIndex.Index","CustomWithIndex.Column1", "CustomWithIndex.Column2"}),
    	#"Expanded Custom.Column2" = Table.ExpandListColumn(#"Expanded Custom", "CustomWithIndex.Column2"),
    	#"Added Conditional Column2" = Table.AddColumn(#"Expanded Custom.Column2", "nonBulkOutput", each if [CustomWithIndex.Column1] = null then [Column1.outputData] else null),
    	#"Expanded nonBulkOutput" = Table.ExpandListColumn(#"Added Conditional Column2", "nonBulkOutput"),
    	#"Added Conditional Column3" = Table.AddColumn(#"Expanded nonBulkOutput", "input", each if [CustomWithIndex.Column1] <> null then [CustomWithIndex.Column1] else [Column2.inputData]),
    	#"Added Conditional Column4" = Table.AddColumn(#"Added Conditional Column3", "output", each if [CustomWithIndex.Column1] <> null then [CustomWithIndex.Column2] else [nonBulkOutput]),
    	#"Merged Columns" = Table.CombineColumns(Table.TransformColumnTypes(#"Added Conditional Column4", {{"CustomWithIndex.Index", type text}}, "en-US"),{"id", "CustomWithIndex.Index"},Combiner.CombineTextByDelimiter("#", QuoteStyle.None),"IOid"),
   	#"Remove aux" = Table.SelectColumns(#"Merged Columns",{"IOid","input","output"}),
	#"Added Technical Id" = Table.AddColumn(#"Remove aux", "id", each Text.BeforeDelimiter([IOid],"#")),
	#"Reordered Columns" = Table.ReorderColumns(#"Added Technical Id",{"IOid", "id", "input","output"})
    in

   	 #"Reordered Columns"
in
	Source

```

{% hint style="info" %}
Do not forget to copy paste your own **Business Intelligence API Key** into the `BI_API_KEY` parameter you created. You can generate your Business Intelligence API Key in the API Keys section of the app.
{% endhint %}

Next right-click the created query, select Rename and enter your name of choice. Note that this is only a helper function preparing our source, later you will extract from in your input and output data. &#x20;

<figure><img src="../.gitbook/assets/image (275).png" alt=""><figcaption><p>Option to invoke the query</p></figcaption></figure>

Now if you invoke the query you should get a table with the following structure ( you need to have your `BI_API_KEY` and `RULE_ID` set and some audit logs generated in DecisionRules )

<figure><img src="../.gitbook/assets/image (277).png" alt=""><figcaption><p>Invoked Input/output query</p></figcaption></figure>

Now it is advisable to create to invoked function, one for the input data and another for the output data. This will make them easier to work with and more manageable. You can do this by Invoking the query two time and renaming one of these to "Input data" and other to "Output data".

#### **Input data**

Start by removing the `output` column, then expand the column `input` to your desired form.\
Remove duplicate rows ( which might have been created by precious expansion of output data)

![](https://lh7-us.googleusercontent.com/9uW06wsiMoqMu0VS6iyDc2ecSIT7cCoJ2dM7IXoZWLlSN2eQ7UcyGGl04cXnNAgGzqhNF0mjbha-IhlFa3rs4rHC4yG\_05dwTNT-O4uE3XKwZt0BZehFV6qzwsuseVxPNiFzIcJZ3cY1OAu39nu4fDo)



#### **Output data**

Remove the `Column2.inputData` column and proceed to expand the data to your desired form ( duplicate removal is not needed )

#### **Relationship between input and output data**

You can create a relationship between these two objects based on the `IOid` property, this id links a particular set of input data to its response, even if you use Bulk input. Now you should have the data prepared for creation of your reports.

### Extracting technical data from audit logs

If you want to extract the technical data available in the logs you can create another query using the following code

```dax
// Part 1
// Get Count of relevant Audit Logs
let
	Source = () => let
iterations = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=" & BI_API_KEY & "&rules=" & RULE_ID & "&limit=1"))[matchedCount],

// Part 2
// Prepare a function that loads one auditlog
FnGetOnePage =
(Page)  =>
let
Source = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=" & BI_API_KEY & "&rules=" & RULE_ID & "&page_size=1&page="&Number.ToText(Page)))[audits]
in
Source,
// Part 3
// Load all available logs into a table
GeneratedList =
List.Generate(
    ()=>[i=1, res = FnGetOnePage(i)],
    each [i]<=iterations,
    each [i=[i]+1, res = FnGetOnePage(i)],
    each [res]),
// Part 4
// Get Technical data from logs
   	 // Load data into table
   	 #"Converted to Table" = Table.FromList(GeneratedList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
     #"Expanded Column1" = Table.ExpandListColumn(#"Converted to Table", "Column1"),
     #"Expanded Column2" = Table.ExpandRecordColumn(#"Expanded Column1", "Column1", {"_id", "correlationId", "id", "baseId", "ruleAlias", "version", "type", "status", "outputSchema", "createdIn", "inputSchema", "tags", "name", "lastUpdate", "solverKey", "executionTime", "statusCode", "expirationDate", "errorMessage", "debugLogId", "userId", "spaceId", "timestamp", "size"}, {"_id", "correlationId", "id", "baseId", "ruleAlias", "version", "type", "status", "outputSchema", "createdIn", "inputSchema", "tags", "name", "lastUpdate", "solverKey",  "executionTime", "statusCode", "expirationDate", "errorMessage", "debugLogId", "userId", "spaceId", "timestamp", "size"})
in
    #"Expanded Column2"
in 
    Source
```

After invoking the query your resulting table should have the following structure

<figure><img src="../.gitbook/assets/image (278).png" alt=""><figcaption><p>Technical data</p></figcaption></figure>

#### Relationship between technical data and input/output data

If you need to link both input/output and technical data together you can use the `ID` column which contains an identifier unique to any Audit log.

### Visualize Data

When you are satisfied with the loaded data, click Close & Apply. This will bring you back to the Power BI Desktop. Here you can add graphs and create various visualizations of any part of the audit logs you desire.
