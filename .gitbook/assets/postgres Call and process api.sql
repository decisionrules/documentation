DO $$

DECLARE
-- input count
count int = (select count(*) from my_dr_input);
-- variable to store body
body text ;
-- variable to store result
result text;
-- size of one batch
batchSize int = 20;
lastBatchStart int = 1;

rule_alias text = 'test';
API_KEY text = '<YOUR API KEY HERE>';
BEGIN
while lastBatchStart <= count
	LOOP
	RAISE NOTICE 'processing %', lastBatchStart;
	-- create the input structure
	select json_build_object( 'data', json_agg(json_build_object( 'promoCode' , promoCode , 'productType', productType, 'period', period)) )
		into body
		from (select * from my_dr_input dr OFFSET lastBatchStart - 1 FETCH FIRST batchSize rows only);
	-- get the results of api call into variable
	result =  py_pgrest(  'https://api.decisionrules.io/rule/solve/' || rule_alias,
					   'POST' , 
					   body, 
					   '{"Authorization":"Bearer ' || API_KEY ||  '","Content-Type": "application/json"}');
	-- store results in a table
	-- use -> to access nested object
	-- use ->> to extract the value
	-- use ::data_type to convert the value into your desired datatype
	insert into results
	select (res::json->'prices'->>'finalPrice')::float ,
	   	   (res::json->'prices'->>'crudePrice')::float ,
	        res::json->>'message' 
		-- parse the response by object
		from (select JSON_ARRAY_ELEMENTS(JSON_ARRAY_ELEMENTS(result::json) ) as res ) ;
	
	
	lastBatchStart = lastBatchStart + batchSize;
	
	END LOOP;

END; 
$$