---
description: >-
  These instructions describe how to connect Power BI to the Business
  Intelligence API.
---

# Connect Power BI to Business Intelligence API

DecisionRules allow to generate logs from each rule solver run and get them via the [Business Intelligence API](../api/bi-api.md). The obtained data can be then used in BI tools to build analyses and visualizations. In this article, we describe this process for the case of Power BI.

## How to Connect Power BI to Business Intelligence API?

There are a couple of steps to follow.

{% hint style="info" %}
If you would like to go step by step or download a sample report, you may also take advantage of our [Power BI Tutorial](../tutorials/create-a-power-bi-report.md).
{% endhint %}

### Get Data

Open new project in Power BI Desktop and click the **Transform data** button in the Queries section of the menu (under the Home tab). This will open the Power Query Editor. In the Queries box on the left-hand side of the editor, right-click and select New Query -> Blank Query from the drop-down menu. Then right-click the new Query1 item and select Advanced Editor from the drop-down menu.

Now, copy paste the following code.

```
(Page as number) =>
let
    Source = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=your-api-key-here&page="&Number.ToText(Page)))[audits]
in
    Source
```

{% hint style="info" %}
Do not forget to copy paste your own **Business Intelligence API Key** into the URL above. You can generate your Business Intelligence API Key in the API Keys section of the app.
{% endhint %}

Next right-click the created query, select Rename and enter **`fAudits`** as the name. Note that this is only a helper function preparing our source. We are now going to use this function to loop over pages of audit data and load all data that are available.

Create new Blank Query (in the same way as before), open the Advanced Editor again and copy paste the following code.

```
let
   Source = List.Distinct(List.Generate(()=>
[Result = if List.IsEmpty(fAudits(1)) then null else fAudits(1) , Page=1],
each  [Result] <> null,
each [Result =  if List.IsEmpty(fAudits([Page])) then null else fAudits([Page]) , Page=[Page]+1],
each [Result])),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "audit"}}),
    #"Expanded audit" = Table.ExpandListColumn(#"Renamed Columns", "audit"),
    #"Expanded audit1" = Table.ExpandRecordColumn(#"Expanded audit", "audit", {"guid", "baseId", "version", "correlationId", "type", "status", "outputSchema", "createdIn", "inputSchema", "tags", "name", "lastUpdate", "apiKey", "inputData", "outputData", "timestamp"}, {"guid", "baseId", "version", "correlationId", "type", "status", "outputSchema", "createdIn", "inputSchema", "tags", "name", "lastUpdate", "apiKey", "inputData", "outputData", "timestamp"})
in
    #"Expanded audit1"
```

Save the query.

{% hint style="info" %}
Power Query will probably show you a warning and ask you to _Please specify how to connect._ If this happens, just click the **Edit credentials** button, choose **Anonymous**, do not change anything and click **Connect**.
{% endhint %}

You should see a table with your audit data. You can apply arbitrary further steps, e.g. expand the inputData and the outputData columns. Your data is ready now!

{% hint style="info" %}
If you are getting the _Expression.Error: The column 'Column1' of the table wasn't found._ error, it means that there are no audits matching your query.
{% endhint %}

### Apply Limits or Filters

If you have a lot of audit logs and downloading them takes too long, you can use a limit on the number of records or specify the time period of the solve that is of your interest. This can be done easily by including suitable query parameters in the request URL. For example, to limit the number of records to 100, we can edit the **`fAudits`** function to read

```
(Page as number) =>
let
    Source = Json.Document(Web.Contents("https://bi.decisionrules.io/audit?bi_key=your-api-key-here&limit=100&page="&Number.ToText(Page)))[audits]
in
    Source
```

{% hint style="info" %}
Do not foget to copy paste your own **Business Intelligence API Key** into the URL above. You can generate your Business Intelligence API Key in the Api keys section of the app.
{% endhint %}

More options can be found in the [Business Intelligence API section](../api/bi-api.md).

### Visualize Data

When you are satisfied with the loaded data, click Close & Apply. This will bring you back to the Power BI Desktop. Here you can add graphs and create various visualizations of any part of the audit logs you desire.
