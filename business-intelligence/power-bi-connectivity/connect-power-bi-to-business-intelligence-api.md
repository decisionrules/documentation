---
description: >-
  These instructions describe how to connect Power BI to the Business
  Intelligence API v2.
---

# Connect Power BI to Business Intelligence API

DecisionRules allows you to generate logs from each rule solver run and get them via the [Business Intelligence API](../../api/bi-api/). The obtained data can be then used in BI tools to build analyses and visualizations. In this article, we describe this process for the case of Power BI.

## How to Connect Power BI to Business Intelligence API?

There are a couple of steps to follow.

{% hint style="info" %}
If you would like to go step by step or download a sample report, you may also take advantage of our [Power BI Tutorial](create-a-power-bi-report.md).
{% endhint %}

### Create  the query

Open new project in Power BI Desktop and click the **Get data -> Blank query** button in the top menu (under the Home tab).&#x20;

<figure><img src="../../.gitbook/assets/image (274).png" alt=""><figcaption></figcaption></figure>

Create Parameters

In the top menu select the option Manage Parameters and create parameter BI\_API\_KEY which will hold values for the Business Intelligence API Key (which you generated in step 6) and create a parameter URL. Set the URL parameter to one of the values below depending on your DecisionRules hosting.

For global hosting use: `https://bi.decisionrules.io`

For the US region hosting use: `https://us.bi.decisionrules.io`

For the EU region hosting use: `https://eu.bi.decisionrules.io`

For the AU region hosting use: `https://au.bi.decisionrules.io`

For the on premise hosting solution use the following format: `https://yourUrlHere`

### Extracting Input and Output data from audit logs

For this step we have a query prepared that is functionally divided into the 4 following parts

**Part1 - Define a function to call the Business intelligence API**

In this part of the code we define a function to query the DecisionRules Business intelligence API. The function uses a parameter after to define the position of the last Audit to paginate from. We also use query parameters bi\_key, which is passed the previously defined parameter BI\_API\_KEY, and fields. The fields query parameter tells the Business Intelligence API the names of fields to fetch from your audit logs.

Part  2 - Define a recursive function to retrieve all audit logs data from the Business Intelligence API

Next up we defined a recursive function to get all your audit logs. The function checks the value for hasMore after each call to get information about the remaining audit log. When the value for hasMore is equal to false, meaning there are no more audit logs to fetch, the function returns an appended list updated of all audit logs from previous and final response and ends.

**Part 3 - Set initial parameters and call the recursive function**

Now we set initial parameters for the recursive function and call it. The function retrieves a list of audit logs as records wich we then expand to a table for future transformations in Power BI

Part 4 - Transform retrieved data

At last we transform retrieved data. This transformation ensures that the input and output data for each call are kept together in all possible cases (bulk loads, multiple outputs for one input etc..) and transforms all inputs and outputs into the record type for simplifying future transformations. Finally we decided to rename the fields correlationId, id and baseId for better understanding of their meaning to callId, solveId and ruleId.&#x20;

**Full query Code**

Now right-click the new Query1 item and select Advanced Editor from the drop-down menu and copy paste the following code.



```powerquery
let Source = () =>

let
// Part 1
// Function to call Bussines Inteligence API using parameters BI_API_KEY and after (initial is "0" and with every call changes to `cursor` value
    GetAuditLogs = (after) => 
        let
            Source = Json.Document(Web.Contents(
                URL & "/audit/v2/",
                [Query = [
                    bi_key = BI_API_KEY,
                    fields= "correlationId, id, baseId, ruleAlias, inputData, outputData",
                    after= after
                    ]
                ]))
        in
          Source,
// Part 2
// Recursive function to get audit logs until the value for hasMore is false
    FetchUntil = (initialData, initialHasMore, initialAfter, initialResponse) => 
        let
            FetchRecursive = (currentData, hasMore, after, response) =>
            let
                
                cursor = Number.ToText(response[cursor]),
                newCall = if hasMore = true then
                    GetAuditLogs(cursor)
                else
                    {},
                newHasMore = newCall[hasMore],

                newAudits = if hasMore = true and newCall <> null then
                    newCall[audits]
                else
                    {},

                updated = List.Combine({currentData, newAudits}),

                result = if hasMore = true then
                    @FetchRecursive(updated, newHasMore, cursor, newCall)
                else
                    updated
            in
                result
        in
            FetchRecursive(initialData, initialAfter, initialHasMore, initialResponse),
// Part 3
// Initial parameters and call recursive funciton with initial parameters - retrieve list of audit logs as records
    initialAfter = "0",
    initialResponse = GetAuditLogs(initialAfter),
    initialData = initialResponse[audits],
    initialHasMore = true,
    final = FetchUntil(initialData, initialAfter, initialHasMore, initialResponse),
// Part 4
    #"Converted to Table" = Table.FromList(final, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", List.Union(List.Transform(#"Converted to Table"[Column1], each Record.FieldNames(_)))),
    #"Expanded outputData" = Table.ExpandListColumn(#"Expanded Column1", "outputData"),
// Expand input and output data, added validation of types and transformation of types
    #"Add inputDataAsList" = Table.AddColumn(#"Expanded outputData", "inputDataList", each if Value.Is([inputData], type list) then [inputData] else {[inputData]}, type list),
    #"Add outputDataAsList" = Table.AddColumn(#"Add inputDataAsList", "outputDataList", each if Value.Is([outputData], type list) then [outputData] else {[outputData]}, type list),
// index inputs and outputs to bind them together
    #"Added Table" = Table.AddColumn(#"Add outputDataAsList", "Custom", each Table.FromColumns({[inputDataList],[outputDataList]},{"inputs", "outputs"} )),
    #"Add inputIndex" = Table.AddColumn(#"Added Table","CustomWithIndex", each if Value.Is([Custom], type table) then Table.AddIndexColumn([Custom],"inputIndex") else [Custom]),
    #"Expand Indexed Tables" = Table.ExpandTableColumn(#"Add inputIndex", "CustomWithIndex", List.Union(List.Transform(#"Add inputIndex"[CustomWithIndex], each Table.ColumnNames(_)))),
    #"Match inputs to outputs" = Table.FillDown(#"Expand Indexed Tables", {"inputs"}),
    #"Remove unnecessary columns" = Table.RemoveColumns(#"Match inputs to outputs", {"Custom", "inputDataList", "outputDataList", "inputData", "outputData", "inputIndex"}),
    #"Rename columns"= Table.RenameColumns(#"Remove unnecessary columns",{{"correlationId", "callId"}, {"id", "solveId"}, {"baseId", "ruleId"}})

in
    #"Rename columns"

in
Source


```

{% hint style="info" %}
Do not forget to copy paste your own **Business Intelligence API Key** into the `BI_API_KEY` parameter you created. You can generate your Business Intelligence API Key in the API Keys section of the app.
{% endhint %}

Next right-click the created query, select Rename and enter your name of choice. Note that this is only a helper function preparing our source, later you will extract from in your input and output data. &#x20;

<figure><img src="../../.gitbook/assets/image (275).png" alt=""><figcaption><p>Option to invoke the query</p></figcaption></figure>

Now if you invoke the query you should get a table with the following structure (you need to have your BI\_API\_KEY set and some audit logs generated in DecisionRules)

<div data-full-width="true"><figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXe7OLNNXJNZ5c8aRk80zk4MWno-6asgt4B0_q8BFGsKqemuSr_vp_4XPepHbXeZg5CXuAxMn5ISlA6jVpMZ2yEpSEHoqfEO4Vq7baXcRb3t-dwOzALI5OMOqbqFozup4_eEVKwU9OT2AW1LV2wSG1EOTrw?key=UUuqRLVIFfEg7au8-XUaaw" alt=""><figcaption><p>Input/Output Data</p></figcaption></figure></div>

Now it is advisable to create an invoked function, one for the input data and another for the output data. This will make them easier to work with and more manageable. You can do this by Invoking the query two times and renaming one of these to "Input data" and other to "Output data"

#### **Input data**

Start by creating an index column and then removing the `outputs` column, then expand the column `inputs` to your desired form.

**Output data**

Create an index column the same way as you did with the input query. Then remove the `inputs` column and proceed to expand the data to your desired form.

#### **Relationship between input and output data**

You can create a relationship between these two objects using the index columns that were created in the previous steps. Now you should have the data prepared for creation of your reports.

### Extracting technical data from audit logs

If you want to extract the technical data available in the logs you can create another query using the following code

```powerquery
let Source = () =>

let
// Part 1
// Function to call Bussines Inteligence API using parameters BI_API_KEY and after (initial is "0" and with every call changes to `cursor` value
    GetAuditLogs = (after) => 
        let
            Source = Json.Document(Web.Contents(
                URL & "/audit/v2/",
                [Query = [
                    bi_key = BI_API_KEY,
                    fields= "correlationId, id, baseId, ruleAlias, version, type, status, createdIn, tags, lastUpdate, solverKey, executionTime, statusCode, expirationDate, errorMessage, debugLogId, userId, spaceId, timestamp, positionId",
                    after= after
                    ]
                ]))
        in
          Source,
// Part 2
// Recursive function to get audit logs until the value for hasMore is false
    FetchUntil = (initialData, initialHasMore, initialAfter, initialResponse) => 
        let
            FetchRecursive = (currentData, hasMore, after, response) =>
            let
                
                cursor = Number.ToText(response[cursor]),
                newCall = if hasMore = true then
                    GetAuditLogs(cursor)
                else
                    {},
                newHasMore = newCall[hasMore],

                newAudits = if hasMore = true and newCall <> null then
                    newCall[audits]
                else
                    {},

                updated = List.Combine({currentData, newAudits}),

                result = if hasMore = true then
                    @FetchRecursive(updated, newHasMore, cursor, newCall)
                else
                    updated
            in
                result
        in
            FetchRecursive(initialData, initialAfter, initialHasMore, initialResponse),
// Part 3
// Initial parameters and call recursive funciton with initial parameters - retrieve list of audit logs as records
    initialAfter = "0",
    initialResponse = GetAuditLogs(initialAfter),
    initialData = initialResponse[audits],
    initialHasMore = true,
    final = FetchUntil(initialData, initialAfter, initialHasMore, initialResponse),
// Part 4
    #"Converted to Table" = Table.FromList(final, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", List.Union(List.Transform(#"Converted to Table"[Column1], each Record.FieldNames(_)))),
    #"Rename Columns" = Table.RenameColumns(#"Expanded Column1",{{"correlationId", "callId"}, {"id", "solveId"}, {"baseId", "ruleId"}})
in
    #"Rename Columns"


in
Source

```

After invoking the query your resulting table should have the following structure

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXeJ9uYAIy_tmuLW4cnMI4lWIjgfP3gH6F3OPUee9XIRdi_Qpo8STVI2HWCpQjPOkJRPzskIOWo1GHTDI-qCiivSsQLfv7lyjJB8WJpKithR_3b8zOIveqw_wjfEP8eip5KatDNid4v2h0kHx3voytJL3zM?key=UUuqRLVIFfEg7au8-XUaaw" alt=""><figcaption><p>Technical Data</p></figcaption></figure>

#### Relationship between technical data and input/output data

If you need to link both input/output and technical data together you can use the `solveId` column which contains an identifier unique to any Audit log.

### Visualize Data

When you are satisfied with the loaded data, click Close & Apply. This will bring you back to the Power BI Desktop. Here you can add graphs and create various visualizations of any part of the audit logs you desire.
