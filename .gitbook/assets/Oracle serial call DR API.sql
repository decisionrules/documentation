SET serveroutput on;
declare
    v_req       utl_http.req;
    v_res       utl_http.resp;
    v_buffer    clob; 
    v_body      clob ; -- Input JSON Data
    fullResponse clob := '';
    timestart   timestamp;
    timeend     timestamp;
    datachunk clob;
    chunkStart int := 1;
    max_size int := 32000;
    input_count number ;
    current_batch_start number := 1;
    -- CHANGE THE SIZE OF THE BATCH, THAT IS EVALUATED IN ONE CALL
    batch_size number := 10;
    result_count int := 0;
    
    -- DecisionRules Solver API parameters
    rule_version varchar2(5) := '';
    rule_alias varchar2(100) := 'test';
    API_KEY varchar2(100) := '<YOUR API KEY HERE>';
    
begin
    select count(*) into input_count from my_DR_input;
    WHILE current_batch_start <= input_count       
    LOOP
        chunkStart := 1;
        timestart := systimestamp;
        SELECT JSON_OBJECT('data' value  JSON_ARRAYAGG( JSON_OBJECT('productType' value productType , 'period' value period , 'promoCode' value promoCode returning clob) returning clob )  returning clob  )  
            INTO v_body 
            FROM MY_dr_input where row# between current_batch_start and current_batch_start + batch_size - 1;
        -- Set connection.
        -- Please fill in the RULE_ID and optional version in URL
        /* --TO USE HTTPS YOU NEED TO SET UP A WALLET WITH SSL CERTIFICATE
        utl_http.set_wallet('file:D:\wallet', NULL);
        v_req := utl_http.begin_request('https://api.decisionrules.io/rule/solve/' || rule_alias || nvl2(rule_version,'/' || rule_version,'') , 'POST');
        */
        v_req := utl_http.begin_request('http://api.decisionrules.io/rule/solve/' || rule_alias || nvl2(rule_version,'/' || rule_version,'') , 'POST');
        --utl_http.set_transfer_timeout(v_req,180);
        -- Set headers
        -- Please fill in the Solver api key which you can get after logging into the decisionrules application
        utl_http.set_header(v_req, 'Authorization', 'Bearer ' || API_KEY); 
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
        -- 
        begin
            -- Read the data from the response
            -- utl_http.read_text is again limited to 32Kb
            
            loop
                utl_http.read_text(v_res, v_buffer, max_size);
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
            
            select count(*) into result_count from results;
            utl_http.end_response(v_res);
        -- Exception handler
        -- If some error were to happen, we need to end the API call before passing on the error
        exception
            when others then
                utl_http.end_response(v_res);
        end;
        dbms_output.put_line('finished batch ' || to_char(current_batch_start) );        
        current_batch_start := current_batch_start + batch_size;
    END LOOP;
    select count(*) into result_count from results;
    dbms_output.put_line( 'records processed: ' || to_char(input_count) );

end;