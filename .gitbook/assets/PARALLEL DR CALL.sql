SET SERVEROUTPUT ON
DECLARE
  -- store SQL commnad
  l_sql_stmt VARCHAR2(1000);
  -- retries count
  l_try NUMBER;
  -- Execution status 
  l_status NUMBER;

  -- Size of one batch  
  batch_size int := 50;
  -- Maximum number of parallel calls
  parallel_lev int := 6;
BEGIN
  timestart := SYSTIMESTAMP;
  -- Create the TASK
  DBMS_PARALLEL_EXECUTE.CREATE_TASK ('mytask');
  select count(*) into l_try from my_dr_input;
  DBMS_OUTPUT.PUT_LINE( 'input count: ' || to_char(l_try)  );
  -- Chunk the table by ROWID
  DBMS_PARALLEL_EXECUTE.CREATE_CHUNKS_BY_NUMBER_COL('mytask', 'SYS', 'MY_DR_INPUT', 'ROW#', batch_size);
  -- Execute the DML in parallel
  l_sql_stmt := 'BEGIN DR_CALL(:start_id,:end_id); END;';
  DBMS_PARALLEL_EXECUTE.RUN_TASK('mytask', l_sql_stmt, DBMS_SQL.NATIVE,
                                 parallel_level => parallel_lev);

  
  -- If there is an error, RESUME it for at most 2 times.
  L_try := 0;
  L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
  WHILE(l_try < 10 and L_status != DBMS_PARALLEL_EXECUTE.FINISHED) 
  LOOP
    L_try := l_try + 1;
    DBMS_PARALLEL_EXECUTE.RESUME_TASK('mytask');
    L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
    dbms_output.put_line('Some error occured , retry ' || to_char(l_try) );
  END LOOP;

  -- Done with processing; drop the task
  DBMS_OUTPUT.PUT_LINE( to_char( DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask') )  );
  dbms_output.put_line('time to get response' ||   to_char(SYSTIMESTAMP) || '  started : ' || to_char(timestart) );  
  INSERT INTO parallel_logs select * from dba_parallel_execute_chunks;
  DBMS_PARALLEL_EXECUTE.DROP_TASK('mytask'); 
END;
/