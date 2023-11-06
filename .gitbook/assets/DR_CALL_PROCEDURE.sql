CREATE OR REPLACE PROCEDURE DR_CALL (start_id in number, end_id in number)
AS
BEGIN
declare
    v_req       utl_http.req;
    v_res       utl_http.resp;
    v_buffer    clob; 
    v_body      clob ; -- Input JSON Data
    fullResponse clob := 'a';
    timestart   timestamp;
    timeend     timestamp;
    datachunk clob;
    chunkStart int := 1;
    max_size int := 32000;
    
    -- DecisionRules Solver API parameters
    rule_version varchar2(5) := '';
    rule_alias varchar2(100) := 'test';
    API_KEY varchar2(100) := '<YOUR API KEY HERE>';
begin
    timestart := systimestamp;
    SELECT JSON_OBJECT('data' value  JSON_ARRAYAGG( JSON_OBJECT('productType' value productType , 'period' value period , 'promoCode' value promoCode returning clob) returning clob )  returning clob  )  
        INTO v_body 
        FROM MY_dr_input where row# between start_id and end_id;
    -- Set connection.
    -- Please fill in the RULE_ID and optional version in URL
    v_req := utl_http.begin_request('http://api.decisionrules.io/rule/solve/' || rule_alias || nvl2(rule_version,'/' || rule_version,''), 'POST');
    -- Please fill in the Solver api key which you can get after logging into the decisionrules application
    utl_http.set_header(v_req, 'Authorization', 'Bearer ' || API_KEY); 
    utl_http.set_header(v_req, 'Content-Type', 'application/json'); 
    utl_http.set_header(v_req, 'Content-Length', length(v_body));
    dbms_lob.createtemporary(fullResponse,true);
    -- Invoke REST API.
    LOOP
        datachunk := substr(v_body, chunkStart, max_size );
        utl_http.write_text(v_req, datachunk);
        IF ( length(datachunk) < max_size ) then exit; end if;
        chunkStart := chunkStart + max_size;
    END LOOP;
  
    -- Get response.
    v_res := utl_http.get_response(v_req);
    timeend := SYSTIMESTAMP;
    dbms_output.put_line('time to get response' ||   TO_CHAR( extract(second from timeend - timestart ) ) );    
    begin
        loop
            utl_http.read_text(v_res, v_buffer, max_size);
            dbms_output.put_line('appending ' || to_char( length(v_buffer) ) ) ; 
            dbms_lob.append(fullResponse, v_buffer  );   
            -- Do something with buffer.
            --dbms_output.put_line(v_buffer);
            if (length(v_buffer) < max_size ) THEN EXIT; END IF;
            
        end loop;
        INSERT INTO RESULTS SELECT * FROM JSON_TABLE( fullResponse , '$[*]' COLUMNS(  finalPrice varchar2(10) Path '$[*].prices.finalPrice' , crudePrice Varchar2(10) Path '$[*].prices.crudePrice' , message VARCHAR2(50) Path '$[*].message') );
        utl_http.end_response(v_res);
    exception
        when others then
            utl_http.end_response(v_res);
    end;

end;
END;