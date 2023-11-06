--DROP PROCEDURE decisionRulesSolve;
CREATE PROCEDURE decisionRulesSolve(@ruleId Varchar(50) , @token Varchar(100) , @body Varchar(max) , @json Varchar(max) OUTPUT ,@version varchar(5) )
AS

BEGIN
-- DecisionRules URL
IF @version IS NULL SET @version = '' ELSE SET @version = '/' + str(@version) 
IF @token IS NULL SET @token = 'Bearer <Default Token>' ELSE SET @token = 'Bearer ' + @token;
IF @body IS NULL SET @body = '{"data": {}}';
DECLARE @URL NVARCHAR(MAX) = 'http://api.decisionrules.io/rule/solve/' + @ruleId +@version;
Declare @Object as Int;
Declare @ResponseText as Varchar(max);
Declare @status as Varchar(max);
Declare @statusText as Varchar(max);
Declare @outputTable Table ( finalPrice float, crudePrice float , message Varchar(50) , ind int);
-- Temporary table for storing parsed response
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