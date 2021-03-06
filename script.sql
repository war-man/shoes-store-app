USE [DbShoeStore]
GO
/****** Object:  Table [dbo].[Price]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[PriceID] [bigint] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NULL,
	[Value] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED 
(
	[PriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ColorPrice]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ColorPrice](
	[ColorID] [bigint] NOT NULL,
	[PriceID] [bigint] NOT NULL,
 CONSTRAINT [PK_ColorPrice] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC,
	[PriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PriceOfShoesView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[PriceOfShoesView]
as
select * from
(select ColorID,DateCreated,Value from ColorPrice,Price 
where ColorPrice.PriceID = Price.PriceID) T1
where T1.DateCreated >= all(select DateCreated from
(select ColorID,DateCreated,Value from ColorPrice,Price 
where ColorPrice.PriceID = Price.PriceID) T2 where T1.ColorID = T2.ColorID)
GO
/****** Object:  Table [dbo].[PhotoDescriptions]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhotoDescriptions](
	[PhotoID] [bigint] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](200) NULL,
	[Status] [bit] NULL,
	[ColorID] [bigint] NULL,
 CONSTRAINT [PK_PhotoDescriptions] PRIMARY KEY CLUSTERED 
(
	[PhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PhotoOfShoesView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[PhotoOfShoesView]
as
select * from (select * from PhotoDescriptions where Status = 1) T1
where T1.PhotoID <= all(select PhotoID from (select * from PhotoDescriptions where Status = 1) T2
where T1.ColorID = T2.ColorID ) 
GO
/****** Object:  Table [dbo].[ShoeSize]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoeSize](
	[ShoeID] [bigint] NOT NULL,
	[SizeID] [bigint] NOT NULL,
 CONSTRAINT [PK_ShoeSize] PRIMARY KEY CLUSTERED 
(
	[ShoeID] ASC,
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[SizeID] [bigint] IDENTITY(1,1) NOT NULL,
	[Number] [numeric](18, 1) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Size] PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductSizeView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ProductSizeView]
as
select ShoeID,Number,Status from ShoeSize,Size
where ShoeSize.SizeID= Size.SizeID
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
	[CategoryParentID] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shoe]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shoe](
	[ShoeID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Descriptions] [nvarchar](200) NULL,
	[VideoIllustration] [nvarchar](200) NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK_Shoe] PRIMARY KEY CLUSTERED 
(
	[ShoeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Color]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[ColorID] [bigint] IDENTITY(1,1) NOT NULL,
	[ColorName] [nvarchar](50) NULL,
	[ViewNumber] [int] NULL,
	[LikeNumber] [int] NULL,
	[Status] [bit] NULL,
	[DateCreated] [datetime] NULL,
	[ShoeID] [bigint] NULL,
 CONSTRAINT [PK_Color] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TemplateProductView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TemplateProductView]
as
select Shoe.ShoeID,Name,Descriptions,Shoe.CategoryID,CategoryName,T1.ColorID,T1.ColorName,
T1.DateCreated DateCreateColor, T1.Status ColorStatus,ViewNumber,LikeNumber,
PriceOfShoesView.DateCreated DateCreatePrice,Value Price, PhotoID,Image,PhotoOfShoesView.Status ImageStatus
from(
select * from Color C1
where LikeNumber >= all(select LikeNumber
from Color where C1.ShoeID = Color.ShoeID)) T1
join PriceOfShoesView on T1.ColorID = PriceOfShoesView.ColorID
join Shoe on T1.ShoeID = Shoe.ShoeID
join Category on Category.CategoryID = Shoe.CategoryID
join PhotoOfShoesView on PhotoOfShoesView.ColorID = T1.ColorID
GO
/****** Object:  View [dbo].[TopTrendingView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TopTrendingView]
as
select Shoe.ShoeID,Name,Descriptions,Shoe.CategoryID,CategoryName,T1.ColorID,T1.ColorName,
T1.DateCreated DateCreateColor, T1.Status ColorStatus,ViewNumber,LikeNumber,
PriceOfShoesView.DateCreated DateCreatePrice,Value Price, PhotoID,Image,PhotoOfShoesView.Status ImageStatus
from(
select * from Color C1
where LikeNumber >= all(select LikeNumber
from Color where C1.ShoeID = Color.ShoeID)
and C1.Status = 1 and DATEDIFF(day,C1.DateCreated,GETDATE()) <= 30) T1
join PriceOfShoesView on T1.ColorID = PriceOfShoesView.ColorID
join Shoe on T1.ShoeID = Shoe.ShoeID
join Category on Category.CategoryID = Shoe.CategoryID
join PhotoOfShoesView on PhotoOfShoesView.ColorID = T1.ColorID
GO
/****** Object:  View [dbo].[ProductView]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ProductView]
as
select C.ShoeID,Name,Descriptions, VideoIllustration, Category.CategoryID,CategoryName,
C.ColorID,ColorName,c.DateCreated DateCreateColor, C.Status ColorStatus,
ViewNumber,LikeNumber,PriceOfShoesView.DateCreated DateCreatePrice,Value Price,
PhotoID,Image,PhotoOfShoesView.Status ImageStatus
from Color C
join PriceOfShoesView on C.ColorID = PriceOfShoesView.ColorID
join Shoe on C.ShoeID = Shoe.ShoeID
join Category on Category.CategoryID = Shoe.CategoryID
join PhotoOfShoesView on PhotoOfShoesView.ColorID = C.ColorID
GO
/****** Object:  Table [dbo].[PurchaseOrders]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrders](
	[PoID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL,
	[DeliveryDate] [datetime] NULL,
	[Status] [bit] NULL,
	[PayID] [int] NULL,
 CONSTRAINT [PK_PurchaseOrders] PRIMARY KEY CLUSTERED 
(
	[PoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderDetails]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderDetails](
	[UserID] [bigint] NOT NULL,
	[PoID] [bigint] NOT NULL,
	[ShoeID] [bigint] NOT NULL,
	[Quantity] [int] NULL,
	[Cost] [numeric](18, 2) NULL,
	[Color] [nvarchar](50) NULL,
	[Size] [numeric](18, 2) NULL,
 CONSTRAINT [PK_PurchaseOrderDetails] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[PoID] ASC,
	[ShoeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_OrderDetails]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[udf_OrderDetails]()
returns table
as
return(
select T1.PoID,OrderDate,DeliveryDate,T1.UserID,T1.ShoeID,ColorID,Quantity,Cost,Color,Size,PayID 
from(
select A.PoID,OrderDate,DeliveryDate,B.UserID,B.ShoeID,Quantity,Cost,Color,Size,PayID 
from PurchaseOrders A,PurchaseOrderDetails B
where A.PoID = B.PoID and Status = 'true') T1
join Color on T1.ShoeID = Color.ShoeID and T1.Color = Color.ColorName
and DATEDIFF(day,T1.OrderDate,GETDATE()) <= 30)
GO
/****** Object:  View [dbo].[BestSellerProduct]    Script Date: 11/30/2019 1:19:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[BestSellerProduct]
as
select ShoeID,ColorID,sum(Quantity) Total from udf_OrderDetails()
group by ShoeID,ColorID
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Email] [varchar](200) NULL,
	[Password] [varchar](20) NULL,
	[DateCreated] [datetime] NULL,
	[Status] [bit] NULL,
	[UserID] [bigint] NULL,
	[ManageID] [bigint] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountAuthorization]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountAuthorization](
	[AccID] [bigint] NOT NULL,
	[AuID] [int] NOT NULL,
 CONSTRAINT [PK_AccountAuthorization] PRIMARY KEY CLUSTERED 
(
	[AccID] ASC,
	[AuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authorization](
	[AuID] [int] IDENTITY(1,1) NOT NULL,
	[AuName] [nvarchar](50) NULL,
	[Descriptions] [nvarchar](200) NULL,
 CONSTRAINT [PK_Authorization] PRIMARY KEY CLUSTERED 
(
	[AuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FbID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UContent] [text] NULL,
	[UserID] [bigint] NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[FbID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Link] [varchar](200) NULL,
	[DateCreated] [datetime] NULL,
	[Status] [bit] NULL,
	[AccID] [bigint] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayMethod]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayMethod](
	[PayID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_PayMethod] PRIMARY KEY CLUSTERED 
(
	[PayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[SlideID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Link] [varchar](200) NULL,
	[DateCreated] [datetime] NULL,
	[Status] [bit] NULL,
	[AccID] [bigint] NULL,
 CONSTRAINT [PK_Slide] PRIMARY KEY CLUSTERED 
(
	[SlideID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/30/2019 1:19:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NULL,
	[DayOfBirth] [date] NULL,
	[Gender] [char](1) NULL,
	[Email] [varchar](200) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [nvarchar](300) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccID], [UserName], [Email], [Password], [DateCreated], [Status], [UserID], [ManageID]) VALUES (1, N'user', N'nhthinh@gmail.com', N'1', NULL, 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryParentID]) VALUES (1, N'MEN', NULL)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryParentID]) VALUES (2, N'WOMEN', NULL)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [CategoryParentID]) VALUES (3, N'KIDS', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Color] ON 

INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (1, N'Orangle Pulse', 5000, 150, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (2, N'Vast Gray', 5000, 75, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (3, N'Ghost Aqua', 5000, 200, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (4, N'Dynamic Yellow', 5000, 68, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (5, N'Vivid Purple', 5000, 81, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (6, N'Black White', 5000, 134, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (7, N'Dark', 5000, 75, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (8, N'White Pink', 5000, 86, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (9, N'White Light', 5000, 250, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (10, N'Black White', 5000, 96, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (11, N'Brown', 5000, 3, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (12, N'White Gray', 5000, 58, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (13, N'White Black', 5000, 99, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (14, N'Red White', 5000, 15, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (15, N'Blue Black', 5000, 22, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (16, N'Hybrid', 5000, 11, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (17, N'Black', 5000, 36, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (18, N'Blue', 5000, 11, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (19, N'Brown Orange', 5000, 112, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (20, N'Yellow Light', 5000, 60, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (21, N'White', 5000, 93, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (22, N'Black Red', 5000, 27, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (23, N'Purple', 5000, 175, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (24, N'Pink', 5000, 191, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (25, N'White', 5000, 13, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (26, N'Black', 5000, 7, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (27, N'Red', 5000, 54, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (28, N'White', 5000, 1, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (29, N'Gray Black', 5000, 5, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Color] ([ColorID], [ColorName], [ViewNumber], [LikeNumber], [Status], [DateCreated], [ShoeID]) VALUES (30, N'Black', 5000, 15, 1, CAST(N'2019-11-28T00:00:00.000' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[Color] OFF
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (1, 1)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (1, 2)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (1, 3)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (2, 3)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (2, 7)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (3, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (4, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (5, 7)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (6, 8)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (7, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (8, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (9, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (10, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (11, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (12, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (13, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (14, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (15, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (16, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (17, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (18, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (19, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (20, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (21, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (22, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (23, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (24, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (25, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (26, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (27, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (28, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (29, 5)
INSERT [dbo].[ColorPrice] ([ColorID], [PriceID]) VALUES (30, 5)
SET IDENTITY_INSERT [dbo].[PayMethod] ON 

INSERT [dbo].[PayMethod] ([PayID], [Name], [Status]) VALUES (1, N'Check Payments', 1)
INSERT [dbo].[PayMethod] ([PayID], [Name], [Status]) VALUES (2, N'Paypal', 1)
SET IDENTITY_INSERT [dbo].[PayMethod] OFF
SET IDENTITY_INSERT [dbo].[PhotoDescriptions] ON 

INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (1, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_a3_mzhk2a.webp', 1, 1)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (2, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_b3_c7gll6.webp', 1, 1)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (3, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775110/storage/women/Nike_Jordan_Why_Not_Zer02_c3_plhk37.webp', 1, 1)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (4, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_d3_rtjil4.webp', 1, 1)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (5, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775112/storage/women/Nike_Jordan_Why_Not_Zer02_a2_zcesgi.webp', 1, 2)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (6, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_b2_obwmjy.webp', 1, 2)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (7, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775110/storage/women/Nike_Jordan_Why_Not_Zer02_c2_pb41jb.webp', 1, 2)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (8, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_d2_tdojeq.webp', 1, 2)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (9, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775112/storage/women/Nike_Jordan_Why_Not_Zer02_a1_occi1d.webp', 1, 3)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (10, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775111/storage/women/Nike_Jordan_Why_Not_Zer02_b1_s2jbsn.webp', 1, 3)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (11, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775110/storage/women/Nike_Jordan_Why_Not_Zer02_c1_bc4wrv.webp', 1, 3)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (12, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775110/storage/women/Nike_Jordan_Why_Not_Zer02_d1_oqhgbl.webp', 1, 3)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (13, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_a1_pd3qj8.webp', 1, 4)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (14, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_b1_egjvk7.webp', 1, 4)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (15, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_c1_suw8th.webp', 1, 4)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (16, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_Air_Max_270_React_d1_hgpqnr.webp', 1, 4)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (17, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_a2_kfzjrr.webp', 1, 5)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (18, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_b2_or7o5b.webp', 1, 5)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (19, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_Air_Max_270_React_c2_hr2hbf.webp', 1, 5)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (20, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_Air_Max_270_React_d2_guzjab.webp', 1, 5)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (21, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_a3_h4iji7.webp', 1, 6)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (22, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775216/storage/kids/Nike_Air_Max_270_React_b3_koefd6.webp', 1, 6)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (23, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_Air_Max_270_React_c3_gythft.webp', 1, 6)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (24, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_Air_Max_270_React_d3_lul1ae.webp', 1, 6)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (25, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775132/storage/women/Nike_Air_VarpoMax_a1_vdiexz.webp', 1, 7)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (26, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775132/storage/women/Nike_Air_VarpoMax_b1_lr26lf.webp', 1, 7)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (27, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775130/storage/women/Nike_Air_VarpoMax_c1_ynn6r6.webp', 1, 7)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (28, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775130/storage/women/Nike_Air_VarpoMax_d1_qlvvy6.webp', 1, 7)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (29, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_a2_pzueme.webp', 1, 8)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (30, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_b2_hspbp7.webp', 1, 8)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (31, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775130/storage/women/Nike_Air_VarpoMax_c2_ifgowe.webp', 1, 8)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (32, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775130/storage/women/Nike_Air_VarpoMax_d2_pvqfl9.webp', 1, 8)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (33, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_a3_bbdjgf.webp', 1, 9)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (34, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_b3_mfhvqh.webp', 1, 9)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (35, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_c3_ihi0hb.webp', 1, 9)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (36, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775131/storage/women/Nike_Air_VarpoMax_d3_drgelz.webp', 1, 9)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (37, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775015/storage/men/Nike_Epic_React_a1_kwzzdm.webp', 1, 10)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (38, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_b1_v1yh51.webp', 1, 10)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (39, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775013/storage/men/Nike_Epic_React_c1_wegzaz.webp', 1, 10)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (40, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_d1_i8kymn.webp', 1, 10)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (41, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775015/storage/men/Nike_Epic_React_a2_lnaic5.webp', 1, 11)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (42, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_b2_wv1wnu.webp', 1, 11)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (43, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775013/storage/men/Nike_Epic_React_c2_j641df.webp', 1, 11)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (44, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775013/storage/men/Nike_Epic_React_d2_jlyln0.webp', 1, 11)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (45, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_a3_yz1fp5.webp', 1, 12)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (46, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_b3_r6bqav.webp', 1, 12)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (47, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775014/storage/men/Nike_Epic_React_c3_frsuep.webp', 1, 12)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (48, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775013/storage/men/Nike_Epic_React_d3_ckvi8a.webp', 1, 12)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (49, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775027/storage/men/Nike_Metcon_5_a1_hzmstq.webp', 1, 13)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (50, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775027/storage/men/Nike_Metcon_5_b1_tciqo9.webp', 1, 13)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (51, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_c1_eos3vy.webp', 1, 13)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (52, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_d1_xxwkbv.webp', 1, 13)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (53, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775027/storage/men/Nike_Metcon_5_a2_u2xktr.webp', 1, 14)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (54, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775027/storage/men/Nike_Metcon_5_b2_ou6tux.webp', 1, 14)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (55, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_c2_mx2bng.webp', 1, 14)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (56, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_d2_kppmlg.webp', 1, 14)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (57, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775027/storage/men/Nike_Metcon_5_a3_vdxsal.webp', 1, 15)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (58, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_b3_toz2wj.webp', 1, 15)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (59, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_c3_mc3oav.webp', 1, 15)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (60, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775026/storage/men/Nike_Metcon_5_d3_fntvbk.webp', 1, 15)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (61, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775147/storage/women/Nike_Zoom_Freak_1_a1_dmlpha.webp', 1, 16)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (62, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775146/storage/women/Nike_Zoom_Freak_1_b1_k3saed.webp', 1, 16)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (63, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_c1_jougdv.webp', 1, 16)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (64, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_d1_pgnxnh.webp', 1, 16)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (65, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775147/storage/women/Nike_Zoom_Freak_1_a2_e3ufjh.webp', 1, 17)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (66, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775146/storage/women/Nike_Zoom_Freak_1_b2_ai60r7.webp', 1, 17)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (67, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_c2_nrgnxt.webp', 1, 17)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (68, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_d2_ui99qe.webp', 1, 17)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (69, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775146/storage/women/Nike_Zoom_Freak_1_a3_xqkzer.webp', 1, 18)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (70, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775146/storage/women/Nike_Zoom_Freak_1_b3_fywsze.webp', 1, 18)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (71, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_c3_fwe6oi.webp', 1, 18)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (72, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775145/storage/women/Nike_Zoom_Freak_1_d3_vpkwd7.webp', 1, 18)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (73, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775048/storage/men/Nike_Free_Metcon_a1_myavsh.webp', 1, 19)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (74, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775046/storage/men/Nike_Free_Metcon_b1_lmixvg.webp', 1, 19)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (75, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775048/storage/men/Nike_Free_Metcon_c1_e8huht.webp', 1, 19)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (76, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775045/storage/men/Nike_Free_Metcon_d1_fdb7eu.webp', 1, 19)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (77, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775047/storage/men/Nike_Free_Metcon_a2_n0gvvw.webp', 1, 20)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (78, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775046/storage/men/Nike_Free_Metcon_b2_zgwx9v.webp', 1, 20)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (79, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775045/storage/men/Nike_Free_Metcon_c2_e7jzhf.webp', 1, 20)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (80, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775045/storage/men/Nike_Free_Metcon_d2_v4kkuv.webp', 1, 20)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (81, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775046/storage/men/Nike_Free_Metcon_a3_h74b9p.webp', 1, 21)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (82, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775046/storage/men/Nike_Free_Metcon_b3_niyjwa.webp', 1, 21)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (83, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775045/storage/men/Nike_Free_Metcon_c3_zdqneu.webp', 1, 21)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (84, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775045/storage/men/Nike_Free_Metcon_d3_fyyj7n.webp', 1, 21)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (85, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_React_Presto_a1_puubhi.webp', 1, 22)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (86, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_b1_cbzugp.webp', 1, 22)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (87, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_c1_qrcpbq.webp', 1, 22)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (88, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_d1_gjvsee.webp', 1, 22)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (89, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775215/storage/kids/Nike_React_Presto_a2_voucbh.webp', 1, 23)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (90, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_b2_akbfhn.webp', 1, 23)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (91, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_c2_qloslk.webp', 1, 23)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (92, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_d2_folieh.webp', 1, 23)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (93, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_a3_h98cmz.webp', 1, 24)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (94, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_b3_vxa7np.webp', 1, 24)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (95, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_c3_jwuogy.webp', 1, 24)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (96, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775214/storage/kids/Nike_React_Presto_d3_jdk6rp.webp', 1, 24)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (97, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775079/storage/men/Air_Jordan_XXXIV_a1_cysakk.webp', 1, 25)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (98, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775078/storage/men/Air_Jordan_XXXIV_b1_ftartz.webp', 1, 25)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (99, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775077/storage/men/Air_Jordan_XXXIV_c1_u1wlx1.webp', 1, 25)
GO
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (100, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775077/storage/men/Air_Jordan_XXXIV_d1_zquk7p.webp', 1, 25)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (101, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775078/storage/men/Air_Jordan_XXXIV_a2_q33blj.webp', 1, 26)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (102, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775078/storage/men/Air_Jordan_XXXIV_b2_mr7cdj.webp', 1, 26)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (103, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775077/storage/men/Air_Jordan_XXXIV_c2_cw32cj.webp', 1, 26)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (104, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775079/storage/men/Air_Jordan_XXXIV_d2_pza0yx.webp', 1, 26)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (105, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775078/storage/men/Air_Jordan_XXXIV_a3_wrpicc.webp', 1, 27)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (106, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775078/storage/men/Air_Jordan_XXXIV_b3_mh9j2a.webp', 1, 27)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (107, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775077/storage/men/Air_Jordan_XXXIV_c3_zpxc08.webp', 1, 27)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (108, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775077/storage/men/Air_Jordan_XXXIV_d3_a66yr5.webp', 1, 27)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (109, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_a1_nglkcx.webp', 1, 28)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (110, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_b1_z3ko9t.webp', 1, 28)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (111, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775168/storage/women/Nike_Drop-Type_c1_lzjwbt.webp', 1, 28)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (112, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775166/storage/women/Nike_Drop-Type_d1_mnqyhl.webp', 1, 28)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (113, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_a2_k5rds7.webp', 1, 29)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (114, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_b2_cbrbod.webp', 1, 29)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (115, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775166/storage/women/Nike_Drop-Type_c2_wab7qn.webp', 1, 29)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (116, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775166/storage/women/Nike_Drop-Type_d2_eeqebh.webp', 1, 29)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (117, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_a3_a8icxp.webp', 1, 30)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (118, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775167/storage/women/Nike_Drop-Type_b3_l8oogp.webp', 1, 30)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (119, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775166/storage/women/Nike_Drop-Type_c3_meugmy.webp', 1, 30)
INSERT [dbo].[PhotoDescriptions] ([PhotoID], [Image], [Status], [ColorID]) VALUES (120, N'https://res.cloudinary.com/dfiw4oxro/image/upload/v1574775165/storage/women/Nike_Drop-Type_d3_f75afi.webp', 1, 30)
SET IDENTITY_INSERT [dbo].[PhotoDescriptions] OFF
SET IDENTITY_INSERT [dbo].[Price] ON 

INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (1, CAST(N'2019-10-18T00:00:00.000' AS DateTime), CAST(100.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (2, CAST(N'2019-10-19T00:00:00.000' AS DateTime), CAST(110.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (3, CAST(N'2019-10-20T00:00:00.000' AS DateTime), CAST(115.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (4, CAST(N'2019-10-21T00:00:00.000' AS DateTime), CAST(120.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (5, CAST(N'2019-10-22T00:00:00.000' AS DateTime), CAST(125.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (6, CAST(N'2019-10-23T00:00:00.000' AS DateTime), CAST(130.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (7, CAST(N'2019-10-24T00:00:00.000' AS DateTime), CAST(135.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (8, CAST(N'2019-10-25T00:00:00.000' AS DateTime), CAST(140.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (9, CAST(N'2019-10-26T00:00:00.000' AS DateTime), CAST(145.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (10, CAST(N'2019-10-27T00:00:00.000' AS DateTime), CAST(150.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (11, CAST(N'2019-10-28T00:00:00.000' AS DateTime), CAST(155.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (12, CAST(N'2019-10-29T00:00:00.000' AS DateTime), CAST(160.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (13, CAST(N'2019-10-30T00:00:00.000' AS DateTime), CAST(165.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (14, CAST(N'2019-11-01T00:00:00.000' AS DateTime), CAST(170.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (15, CAST(N'2019-11-02T00:00:00.000' AS DateTime), CAST(175.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (16, CAST(N'2019-11-03T00:00:00.000' AS DateTime), CAST(180.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (17, CAST(N'2019-11-04T00:00:00.000' AS DateTime), CAST(185.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (18, CAST(N'2019-11-05T00:00:00.000' AS DateTime), CAST(190.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (19, CAST(N'2019-11-06T00:00:00.000' AS DateTime), CAST(195.00 AS Numeric(18, 2)))
INSERT [dbo].[Price] ([PriceID], [DateCreated], [Value]) VALUES (20, CAST(N'2019-11-07T00:00:00.000' AS DateTime), CAST(200.00 AS Numeric(18, 2)))
SET IDENTITY_INSERT [dbo].[Price] OFF
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (1, 1, 4, 1, CAST(125.00 AS Numeric(18, 2)), N'Black White', CAST(43.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (1, 2, 8, 1, CAST(125.00 AS Numeric(18, 2)), N'Pink', CAST(43.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (2, 3, 10, 5, CAST(125.00 AS Numeric(18, 2)), N'Gray Black', CAST(41.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (3, 4, 9, 2, CAST(125.00 AS Numeric(18, 2)), N'Red', CAST(43.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (3, 8, 6, 2, CAST(125.00 AS Numeric(18, 2)), N'Black', CAST(41.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (4, 5, 1, 3, CAST(125.00 AS Numeric(18, 2)), N'Ghost Aqua', CAST(42.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (5, 6, 3, 1, CAST(125.00 AS Numeric(18, 2)), N'White Light', CAST(40.00 AS Numeric(18, 2)))
INSERT [dbo].[PurchaseOrderDetails] ([UserID], [PoID], [ShoeID], [Quantity], [Cost], [Color], [Size]) VALUES (5, 7, 5, 4, CAST(125.00 AS Numeric(18, 2)), N'White Black', CAST(43.00 AS Numeric(18, 2)))
SET IDENTITY_INSERT [dbo].[PurchaseOrders] ON 

INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (1, CAST(N'2019-11-22T00:38:34.590' AS DateTime), NULL, 1, 1)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (2, CAST(N'2019-11-22T01:02:09.880' AS DateTime), NULL, 1, 1)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (3, CAST(N'2019-11-15T00:00:00.000' AS DateTime), NULL, 1, 2)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (4, CAST(N'2019-11-02T00:00:00.000' AS DateTime), NULL, 1, 1)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (5, CAST(N'2019-11-14T00:00:00.000' AS DateTime), NULL, 1, 1)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (6, CAST(N'2019-11-20T00:00:00.000' AS DateTime), NULL, 1, 1)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (7, CAST(N'2019-11-07T00:00:00.000' AS DateTime), NULL, 1, 2)
INSERT [dbo].[PurchaseOrders] ([PoID], [OrderDate], [DeliveryDate], [Status], [PayID]) VALUES (8, CAST(N'2019-11-28T00:00:00.000' AS DateTime), NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[PurchaseOrders] OFF
SET IDENTITY_INSERT [dbo].[Shoe] ON 

INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (1, N'Jordan Zer0.2 SE', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/BXci8fl99M8', 2)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (2, N'Nike Air Max 270', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/ELISF5zdc0s', 3)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (3, N'Nike Air VarpoMax', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/jpUkLeW-VoM', 2)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (4, N'Nike Epic React', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/YwpUbMxz7vg', 1)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (5, N'Nike Metcon 5', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/NP7oNGpH-LQ', 1)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (6, N'Nike Zoom Freak 1', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/H6-NoTE1YXE', 2)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (7, N'Nike Free Metcon', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/TBD8-WsPn6A', 1)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (8, N'Nike React Presto', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/V72z-uikrmc', 3)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (9, N'Air Jordan XXXIV', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/PKxwQ9o7FXg', 1)
INSERT [dbo].[Shoe] ([ShoeID], [Name], [Descriptions], [VideoIllustration], [CategoryID]) VALUES (10, N'Nike Drop Type', N'Full canvas double sided print with rounded toe construction', N'https://www.youtube.com/embed/rJH3JTD9_sg&feature=youtu.be', 2)
SET IDENTITY_INSERT [dbo].[Shoe] OFF
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (1, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (1, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (1, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (1, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (1, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (2, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (2, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (2, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (2, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (2, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (3, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (3, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (3, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (3, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (3, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (4, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (4, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (4, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (4, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (4, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (5, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (5, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (5, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (5, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (5, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (6, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (6, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (6, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (6, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (6, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (7, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (7, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (7, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (7, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (7, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (8, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (8, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (8, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (8, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (8, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (9, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (9, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (9, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (9, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (9, 10)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (10, 6)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (10, 7)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (10, 8)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (10, 9)
INSERT [dbo].[ShoeSize] ([ShoeID], [SizeID]) VALUES (10, 10)
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (1, CAST(35.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (2, CAST(36.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (3, CAST(37.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (4, CAST(38.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (5, CAST(39.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (6, CAST(40.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (7, CAST(41.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (8, CAST(42.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (9, CAST(43.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (10, CAST(44.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (11, CAST(45.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (12, CAST(46.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (13, CAST(47.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (14, CAST(48.0 AS Numeric(18, 1)), 1)
INSERT [dbo].[Size] ([SizeID], [Number], [Status]) VALUES (15, CAST(49.0 AS Numeric(18, 1)), 1)
SET IDENTITY_INSERT [dbo].[Size] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [Name], [DayOfBirth], [Gender], [Email], [Phone], [Address]) VALUES (1, N'Nguyen Hoang Thinh', CAST(N'1997-10-06' AS Date), N'M', N'blv.tu97@gmail.com', N'0988419846', N'Thon 11, My Thang, Phu My, Binh Dinh')
INSERT [dbo].[User] ([UserID], [Name], [DayOfBirth], [Gender], [Email], [Phone], [Address]) VALUES (2, N'Luu Van Quan', CAST(N'1999-05-07' AS Date), N'M', N'dbabi@gmail.com', N'0973234116', N'Quan 12')
INSERT [dbo].[User] ([UserID], [Name], [DayOfBirth], [Gender], [Email], [Phone], [Address]) VALUES (3, N'Nguyen Anh Quan', CAST(N'1999-08-02' AS Date), N'M', N'aquan69@gmail.com', N'0987653210', N'Thu Duc')
INSERT [dbo].[User] ([UserID], [Name], [DayOfBirth], [Gender], [Email], [Phone], [Address]) VALUES (4, N'Huynh Nhan', CAST(N'1999-11-20' AS Date), N'M', N'huynhnhan@yahoo.com', N'0999888888', N'Quan 1')
INSERT [dbo].[User] ([UserID], [Name], [DayOfBirth], [Gender], [Email], [Phone], [Address]) VALUES (5, N'Lionel Messi', CAST(N'1989-10-06' AS Date), N'M', N'm10@gmail.com', N'0888888888', N'Argentina')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK__Account__ManageI__6FE99F9F] FOREIGN KEY([ManageID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK__Account__ManageI__6FE99F9F]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Users]
GO
ALTER TABLE [dbo].[AccountAuthorization]  WITH CHECK ADD  CONSTRAINT [FK__AccountAu__AccID__7B5B524B] FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[AccountAuthorization] CHECK CONSTRAINT [FK__AccountAu__AccID__7B5B524B]
GO
ALTER TABLE [dbo].[AccountAuthorization]  WITH CHECK ADD  CONSTRAINT [FK_AccountAuthorization_Authorization] FOREIGN KEY([AuID])
REFERENCES [dbo].[Authorization] ([AuID])
GO
ALTER TABLE [dbo].[AccountAuthorization] CHECK CONSTRAINT [FK_AccountAuthorization_Authorization]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK__Category__Catego__72C60C4A] FOREIGN KEY([CategoryParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK__Category__Catego__72C60C4A]
GO
ALTER TABLE [dbo].[Color]  WITH CHECK ADD  CONSTRAINT [FK__Color__ShoeID__75A278F5] FOREIGN KEY([ShoeID])
REFERENCES [dbo].[Shoe] ([ShoeID])
GO
ALTER TABLE [dbo].[Color] CHECK CONSTRAINT [FK__Color__ShoeID__75A278F5]
GO
ALTER TABLE [dbo].[ColorPrice]  WITH CHECK ADD  CONSTRAINT [FK__ColorPric__Color__7C4F7684] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[ColorPrice] CHECK CONSTRAINT [FK__ColorPric__Color__7C4F7684]
GO
ALTER TABLE [dbo].[ColorPrice]  WITH CHECK ADD  CONSTRAINT [FK__ColorPric__Price__7D439ABD] FOREIGN KEY([PriceID])
REFERENCES [dbo].[Price] ([PriceID])
GO
ALTER TABLE [dbo].[ColorPrice] CHECK CONSTRAINT [FK__ColorPric__Price__7D439ABD]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK__Feedback__UserID__6EF57B66] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK__Feedback__UserID__6EF57B66]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK__Menu__AccID__6D0D32F4] FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK__Menu__AccID__6D0D32F4]
GO
ALTER TABLE [dbo].[PhotoDescriptions]  WITH CHECK ADD  CONSTRAINT [FK__PhotoDesc__Color__76969D2E] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Color] ([ColorID])
GO
ALTER TABLE [dbo].[PhotoDescriptions] CHECK CONSTRAINT [FK__PhotoDesc__Color__76969D2E]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseO__ShoeI__7A672E12] FOREIGN KEY([ShoeID])
REFERENCES [dbo].[Shoe] ([ShoeID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [FK__PurchaseO__ShoeI__7A672E12]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseO__UserI__787EE5A0] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [FK__PurchaseO__UserI__787EE5A0]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseOr__PoID__797309D9] FOREIGN KEY([PoID])
REFERENCES [dbo].[PurchaseOrders] ([PoID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [FK__PurchaseOr__PoID__797309D9]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD  CONSTRAINT [FK__PurchaseO__PayID__778AC167] FOREIGN KEY([PayID])
REFERENCES [dbo].[PayMethod] ([PayID])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK__PurchaseO__PayID__778AC167]
GO
ALTER TABLE [dbo].[Shoe]  WITH CHECK ADD  CONSTRAINT [FK_Shoe_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Shoe] CHECK CONSTRAINT [FK_Shoe_Category]
GO
ALTER TABLE [dbo].[ShoeSize]  WITH CHECK ADD  CONSTRAINT [FK__ShoeSize__ShoeID__7E37BEF6] FOREIGN KEY([ShoeID])
REFERENCES [dbo].[Shoe] ([ShoeID])
GO
ALTER TABLE [dbo].[ShoeSize] CHECK CONSTRAINT [FK__ShoeSize__ShoeID__7E37BEF6]
GO
ALTER TABLE [dbo].[ShoeSize]  WITH CHECK ADD  CONSTRAINT [FK__ShoeSize__SizeID__7F2BE32F] FOREIGN KEY([SizeID])
REFERENCES [dbo].[Size] ([SizeID])
GO
ALTER TABLE [dbo].[ShoeSize] CHECK CONSTRAINT [FK__ShoeSize__SizeID__7F2BE32F]
GO
ALTER TABLE [dbo].[Slide]  WITH CHECK ADD  CONSTRAINT [FK__Slide__AccID__6E01572D] FOREIGN KEY([AccID])
REFERENCES [dbo].[Account] ([AccID])
GO
ALTER TABLE [dbo].[Slide] CHECK CONSTRAINT [FK__Slide__AccID__6E01572D]
GO
