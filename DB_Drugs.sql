USE [master]
GO
/****** Object:  Database [MedicineReceipt]    Script Date: 3/26/2024 1:25:32 PM ******/
CREATE DATABASE [MedicineReceipt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MedicineReceipt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MedicineReceipt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MedicineReceipt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MedicineReceipt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MedicineReceipt] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MedicineReceipt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MedicineReceipt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MedicineReceipt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MedicineReceipt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MedicineReceipt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MedicineReceipt] SET ARITHABORT OFF 
GO
ALTER DATABASE [MedicineReceipt] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MedicineReceipt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MedicineReceipt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MedicineReceipt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MedicineReceipt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MedicineReceipt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MedicineReceipt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MedicineReceipt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MedicineReceipt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MedicineReceipt] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MedicineReceipt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MedicineReceipt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MedicineReceipt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MedicineReceipt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MedicineReceipt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MedicineReceipt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MedicineReceipt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MedicineReceipt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MedicineReceipt] SET  MULTI_USER 
GO
ALTER DATABASE [MedicineReceipt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MedicineReceipt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MedicineReceipt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MedicineReceipt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MedicineReceipt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MedicineReceipt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MedicineReceipt] SET QUERY_STORE = OFF
GO
USE [MedicineReceipt]
GO
/****** Object:  Table [dbo].[Drug]    Script Date: 3/26/2024 1:25:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drug](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
	[quantity] [int] NULL,
	[price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (3, N'Tebexerol ', 25, CAST(150000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (4, N'Medrol ', 30, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (5, N'Arcoxia', 30, CAST(300000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (9, N'CELERZIN', 10, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (10, N'Amoxycilin', 100, CAST(1000000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (11, N'Zinnat', 50, CAST(360000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (12, N'Rivaroxaban', 70, CAST(150000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (13, N'Tablet', 80, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (15, N'Pregabalin (SUNPREGABA 75)', 34, CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (16, N'Valsartan (Diovan 80)', 53, CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (17, N'Clopidogrel (G5 Duratrix)', 324, CAST(30000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (18, N'Metformin (Metsav 850)', 34, CAST(60000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (19, N'Saferon', 12, CAST(4620.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (20, N'Gyfor 100ml', 64, CAST(40232.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (21, N'Clogin elle', 53, CAST(31656.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (22, N'Medrol 16mg', 63, CAST(4040.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (23, N'Suprazole 40mg', 42, CAST(6420.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (24, N'Opecalcium ', 15, CAST(11770.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (26, N'Devodil ', 34, CAST(2860.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (27, N'Smartbibi', 67, CAST(251450.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (29, N'Redbama ', 40, CAST(10112.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (30, N'DICSEP 500mg ', 54, CAST(5885.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (31, N'Bestimac Q10', 345, CAST(4920.00 AS Decimal(10, 2)))
GO
USE [master]
GO
ALTER DATABASE [MedicineReceipt] SET  READ_WRITE 
GO
