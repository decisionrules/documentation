---
description: How to call DecisionRules directly from Oracle PLSQL
---

# Oracle PL/SQL

## How to call DecisionRules Solver API from Oracle PL/SQL



## Database setup

To execute the API call directly from Oracle PL/SQL we will take advantage of the provided `UTL_HTTP` package. However, in a typical database a regular user will not have the necessary privileges to use this package.

You will need to have privileges to access the `UTL_HTTP` package and have Access Control List setup.

For the purposes of first test you can use the code in the file below, which will create _my\_DR\_input_ table which contains sample input data and _results_ table to store the data received from DecisionRules.

Bellow you can find all the code files necessary to set up and test your first API call

{% file src="../../.gitbook/assets/Oracle create results.sql" %}
Create command for RESULTS table
{% endfile %}

{% file src="../../.gitbook/assets/Oracle create my_DR_input.sql" %}
Create command for MY\_DR\_INPUT table
{% endfile %}



{% file src="../../.gitbook/assets/Test_v2.json" %}
Showcase rule for testing the call, please import this rule to your DecisionRules space
{% endfile %}

How to set up the ACL is described in this article [https://oracle-base.com/articles/misc/utl\_http-and-ssl#acl](https://oracle-base.com/articles/misc/utl\_http-and-ssl#acl) ( first chapter _Access Control List (ACL)_ )



## Using HTTP or HTTPS

The showcase script uses HTTP to call the DecisionRules API, to make it easier to make your first call and test whether you have all the necessary permissions and all prerequisites met.

If you want to use HTTPS you will need to set up an Oracle Wallet with the propper SSL certificate, otherwise Oracle will not let you execute the Call.

How to get the certificate and create the wallet is explained here [https://oracle-base.com/articles/misc/utl\_http-and-ssl#acl](https://oracle-base.com/articles/misc/utl\_http-and-ssl#acl) ( third chapter _Get Site Certificates_ and fourth chapter _Create an Oracle Wallet Containing the Certificates_)

Once you have the wallet setup you can change the call URL to https and add uncomment the `utl_http.set_wallet('file:<FILE LOCATION HERE>', NULL);`  command providing path to your newly created wallet.

## Methods of processing

First we will take a look at how to setup a simple serial call, that processes multiple API Calls one after another, and then we will expand on it using parallel API Calls that can be useful in the cases where you need to evaluate very large sets of data.&#x20;

## Serial method

The DecisionRules API calls are made in batches using the Bulk input feature. You can set the size of the batches by changing the value of the _`batch_size`_ variable.

Using the Serial approach we execute the API call one after another in a typical SQL fashion.\
Now lets describe the necessary steps executed by the script

Now we will describe the necessary code in parts, the full script can be downloaded here

You should make changes in the following variable to suit your own case



```plsql
DECLARE   
    batch_size number := 10;
    -- Version number, can be left blank to access the latest version
    rule_version varchar2(5) := '';
    rule_alias varchar2(100) := '<YOUR RULE ID or ALIAS>';
    API_KEY varchar2(100) := '<YOUR API KEY HERE>';
```

{% file src="../../.gitbook/assets/Oracle serial call DR API.sql" %}
Code executes calls by batch one after another
{% endfile %}

{% hint style="info" %}
You will need to provide your own API Key in the `API_KEY` variable
{% endhint %}

### Transforming data to JSON format

DecisionRules API accepts the input data in the form of a JSON wrapped in a 'data' wrapper.To transform the data into the required JSON format we use Oracles provided functions

* `JSON_OBJECT(`` `_`key VALUE column,...)`_ - creates a JSON object with specified keys and values
* `JSON_ARRAYAGG(`` `_`values )` -_ creates a JSON array with elements specified in _values_

```plsql
SELECT JSON_OBJECT('data' value  JSON_ARRAYAGG( 
                        JSON_OBJECT('productType' value productType ,
                                    'period' value period , 
                                    'promoCode' value promoCode returning clob) 
                                    returning clob )  returning clob  )  
            INTO v_body 
            FROM MY_dr_input
            
```

Depending on the size of your data you might choose between storing your input and output data either in Varchar or Clob variables. In the provided code we showcase the use of Clob variables, which results in more complex code, but works for large datasets&#x20;



{% hint style="info" %}
Varchar2 variables are limited to 32Kb. \
CLOBs can typically store up to 2Gb&#x20;
{% endhint %}

### Executing the API Call

To execute the call we use the `UTL_HTTP` package.

```plsql
    -- Set connection.
    -- Please fill in the RULE_ID and optional version in URL
    v_req := utl_http.begin_request('http://api.decisionrules.io/rule/solve/:ruleId', 'POST');
    -- Set transfer timeout of needed, default value is 60s
    utl_http.set_transfer_timeout(v_req,180);
    -- Set headers
    -- Please fill in the Solver api key which you can get after logging into the decisionrules application
    utl_http.set_header(v_req, 'Authorization', 'Bearer ' || API_KEY'); 
    utl_http.set_header(v_req, 'Content-Type', 'application/json'); 
    utl_http.set_header(v_req, 'Content-Length', length(v_body));
    dbms_lob.createtemporary(fullResponse,true);
    -- Invoke REST API.
    -- Load all input data into the request
    --  Has to be done in chunks to accomodate body of size larger than 32Kb
    LOOP
        datachunk := substr(v_body, chunkStart, max_size );
        utl_http.write_text(v_req, datachunk);
        IF ( length(datachunk) < max_size ) then exit; end if;
        chunkStart := chunkStart + max_size;
    END LOOP;
      
    -- Get response.
    v_res := utl_http.get_response(v_req);
```

{% hint style="info" %}
You will need to provide the API Key of your own space to test the rule evaluation ( the value is set in the API\_KEY variable ).
{% endhint %}

In this part we begin the request , setup the headers and then we load the data into the body. Note that there is a limit of the input size in the `UTL_HTTP.write_text` function of 32Kb , so we need to use a loop to accommodate inputs of larger sizes.

Finally we load the response into a prepared variable.

### Extracting data from the response

To extract the data from the calls response we use the `JSON_TABLE` function, this function takes a JSON object and transforms it into a table with columns specified in the `COLUMNS` clause. Here you can specify the name and data type of the resulting column followed by the path to the value in the JSON

After transforming the data into the table format you can then use it to execute any DML statement you need, in our example we show a simple INSERT into the RESULTS table

```plsql
begin
            -- Read the data from the response
            -- utl_http.read_text is again limited to 32Kb
            loop
                utl_http.read_text(v_res, v_buffer, max_size);
                --dbms_output.put_line('appending ' || to_char( length(v_buffer) ) ) ; 
                dbms_lob.append(fullResponse, v_buffer  );   
                -- Do something with buffer.
                if (length(v_buffer) < max_size ) THEN EXIT; END IF;
                
            end loop;
            -- Process the results
            -- We are using the JSON_TABLE function to transform the contents of the response JSON into a table
            --  which we can then use for DML operations etc.
            -- In out case we show a simple INSERT into the RESULTS table
            INSERT INTO RESULTS 
                SELECT * 
                FROM JSON_TABLE( fullResponse 
                                , '$[*]' COLUMNS(  finalPrice varchar2(10) Path '$[*].prices.finalPrice' , 
                                                   crudePrice Varchar2(10) Path '$[*].prices.crudePrice' , 
                                                   message VARCHAR2(50) Path '$[*].message')
                                );
            --select count(*) into result_count from results;
            --dbms_output.put_line('current count:  ' || to_char(result_count));
            utl_http.end_response(v_res);
        -- Exception handler
        -- If some error were to happen, we need to end the API call before passing on the error
        exception
            when others then
                utl_http.end_response(v_res);
                dbms_output.put_line('end reached ');
        end;
```

## Parallel approach

If your dataset is so large enough, that the serial execution of the API calls takes too long, you can take advantage of the `DBMS_PARALLEL` package to utilize the computation power of the server more efficiently and run several API calls at once.

We use one more table to store the final status of parallel execution, this gives us the option to check for errors, if the calls fail.

{% file src="../../.gitbook/assets/Oracle create parallel logs.sql" %}
Table for logging the status of parallel execution
{% endfile %}

This approach requires some additional setup. First we transform our API call into a procedure that takes as parameter _`start_id`_ and _`end_id`_ and processes the API call for a set of rows delimited by these two values

```plsql
CREATE OR REPLACE PROCEDURE DR_CALL (start_id in number, end_id in number)
AS
BEGIN
-- API CALL PROCESSING
END;
```



{% file src="../../.gitbook/assets/DR_CALL_PROCEDURE.sql" %}
Full code of the procedure, please insert your API key into the API\_KEY variable
{% endfile %}



{% file src="../../.gitbook/assets/PARALLEL DR CALL.sql" %}
Script for parallel execution, you first need to create the procedure above, then you can run this code
{% endfile %}

Now we can use the `DBMS_PARALLEL` package to execute several calls in parallel, we use the following functions of `DBMS_PARALLEL` in particular

* `CREATE_TASK` - creates a new task which will contain all the unique API Calls
* `CREATE_CHUNKS_BY_NUMBER_COL` - divides the table into chunks of specified size by a column of data type NUMBER( each one will then be the input of an API Call )
* `RUN_TASK` - executes the task running the provided SQL code for each chunk
* `RESUME_TASK` - execute the task that failed with errors again
* `DROP_TASK` - delete the task, that we needed only for the purposes of this procedure
* `TASK_STATUS` - property that hold the status of the task ( finished, with errors  etc. )

```plsql
DECLARE
  -- Stores SQL code to be executed in parallel
  l_sql_stmt VARCHAR2(1000);
  -- Count of failed calls
  --  used to specify number of retries
  l_try NUMBER := 0;
  -- Status of execution, DBMS_PARALLEL property
  l_status NUMBER;
  -- Count of call to be executed in parallel
  parallel_lev int := 12;
BEGIN
  -- Create task
  DBMS_PARALLEL_EXECUTE.CREATE_TASK ('mytask');
  -- Chunk the table by Number col
  DBMS_PARALLEL_EXECUTE.CREATE_CHUNKS_BY_NUMBER_COL('mytask', 'SYS', 'MY_DR_INPUT', 'ROW#', 10000);
  -- Prepare the sql that is to be executed ( api call procedure )
  l_sql_stmt := 'BEGIN DR_CALL(:start_id,:end_id); END;';
  -- execute prepared tasks
  DBMS_PARALLEL_EXECUTE.RUN_TASK('mytask', l_sql_stmt, DBMS_SQL.NATIVE,
                                 parallel_level => parallel_lev);

  
  -- If there is an error, RESUME it for at most 5 times.
  L_try := 0;
  L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
  WHILE(l_try < 5 and L_status != DBMS_PARALLEL_EXECUTE.FINISHED) 
  LOOP
    L_try := l_try + 1;
    DBMS_PARALLEL_EXECUTE.RESUME_TASK('mytask');
    L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
    dbms_output.put_line('Some error occured , retry ' || to_char(l_try) );
  END LOOP;
  
  ---- OPTIONAL PROCESSING ----
  -- Save the status of execution in log
  INSERT INTO parallel_logs select * from dba_parallel_execute_chunks;
  ---- OPTIONAL PROCESSING ----
  
  

  -- Done with processing; drop the task  
  DBMS_PARALLEL_EXECUTE.DROP_TASK('mytask'); 
END;
/
```
