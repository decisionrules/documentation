---
description: How to call DecisionRules directly from Oracle PLSQL
---

# Oracle PL/SQL

## How to call DecisionRules Solver API from Oracle PL/SQL



```plsql
declare
    v_req       utl_http.req;
    v_res       utl_http.resp;
    v_buffer    varchar2(4000); 
    v_body      varchar2(4000) := '"data":{"field":"value"}'; -- Input JSON Data
begin
    -- Set connection.
    -- Please fill in the RULE_ID and optional version in URL
    v_req := utl_http.begin_request('https://api.decisionrules.io/rule/solve/RULE_ID/VERSION', 'POST');
    
    
    -- Please fill in the Solver api key which you can get after logging into the decisionrules application
    utl_http.set_header(v_req, 'Authorization', 'Bearer SOLVER_API_KEY'); 
    utl_http.set_header(v_req, 'Content-Type', 'application/json'); 
    utl_http.set_header(v_req, 'Content-Length', length(v_body));
    
    -- Invoke REST API.
    utl_http.write_text(v_req, v_body);
  
    -- Get response.
    v_res := utl_http.get_response(v_req);
    begin
        loop
            utl_http.read_line(v_res, v_buffer);
            -- Do something with buffer.
            dbms_output.put_line(v_buffer);
        end loop;
        utl_http.end_response(v_res);
    exception
        when utl_http.end_of_body then
            utl_http.end_response(v_res);
    end;
end;
```
