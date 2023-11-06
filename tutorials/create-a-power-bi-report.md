---
description: >-
  This tutorial will walk you through the creation of a Power BI report using
  the DecisionRules BI API.
---

# Create a Power BI Report

DecisionRules provides the Audit Log functionality which allows to store detailed information from each run of the rule solver. The audit logs can be then accessed through our [Business Intelligence API](../api/bi-api.md), in particular its `/audit` endpoint, and used as a base for further analysis performed with the help of an arbitrary BI tool. In this tutorial, we shall start with a simple rule (a single Decision Table), call it with mock data and build a report in Power BI Desktop, all step by step.

## From a business rule to a Power BI report

Let's start! You can follow the steps below or skip to the end of the page where we provide a resume with all the necessary files, including the sample Power BI report.

### 1. Log in to DecisionRules

Go to the [login page](https://app.decisionrules.io/auth/login) and pass in your credentials. If you do not have an account yet, you can quickly create it [here](https://app.decisionrules.io/auth/register). After you log in, you should see the Dashboard.

### 2. Create a Decision Table

In your home folder click the option **+Create Rule,** in the following menu choose **Decision table -> Sample ,** enter a name for the table and click **Create Rule**

<figure><img src="../.gitbook/assets/image (279).png" alt=""><figcaption><p>Create rule menu</p></figcaption></figure>

{% hint style="info" %}
If you want to create your own table, you can absolutely do so. However you will need to perform additional modification in the provided PowerBI file to import your data ( these are described at the end of this page )
{% endhint %}

### 3. Test the rule

Now we should check that the rule does what we need. This will be a simple task. First open the newly created rule and visit the **Rule Settings** tab and (if not already published) change the state of the rule from **Pending** to **Published**. This means we can request the rule solver to solve this particular rule. Next click the **Test Bench** button at the bottom of the page.

Now we can enter some input data and see what the rule does with them. Let us enter "basic" for <mark style="color:purple;background-color:purple;">**productType**</mark>, "month" for <mark style="color:purple;background-color:purple;">**period**</mark> and "SUMMER SALE" for <mark style="color:purple;background-color:purple;">**promoCode**</mark>. Upon hitting Run, we should get <mark style="color:purple;background-color:purple;">**finalPrice**</mark> equal to 5.6, <mark style="color:purple;background-color:purple;">**crudePrice**</mark> 8 and <mark style="color:purple;background-color:purple;">**message**</mark> reading '30% discount'. In other words, the rule is telling us that with the SUMMER SALE benefit code, we get 30% discount. This is the desired behavior.

<figure><img src="../.gitbook/assets/image (280).png" alt=""><figcaption><p>Using the test bench</p></figcaption></figure>

### 4. Turn on Audit Logging

Now that we have created and tested our Decision Table, it is time to start logging! In the Rule Settings, find the **Audit Logs** slider and turn it on. The audit logging is now activated! From now on, every rule solve will generate an audit log and save it to the database. You do not need to turn on **Debug Data** now, that is just some supplementary data about your rule solve. For the sake of this tutorial, you may set the **Audit Lifespan** for 1 day, since you do not need the audits to live for any longer periods.

### 5. Run some rule requests

You can now simply use Test Bench to call the rule again, as in Step 3. If you choose this option, enter various input values and **Run** the rule couple of times so that there is some data to query later. Try all the listed benefit codes. Alternatively, you may of course make some calls to the rule solver via the [Rule Solver API](../api/rule-solver-api.md).

### 6. Generate your Business Intelligence API Key

We will use the [Business Intelligence API](../api/bi-api.md) to fetch the audit logs in Power BI. However, for it to work, you need your Business Intelligence API Key. You can quickly generate it in the **API Keys** section of the app. Just find the Business Intelligence API Keys section and click **+Add Business Intelligence API Key**. Good. You will find this key here when you need it.

### 7. Prepare your query

In this step, we shall assume you have already downloaded and installed the Power BI Desktop. If not, please do it before you continue with the tutorial.

We have all we need to prepare our first DecisionRules query in Power BI, great! From here, there are two parallel ways to continue. You can either start building the report from scratch or just download our sample report and modify it to work with your rule. Both procedures are described below.

#### Create your report from scratch

In PowerBI navigate into **Get Data (dropdown menu ) -> Blank Query ,** this opens the PowerQuery editor. In the top menu select the option **Manage Parameters** and create parameters RULE\_ID and BI\_API\_KEY which will hold values for the RuleId of the rule you created (you can copy this from the Rule Setting tab in DecisionRules) and Business Intelligence API Key (which you generated in step 6).

After setting up these parameters, select the newly created query (typically named Query1) , in the top menu select **Advanced Editor** and in paste the following code into the window and click **done**

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

Select the query again and click **Invoke** two times, this will create two tables base on the query, name one Input and the other Output

#### **Input data**

Start by removing the `output` column, then expand the column `input` to your desired form.\
Remove duplicate rows ( which might have been created by precious expansion of output data)

![](https://lh7-us.googleusercontent.com/9uW06wsiMoqMu0VS6iyDc2ecSIT7cCoJ2dM7IXoZWLlSN2eQ7UcyGGl04cXnNAgGzqhNF0mjbha-IhlFa3rs4rHC4yG\_05dwTNT-O4uE3XKwZt0BZehFV6qzwsuseVxPNiFzIcJZ3cY1OAu39nu4fDo)



#### **Output data**

Remove the `Column2.inputData` column and proceed to expand the data to your desired form (duplicate removal is not needed)

If you have successfully completed the instructions, you should have a working query now, that is, you should see some data loaded in your Power Query Editor.

{% hint style="info" %}
If the query does not return anything, check again these things: Do you have audit logging active on the rule? Did you make any calls to the rule solver (through the Test Bench or via the Rule Solver API) **after** activating it? Is your query defined correctly? Did you enter a valid Business Intelligence API Key as a query parameter ?
{% endhint %}

If everything worked well, you now have a working query which is able to obtain the audit logs from the database, and you can indeed see some records loaded.

When you are done, click **Close & Apply**. Congratulations, your query is ready now! If you need to return to the Power Query Editor at some point, you may just click the **Transform data** button.

#### Download and modify the sample report

Download the below given file and open it in Power BI Desktop. The project contains simple graphs and tables whose main purpose is to show whether or not the data is actually loaded into PowerBI.

{% file src="../.gitbook/assets/Sample time showcase.pbix" %}

{% hint style="info" %}
You will need to put your Business Intelligence API key and your RuleId into the corresponding parameters in Power query editor, as is described at the start of part 7
{% endhint %}

If your input and output model is not exactly the same as the one we have defined in Step 2, you may encounter an error. However, it can be easily removed by going to the Power Query Editor, right-clicking the particular query, going to the Advanced Editor and there fixing the column names so that they match your input/output model. Then click **Close & Apply** and you are good to go.

### 8. Play with your visuals

If you have taken the hard way and tried to build your report from scratch, you now have the opportunity to create your own visuals.

#### Creating your visuals

We will not go into detail about creating the visuals as one can read about this topic elsewhere. Let us add only a few very basic notes. In the right hand side of Power BI Desktop, there is a **Fields** area listing the queries that can be used for building custom visuals, and next to it are **Visualizations** where you can introduce and manage your visuals. So, all you need to do is choose one of the available visuals and then provide it with the fields that you would like to visualize by selecting them from your query.

Lucky visualizing!

### 9. Further suggestions

If you have reached this point, congratulations! You have successfully completed the tutorial. If you wish to learn even more, there is a couple of suggestions on what you might do next.

* Try to create a new version. Go back to DecisionRules and create a new version of the Benefit Program Sample rule (just go to its Rule Settings and click the **New Version** button). Then change the rule in some way, save it, publish it (in Rule Setting again) and use the Test Bench to call the rule several times. Return to Power BI and check whether you can see the audit logs from the new version (hit **Refresh** to see the new data).
* Try to apply some filters. Check out our [Business Intelligence API](../api/bi-api.md) documentation and try to apply filters to your query by including some query parameters to the URL in the fAudits function.
* Play with your queries. Duplicate or reference your query in the Power query editor and try to introduce new columns, group the query by some identifier, and more.
* Play with your visuals.

### Wrapping up

You have gone through all the steps towards creating your DecisionRules Power BI report. Big thumbs up! Now you have all the information you need for your successful DecisionRules reporting with Power BI. Below you find the resources used in this tutorial.



{% file src="../.gitbook/assets/Sample time showcase (1).pbix" %}

Thank you for reading!
