USE [Auth]
GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 10-11-2020 17:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holiday](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[month] [int] NULL,
	[date] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[PersmissionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](15) NULL,
	[Isdeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PersmissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectCode] [varchar](15) NULL,
	[ProjectName] [varchar](15) NULL,
	[StartDate] [varchar](15) NULL,
	[EndDate] [varchar](15) NULL,
	[DailyLogHours] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectAlocation]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAlocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Projectid] [int] NULL,
	[userid] [int] NULL,
	[isdeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermission](
	[RolePermissionID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[PermissionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RolePermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[timesheet]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[timesheet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NULL,
	[TimesheeetDate] [date] NULL,
	[TimesheetHour] [numeric](2, 1) NULL,
	[IsOff] [bit] NULL,
	[isHalfday] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UserID] [int] NULL,
	[empid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](15) NULL,
	[LastName] [varchar](15) NULL,
	[UserKey] [varchar](50) NULL,
	[Password] [varchar](15) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](15) NULL,
	[Token] [varchar](max) NULL,
	[empid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 10-11-2020 17:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRoleID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[RoleID] [int] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Holiday] ON 

INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (1, 1, 1)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (2, 1, 26)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (3, 2, 25)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (4, 3, 26)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (5, 4, 14)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (6, 5, 1)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (7, 6, 7)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (8, 7, 30)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (9, 8, 12)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (10, 9, 18)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (11, 9, 19)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (12, 10, 30)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (13, 11, 14)
INSERT [dbo].[Holiday] ([id], [month], [date]) VALUES (14, 12, 25)
SET IDENTITY_INSERT [dbo].[Holiday] OFF
GO
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([ProjectID], [ProjectCode], [ProjectName], [StartDate], [EndDate], [DailyLogHours]) VALUES (1, N'C001', N'EDMS', N'2020-10-01', N'2020-12-30', 8)
SET IDENTITY_INSERT [dbo].[Project] OFF
GO
SET IDENTITY_INSERT [dbo].[ProjectAlocation] ON 

INSERT [dbo].[ProjectAlocation] ([Id], [Projectid], [userid], [isdeleted]) VALUES (1, 1, 1, 0)
INSERT [dbo].[ProjectAlocation] ([Id], [Projectid], [userid], [isdeleted]) VALUES (2, 1, 2, 0)
INSERT [dbo].[ProjectAlocation] ([Id], [Projectid], [userid], [isdeleted]) VALUES (3, 1, 3, 0)
INSERT [dbo].[ProjectAlocation] ([Id], [Projectid], [userid], [isdeleted]) VALUES (4, 1, 4, 0)
SET IDENTITY_INSERT [dbo].[ProjectAlocation] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Member')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[timesheet] ON 

INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (1, 1, CAST(N'2020-10-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:05:11.750' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (2, 1, CAST(N'2020-10-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:05:23.230' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (3, 1, CAST(N'2020-10-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:05:46.813' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (4, 1, CAST(N'2020-10-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:05:54.790' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (5, 1, CAST(N'2020-10-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:06:10.683' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (6, 1, CAST(N'2020-10-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-22T15:06:23.253' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (7, 1, CAST(N'2020-10-07' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-23T17:22:48.573' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (8, 1, CAST(N'2020-10-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-24T13:29:20.270' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (11, 1, CAST(N'2020-10-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-24T13:30:35.253' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (12, 1, CAST(N'2020-10-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-10-24T13:30:42.913' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (13, 1, CAST(N'2020-10-15' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-24T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (14, 1, CAST(N'2020-10-18' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-24T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (15, 1, CAST(N'2020-10-19' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-24T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (16, 1, CAST(N'2020-10-14' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-24T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (17, 1, CAST(N'2020-10-22' AS Date), CAST(3.3 AS Numeric(2, 1)), 1, 1, CAST(N'2020-10-27T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (18, 1, CAST(N'2020-10-13' AS Date), CAST(3.3 AS Numeric(2, 1)), 1, 1, CAST(N'2020-10-27T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (19, 1, CAST(N'2020-10-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.687' AS DateTime), 2, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (20, 1, CAST(N'2020-10-20' AS Date), CAST(3.3 AS Numeric(2, 1)), 1, 1, CAST(N'2020-10-27T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (21, 1, CAST(N'2020-10-29' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-27T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (22, 1, CAST(N'2020-10-28' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (23, 1, CAST(N'2020-10-27' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (24, 1, CAST(N'2020-10-26' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (25, 1, CAST(N'2020-10-21' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (26, 1, CAST(N'2020-10-23' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (27, 1, CAST(N'2020-10-16' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (28, 1, CAST(N'2020-10-12' AS Date), CAST(0.0 AS Numeric(2, 1)), 1, 0, CAST(N'2020-10-29T00:00:00.000' AS DateTime), 1, 2001)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (29, 1, CAST(N'2020-10-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.053' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (30, 1, CAST(N'2020-10-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.137' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (31, 1, CAST(N'2020-10-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.150' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (32, 1, CAST(N'2020-10-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.710' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (33, 1, CAST(N'2020-10-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.713' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (34, 1, CAST(N'2020-10-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.717' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (41, 1, CAST(N'2020-10-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.150' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (42, 1, CAST(N'2020-10-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.153' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (43, 1, CAST(N'2020-10-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.157' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (44, 1, CAST(N'2020-10-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.157' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (45, 1, CAST(N'2020-10-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.157' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (46, 1, CAST(N'2020-10-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.160' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (47, 1, CAST(N'2020-10-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.160' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (48, 1, CAST(N'2020-10-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.163' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (49, 1, CAST(N'2020-10-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.163' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (50, 1, CAST(N'2020-10-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.163' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (51, 1, CAST(N'2020-10-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.167' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (52, 1, CAST(N'2020-10-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.170' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (53, 1, CAST(N'2020-10-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.170' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (54, 1, CAST(N'2020-10-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.173' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (55, 1, CAST(N'2020-10-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.173' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (56, 1, CAST(N'2020-10-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.180' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (57, 1, CAST(N'2020-10-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.183' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (58, 1, CAST(N'2020-10-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.187' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (59, 1, CAST(N'2020-10-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.187' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (60, 1, CAST(N'2020-10-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.187' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (61, 1, CAST(N'2020-10-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.190' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (62, 1, CAST(N'2020-10-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.190' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (63, 1, CAST(N'2020-10-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.193' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (64, 1, CAST(N'2020-10-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.197' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (65, 1, CAST(N'2020-10-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.200' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (66, 1, CAST(N'2020-10-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.203' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (67, 1, CAST(N'2020-10-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T16:26:50.203' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (68, 1, CAST(N'2020-09-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.693' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (69, 1, CAST(N'2020-09-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.750' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (70, 1, CAST(N'2020-09-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.760' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (71, 1, CAST(N'2020-09-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.763' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (72, 1, CAST(N'2020-09-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.763' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (73, 1, CAST(N'2020-09-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.767' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (74, 1, CAST(N'2020-09-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.770' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (75, 1, CAST(N'2020-09-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.770' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (76, 1, CAST(N'2020-09-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.773' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (77, 1, CAST(N'2020-09-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.773' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (78, 1, CAST(N'2020-09-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.777' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (79, 1, CAST(N'2020-09-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.777' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (80, 1, CAST(N'2020-09-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.780' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (81, 1, CAST(N'2020-09-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-03T18:20:16.780' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (82, 1, CAST(N'2020-09-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-03T18:20:16.783' AS DateTime), 0, 2004)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (83, 1, CAST(N'2020-09-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.787' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (84, 1, CAST(N'2020-09-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.787' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (85, 1, CAST(N'2020-09-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.790' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (86, 1, CAST(N'2020-09-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.790' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (87, 1, CAST(N'2020-09-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.793' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (88, 1, CAST(N'2020-09-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.793' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (89, 1, CAST(N'2020-09-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.797' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (90, 1, CAST(N'2020-09-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.797' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (91, 1, CAST(N'2020-09-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.800' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (92, 1, CAST(N'2020-09-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.803' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (93, 1, CAST(N'2020-09-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.803' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (94, 1, CAST(N'2020-09-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.807' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (95, 1, CAST(N'2020-09-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-03T18:20:16.810' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (96, 1, CAST(N'2020-09-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-03T18:20:16.810' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (97, 1, CAST(N'2020-09-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-03T18:20:16.813' AS DateTime), 0, 2003)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (98, 1, CAST(N'2020-10-01' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.543' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (99, 1, CAST(N'2020-10-02' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.593' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (100, 1, CAST(N'2020-10-03' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.607' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (101, 1, CAST(N'2020-10-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.610' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (102, 1, CAST(N'2020-10-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.613' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (103, 1, CAST(N'2020-10-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.690' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (104, 1, CAST(N'2020-10-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.693' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (105, 1, CAST(N'2020-10-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.693' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (106, 1, CAST(N'2020-10-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.697' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (107, 1, CAST(N'2020-10-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.700' AS DateTime), 0, 2002)
GO
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (108, 1, CAST(N'2020-10-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.703' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (109, 1, CAST(N'2020-10-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.703' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (110, 1, CAST(N'2020-10-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-05T14:44:55.707' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (111, 1, CAST(N'2020-10-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-05T14:44:55.710' AS DateTime), 0, 2002)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (112, 1, CAST(N'2020-10-04' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.717' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (113, 1, CAST(N'2020-10-05' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.720' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (114, 1, CAST(N'2020-10-06' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.723' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (115, 1, CAST(N'2020-10-07' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.723' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (116, 1, CAST(N'2020-10-08' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.727' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (117, 1, CAST(N'2020-10-09' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.730' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (118, 1, CAST(N'2020-10-10' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.733' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (119, 1, CAST(N'2020-10-11' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.733' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (120, 1, CAST(N'2020-10-12' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.737' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (121, 1, CAST(N'2020-10-13' AS Date), CAST(6.5 AS Numeric(2, 1)), 0, 0, CAST(N'2020-11-05T14:44:55.740' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (122, 1, CAST(N'2020-10-14' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-05T14:44:55.740' AS DateTime), 0, 2005)
INSERT [dbo].[timesheet] ([ID], [ProjectID], [TimesheeetDate], [TimesheetHour], [IsOff], [isHalfday], [CreatedDate], [UserID], [empid]) VALUES (123, 1, CAST(N'2020-10-15' AS Date), CAST(6.5 AS Numeric(2, 1)), 1, 0, CAST(N'2020-11-05T14:44:55.743' AS DateTime), 0, 2005)
SET IDENTITY_INSERT [dbo].[timesheet] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserID], [FirstName], [LastName], [UserKey], [Password], [IsDeleted], [CreatedDate], [CreatedBy], [Token], [empid]) VALUES (1, N'Neeethu', N'shaji', N'neethushaji2@gmail.com', N'pass@456', 0, CAST(N'2020-10-21T11:21:03.103' AS DateTime), N'test', N'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJEZXQiOlsiMSIsIjIwMDEiLCJmYWxzZSJdLCJuYmYiOjE2MDQ0ODYxMTksImV4cCI6MTYwNDU3MjUxOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0NTA5Mi8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjQ1MDkyLyJ9.iMtc6dHolGeQtNgs9Jsu5gywyo87HfI0rm1XhB6cxig', 2001)
INSERT [dbo].[UserProfile] ([UserID], [FirstName], [LastName], [UserKey], [Password], [IsDeleted], [CreatedDate], [CreatedBy], [Token], [empid]) VALUES (2, N'Samanyu', N'subin', N'samanyu@gmail.com', N'pass@123', 0, CAST(N'2020-10-21T11:21:03.103' AS DateTime), N'test', NULL, 2002)
INSERT [dbo].[UserProfile] ([UserID], [FirstName], [LastName], [UserKey], [Password], [IsDeleted], [CreatedDate], [CreatedBy], [Token], [empid]) VALUES (3, N'Sanvika', N'subin', N'sanvika@gmail.com', N'pass@123', 0, CAST(N'2020-10-21T11:21:03.103' AS DateTime), N'test', NULL, 2003)
INSERT [dbo].[UserProfile] ([UserID], [FirstName], [LastName], [UserKey], [Password], [IsDeleted], [CreatedDate], [CreatedBy], [Token], [empid]) VALUES (4, N'Subin', N'Das', N'dassubin@gmail.com', N'pass@123', 0, CAST(N'2020-10-21T11:21:03.103' AS DateTime), N'test', N'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJEZXQiOlsiNCIsIjIwMDQiLCJ0cnVlIl0sIm5iZiI6MTYwNDU2ODA3MiwiZXhwIjoxNjA0NjU0NDcyLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjQ1MDkyLyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDUwOTIvIn0.Ufn8gQlgi5nQJQXbG-rCP5Li8B3-Op8fuxMhNIf7Q1w', 2004)
INSERT [dbo].[UserProfile] ([UserID], [FirstName], [LastName], [UserKey], [Password], [IsDeleted], [CreatedDate], [CreatedBy], [Token], [empid]) VALUES (5, N'Jerin', N'Jose', N'Jerin.Jose@cognizant.com', N'123', 0, CAST(N'2020-11-03T00:00:00.000' AS DateTime), N'FileUpload', NULL, 2005)
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID], [IsDeleted], [CreatedDate], [CreatedBy]) VALUES (1, 4, 1, 0, CAST(N'2020-10-21T19:30:11.260' AS DateTime), N'subin')
INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID], [IsDeleted], [CreatedDate], [CreatedBy]) VALUES (2, 1, 2, 0, CAST(N'2020-10-21T19:30:34.540' AS DateTime), N'subin')
INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID], [IsDeleted], [CreatedDate], [CreatedBy]) VALUES (3, 2, 2, 0, CAST(N'2020-10-21T19:30:34.563' AS DateTime), N'subin')
INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID], [IsDeleted], [CreatedDate], [CreatedBy]) VALUES (4, 3, 2, 0, CAST(N'2020-10-21T19:30:34.567' AS DateTime), N'subin')
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
