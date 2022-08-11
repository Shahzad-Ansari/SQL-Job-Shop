SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[actNo] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account] ADD PRIMARY KEY CLUSTERED 
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asmbly](
	[asmID] [int] NOT NULL,
	[orderDate] [date] NULL,
	[details] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[asmbly] ADD PRIMARY KEY CLUSTERED 
(
	[asmID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [asmblyID] ON [dbo].[asmbly]
(
	[asmID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[name] [varchar](64) NOT NULL,
	[address] [varchar](64) NULL,
	[category] [varchar](64) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[customer] ADD PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [customerCategoryIdx] ON [dbo].[customer]
(
	[category] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD CHECK  (([category]>=(1) AND [category]<=(10)))
GO
-----------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dept](
	[deptId] [int] NOT NULL,
	[deptData] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dept] ADD PRIMARY KEY CLUSTERED 
(
	[deptId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
-----------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job](
	[jobId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[job] ADD PRIMARY KEY CLUSTERED 
(
	[jobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
---------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[process](
	[pid] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[process] ADD PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
-------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jobTransaction](
	[transNo] [int] NOT NULL,
	[supCost] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[jobTransaction] ADD PRIMARY KEY CLUSTERED 
(
	[transNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assemblyAct](
	[actNo] [int] NOT NULL,
	[startDate] [date] NULL,
	[assemblyCost] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[assemblyAct] ADD PRIMARY KEY CLUSTERED 
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [actNo] ON [dbo].[assemblyAct]
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[assemblyAct]  WITH CHECK ADD  CONSTRAINT [FK_assemblyAct_actNo] FOREIGN KEY([actNo])
REFERENCES [dbo].[account] ([actNo])
GO
ALTER TABLE [dbo].[assemblyAct] CHECK CONSTRAINT [FK_assemblyAct_actNo]
GO


-------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assignes](
	[startDate] [date] NULL,
	[endDate] [date] NULL,
	[jobNo] [int] NOT NULL,
	[pid] [int] NOT NULL,
	[asmID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[assignes] ADD  CONSTRAINT [PK_assignes] PRIMARY KEY CLUSTERED 
(
	[jobNo] ASC,
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[assignes]  WITH CHECK ADD  CONSTRAINT [FK_assignes_asmID] FOREIGN KEY([asmID])
REFERENCES [dbo].[asmbly] ([asmID])
GO
ALTER TABLE [dbo].[assignes] CHECK CONSTRAINT [FK_assignes_asmID]
GO
ALTER TABLE [dbo].[assignes]  WITH CHECK ADD  CONSTRAINT [FK_assignes_JobNo] FOREIGN KEY([jobNo])
REFERENCES [dbo].[job] ([jobId])
GO
ALTER TABLE [dbo].[assignes] CHECK CONSTRAINT [FK_assignes_JobNo]
GO
ALTER TABLE [dbo].[assignes]  WITH CHECK ADD  CONSTRAINT [FK_assignes_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[assignes] CHECK CONSTRAINT [FK_assignes_pid]
GO

---------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cust_order](
	[asmID] [int] NOT NULL,
	[name] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cust_order] ADD PRIMARY KEY CLUSTERED 
(
	[asmID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Cust_OrderIDX] ON [dbo].[cust_order]
(
	[asmID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cust_order]  WITH CHECK ADD  CONSTRAINT [FK_asmID] FOREIGN KEY([asmID])
REFERENCES [dbo].[asmbly] ([asmID])
GO
ALTER TABLE [dbo].[cust_order] CHECK CONSTRAINT [FK_asmID]
GO
ALTER TABLE [dbo].[cust_order]  WITH CHECK ADD  CONSTRAINT [FK_name] FOREIGN KEY([name])
REFERENCES [dbo].[customer] ([name])
GO
ALTER TABLE [dbo].[cust_order] CHECK CONSTRAINT [FK_name]
GO

------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deptAct](
	[actNo] [int] NOT NULL,
	[startDate] [date] NULL,
	[deptCost] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[deptAct] ADD PRIMARY KEY CLUSTERED 
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [actNo] ON [dbo].[deptAct]
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[deptAct]  WITH CHECK ADD  CONSTRAINT [FK_dept_actNo] FOREIGN KEY([actNo])
REFERENCES [dbo].[account] ([actNo])
GO
ALTER TABLE [dbo].[deptAct] CHECK CONSTRAINT [FK_dept_actNo]
GO

-------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fitJob](
	[jobId] [int] NOT NULL,
	[details] [varchar](64) NULL,
	[labor] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fitJob] ADD PRIMARY KEY CLUSTERED 
(
	[jobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fitJob]  WITH CHECK ADD  CONSTRAINT [FK_fitJob_jobId] FOREIGN KEY([jobId])
REFERENCES [dbo].[job] ([jobId])
GO
ALTER TABLE [dbo].[fitJob] CHECK CONSTRAINT [FK_fitJob_jobId]
GO

-------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cutProcess](
	[pid] [int] NOT NULL,
	[process_data] [varchar](64) NULL,
	[cutType] [varchar](64) NULL,
	[machineType] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cutProcess] ADD PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [cutProcessIDX] ON [dbo].[cutProcess]
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cutProcess]  WITH CHECK ADD  CONSTRAINT [FK_cutProcess_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[cutProcess] CHECK CONSTRAINT [FK_cutProcess_pid]
GO
------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cutJob](
	[jobId] [int] NOT NULL,
	[details] [varchar](64) NULL,
	[materials] [varchar](64) NULL,
	[machineType] [varchar](64) NULL,
	[labor] [int] NULL,
	[timeTaken] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cutJob] ADD PRIMARY KEY CLUSTERED 
(
	[jobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cutJob]  WITH CHECK ADD  CONSTRAINT [FK_cutJob_jobId] FOREIGN KEY([jobId])
REFERENCES [dbo].[job] ([jobId])
GO
ALTER TABLE [dbo].[cutJob] CHECK CONSTRAINT [FK_cutJob_jobId]
GO
-------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pass_through](
	[pid] [int] NULL,
	[asmID] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PassThroughIDX] ON [dbo].[pass_through]
(
	[asmID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[pass_through]  WITH CHECK ADD  CONSTRAINT [FK_passThrough_asmID] FOREIGN KEY([asmID])
REFERENCES [dbo].[asmbly] ([asmID])
GO
ALTER TABLE [dbo].[pass_through] CHECK CONSTRAINT [FK_passThrough_asmID]
GO
ALTER TABLE [dbo].[pass_through]  WITH CHECK ADD  CONSTRAINT [FK_passThrough_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[pass_through] CHECK CONSTRAINT [FK_passThrough_pid]
GO
--------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paintProcess](
	[pid] [int] NOT NULL,
	[process_data] [varchar](64) NULL,
	[paintType] [varchar](64) NULL,
	[paintingMethod] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[paintProcess] ADD PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [paintProcessIDX] ON [dbo].[paintProcess]
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[paintProcess]  WITH CHECK ADD  CONSTRAINT [FK_paintProcess_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[paintProcess] CHECK CONSTRAINT [FK_paintProcess_pid]
GO
--------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paintJob](
	[jobId] [int] NOT NULL,
	[details] [varchar](64) NULL,
	[color] [varchar](64) NULL,
	[labor] [int] NULL,
	[volume] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[paintJob] ADD PRIMARY KEY CLUSTERED 
(
	[jobId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[paintJob]  WITH CHECK ADD  CONSTRAINT [FK_paintJob_jobId] FOREIGN KEY([jobId])
REFERENCES [dbo].[job] ([jobId])
GO
ALTER TABLE [dbo].[paintJob] CHECK CONSTRAINT [FK_paintJob_jobId]
GO
---------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[maintains](
	[pid] [int] NULL,
	[asmID] [int] NULL,
	[deptId] [int] NULL,
	[actNo] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[maintains] ADD  CONSTRAINT [PK_maintains] PRIMARY KEY CLUSTERED 
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [actNo] ON [dbo].[maintains]
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[maintains]  WITH CHECK ADD  CONSTRAINT [FK_maintains_actNo] FOREIGN KEY([actNo])
REFERENCES [dbo].[account] ([actNo])
GO
ALTER TABLE [dbo].[maintains] CHECK CONSTRAINT [FK_maintains_actNo]
GO
ALTER TABLE [dbo].[maintains]  WITH CHECK ADD  CONSTRAINT [FK_maintains_asmID] FOREIGN KEY([asmID])
REFERENCES [dbo].[asmbly] ([asmID])
GO
ALTER TABLE [dbo].[maintains] CHECK CONSTRAINT [FK_maintains_asmID]
GO
ALTER TABLE [dbo].[maintains]  WITH CHECK ADD  CONSTRAINT [FK_maintains_deptID] FOREIGN KEY([deptId])
REFERENCES [dbo].[dept] ([deptId])
GO
ALTER TABLE [dbo].[maintains] CHECK CONSTRAINT [FK_maintains_deptID]
GO
ALTER TABLE [dbo].[maintains]  WITH CHECK ADD  CONSTRAINT [FK_maintains_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[maintains] CHECK CONSTRAINT [FK_maintains_pid]
GO

---------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[updates](
	[transNo] [int] NOT NULL,
	[actNo] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[updates] ADD PRIMARY KEY CLUSTERED 
(
	[transNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[updates]  WITH CHECK ADD  CONSTRAINT [FK_updates_actNo] FOREIGN KEY([actNo])
REFERENCES [dbo].[account] ([actNo])
GO
ALTER TABLE [dbo].[updates] CHECK CONSTRAINT [FK_updates_actNo]
GO
ALTER TABLE [dbo].[updates]  WITH CHECK ADD  CONSTRAINT [FK_updates_transNo] FOREIGN KEY([transNo])
REFERENCES [dbo].[jobTransaction] ([transNo])
GO
ALTER TABLE [dbo].[updates] CHECK CONSTRAINT [FK_updates_transNo]
GO

---------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supervises](
	[pid] [int] NOT NULL,
	[deptId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supervises] ADD PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supervises]  WITH CHECK ADD  CONSTRAINT [FK_supervises_deptID] FOREIGN KEY([deptId])
REFERENCES [dbo].[dept] ([deptId])
GO
ALTER TABLE [dbo].[supervises] CHECK CONSTRAINT [FK_supervises_deptID]
GO
ALTER TABLE [dbo].[supervises]  WITH CHECK ADD  CONSTRAINT [FK_supervises_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[supervises] CHECK CONSTRAINT [FK_supervises_pid]
GO


---------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[procAct](
	[actNo] [int] NOT NULL,
	[startDate] [date] NULL,
	[procCost] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[procAct] ADD PRIMARY KEY CLUSTERED 
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [actNo] ON [dbo].[procAct]
(
	[actNo] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[procAct]  WITH CHECK ADD  CONSTRAINT [FK_procAct_actNo] FOREIGN KEY([actNo])
REFERENCES [dbo].[account] ([actNo])
GO
ALTER TABLE [dbo].[procAct] CHECK CONSTRAINT [FK_procAct_actNo]
GO


---------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fitProcess](
	[pid] [int] NOT NULL,
	[process_data] [varchar](64) NULL,
	[fitType] [varchar](64) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fitProcess] ADD PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fitProcess]  WITH CHECK ADD  CONSTRAINT [FK_fitProcess_pid] FOREIGN KEY([pid])
REFERENCES [dbo].[process] ([pid])
GO
ALTER TABLE [dbo].[fitProcess] CHECK CONSTRAINT [FK_fitProcess_pid]
GO




















