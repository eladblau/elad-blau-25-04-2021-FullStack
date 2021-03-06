USE [Weather]
GO
/****** Object:  Table [dbo].[CurrentWeathers]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrentWeathers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](50) NULL,
	[LocalObservationDateTime] [datetimeoffset](7) NULL,
	[CelsiusValue] [decimal](18, 2) NULL,
	[WeatherText] [nvarchar](max) NULL,
	[lastModified] [datetimeoffset](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorites]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorites](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LocationKey] [nvarchar](50) NULL,
	[LocalizedName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteFavorite]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DeleteFavorite]

	@locationKey nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
		DELETE FROM [dbo].[Favorites]
		WHERE LocationKey = @locationKey
		
		

END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCurrentWeather]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetCurrentWeather]
	
	   @Key nvarchar(50)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
		SELECT * 
		FROM [dbo].[CurrentWeathers] c
		WHERE c.[Key] = @Key


		

END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetFavorites]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetFavorites]

	@locationKey nvarchar(50) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
		SELECT * 
		FROM [dbo].[Favorites] f
		WHERE (@locationKey IS NOT NULL AND f.LocationKey = @locationKey) OR @locationKey IS NULL
		
		

END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertCurrentWeather]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertCurrentWeather]
	
	   @Key nvarchar(50)
	  ,@LocalObservationDateTime datetimeoffset(7)
	  ,@CelsiusValue decimal(18,2)
	  ,@WeatherText nvarchar(max)
	  ,@lastModified datetimeoffset(7)




AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
	IF NOT EXISTS 
		(SELECT * 
		FROM [dbo].[CurrentWeathers] c
		WHERE c.[Key] = @Key)

	INSERT INTO [dbo].[CurrentWeathers]
           ([Key]
           ,[LocalObservationDateTime]
           ,[CelsiusValue]
           ,[WeatherText]
           ,[lastModified])
     VALUES
           (@Key
           ,@LocalObservationDateTime
           ,@CelsiusValue
           ,@WeatherText
           ,@lastModified)

		   
	ELSE 

		UPDATE [dbo].CurrentWeathers
		SET	  [LocalObservationDateTime] = @LocalObservationDateTime
			  ,[CelsiusValue] = @CelsiusValue
			  ,[WeatherText] = @WeatherText
			  ,[lastModified] = @lastModified
		 WHERE [Key] = @Key


		

END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertFavorite]    Script Date: 25/04/2021 00:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertFavorite]
	
	   @LocationKey nvarchar(50)
	  ,@LocalizedName nvarchar(max)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
	IF NOT EXISTS 
		(SELECT * 
		FROM [dbo].[Favorites] f
		WHERE f.[LocationKey] = @LocationKey)

	INSERT INTO [dbo].[Favorites]
           ([LocationKey]
           ,[LocalizedName])
     VALUES
           (@LocationKey
           ,@LocalizedName)
     
		   
	ELSE 

		SELECT * 
		FROM [dbo].[Favorites] f
		WHERE f.[LocationKey] = @LocationKey
		

END
GO
