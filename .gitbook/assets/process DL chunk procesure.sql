---drop procedure processDRChunk
CREATE PROCEDURE processDRChunk ( @lastBatchStart int, @batchSize int ) as
DECLARE @currentBatch varchar(max);
DECLARE @API_KEY varchar(100) = '<API KEY HERE>';
DECLARE @responseText Varchar(max);
DECLARE @ruleId Varchar(100) = 'test';
DECLARE @startTime datetime;
BEGIN
-- Current set of input data
	SET @startTime = GETDATE()
	SET @currentBatch = (
							select *  from msdb.dbo.my_DR_input 
							where row# between @lastBatchStart and @lastBatchStart + @batchSize -1
							FOR JSON PATH , ROOT('data')
						);
	--print @currentBatch
-- Send current set of Input data to DecisionRules and store the response in @responseText variable
	Exec msdb.dbo.decisionRulesSolve @ruleId = @ruleId , @token =  @API_KEY, @body =  @currentBatch , @json = @responseText output , @version = NULL;
	--print 'res: ' + @responseText
	--print ' something happened'
-- Increment the loop counters and starting point for next dataset
	-- Process the results of the API call , for example insert into a result table
	-- Use the function OPENJSON to parse the response text
	-- Mapping from json to table column is done through aliases specified in the WITH clause using structure
	--	WITH ( your_column_name data_type '$[0].{json_path}' , ... ) where json path is comma sepparated path specifying position in the JSON
	
	/* Example of processing CODE */
	Insert into msdb.dbo.results
	select * from OPENJSON(@responseText,'$') WITH ( finalPrice float '$[0].prices.finalPrice' ,
										 crudePrice float '$[0].prices.crudePrice',
										 message varchar(100) '$[0].message');
	--Insert into msdb.dbo.logs
	--Values (  DATEDIFF( ms , getDATE() , @startTime ) , @lastBatchStart , @lastBatchStart + @batchSize -1 , @startTime ,getDate() )
	END