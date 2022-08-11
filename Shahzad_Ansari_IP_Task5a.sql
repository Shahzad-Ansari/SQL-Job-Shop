/****** Object:  StoredProcedure [dbo].[Associate_assembly_customer]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Associate_assembly_customer]
@asmID INTEGER,
@name VARCHAR(64)

AS 
BEGIN
    INSERT INTO cust_order VALUES(@asmID,@name)
END

/****** Object:  StoredProcedure [dbo].[Associate_assembly_process]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Associate_assembly_process]
@asmID INTEGER,
@pid INTEGER

AS 
BEGIN
    INSERT INTO pass_through VALUES(@pid,@asmID)
    
END
--
/****** Object:  StoredProcedure [dbo].[changePaint]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[changePaint]

@jobId INTEGER,
@color VARCHAR(64)

AS 
BEGIN  
  UPDATE paintJob set color = @color WHERE jobId = @jobId
END

/****** Object:  StoredProcedure [dbo].[completed_job]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[completed_job]
@jobNo INTEGER,
@endDate DATE



AS 
BEGIN
    UPDATE assignes
    SET endDate = @endDate
    WHERE jobNo = @jobNo
END

/****** Object:  StoredProcedure [dbo].[createAccount]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createAccount]
@actNo INTEGER
AS
BEGIN  
    INSERT INTO account VALUES (@actNo)
END

-----------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[createAssemblyAccount]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createAssemblyAccount]
@actNo INTEGER,
@asmID INTEGER,
@startDate DATE
AS
BEGIN  
    INSERT INTO maintains VALUES (NULL,@asmID,NULL,@actNo)
    INSERT INTO assemblyAct VALUES(@actNo,@startDate,0)
END

-----------------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[createDeptAccount]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createDeptAccount]
@actNo INTEGER,
@deptId INTEGER,
@startDate DATE

AS
BEGIN  
    INSERT INTO maintains VALUES (NULL,NULL,@deptId,@actNo)
    INSERT INTO deptAct VALUES(@actNo,@startDate,0)
END

/****** Object:  StoredProcedure [dbo].[createProcessAccount]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createProcessAccount]
@actNo INTEGER,
@pid INTEGER,
@startDate DATE
AS
BEGIN  
    INSERT INTO maintains VALUES (@pid,NULL,NULL,@actNo)
    INSERT INTO procAct VALUES(@actNo,@startDate,0)
END

/****** Object:  StoredProcedure [dbo].[cut_Job]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cut_Job]
@jobNo INTEGER,
@details VARCHAR(64),
@materials VARCHAR(64),
@machineType VARCHAR(64),
@labor INTEGER,
@timeTaken INTEGER

AS 
BEGIN
    INSERT INTO cutJob VALUES(@jobNo,@details,@materials,@machineType,@labor,@timeTaken)
END

/****** Object:  StoredProcedure [dbo].[cutProcessTable]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cutProcessTable]
@pid INTEGER,
@process_data VARCHAR(64),
@cutType  VARCHAR(64),
@machineType VARCHAR(64)
AS 
BEGIN  
    INSERT INTO cutProcess VALUES ( @pid,@process_data,@cutType,@machineType)
END

/****** Object:  StoredProcedure [dbo].[deleteCutJob]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteCutJob]

@startRange INTEGER,
@endRange INTEGER

AS 
BEGIN  
    DELETE FROM cutJob WHERE jobID >= @startRange AND jobID <= @endRange
    DELETE FROM assignes WHERE jobNo >= @startRange AND jobNo <= @endRange
    DELETE FROM job WHERE jobID >= @startRange AND jobID <= @endRange
END

/****** Object:  StoredProcedure [dbo].[fit_Job]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fit_Job]
@jobNo INTEGER,
@details VARCHAR(64),
@labor INTEGER


AS 
BEGIN
    INSERT INTO fitJob VALUES(@jobNo,@details,@labor)
END

/****** Object:  StoredProcedure [dbo].[fitProcessTable]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fitProcessTable]
@pid INTEGER,
@process_data VARCHAR(64),
@fitType VARCHAR(64)
AS
BEGIN  
    INSERT INTO fitProcess VALUES (@pid,@process_data,@fitType)
END

/****** Object:  StoredProcedure [dbo].[getAssemblyProccesHistory]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAssemblyProccesHistory]
@asmID INTEGER

AS 
BEGIN

  SELECT DISTINCT
    a.asmID,j.startDate,p.pid,s.deptId
  FROM
    asmbly a, pass_through p, supervises s,assignes j
  WHERE 
    a.asmID = @asmID
  AND
    p.asmID = a.asmID
  AND
    s.pid = p.pid
  AND 
    j.pid = p.pid
  ORDER BY startDate


END

/****** Object:  StoredProcedure [dbo].[getCustomers]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCustomers]

@startRange INTEGER,
@endRange INTEGER

AS 
BEGIN  
SELECT * FROM customer WHERE category >= @startRange AND category <= @endRange ORDER BY name
END

/****** Object:  StoredProcedure [dbo].[getJobHistory]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getJobHistory]
@deptId INTEGER,
@endDate DATE

AS 
BEGIN

DECLARE @jobs TABLE(
  deptId INTEGER,
  pid INTEGER,
  asmID INTEGER,
  endDate DATE,
  jobNo INTEGER
)

INSERT INTO @jobs(deptId,pid,asmID,endDate,jobNo)
  SELECT DISTINCT
  s.deptId, s.pid , a.asmID,a.endDate,a.jobNo
  FROM 
  supervises s, assignes a
  WHERE
  s.pid = a.pid
  AND
  s.deptId = @deptId
  AND
  a.endDate = @endDate


DECLARE @paintTest INTEGER
set @paintTest =
(SELECT count(1) where exists(  SELECT
                                    deptId,pid,asmID,endDate,jobId,details,color,labor,volume 
                                FROM 
                                    @jobs j, paintJob p 
                                WHERE 
                                    j.jobNo = p.jobId  
                            ) 
)

DECLARE @cutTest INTEGER
set @cutTest = 
(SELECT count(1) where exists(  SELECT 
                                    deptId,pid,asmID,endDate,jobId,details,materials,labor,machineType,timeTaken  
                                FROM 
                                    @jobs j, cutJob c 
                                WHERE 
                                    j.jobNo = c.jobId
                            )
)
 
DECLARE @fitTest INTEGER
set @fitTest = 
(SELECT count(1) where exists(  SELECT 
                                    deptId,pid,asmID,endDate,jobId,details,labor 
                                FROM 
                                    @jobs j, fitJob f 
                                WHERE 
                                    j.jobNo = f.jobId
                            )
)
IF @paintTest > 0
    PRINT'PAINT'

IF @paintTest > 0
    SELECT
        deptId,pid,asmID,endDate,jobId,details,color,labor,volume 
    FROM 
        @jobs j, paintJob p 
    WHERE 
        j.jobNo = p.jobId  


IF @cutTest > 0
    PRINT'cut'

IF @cutTest > 0 
    SELECT 
        deptId,pid,asmID,endDate,jobId,details,materials,labor,machineType,timeTaken  
    FROM 
        @jobs j, cutJob c 
    WHERE 
        j.jobNo = c.jobId

IF @fitTest > 0
    PRINT'FIT'

IF @fitTest > 0
    SELECT 
        deptId,pid,asmID,endDate,jobId,details,labor 
    FROM 
        @jobs j, fitJob f 
    WHERE 
        j.jobNo = f.jobId 




END

/****** Object:  StoredProcedure [dbo].[getJobHistory_cut]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getJobHistory_cut]
@deptId INTEGER,
@endDate DATE

AS
BEGIN

    DECLARE @jobs TABLE(
    deptId INTEGER,
    pid INTEGER,
    asmID INTEGER,
    endDate DATE,
    jobNo INTEGER
    )

    INSERT INTO @jobs(deptId,pid,asmID,endDate,jobNo)
    SELECT DISTINCT
    s.deptId, s.pid , a.asmID,a.endDate,a.jobNo
    FROM 
    supervises s, assignes a
    WHERE
    s.pid = a.pid
    AND
    s.deptId = @deptId
    AND
    a.endDate = @endDate

    
    DECLARE @cutTest INTEGER
    set @cutTest = 
    (SELECT count(1) where exists(  SELECT 
                                        deptId,pid,asmID,endDate,jobId,details,materials,labor,machineType,timeTaken  
                                    FROM 
                                        @jobs j, cutJob c 
                                    WHERE 
                                        j.jobNo = c.jobId
                                )
    )

    IF @cutTest > 0
    PRINT'cut'

    IF @cutTest > 0 
        SELECT 
            deptId,pid,asmID,endDate,jobId,details,materials,labor,machineType,timeTaken  
        FROM 
            @jobs j, cutJob c 
        WHERE 
            j.jobNo = c.jobId
    ELSE  
        SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL

END

/****** Object:  StoredProcedure [dbo].[getJobHistory_fit]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getJobHistory_fit]
@deptId INTEGER,
@endDate DATE

AS
BEGIN

    DECLARE @jobs TABLE(
    deptId INTEGER,
    pid INTEGER,
    asmID INTEGER,
    endDate DATE,
    jobNo INTEGER
    )

    INSERT INTO @jobs(deptId,pid,asmID,endDate,jobNo)
    SELECT DISTINCT
    s.deptId, s.pid , a.asmID,a.endDate,a.jobNo
    FROM 
    supervises s, assignes a
    WHERE
    s.pid = a.pid
    AND
    s.deptId = @deptId
    AND
    a.endDate = @endDate


    DECLARE @fitTest INTEGER
    set @fitTest = 
    (SELECT count(1) where exists(  SELECT 
                                        deptId,pid,asmID,endDate,jobId,details,labor 
                                    FROM 
                                        @jobs j, fitJob f 
                                    WHERE 
                                        j.jobNo = f.jobId
                                )
    )

    IF @fitTest > 0
    PRINT'FIT'

    IF @fitTest > 0
        SELECT 
            deptId,pid,asmID,endDate,jobId,details,labor 
        FROM 
            @jobs j, fitJob f 
        WHERE 
            j.jobNo = f.jobId 
    ELSE  
        SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL


END

/****** Object:  StoredProcedure [dbo].[getJobHistory_paint]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getJobHistory_paint]
@deptId INTEGER,
@endDate DATE

AS
BEGIN

    DECLARE @jobs TABLE(
    deptId INTEGER,
    pid INTEGER,
    asmID INTEGER,
    endDate DATE,
    jobNo INTEGER
    )

    INSERT INTO @jobs(deptId,pid,asmID,endDate,jobNo)
    SELECT DISTINCT
    s.deptId, s.pid , a.asmID,a.endDate,a.jobNo
    FROM 
    supervises s, assignes a
    WHERE
    s.pid = a.pid
    AND
    s.deptId = @deptId
    AND
    a.endDate = @endDate




    DECLARE @paintTest INTEGER
    set @paintTest =
    (SELECT count(1) where exists(  SELECT
                                        deptId,pid,asmID,endDate,jobId,details,color,labor,volume 
                                    FROM 
                                        @jobs j, paintJob p 
                                    WHERE 
                                        j.jobNo = p.jobId  
                                ) 
    )


    IF @paintTest > 0
        PRINT'PAINT'

    IF @paintTest > 0
        SELECT
            deptId,pid,asmID,endDate,jobId,details,color,labor,volume 
        FROM 
            @jobs j, paintJob p 
        WHERE 
            j.jobNo = p.jobId 
     ELSE  
        SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
 
            
END

/****** Object:  StoredProcedure [dbo].[New_assembly_customer]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[New_assembly_customer]
@name VARCHAR(64),
@address VARCHAR(64),
@category INTEGER,
@asmID INTEGER,
@orderDate DATE,
@details VARCHAR(64)


AS 
BEGIN
    IF NOT EXISTS (SELECT * FROM asmbly WHERE asmID = @asmID)
    INSERT INTO asmbly VALUES(@asmID,@orderDate,@details);
    IF NOT EXISTS (SELECT * FROM customer WHERE name = @name)
    INSERT INTO customer VALUES(@name,@address,@category)  
END
--
GO
/****** Object:  StoredProcedure [dbo].[New_Customer]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[New_Customer]
@name VARCHAR(64),
@address VARCHAR(64),
@category VARCHAR(64)

AS
BEGIN
    INSERT INTO customer VALUES ( @name,@address,@category)
END


/****** Object:  StoredProcedure [dbo].[New_dept]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[New_dept]
@deptId INTEGER,
@deptData VARCHAR(64)

AS
BEGIN
    INSERT INTO dept VALUES ( @deptId,@deptData)
END


/****** Object:  StoredProcedure [dbo].[New_Job]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[New_Job]
@jobId INTEGER,
@pid INTEGER,
@asmID INTEGER,
@startDate DATE



AS 
BEGIN
     IF EXISTS(SELECT * FROM pass_through WHERE pid =@pid AND asmID = @asmID)
        INSERT INTO job VALUES(@jobId)
        
    IF EXISTS(SELECT * FROM pass_through WHERE pid =@pid AND asmID = @asmID)
        INSERT INTO assignes VALUES(@startDate,NULL,@jobId,@pid,@asmID)
    ELSE PRINT 'pid isnt associated with asmID'
END


/****** Object:  StoredProcedure [dbo].[New_ProcDept]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[New_ProcDept]
@pid INTEGER,
@deptData VARCHAR(64),
@deptId INTEGER
AS
BEGIN
    INSERT INTO dept VALUES ( @deptId,@deptData);
    INSERT INTO process VALUES (@pid)
END

/****** Object:  StoredProcedure [dbo].[paint_Job]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[paint_Job]
@jobNo INTEGER,
@details VARCHAR(64),
@color VARCHAR(64),
@labor INTEGER,
@volume INTEGER

AS 
BEGIN
    INSERT INTO paintJob VALUES(@jobNo,@details,@color,@labor,@volume)
END

GO
/****** Object:  StoredProcedure [dbo].[paintProcessTable]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[paintProcessTable]
@pid INTEGER,
@paintType VARCHAR(64),
@paintingMethod VARCHAR(64),
@process_data VARCHAR(64)
AS 
BEGIN  
    INSERT INTO paintProcess VALUES ( @pid,@process_data,@paintType,@paintingMethod)
END
GO
/****** Object:  StoredProcedure [dbo].[recordTransaction]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[recordTransaction]
@transNo INTEGER,
@supCost INTEGER,
@actNo INTEGER

AS 
BEGIN
    INSERT INTO jobTransaction VALUES (@transNo,@supCost)
    INSERT INTO updates VALUES (@transNo,@actNo)
    IF EXISTS( SELECT * FROM assemblyAct WHERE actNo = @actNo)
        UPDATE assemblyAct SET assemblyCost = assemblyCost + @supCost WHERE actNo = @actNo

    IF EXISTS( SELECT * FROM procAct WHERE actNo = @actNo)
        UPDATE procAct SET procCost = procCost + @supCost WHERE actNo = @actNo
        
    IF EXISTS( SELECT * FROM deptAct WHERE actNo = @actNo)
        UPDATE deptAct SET deptCost = deptCost + @supCost WHERE actNo = @actNo   
END

/****** Object:  StoredProcedure [dbo].[supervisingTable]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[supervisingTable]

@pid INTEGER,
@deptId INTEGER

AS 
BEGIN  
    INSERT INTO supervises VALUES(@pid,@deptId)
END

/****** Object:  StoredProcedure [dbo].[totalCostOnAssembly]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[totalCostOnAssembly]
@asmID INTEGER

AS 
BEGIN
    SELECT sum(assemblyCost) FROM assemblyAct a INNER JOIN maintains m on m.actNo = a.actNo WHERE m.asmID = @asmID
END

GO
/****** Object:  StoredProcedure [dbo].[totalLaborOneDept]    Script Date: 11/21/2021 5:49:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[totalLaborOneDept]
@deptId INTEGER,
@endDate DATE

AS 
BEGIN


  DECLARE @paint INTEGER
  SET @paint =
    (SELECT SUM(labor) 
    FROM
    supervises s, assignes a , paintJob p 
    WHERE
        a.endDate = @endDate
        AND
        s.deptId = @deptId
        AND
        a.pid = s.pid
        AND 
        jobNo = p.jobId)


  DECLARE @cut INTEGER
  SET @cut =

    (SELECT SUM(labor)
    FROM
    supervises s, assignes a , cutJob c 
    WHERE
        a.endDate = @endDate
        AND
        s.deptId = @deptId
        AND
        a.pid = s.pid
        AND 
        jobNo = c.jobId)

  DECLARE @fit INTEGER
  SET @fit =
    (SELECT SUM(labor)
    FROM
    supervises s, assignes a , fitJob f 
    WHERE
        a.endDate = @endDate
        AND
        s.deptId = @deptId
        AND
        a.pid = s.pid
        AND 
        jobNo = f.jobId)

    DECLARE @totalLabor INTEGER

    SET @totalLabor = IsNull(@fit,0) +IsNull(@cut,0) +IsNull(@paint,0)

    SELECT @totalLabor

END
