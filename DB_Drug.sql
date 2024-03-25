USE [master]
GO
/****** Object:  Database [MedicineReceipt]    Script Date: 25/03/2024 17:48:57 ******/
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
/****** Object:  Table [dbo].[Drug]    Script Date: 25/03/2024 17:48:57 ******/
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
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (1, N'YESOM ', 15, CAST(79000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (2, N'Saferon ', 20, CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (3, N'Tebexerol ', 25, CAST(150000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (4, N'Medrol ', 30, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (5, N'Arcoxia', 30, CAST(300000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (6, N'Baciamin Plus', 35, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (7, N'Bestimac', 27, CAST(350000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (8, N'DICSEP', 50, CAST(250000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (9, N'CELERZIN', 10, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (10, N'Amoxycilin', 100, CAST(1000000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (11, N'Zinnat', 50, CAST(360000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (12, N'Rivaroxaban', 70, CAST(150000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (13, N'Tablet', 80, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[Drug] ([id], [name], [quantity], [price]) VALUES (14, N'Gliclazid', 90, CAST(500000.00 AS Decimal(10, 2)))
GO
USE [master]
GO
ALTER DATABASE [MedicineReceipt] SET  READ_WRITE 
GO
