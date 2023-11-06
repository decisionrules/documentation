
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

