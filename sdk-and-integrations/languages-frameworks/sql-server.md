# SQL Server



## Database setup

Depending on the current configuration of your database you might need to change some settings to be able to exectute the necessary API Calls. The setup should be as follows

```plsql
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO
```

{% file src="../../.gitbook/assets/SQL SERVER create my_DR_input.sql" %}
Create the My\_DR\_input table
{% endfile %}

{% file src="../../.gitbook/assets/SQL server create results.sql" %}
Create the RESULTS table
{% endfile %}

## Methods of processing

First we will take a look at how to setup a simple serial call, that processes multiple API Calls one after another, and then we will expand on it using parallel API Calls that can be useful in the cases where you need to evaluates very large sets of data.&#x20;



### Method 1 : Serial Approach

Using this method, if we run more than one API Call we execute them one after another.

First we need to setup  a procedure which will take as input the ruleId , your API key , body of the request and version, and returns the response JSON



{% file src="../../.gitbook/assets/decisionRulesSolve function.sql" %}
decisionRulesSolve function full code
{% endfile %}

<pre class="language-plsql"><code class="lang-plsql">--DROP PROCEDURE decisionRulesSolve;
CREATE PROCEDURE decisionRulesSolve(@ruleId Varchar(50) , @token Varchar(100) , @body Varchar(max) , @json Varchar(max) OUTPUT ,@version int )
AS

BEGIN
-- DecisionRules URL
-- If version is provided ad '/version_num' to URL
IF @version IS NULL SET @version = '' ELSE SET @version = '/' + str(@version) 
-- Setup the API key authentication
IF @token IS NULL SET @token = 'Bearer &#x3C;Default Token>' ELSE SET @token = 'Bearer ' + @token;
<strong>IF @body IS NULL SET @body = '{"data": {}}';
</strong>-- Construct the API endpoint
DECLARE @URL NVARCHAR(MAX) = 'http://api.decisionrules.io/rule/solve/' + @ruleId ;
-- Variables for executing API Call
Declare @Object as Int;
Declare @ResponseText as Varchar(max);
Declare @status as Varchar(max);
Declare @statusText as Varchar(max);

-- Temporary table for storing parsed response
-- ( storing the clob into table circumvents possible error if response is large)

Declare @tempTable table ( json_table varchar(max) );

-- API Call setup
-- Initiate object
Exec sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
-- Specify type of call
Exec sp_OAMethod @Object, 'open', NULL, 'post',
       @URL,
       'False'
-- Set Bearer token header
Exec sp_OAMethod @Object , 'setRequestHeader' , NULL , 'Authorization' , @token
-- Set Content type Header
Exec sp_OAMethod @Object , 'setRequestHeader' , NULL , 'Content-type' , 'application/json'
-- Send call, with data in body
Exec sp_OAMethod @Object, 'send' , NULL , @body
-- Store the calls response
Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
-- Get status
exec sp_OAGetProperty @Object, 'status' , @status OUT
-- Get Status text
Exec sp_OAMethod @Object, 'statusText', @statusText OUTPUT

INSERT INTO @tempTable Exec sp_OAMethod @Object, 'responseText'
-- Load response text
SET @json = (select * from @tempTable );
Exec sp_OADestroy @Object

END;

;
</code></pre>



Now lets take a look at the main script that takes the data from the database, sends them to DecisionRules and stores the output. We will describe the code bellow in parts, but here is the full file

{% file src="../../.gitbook/assets/SQL server DR evaluation.sql" %}
Main processing script
{% endfile %}

## Load data from database

In the process we first load the data from potentionaly several table into one table variable. The structure of the input JSON is then set according to the aliases of the columns ( simple alias with create a simple json object, but you can create a nested object using the  dot notation e.g."root.nestedValue"



```plsql
DECLARE @json table  (Row# int,promoCode varchar(20), period Varchar(20) , productType Varchar(20) ,first_name varchar(20) , last_name varchar(20) );
						 
BEGIN
-- Fetch the input data into @json variable
-- Mapping for the input JSON is done through column aliases
--		Simple alias 'example' results in { "example": columnValue }
--		Alias sepparated by dots 'example.data' results in nested JSON object {"example":{"data":columnValue} }
-- Column row# has to be included to allow sepparation of data into batches
INSERT INTO @json  
select    	
  ROW_NUMBER() over (order by promoCode desc,period,productType) row#,
  tab.promoCode 'promoCode' ,
  tab.period 'period' , 
  tab.productType  'productType',
  'John' 'name.first_name',
  'Doe' 'name.last_name'
from dbo.my_DR_input tab
```



## Transform data to JSON

To transform the data to JSON we use the FOR JSON PATH clause which creates  a json object from table with structure according to the column aliases. We can also specify the ROOT('data') clause which creates the input json with the necessary wrapper automaticaly



```plsql
SET @currentBatch = (
select *  from @json 
where row# between @lastBatchStart and @lastBatchStart + @batchSize -1
FOR JSON PATH , ROOT('data')
						);
```



## Execute the API call

To get the result of an API call, we use the procedure decisionRulesSove, that we created.&#x20;

Response of the call is then returned through the @json output variable

```plsql
Exec dbo.decisionRulesSolve @ruleId = 'test' , @token =  '<API KEY HERE>', @body =  @currentBatch , @json = @responseText output , @version = NULL;

```



## Parsing the response

To get the data from the response JSON you can use the OPENJSON function, where in the WITH clause you specify the names and data types of field you want to extract and their location in the json File.

The output of this function you can then use for any DML statements, in out example an INSERT into the RESULTS table

```plsql
Insert into results
select * from OPENJSON(@responseText,'$')
 WITH (  finalPrice float '$[0].prices.finalPrice' ,
	 crudePrice float '$[0].prices.crudePrice',
	 message varchar(100) '$[0].message');
END
```

### Method 2: Parallel approach

{% hint style="info" %}
This approach will not work in SQL Server Express Edition, since it does not give you access to SQL server Agent&#x20;
{% endhint %}

To execute API calls in parallel we will take advantage of Jobs and the SQL server agent. Unfortunately there is no package that would serve the same purpose as `DBMS_PARALLEL` does in Oracle so the code might be a little bit more complicated in this case.

{% file src="../../.gitbook/assets/process DL chunk procesure.sql" %}
Process part of input procedure
{% endfile %}

All we need to do is to convert the previous code into a procedure, that loads only rows specified by the input parameters

```plsql
CREATE PROCEDURE processDRChunk ( @lastBatchStart int, @batchSize int ) 
as
BEGIN
DECLARE ...
SET @currentBatch = (
select *  from msdb.dbo.my_DR_input 
where row# between @lastBatchStart and @lastBatchStart + @batchSize -1
FOR JSON PATH , ROOT('data')
);
-- Rest of the code
---
END
```

{% hint style="info" %}
Please provide your Solver API key in the `API_KEY` variable
{% endhint %}

Now we need to create a script that sets up and run a job for entire input divided into chunk of predefined size

{% file src="../../.gitbook/assets/SQL Server parallel.sql" %}
Create and run jobs
{% endfile %}

```plsql
DECLARE @cnt int;
--  size of one batch
DECLARE @chunkSize int = 1000;
-- variable that stores current parallel command
DECLARE @cmd varchar(1000);
-- prefix for all created jobs
DECLARE @jobPrefix varchar(7) = 'MyDRJob';
-- variable to store current jobname
DECLARE @jobName varchar(100) ;
DECLARE @iter int = 1 ;
DECLARE @runningJobsCount int = 0;
-- maximum parallel calls
DECLARE @parallelLevel int = 4;
BEGIN
-- count of inputs
SET @cnt = ( select count(*) from msdb.dbo.my_dr_input );
print @cnt
WHILE @iter <= @cnt
	BEGIN
	-- prepare command
	SET @cmd = 'set textsize -1 exec msdb.dbo.processDRChunk @lastBatchStart = ' + str(@iter) + ' , @batchSize = '+ str(@chunkSize)  + ';'
	-- prepare jobname
	SET @jobName = @jobPrefix + trim(str( @iter )) ;
	print 'setting up job: ' + @jobName
	-- If maximum number of jobs is running then wait
	while @runningJobsCount > @parallelLevel
		BEGIN
			print 'Waiting for others to finish, currently running: ' + str(@runningJobsCount)
			waitfor delay '00:00:01'
			SET @runningJobsCount = (select count(*) from sysjobs where name like @jobPrefix + '%');
		END;
	-- Create job that deletes after succesful execution
	exec sp_add_job @job_name = @jobName , @delete_level = 1 ;
	-- Add the command to step
	exec sp_add_jobstep @job_name = @jobName , @step_name = 'First' , @command = @cmd;
	-- specify server
	exec sp_add_jobserver @job_name = @jobName;
	-- Start the job
	exec sp_start_job @job_name = @jobName ;

	print 'job ran: ' + @jobName
	
	SET @iter = @iter + @chunkSize 
	SET @runningJobsCount = (select count(*) from sysjobs where name like @jobPrefix + '%');
	END
END
```

We need to explicitly watch how many jobs are running in parallel by setting the `@parallelLevel` variable, set this variable according to your DecisionRules server specifications

