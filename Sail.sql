USE [master]
GO
/****** Object:  Database [Sail]    Script Date: 11/21/2017 8:40:12 AM ******/
CREATE DATABASE [Sail]
GO
ALTER DATABASE [Sail] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sail].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sail] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sail] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sail] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sail] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sail] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sail] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Sail] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sail] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sail] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sail] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sail] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sail] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sail] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sail] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sail] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sail] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sail] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sail] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sail] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sail] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sail] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sail] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sail] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sail] SET  MULTI_USER 
GO
ALTER DATABASE [Sail] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sail] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sail] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sail] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Sail] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Sail]
GO
/****** Object:  Table [dbo].[annualFeeStructure]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[annualFeeStructure](
	[year] [int] NOT NULL,
	[annualFee] [float] NULL,
	[earlyDiscountedFee] [float] NULL,
	[earlyDiscountEndDate] [date] NULL,
	[renewDeadlineDate] [date] NULL,
	[taskExemptionFee] [float] NULL,
	[secondBoatFee] [float] NULL,
	[thirdBoatFee] [float] NULL,
	[forthAndSubsequentBoatFee] [float] NULL,
	[nonSailFee] [float] NULL,
	[newMember25DiscountDate] [date] NULL,
	[newMember50DiscountDate] [date] NULL,
	[newMember75DiscountDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[boat]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boat](
	[boatId] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [int] NULL,
	[boatClass] [varchar](50) NULL,
	[hullColour] [varchar](50) NULL,
	[sailNumber] [varchar](50) NULL,
	[hullLength] [float] NULL,
	[boatTypeId] [int] NULL,
	[parkingCode] [varchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[boatType]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boatType](
	[boatTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](255) NULL,
	[chargeable] [bit] NOT NULL,
	[sail] [bit] NOT NULL,
	[image] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[country]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[countryCode] [char](2) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[postalPattern] [varchar](255) NULL,
	[phonePattern] [varchar](50) NULL,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED 
(
	[countryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[memberId] [int] NOT NULL,
	[fullName] [varchar](255) NULL,
	[firstName] [varchar](255) NOT NULL,
	[lastName] [varchar](255) NOT NULL,
	[spouseFirstName] [varchar](255) NULL,
	[spouseLastName] [varchar](255) NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[provinceCode] [char](2) NULL,
	[postalCode] [char](7) NULL,
	[homePhone] [char](12) NULL,
	[email] [varchar](255) NULL,
	[yearJoined] [int] NULL,
	[comment] [varchar](max) NULL,
	[taskExempt] [bit] NOT NULL,
	[useCanadaPost] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[membership]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[membership](
	[membershipId] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [int] NOT NULL,
	[year] [int] NOT NULL,
	[membershipTypeName] [varchar](255) NOT NULL,
	[fee] [real] NOT NULL,
	[comments] [varchar](max) NULL,
	[paid] [bit] NOT NULL,
 CONSTRAINT [PK_membership_1] PRIMARY KEY CLUSTERED 
(
	[membershipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[membershipType]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[membershipType](
	[membershipTypeName] [varchar](255) NOT NULL,
	[description] [varchar](max) NULL,
	[ratioToFull] [float] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberTask]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberTask](
	[memberTaskId] [int] IDENTITY(1,1) NOT NULL,
	[wednesdayDate] [datetime] NULL,
	[taskId] [int] NULL,
	[memberId] [int] NULL,
	[comment] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[parking]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parking](
	[parkingCode] [varchar](255) NOT NULL,
	[boatTypeId] [int] NULL,
	[actualBoatId] [varchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[province]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[province](
	[provinceCode] [char](2) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[countryCode] [char](2) NOT NULL,
	[taxCode] [varchar](50) NULL,
	[taxRate] [float] NOT NULL,
	[capital] [varchar](50) NULL,
 CONSTRAINT [PK_province] PRIMARY KEY CLUSTERED 
(
	[provinceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[surcharge]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[surcharge](
	[surchargeId] [int] IDENTITY(1,1) NOT NULL,
	[startYear] [int] NULL,
	[endYear] [int] NULL,
	[amount] [float] NULL,
	[name] [varchar](255) NULL,
	[description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tasks]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tasks](
	[taskId] [int] NOT NULL,
	[name] [varchar](255) NULL,
	[description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[town]    Script Date: 11/21/2017 8:40:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[town](
	[townName] [varchar](50) NOT NULL,
	[provinceCode] [char](2) NULL,
 CONSTRAINT [PK_town] PRIMARY KEY CLUSTERED 
(
	[townName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[annualFeeStructure] ([year], [annualFee], [earlyDiscountedFee], [earlyDiscountEndDate], [renewDeadlineDate], [taskExemptionFee], [secondBoatFee], [thirdBoatFee], [forthAndSubsequentBoatFee], [nonSailFee], [newMember25DiscountDate], [newMember50DiscountDate], [newMember75DiscountDate]) VALUES (2014, 230, 210, CAST(N'2014-04-30' AS Date), CAST(N'2014-05-31' AS Date), 100, 50, 75, 100, 0, CAST(N'2014-06-30' AS Date), CAST(N'2011-07-31' AS Date), CAST(N'2011-08-31' AS Date))
INSERT [dbo].[annualFeeStructure] ([year], [annualFee], [earlyDiscountedFee], [earlyDiscountEndDate], [renewDeadlineDate], [taskExemptionFee], [secondBoatFee], [thirdBoatFee], [forthAndSubsequentBoatFee], [nonSailFee], [newMember25DiscountDate], [newMember50DiscountDate], [newMember75DiscountDate]) VALUES (2015, 240, 230, CAST(N'2015-04-30' AS Date), CAST(N'2013-05-31' AS Date), 100, 50, 75, 100, 0, CAST(N'2015-06-30' AS Date), CAST(N'2012-07-31' AS Date), CAST(N'2012-08-31' AS Date))
INSERT [dbo].[annualFeeStructure] ([year], [annualFee], [earlyDiscountedFee], [earlyDiscountEndDate], [renewDeadlineDate], [taskExemptionFee], [secondBoatFee], [thirdBoatFee], [forthAndSubsequentBoatFee], [nonSailFee], [newMember25DiscountDate], [newMember50DiscountDate], [newMember75DiscountDate]) VALUES (2016, 240, 220, CAST(N'2016-04-30' AS Date), CAST(N'2014-05-31' AS Date), 100, 50, 50, 50, 0, CAST(N'2016-06-30' AS Date), CAST(N'2013-07-30' AS Date), CAST(N'2013-08-31' AS Date))
INSERT [dbo].[annualFeeStructure] ([year], [annualFee], [earlyDiscountedFee], [earlyDiscountEndDate], [renewDeadlineDate], [taskExemptionFee], [secondBoatFee], [thirdBoatFee], [forthAndSubsequentBoatFee], [nonSailFee], [newMember25DiscountDate], [newMember50DiscountDate], [newMember75DiscountDate]) VALUES (2017, 250, 230, CAST(N'2017-04-30' AS Date), CAST(N'2015-05-31' AS Date), 100, 50, 50, 50, 0, CAST(N'2017-06-30' AS Date), CAST(N'2014-07-30' AS Date), CAST(N'2014-08-31' AS Date))
INSERT [dbo].[annualFeeStructure] ([year], [annualFee], [earlyDiscountedFee], [earlyDiscountEndDate], [renewDeadlineDate], [taskExemptionFee], [secondBoatFee], [thirdBoatFee], [forthAndSubsequentBoatFee], [nonSailFee], [newMember25DiscountDate], [newMember50DiscountDate], [newMember75DiscountDate]) VALUES (2018, 255, 235, CAST(N'2018-04-30' AS Date), CAST(N'2016-05-31' AS Date), 100, 50, 50, 50, 0, CAST(N'2018-06-30' AS Date), CAST(N'2015-07-30' AS Date), CAST(N'2015-08-31' AS Date))
SET IDENTITY_INSERT [dbo].[boat] ON 

INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (1, 2, N'Hobie Tiger', N'White', N'65', 16, 6, N'D10')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (2, 2, N'Albacore', N'white', N'A310', 16, 3, N'C44')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (3, 3, N'Laser II', N'Blue', N'', 16, 3, N'C20')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (4, 6, N'Catamaran', N'Wooden, Blue', N'2456', 12, 6, N'')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (5, 6, N'Skiff', N'Yellow', N'', 10, 1, N'')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (6, NULL, N'Byte', N'Cream', N'65456', 11, NULL, N'A15')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (7, 12, N'Laser', N'White', N'', 13.5, 1, N'A09')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (8, 16, N'CL16', N'Cream', N'54', 16, 3, N'C01')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (9, 16, N'Sunfish', N'white', N'54', 13.5, 1, N'A22')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (10, 18, N'Dart', N'White', N'776', 18, 6, N'D14')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (11, 19, N'Canoe', N'Green', N'', 16, 7, N'')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (12, 20, N'Hobie14', N'White', N'789', 14, 6, N'D06')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (13, 20, N'Hobie Tiger', N'White', N'6788', 18, 6, N'D22')
INSERT [dbo].[boat] ([boatId], [memberId], [boatClass], [hullColour], [sailNumber], [hullLength], [boatTypeId], [parkingCode]) VALUES (16, 20, N'mmmm', N'ww', N'33', 44, 8, N'A24')
SET IDENTITY_INSERT [dbo].[boat] OFF
SET IDENTITY_INSERT [dbo].[boatType] ON 

INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (1, N'small', N'small single-crew, stored mast down: Laser, Sunfsh, Byte, etc.', 1, 1, N'sunfish.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (2, N'under-14', N'boats under 14, stored mast up: Mirror, etc.', 1, 1, N'mirror.png')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (3, N'14-17 dinghy', N'mid-sized single-hull dinghies, 14-17'', no keel: Wayfarer, CL, Fireball, Laser II, etc.', 1, 1, N'CL16.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (4, N'over 17 dinghy', N'larger single-hull dinghies, over 17'', no keel: Y-Flier, Buccaneer', 1, 1, N'yflier.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (5, N'cruiser', N'any length single-hull boat with a weighted keel: Siren, Sirius, etc.', 1, 1, N'siren.png')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (6, N'catamaran', N'dual- and tri-hull boats, any length: Venture, Hobie, Dart, etc.', 1, 1, N'hobie.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (7, N'canoe/kayak', N'paddle-powered canoes and kayaks, no sail, stored in canoe shed or behind clubhouse', 0, 0, N'kayak.png')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (8, N'paddle boat', N'foot-powered paddleboats, stored with sailbat or behind clubhouse: Pelican, etc.', 0, 0, N'paddleboat.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (9, N'wind surf', N'sail-powered stand-up wind surfer, stored with sailboat or behind clubhouse', 0, 1, N'windsurfer.jpg')
INSERT [dbo].[boatType] ([boatTypeId], [name], [description], [chargeable], [sail], [image]) VALUES (10, N'inactive boat', N'inactive boats and boats of non-renewed members', 1, 1, N'abandonedBoat.jpg')
SET IDENTITY_INSERT [dbo].[boatType] OFF
INSERT [dbo].[country] ([countryCode], [name], [postalPattern], [phonePattern]) VALUES (N'CA', N'Canada', N'[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ] ?\d[ABCEGHJKLMNPRSTVWXYZ]\d', N'\d{3}-\d{3}-\d{4}')
INSERT [dbo].[country] ([countryCode], [name], [postalPattern], [phonePattern]) VALUES (N'FR', N'France', N'\d{5}', N'(0 ?\d{3} (\d{2} \d{4}|\d{3} \d{3})')
INSERT [dbo].[country] ([countryCode], [name], [postalPattern], [phonePattern]) VALUES (N'JA', N'Japan', N'\d{3}(-(\d{4}|\d{2}))?', N'(0\d{1,4}-|\(0\d{1,4}\) ?)\d{1,4}-\d{4}')
INSERT [dbo].[country] ([countryCode], [name], [postalPattern], [phonePattern]) VALUES (N'US', N'United States of America', N'\d{5}(-\d{4})?', N'\(d{3}\) \d{3}-|d{4}')
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (2, N'Chesterfield, Stanley & Mabel', N'Stanley', N'Chesterfield', N'Mabel', NULL, N'89 Trenton Ct', N'Ariss', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (3, N'Desoto, Eric', N'Eric', N'Desoto', NULL, NULL, N'123 Main', N'Kitchener', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (4, N'Concarne, Keith', N'Keith', N'Concarne', NULL, NULL, N'75 Northwood', N'Miller Lake', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, N'exempt (life)', 0, 1)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (6, N'Gunther, Adrian', N'Adrian', N'Gunther', NULL, NULL, N'2 Maryhill', N'Guelph', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, N'exempt (age)', 1, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (11, N'Tannoy, Ursulas', N'Ursulas', N'Tannoy', NULL, NULL, N'844 Tennyson', N'Guelph', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (12, N'Maple, John', N'John', N'Maple', NULL, NULL, N'324 Bordon', N'Kitchener', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 1)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (16, N'Oak, Paul', N'Paul', N'Oak', NULL, NULL, N'4343 Park', N'Fergus', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, N'exempt (life)', 1, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (18, N'Hogs, Les', N'Les', N'Hogs', NULL, NULL, N'32 Tennyson', N'Fergus', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 0)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (19, N'Rivers, Dresden & Joan', N'Dresden', N'Rivers', N'Joan', NULL, N'56BlueGate', N'Guelph', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, N'exempt (life)', 1, 1)
INSERT [dbo].[member] ([memberId], [fullName], [firstName], [lastName], [spouseFirstName], [spouseLastName], [street], [city], [provinceCode], [postalCode], [homePhone], [email], [yearJoined], [comment], [taskExempt], [useCanadaPost]) VALUES (20, N'Trenton, Doug & Jean', N'Doug', N'Trenton', N'Jean', NULL, N'65Westmount', N'Guelph', N'ON', N'N2G 4M4', N'519-748-5220', N'dturton@conestogac.on.ca', 1974, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[membership] ON 

INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (1, 2, 2007, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (2, 2, 2009, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (3, 2, 2010, N'Full', 200, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (4, 2, 2011, N'Full', 200, NULL, 0)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (5, 3, 2007, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (6, 3, 2009, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (7, 3, 2010, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (8, 3, 2011, N'Full', 300, N'', 0)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (9, 4, 2007, N'Full', 270, N'Executive', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (10, 4, 2009, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (11, 4, 2010, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (12, 4, 2011, N'Life', 0, N'500 donation', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (13, 6, 2007, N'Associate', 150, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (14, 6, 2009, N'Associate', 150, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (15, 6, 2010, N'Associate', 150, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (16, 6, 2011, N'Associate', 150, N'will not be renewing 2011 due to health problems, incl not driving', 0)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (17, 11, 2007, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (18, 11, 2009, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (19, 11, 2010, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (20, 11, 2011, N'Full', 270, N'210 full early; making donation: exempt levy', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (21, 12, 2007, N'Full', 303, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (22, 12, 2009, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (23, 12, 2010, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (24, 12, 2011, N'Full', 280, N'280 full early', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (25, 16, 2007, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (26, 16, 2009, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (27, 16, 2010, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (28, 16, 2011, N'Life', 0, N'70 life donation', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (29, 18, 2007, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (30, 18, 2009, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (31, 18, 2010, N'Full', 300, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (32, 18, 2011, N'Full', 300, N'280 full early', 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (33, 19, 2007, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (34, 19, 2009, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (35, 19, 2010, N'Life', 0, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (36, 19, 2011, N'Life', 0, N'life, donate $70', 0)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (37, 20, 2007, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (38, 20, 2009, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (39, 20, 2010, N'Full', 270, NULL, 1)
INSERT [dbo].[membership] ([membershipId], [memberId], [year], [membershipTypeName], [fee], [comments], [paid]) VALUES (40, 20, 2011, N'Full', 270, N'exec; 260 full early 2nd + pledge', 1)
SET IDENTITY_INSERT [dbo].[membership] OFF
INSERT [dbo].[membershipType] ([membershipTypeName], [description], [ratioToFull]) VALUES (N'Associate', N'member without a sailboat (not occupying a parking spot)', 0.5)
INSERT [dbo].[membershipType] ([membershipTypeName], [description], [ratioToFull]) VALUES (N'Full', N'member with a sailboat: occupying a parking spot', 1)
INSERT [dbo].[membershipType] ([membershipTypeName], [description], [ratioToFull]) VALUES (N'Junior', N'member under 17, with a sailboat occupying a arking spot', 0.5)
INSERT [dbo].[membershipType] ([membershipTypeName], [description], [ratioToFull]) VALUES (N'Life', N'life member as voted by membership: no charges, can have sailboats occupying parking spots', 0)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A01', 1, N'27')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A02', 1, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A03', 1, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A04', 1, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A05', 1, N'269')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A06', 1, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A07', 1, N'290')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A08', 1, N'287')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A09', 1, N'12')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A10', 1, N'216')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A11', 1, N'269')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A12', 1, N'242')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A13', 1, N'')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A14', 1, N'2')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A15', 1, N'11')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A16', 1, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A17', 1, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A18', 1, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A19', 1, N'218')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A20', 1, N'24')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A21', 1, N'290')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A22', 1, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A23', 1, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'A24', 1, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B01', 2, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B02', 2, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B03', 2, N'395')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B04', 2, N'407')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B05', 2, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'B06', 2, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C01', 3, N'16')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C02', 3, N'323')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C03', 3, N'346')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C04', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C05', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C06', 3, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C07', 3, N'386')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C08', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C09', 3, N'86')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C10', 3, N'34')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C11', 3, N'54')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C12', 3, N'337')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C13', 3, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C14', 3, N'52')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C15', 3, N'331')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C16', 3, N'212')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C17', 3, N'295')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C18', 3, N'342')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C19', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C20', 3, N'wrap')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C21', 3, N'wrap')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C22', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C23', 3, N'wrap')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C24', 3, N'130')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C25', 3, N'56')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C26', 3, N'397')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C27', 3, N'416')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C28', 3, N'330')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C29', 3, N'366')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C30', 3, N'367')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C31', 3, N'153')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C32', 3, N'269')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C33', 3, N'363')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C34', 3, N'375')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C35', 3, N'309')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C36', 3, N'424')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C37', 3, N'373')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C38', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C39', 3, N'65')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C40', 3, N'200')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C41', 3, N'403')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C42', 3, N'229')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C43', 3, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C44', 3, N'409')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C45', 3, N'96')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C46', 3, N'406')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C47', 3, N'wrap')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C50', 3, N'341')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C51', 3, N'408')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'C52', 3, N'347')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D01', 6, N'109')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D02', 6, N'285')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D03', 6, N'33')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D04', 6, N'334')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D05', 6, N'315')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D06', 6, N'20')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D07', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D08', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D09', 6, N'20')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D10', 6, N'275')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D11', 6, N'250')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D12', 6, N'2')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D13', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D14', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D15', 6, N'249')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D16', 6, N'400')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D17', 6, N'297')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D18', 6, N'396')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D19', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D20', 6, N'387')
GO
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D21', 6, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D22', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D23', 6, N'401')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D24', 6, N'24')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D25', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D26', 6, N'?big')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D27', 6, N'96')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D28', 6, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D29', 6, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'D30', 6, N'385')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E03', 5, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E04', 5, N'390')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E05', 5, N'18')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E06', 5, N'121')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E07', 5, N'168')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E08', 5, N'409')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E09', 5, N'378')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E10', 5, N'242')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E11', 5, N'?')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E12', 5, N'372')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E13', 5, N'353')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E14', 5, N'398')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E15', 5, N'419')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E16', 5, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E17', 5, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'E18', 5, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F01', 4, N'216')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F02', 4, N'409')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F03', 4, N'287')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F04', 4, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F05', 4, N'249')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F06', 4, N'sirus temp Bill')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F07', 4, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F08', 4, N'wrap')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'F09', 4, N'371')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G01', 10, N'128')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G02', 10, N'359')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G03', 10, N'321')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G04', 10, N'329')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G05', 10, N'Sirius')
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'G06', 10, NULL)
INSERT [dbo].[parking] ([parkingCode], [boatTypeId], [actualBoatId]) VALUES (N'', 10, N'')
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'AB', N'Alberta', N'CA', N'GST', 0.05, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'BC', N'British Columbia', N'CA', N'GST+PST', 0.12, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'CA', N'California', N'US', N'retail', 0.1, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'MB', N'Manitoba', N'CA', N'GST+PST', 0.13, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'MI', N'Michigan', N'US', N'retail', 0.06, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NB', N'New Brunswick', N'CA', N'HST', 0.13, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NL', N'Newfoundland and Labrador', N'CA', N'HST', 0.13, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NS', N'Nova Scotia', N'CA', N'HST', 0.15, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NT', N'Northwest Territories', N'CA', N'GST', 0.05, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NU', N'Nunavut', N'CA', N'GST', 0.05, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'NY', N'New York', N'US', N'retail', 0.08875, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'ON', N'Ontario', N'CA', N'HST', 0.13, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'PE', N'Price Edward Island', N'CA', N'HST', 0.14, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'QC', N'Quebec', N'CA', N'GST+QST', 0.14975, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'SK', N'Saskatchewan', N'CA', N'GST+PST', 0.1, NULL)
INSERT [dbo].[province] ([provinceCode], [name], [countryCode], [taxCode], [taxRate], [capital]) VALUES (N'YT', N'Yukon Territory', N'CA', N'GST', 0.05, NULL)
SET IDENTITY_INSERT [dbo].[surcharge] ON 

INSERT [dbo].[surcharge] ([surchargeId], [startYear], [endYear], [amount], [name], [description]) VALUES (1, 2011, 2014, 70, N'Clubhouse Renovations', N'renovating the interior, exterior, foundations, roof, wiring and plumbing of the clubhouse')
SET IDENTITY_INSERT [dbo].[surcharge] OFF
INSERT [dbo].[tasks] ([taskId], [name], [description]) VALUES (1, N'Washrooms and Kitchen', N'Clean kitchen, including fridge, stove, counter. Clean games area. Clean both washrooms including toilets and sink')
INSERT [dbo].[tasks] ([taskId], [name], [description]) VALUES (2, N'Grass: Non-Lakeside', N'Cut grass from the club gate to the clubhouse, behind the clubhouse and the canoe shed and back to the clubhouse. Weed whack around trees, posts etc.')
INSERT [dbo].[tasks] ([taskId], [name], [description]) VALUES (3, N'Sweep Buildings', N'Sweep and wash clubhouse floors including washrooms Tidy and sweep both garages, canoe shed and locker\storage room at the back of clubhouse.')
INSERT [dbo].[tasks] ([taskId], [name], [description]) VALUES (4, N'Grass: Lakeside', N'Cut grass from the lake side of clubhouse, in front of clubhouse along the lake to the club property line by the front gate. Weed whack around trees, posts etc.')
INSERT [dbo].[tasks] ([taskId], [name], [description]) VALUES (5, N'Towels and Garbage', N'Site garbage pickup, tidy supply room, replace the used towel in the kitchen and washroom, wash towels at home. Fill soap and toilet rolls, clean bird droppings off of picnic tables. Take home any garbage.')
/****** Object:  Index [aaaaaannualFeeStructure_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[annualFeeStructure] ADD  CONSTRAINT [aaaaaannualFeeStructure_PK] PRIMARY KEY NONCLUSTERED 
(
	[year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaboat_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [aaaaaboat_PK] PRIMARY KEY NONCLUSTERED 
(
	[boatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaboatType_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[boatType] ADD  CONSTRAINT [aaaaaboatType_PK] PRIMARY KEY NONCLUSTERED 
(
	[boatTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaamember_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [aaaaamember_PK] PRIMARY KEY NONCLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aaaaamembershipType_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[membershipType] ADD  CONSTRAINT [aaaaamembershipType_PK] PRIMARY KEY NONCLUSTERED 
(
	[membershipTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaamemberTask_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[memberTask] ADD  CONSTRAINT [aaaaamemberTask_PK] PRIMARY KEY NONCLUSTERED 
(
	[memberTaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aaaaaparking_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[parking] ADD  CONSTRAINT [aaaaaparking_PK] PRIMARY KEY NONCLUSTERED 
(
	[parkingCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaasurcharge_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[surcharge] ADD  CONSTRAINT [aaaaasurcharge_PK] PRIMARY KEY NONCLUSTERED 
(
	[surchargeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaatasks_PK]    Script Date: 11/21/2017 8:40:13 AM ******/
ALTER TABLE [dbo].[tasks] ADD  CONSTRAINT [aaaaatasks_PK] PRIMARY KEY NONCLUSTERED 
(
	[taskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[province] ADD  CONSTRAINT [DF_province_taxRate]  DEFAULT ((0)) FOR [taxRate]
GO
ALTER TABLE [dbo].[boat]  WITH CHECK ADD  CONSTRAINT [FK_boat_boatType] FOREIGN KEY([boatTypeId])
REFERENCES [dbo].[boatType] ([boatTypeId])
GO
ALTER TABLE [dbo].[boat] CHECK CONSTRAINT [FK_boat_boatType]
GO
ALTER TABLE [dbo].[boat]  WITH CHECK ADD  CONSTRAINT [FK_boat_member] FOREIGN KEY([memberId])
REFERENCES [dbo].[member] ([memberId])
GO
ALTER TABLE [dbo].[boat] CHECK CONSTRAINT [FK_boat_member]
GO
ALTER TABLE [dbo].[boat]  WITH CHECK ADD  CONSTRAINT [FK_boat_parking] FOREIGN KEY([parkingCode])
REFERENCES [dbo].[parking] ([parkingCode])
GO
ALTER TABLE [dbo].[boat] CHECK CONSTRAINT [FK_boat_parking]
GO
ALTER TABLE [dbo].[member]  WITH CHECK ADD  CONSTRAINT [FK_member_province] FOREIGN KEY([provinceCode])
REFERENCES [dbo].[province] ([provinceCode])
GO
ALTER TABLE [dbo].[member] CHECK CONSTRAINT [FK_member_province]
GO
ALTER TABLE [dbo].[membership]  WITH CHECK ADD  CONSTRAINT [FK_membership_member] FOREIGN KEY([memberId])
REFERENCES [dbo].[member] ([memberId])
GO
ALTER TABLE [dbo].[membership] CHECK CONSTRAINT [FK_membership_member]
GO
ALTER TABLE [dbo].[membership]  WITH CHECK ADD  CONSTRAINT [FK_membership_membershipType] FOREIGN KEY([membershipTypeName])
REFERENCES [dbo].[membershipType] ([membershipTypeName])
GO
ALTER TABLE [dbo].[membership] CHECK CONSTRAINT [FK_membership_membershipType]
GO
ALTER TABLE [dbo].[memberTask]  WITH CHECK ADD  CONSTRAINT [FK_memberTask_member] FOREIGN KEY([memberId])
REFERENCES [dbo].[member] ([memberId])
GO
ALTER TABLE [dbo].[memberTask] CHECK CONSTRAINT [FK_memberTask_member]
GO
ALTER TABLE [dbo].[memberTask]  WITH CHECK ADD  CONSTRAINT [FK_memberTask_tasks] FOREIGN KEY([taskId])
REFERENCES [dbo].[tasks] ([taskId])
GO
ALTER TABLE [dbo].[memberTask] CHECK CONSTRAINT [FK_memberTask_tasks]
GO
ALTER TABLE [dbo].[parking]  WITH CHECK ADD  CONSTRAINT [FK_parking_boatType] FOREIGN KEY([boatTypeId])
REFERENCES [dbo].[boatType] ([boatTypeId])
GO
ALTER TABLE [dbo].[parking] CHECK CONSTRAINT [FK_parking_boatType]
GO
ALTER TABLE [dbo].[province]  WITH CHECK ADD  CONSTRAINT [FK_province_country] FOREIGN KEY([countryCode])
REFERENCES [dbo].[country] ([countryCode])
GO
ALTER TABLE [dbo].[province] CHECK CONSTRAINT [FK_province_country]
GO
ALTER TABLE [dbo].[town]  WITH CHECK ADD  CONSTRAINT [FK_town_province] FOREIGN KEY([provinceCode])
REFERENCES [dbo].[province] ([provinceCode])
GO
ALTER TABLE [dbo].[town] CHECK CONSTRAINT [FK_town_province]
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'year' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'year' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1284' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'base annual fee (full members)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'annualFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'annualFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'annualFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2112' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'?/??????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'base annual fee if paid on or before early discount date (full members)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'earlyDiscountedFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'earlyDiscountedFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountedFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2328' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'early discount ends after this date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'earlyDiscountEndDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'earlyDiscountEndDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'earlyDiscountEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2124' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date to renew membership ... afterwards, boat can be moved' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'renewDeadlineDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'renewDeadlineDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'renewDeadlineDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1992' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fee to be exempt from maintenance tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'taskExemptionFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'taskExemptionFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'taskExemptionFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1740' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fee for 2nd sail boat (in addition to other fees)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'secondBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'secondBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'secondBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fee for 3rd sail boat (in addition to 2nd)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'thirdBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'thirdBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'thirdBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2904' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fee for 4th & subsequent boats (usually not permitted)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'forthAndSubsequentBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'forthAndSubsequentBoatFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'forthAndSubsequentBoatFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1332' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fee for canoes & kayaks (don''t take parking spots)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'nonSailFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'nonSailFee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'nonSailFee'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2904' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date after which a new member gets a 25% discount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'newMember25DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'newMember25DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember25DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2904' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date after which a new member gets a 50% discount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'newMember50DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'newMember50DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember50DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2904' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date after which a new member gets a 75% discount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'newMember75DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'newMember75DiscountDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure', @level2type=N'COLUMN',@level2name=N'newMember75DiscountDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 12:33:25 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/22/2011 5:09:34 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'annualFeeStructure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'annualFeeStructure'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sequentially assigned key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'boatId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'member that owns this boat: should appear on transom' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'make and class designation: Hobie Tiger' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatClass' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'boatClass' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatClass'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'hull colour, can mention deck colour as well' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'hullColour' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'hullColour' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullColour'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'letters and numbers on sail, if any ... for race identification' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'sailNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'sailNumber' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'sailNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'length of hull in feet' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'hullLength' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'hullLength' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'hullLength'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'link to boatType table ... under-14 dighy, cat, canoe, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'parking space for this boat (member), empty string if nothing assigned' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'parkingCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'parkingCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 10:38:43 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/7/2011 7:13:08 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boat' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'167' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boat'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sequential key so can change the type name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2004' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'general type ... single-crew, under 14, 14-17 dingy, cruiser, catamaran, canoe, kayak, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'4656' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'decription of boat type... less than 14'', mast down, single-person, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'some boats (canoe, kayak, paddleboat) aren''t charged as 2nd/3rd boats' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'106' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'chargeable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'chargeable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'chargeable'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'yes, if it''s a sailboat ... to exclude those that aren''t' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'106' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'sail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'sail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType', @level2type=N'COLUMN',@level2name=N'sail'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 10:31:43 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/28/2011 12:25:52 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'boatType'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'member ID ... initially manual, autonumber later' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'generated lastname, firstname <& spouseFirstName <spouseLastName>> for convenience' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'fullName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'fullName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1104' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'first name of primary contact person' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'firstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'firstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'last name of primary contact person' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'lastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'lastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'912' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'first name of spouse or partner' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'spouseFirstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'spouseFirstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseFirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'last name of spouse or partner ... blank if the same' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'spouseLastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'spouseLastName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'spouseLastName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'number & street address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'street' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'street' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'street'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'city they live in' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'city' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'city' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'"ON"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'2-digit province code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=N'>LL' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'provinceCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'provinceCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'provinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'postal code, with a space for printing & mailing convenience' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=N'>L0L\ 0L0;0;_' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'postalCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'postalCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'postalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'??''?????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'phone number with area code, "-" punctuation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=N'!000\-000\-0000;0;_' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'homePhone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'homePhone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'homePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'e-mail address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'year they first joined' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'yearJoined' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'yearJoined' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yearJoined'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'comments regarding preferred task dates, tasks they can''t do, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'taskComment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'16' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'taskComment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'yes if member wishes to pay fee to be exempt from tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'106' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'Yes/No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'taskExempt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'taskExempt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'taskExempt'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'DefaultValue', @value=N'No' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'yes if prefers minutes, newsletters, etc. by post, rather than e-mail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'106' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'True/False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'useCanadaPost' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'18' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'useCanadaPost' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'useCanadaPost'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 11:12:21 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/7/2011 7:19:24 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'134' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowMultipleValues', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowValueListEdits', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1224' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_BoundColumn', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnCount', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHeads', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidths', @value=N'0;5670' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'member assuming thi m embership type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LimitToList', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ListRows', @value=N'16' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ListWidth', @value=N'0twip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowSource', @value=N'SELECT member.memberId, lastName + '', '' + firstName
FROM member
ORDER BY lastName + '', '' + firstName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowSourceType', @value=N'Table/View/StoredProc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowOnlyRowSourceValues', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membership' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'year membership paid for or has o/s issues about' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'year' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'year' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membership' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'year'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowMultipleValues', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowValueListEdits', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_BoundColumn', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnCount', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHeads', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'membership type (dertermines charges)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'111' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_LimitToList', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ListRows', @value=N'16' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ListWidth', @value=N'0twip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowSource', @value=N'membershipType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_RowSourceType', @value=N'Table/View/StoredProc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'membershipTypeName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowOnlyRowSourceValues', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'membershipTypeName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membership' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1512' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'need keys, parking, numbers, o/s fees, contact notes, etc.  everything here requires follow-up' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'outstandingIssues' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'outstandingIssues' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membership' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership', @level2type=N'COLUMN',@level2name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 12:29:22 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/7/2011 7:19:24 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'membership' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'407' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membership'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2412' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'things like "full", "associate", "junior", "life"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'membershipTypeName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'membershipTypeName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membershipType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'membershipTypeName'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'4464' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description of rights, restrictions: associate can''t park a boat; junior max age 18, 22 if in school' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membershipType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1236' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'percent of base annual fees this type of member pays, relative to a full member' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'feeFactor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'feeFactor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'membershipType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType', @level2type=N'COLUMN',@level2name=N'ratioToFull'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 12:20:10 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/24/2011 12:15:21 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'membershipType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'membershipType'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'unique key to allow easier updates to existing records' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberTaskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'memberTaskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberTaskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'2340' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date this task starts ... done any time from here to next Wednesday' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'ddd dd mmm yyyy' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'wednesdayDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'ShowDatePicker', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'wednesdayDate' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'wednesdayDate'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'task number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'taskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'taskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'member assigned ... may be a second task in same week for spouse' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'memberId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'memberId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'anything about this member/task assignment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'comment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'comment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask', @level2type=N'COLUMN',@level2name=N'comment'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 11:20:50 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'9/7/2011 7:12:38 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'memberTask' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'40' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'memberTask'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'parking lots are designated by letter and number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'parkingCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'parkingCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'parking' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'parkingCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'1848' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'link to boatType table: general type of boat for this spot: not hard-and-fast rule' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'boatTypeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'parking' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'boatTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this is the member number of the boat on site, "?" if not numbered (or rserved w/trailer), blank if nothing there when surveyed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'actualBoatId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'actualBoatId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'parking' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking', @level2type=N'COLUMN',@level2name=N'actualBoatId'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 11:12:37 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/28/2011 12:25:42 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'parking' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'141' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'parking'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'17' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'unique number of surcharge (levy)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'surchargeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'surchargeId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'surchargeId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'first year surcharge starts to be added to membership fees' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'startYear' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'startYear' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'startYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'last year surcharge is added to membership fees' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'endYear' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'endYear' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'endYear'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'amount of surcharge for full-time members' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'amount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'amount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the surcharge (club house renovation)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CurrencyLCID', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'????????' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description of what''s covered by surcharge, phases, completion criteria, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ResultType', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextFormat', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'AlternateBackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'BackShade', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'BackTint', @value=N'100' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetForeThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'DatasheetGridlinesThemeColorIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 11:55:27 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/24/2011 12:15:21 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'surcharge' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'PublishToWeb', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'ThemeFontIndex', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'surcharge'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'usually just 1-5, re-using numbers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'taskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'taskId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'taskId'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'short name of task' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description of what''s involved' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks', @level2type=N'COLUMN',@level2name=N'description'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'4/26/2011 11:18:06 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'5/24/2011 12:15:21 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'tasks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tasks'
GO
USE [master]
GO
ALTER DATABASE [Sail] SET  READ_WRITE 
GO
