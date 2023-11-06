----- PREPARE THE INPUT
-- Input is evaluated in batches, set the size according the size limitations
DECLARE	@batchSize  int = 50; -- á 10.000

-- Variable that stores input data for processing
-- Setup the columns according to your data
DECLARE @json table  (Row# int,promoCode varchar(20), period Varchar(20) , productType Varchar(20) );
						 
BEGIN
-- Fetch the input data into @json variable
-- Mapping for the input JSON is done through column aliases
--		Simple alias 'example' results in { "example": columnValue }
--		Alias sepparated by dots 'example.data' results in nested JSON object {"example":{"data":columnValue} }
-- Column row# has to be included to allow sepparation of data into batches
INSERT INTO @json  
							select    	top 100
														  ROW_NUMBER() over (order by promoCode desc,period,productType) row#,
														  tab.promoCode 'promoCode' ,
														  tab.period 'period' , 
														  tab.productType  'productType'
														from dbo.my_DR_input tab
								;
-- Declaration of auxiliary variables			
DECLARE @inputCount int = (select COUNT(*) from @json );
DECLARE @iter int = 1;
DECLARE @lastBatchStart int = 1;
DECLARE @currentBatch varchar(max);
DECLARE @responseText Varchar(max);
DECLARE @lastTime datetime;
SET @lastTime = (select GetDATE() );
DECLARE @time datetime;
DECLARE @API_KEY varchar(100) = '<API KEY HERE>';

-- Loop through the input data in @json table and for each batch evaluate in DecisionRules
WHILE @iter <= @inputCount
	BEGIN
	print 'evaluating batch'  + str(@iter) 
	SET @time = (select GetDATE() );
-- Current set of input data
	SET @currentBatch = (
							select *  from @json 
							where row# between @lastBatchStart and @lastBatchStart + @batchSize -1
							FOR JSON PATH , ROOT('data')
						);

	print 'batch load time'+ str(DATEDIFF( ms ,  @time, getDATE() ));
	SET @time = (select GetDATE() );
-- Send current set of Input data to DecisionRules and store the response in @responseText variable
	Exec dbo.decisionRulesSolve @ruleId = 'test' , @token =  @API_KEY, @body =  @currentBatch , @json = @responseText output , @version = NULL;
	print 'evaluation time'+ str(DATEDIFF( ms ,  @time, getDATE() ));
	print 'evaluation done batch' + str(@iter);
-- Increment the loop counters and starting point for next dataset
	SET @lastBatchStart = @lastBatchStart + @batchSize;
	SET @iter = @iter + @batchSize;

	-- Process the results of the API call , for example insert into a result table
	-- Use the function OPENJSON to parse the response text
	-- Mapping from json to table column is done through aliases specified in the WITH clause using structure
	--	WITH ( your_column_name data_type '$[0].{json_path}' , ... ) where json path is comma sepparated path specifying position in the JSON
	
	/* Example of processing CODE */
	Insert into results
	select * from OPENJSON(@responseText,'$') WITH ( finalPrice float '$[0].prices.finalPrice' ,
										 crudePrice float '$[0].prices.crudePrice',
										 message varchar(100) '$[0].message');
	END


select 'time elapsed' , DATEDIFF( ms , getDATE() , @lastTime ), 'RECORDS PROCESSED COUNT' , @inputCount

END;



