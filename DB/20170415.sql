USE [master]
GO
/****** Object:  Database [vitinhth_foody]    Script Date: 15/04/2017 10:28:43 AM ******/
CREATE DATABASE [vitinhth_foody]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'vitinhth_foody', FILENAME = N'D:\Database2012\MSSQL11.SQL2012\MSSQL\DATA\vitinhth_foody.mdf' , SIZE = 7232KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'vitinhth_foody_log', FILENAME = N'D:\Database2012\MSSQL11.SQL2012\MSSQL\DATA\vitinhth_foody_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [vitinhth_foody] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [vitinhth_foody].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [vitinhth_foody] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [vitinhth_foody] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [vitinhth_foody] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [vitinhth_foody] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [vitinhth_foody] SET ARITHABORT OFF 
GO
ALTER DATABASE [vitinhth_foody] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [vitinhth_foody] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [vitinhth_foody] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [vitinhth_foody] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [vitinhth_foody] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [vitinhth_foody] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [vitinhth_foody] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [vitinhth_foody] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [vitinhth_foody] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [vitinhth_foody] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [vitinhth_foody] SET  ENABLE_BROKER 
GO
ALTER DATABASE [vitinhth_foody] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [vitinhth_foody] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [vitinhth_foody] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [vitinhth_foody] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [vitinhth_foody] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [vitinhth_foody] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [vitinhth_foody] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [vitinhth_foody] SET RECOVERY FULL 
GO
ALTER DATABASE [vitinhth_foody] SET  MULTI_USER 
GO
ALTER DATABASE [vitinhth_foody] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [vitinhth_foody] SET DB_CHAINING OFF 
GO
ALTER DATABASE [vitinhth_foody] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [vitinhth_foody] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'vitinhth_foody', N'ON'
GO
USE [vitinhth_foody]
GO
/****** Object:  User [Foody_u]    Script Date: 15/04/2017 10:28:43 AM ******/
CREATE USER [Foody_u] FOR LOGIN [Foody_u] WITH DEFAULT_SCHEMA=[Foody_u]
GO
/****** Object:  User [cycling_u]    Script Date: 15/04/2017 10:28:43 AM ******/
CREATE USER [cycling_u] FOR LOGIN [cycling_u] WITH DEFAULT_SCHEMA=[cycling_u]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Foody_u]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Foody_u]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Foody_u]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Foody_u]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [cycling_u]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [cycling_u]
GO
ALTER ROLE [db_datareader] ADD MEMBER [cycling_u]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [cycling_u]
GO
/****** Object:  Schema [cycling_u]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE SCHEMA [cycling_u]
GO
/****** Object:  Schema [epmdesigns_u]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE SCHEMA [epmdesigns_u]
GO
/****** Object:  Schema [Foody_u]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE SCHEMA [Foody_u]
GO
/****** Object:  Schema [StoreDesign_u]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE SCHEMA [StoreDesign_u]
GO
/****** Object:  StoredProcedure [dbo].[Banner_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  Congtt 
-- Create date: 2015/04/04    
-- Description: <Description,,>      
-- =============================================    
/*

	USE [Foody]
	GO

	DECLARE @return_value INT
	,@total INT

	EXEC @return_value = [dbo].[Banner_Get] @published = N'1'
	,@pageSize = 10
	,@pageIndex = 1
	,@total = @total OUTPUT

	SELECT @total AS N'@total'

	SELECT 'Return Value' = @return_value


*/
CREATE PROC [dbo].[Banner_Get] (
	@name NVARCHAR(500) = NULL
	,@published NCHAR(1) = NULL
	,@position INT = NULL
	,@pageName NVARCHAR(25) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'a.ordering DESC'
	,@total INT OUTPUT
	)
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,
					a.* FROM PNK_Banner a WHERE 1=1';

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX(@name2,a.Name)>0';
			--SET @select = @select + ' and a.Name like ''%' + '+@name2+' + '%''';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and a.Published = @published2 ';
	END

	/*@position*/
	IF (@position IS NOT NULL)
	BEGIN
		SET @select = @select + ' and a.Position = @position2';
	END

	/**@pageName**/
	IF (@pageName IS NOT NULL)
	BEGIN
		SET @select = @select + ' and (select COUNT(*) from dbo.fn_ParseText2Table(a.ArrPageName,'','') where txt_value = @pageName2 ) > 0 ';
	END

	-- paging
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT] AS ( ';

	-- paging 
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql

	SET @Paramlist = N'
						@name2  nvarchar(500),
						@published2 nchar(1),
						@position2 int,
						@pageName2 nvarchar(25)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@name2 = @name
		,@published2 = @published
		,@position2 = @position
		,@pageName2 = @pageName

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'
						@name2  nvarchar(50),
						@published2 nchar(1),
						@position2 int,
						@pageName2 nvarchar(25),
						@Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@name
		,@published
		,@position
		,@pageName
		,@Total2 OUT

	SET @total = @Total2;
END



















GO
/****** Object:  StoredProcedure [dbo].[Booking_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*

	DECLARE @return_value INT
	,@total INT

	EXEC @return_value = [dbo].[Booking_Get] @langId = 1
	,@fromDate='2017-03-20'
	,@toDate='2017-03-24'
	,@published =NULL
	,@pageSize = 1000
	,@pageIndex = 1
	,@total = @total OUTPUT

	SELECT @total AS N'@total'

	SELECT 'Return Value' = @return_value
	GO

*/
CREATE PROCEDURE [dbo].[Booking_Get] @langId INT = NULL
	,@name VARCHAR(255) = NULL
	,@fromDate DATETIME = NULL
	,@toDate DATETIME = NULL
	,@published NCHAR(1) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'PostDate DESC'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,
					l.*,ld.id as subId,ld.langid,ld.name
					 FROM PNK_Booking l INNER JOIN PNK_Bookingdesc ld on l.id = ld.mainid WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and ld.langid = @langId2';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and ld.Name like ''%' + '+@name2+' + '%''';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and l.Published = @published2 ';
	END

	/**@fromDate**/
	IF (@fromDate IS NOT NULL)
	BEGIN
		SET @select = @select + ' and PostDate between @fromDate2 and @toDate2 ';
			--SET @select = @select + ' and cast( PostDate as datetime) between ''' + cast(@fromDate AS DATETIME) + ''' and ''' + cast(@toDate AS DATETIME) + ''' ';
	END

	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT] AS ( ';

	-- paging 
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;
	SET @Paramlist = N'
						@langId2 INT,
						@name2 VARCHAR(255),
						@fromDate2 DATETIME, 
						@toDate2 DATETIME, 
						@published2 nchar(1)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@fromDate2 = @fromDate
		,@toDate2 = @toDate
		,@published2 = @published

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'
						@langId2 INT,
						@name2 VARCHAR(255),
						@fromDate2 DATETIME ,
						@toDate2 DATETIME ,
						@published2 nchar(1),
						@Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@fromDate
		,@toDate
		,@published
		,@Total2 OUTPUT

	SET @total = @Total2;

	PRINT @sql
END


GO
/****** Object:  StoredProcedure [dbo].[BookingPrice_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
	
	DECLARE @return_value INT
	,@total INT

	EXEC @return_value = [dbo].[BookingPrice_Get] @productId=6300, @total = @total OUTPUT

	SELECT @total AS N'@total'

	SELECT 'Return Value' = @return_value
*/
CREATE PROCEDURE [dbo].[BookingPrice_Get] (
	@productId INT,
	@total INT OUTPUT
	)
AS
BEGIN
	DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
	DECLARE @ColumnName AS NVARCHAR(MAX)

	--Get distinct values of the PIVOT Column 
	SELECT @ColumnName = ISNULL(@ColumnName + ',', '') + QUOTENAME(NAME)
	FROM (
		SELECT DISTINCT NAME,
			Ordering
		FROM PNK_BookingPrice
		WHERE Published = '1'
			AND ProductId = @productId
		) AS Courses
	ORDER BY Ordering

	PRINT @ColumnName

	--Prepare the PIVOT query using the dynamic 
	SET @DynamicPivotQuery = N' SELECT *
	FROM (
		SELECT [PriceClass] as [Price Class], Name, Value
		FROM PNK_BookingPrice
		WHERE Published = ''1'' AND  ProductId =' + cast(@productId AS VARCHAR) + '
		
		) p
    PIVOT(AVG(Value) 
          FOR NAME IN (' + @ColumnName + ') ) AS PVTTable '

	PRINT @DynamicPivotQuery

	--Execute the Dynamic Pivot Query
	EXEC sp_executesql @DynamicPivotQuery

	--SELECT *
	--FROM (
	--	SELECT [PriceClass], NAME, Value
	--	FROM PNK_BookingPrice
	--	WHERE ProductId = @productId
	--	) p
	--PIVOT(AVG(Value) FOR NAME IN (
	--			[1 Pax],
	--			[2-3 Pax],
	--			[4-6 Pax],
	--			[7-10 Pax],
	--			[11-15 Pax],
	--			[Luxury Join-in Group],
	--			[Big Group],
	--			[Single Supplement]
	--			)) AS PVTTable
	SET @total = 9999
END



GO
/****** Object:  StoredProcedure [dbo].[BookingPrice_PersonGet]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*

	EXEC [dbo].[BookingPrice_PersonGet] 
	@productId=6233,
	@priceClass='Private',
	@groupType=N'Private',
	@adults=1,
	@child=0,
	@infant=0

	
	*/
CREATE PROCEDURE [dbo].[BookingPrice_PersonGet] @productId INT = NULL,
	@priceClass NVARCHAR(500) = NULL,
	@groupType NVARCHAR(500) = NULL,
	@adults INT = NULL,
	@child INT = NULL,
	@infant INT = NULL
AS
BEGIN
	DECLARE @sum FLOAT = 0,
		@sumAdults FLOAT = 0,
		@sumChild FLOAT = 0,
		@sumInfant FLOAT = 0

	IF (@adults IS NOT NULL)
		SET @sumAdults = @sumAdults + isnull((
					SELECT TOP 1 Value
					FROM [PNK_BookingPrice]
					WHERE NAME NOT IN (
							'child',
							'infant'
							)
						AND productId = @productId
						AND GroupType = @groupType
						AND (
							@adults BETWEEN [min]
								AND [max]
							)
						AND PriceClass = @priceClass
					), 0) * @adults

	IF (@child != 0)
		SET @sumChild = @sumChild + isnull((
					SELECT TOP 1 Value
					FROM [PNK_BookingPrice]
					WHERE NAME = 'child'
						AND ProductId = @productId
						AND GroupType = @groupType
						AND (
							@child BETWEEN [min]
								AND [max]
							)
						AND PriceClass = @priceClass
					), 0) * @child

	IF (@infant  != 0)
		SET @sumInfant = @sumInfant + isnull((
					SELECT TOP 1 Value
					FROM [PNK_BookingPrice]
					WHERE NAME = 'infant'
						AND ProductId = @productId
						AND GroupType = @groupType
						AND (
							@infant BETWEEN [min]
								AND [max]
							)
						AND PriceClass = @priceClass
					), 0) * @infant

	SELECT @sumAdults + @sumChild + @sumInfant AS Total,
		@sumAdults AS SumAdults,
		@sumChild AS SumChild,
		@sumInfant AS SumInfant
END




GO
/****** Object:  StoredProcedure [dbo].[Configuration_Update]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[Configuration_Update] @config_email NVARCHAR(200)
	,@config_fax NVARCHAR(200)
	,@config_phone NVARCHAR(200)
	,@config_sitename NVARCHAR(200)
	,@config_skypeid NVARCHAR(200)
	,@config_yahooid NVARCHAR(max)
	,@config_company_name_vi NVARCHAR(200)
	,@config_company_name_en NVARCHAR(200)
	,@config_address_vi NVARCHAR(200)
	,@config_address1_vi NVARCHAR(200)
	,@config_logoHeader NVARCHAR(200)
	,@config_logoFooter NVARCHAR(200)
	,@config_location NVARCHAR(200)	
	,@title NVARCHAR(max)
	,@metaDescription NVARCHAR(200)
	,@metaKeyword NVARCHAR(max)
	,@config_FBFanPage NVARCHAR(max)
	,@googleplus NVARCHAR(max)
	,@twitter NVARCHAR(max)
	,@config_h1 NVARCHAR(max)	
	,@config_h2 NVARCHAR(max)	
	,@config_h3 NVARCHAR(max)	
	,@config_analytic NVARCHAR(max)	
	,@config_FBLike NVARCHAR(max)	
	,@vchat NVARCHAR(max)	
	,@config_latitude NVARCHAR(200)	
	,@config_longitude NVARCHAR(200)
	,@config_footer NVARCHAR(max)		
AS
BEGIN
	UPDATE PNK_configuration
	SET Value_name = @config_email
	WHERE Key_name = 'config_email';

	UPDATE PNK_configuration
	SET Value_name = @config_fax
	WHERE Key_name = 'config_fax';

	UPDATE PNK_configuration
	SET Value_name = @config_phone
	WHERE Key_name = 'config_phone';

	UPDATE PNK_configuration
	SET Value_name = @config_sitename
	WHERE Key_name = 'config_sitename';
	
	UPDATE PNK_configuration
	SET Value_name = @config_skypeid
	WHERE Key_name = 'config_skypeid';

	UPDATE PNK_configuration
	SET Value_name = @config_yahooid
	WHERE Key_name = 'config_yahooid';

	UPDATE PNK_configuration
	SET Value_name = @config_company_name_vi
	WHERE Key_name = 'config_company_name_vi';

		UPDATE PNK_configuration
	SET Value_name = @config_company_name_en
	WHERE Key_name = 'config_company_name_en';

	UPDATE PNK_configuration
	SET Value_name = @config_address_vi
	WHERE Key_name = 'config_address_vi';

	UPDATE PNK_configuration
	SET Value_name = @config_address1_vi
	WHERE Key_name = 'config_address1_vi';

	UPDATE PNK_configuration
	SET Value_name = @config_logoHeader
	WHERE Key_name = 'config_logoHeader';

	UPDATE PNK_configuration
	SET Value_name = @config_logoFooter
	WHERE Key_name = 'config_logoFooter';

	UPDATE PNK_configuration
	SET Value_name = @config_location
	WHERE Key_name = 'config_location';

	UPDATE PNK_configuration
	SET Value_name = @title
	WHERE Key_name = 'title';

	UPDATE PNK_configuration
	SET Value_name = @metaDescription
	WHERE Key_name = 'metaDescription';

	UPDATE PNK_configuration
	SET Value_name = @metaKeyword
	WHERE Key_name = 'metaKeyword';

	UPDATE PNK_configuration
	SET Value_name = @config_FBFanPage
	WHERE Key_name = 'config_fbfanPage';

	UPDATE PNK_configuration
	SET Value_name = @googleplus
	WHERE Key_name = 'googleplus';

	UPDATE PNK_configuration
	SET Value_name = @twitter
	WHERE Key_name = 'twitter';

	UPDATE PNK_configuration
	SET Value_name = @config_h1
	WHERE Key_name = 'config_h1';

	UPDATE PNK_configuration
	SET Value_name = @config_h2
	WHERE Key_name = 'config_h2';

	UPDATE PNK_configuration
	SET Value_name = @config_h3
	WHERE Key_name = 'config_h3';

	UPDATE PNK_configuration
	SET Value_name = @config_analytic
	WHERE Key_name = 'config_analytic';

	UPDATE PNK_configuration
	SET Value_name = @config_FBLike
	WHERE Key_name = 'config_fbLike';

	UPDATE PNK_configuration
	SET Value_name = @vchat
	WHERE Key_name = 'vchat';

	UPDATE PNK_configuration
	SET Value_name = @config_latitude
	WHERE Key_name = 'config_latitude';

	UPDATE PNK_configuration
	SET Value_name = @config_longitude
	WHERE Key_name = 'config_longitude';

	UPDATE PNK_configuration
	SET Value_name = @config_footer
	WHERE Key_name = 'config_footer';
END




















GO
/****** Object:  StoredProcedure [dbo].[ContentStatic_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  Congtt
-- Create date: 23/09/2014
-- Description: Danh danh sach ContentStatic   
-- =============================================    
/*
	
	DECLARE @p7 INT

	SET @p7 = 0

	EXEC [ContentStatic_Get] @langId = 1
		,@name = NULL
		,@pageIndex = 1
		,@pageSize = 10
		,@cateId = NULL
		,@Id = Null
		,@total = @p7 OUTPUT

	SELECT @p7


*/
CREATE PROCEDURE [dbo].[ContentStatic_Get] @langId INT = NULL
	,@name VARCHAR(255) = NULL
	,@cateId VARCHAR(1000) = NULL
	,@Id VARCHAR(10) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering DESC'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,      
     p.*,pd.id as subId,pd.langid,pd.title,pd.brief,pd.detail,MetaTitle,MetaKeyword,MetaDecription,pd.titleurl     
      FROM PNK_ContentStatic p INNER JOIN PNK_ContentStaticdesc  pd ON p.id = pd.mainid       
     --left join PNK_ContentStaticcategorydesc nc on p.categoryid=nc.mainid 
     WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 ';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.title like ''%''' + '+@name2+' + '''%''';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX( CAST(p.categoryid  AS varchar) ,@cateId2 )> 0 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Id = @Id2 ';
			--SET @select = @select + ' and CHARINDEX( CAST(p.Id  AS varchar) ,@Id2 )> 0 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,postDate,updateDate,ordering,phone, resource ,    
    subId,langid,title,brief,detail,MetaTitle,MetaKeyword,MetaDecription,TitleUrl ) AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000),
	  @Id2 VARCHAR(10)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 VARCHAR(10),     
      @Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@cateId
		,@Id
		,@Total2 OUT

	SET @total = @Total2;
END







GO
/****** Object:  StoredProcedure [dbo].[Country_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  Congtt
-- Create date: 23/09/2014
-- Description: Danh danh sach Country   
-- =============================================    
/*
	
	DECLARE @p7 INT

	SET @p7 = 0

	EXEC [Country_Get] @langId = 1
		,@name = NULL
		,@pageIndex = 1
		,@pageSize = 10
		,@cateId = NULL
		,@Id = Null
		,@total = @p7 OUTPUT

	SELECT @p7


*/
CREATE PROCEDURE [dbo].[Country_Get] @langId INT = NULL
	,@name VARCHAR(255) = NULL
	,@cateId VARCHAR(1000) = NULL
	,@Id VARCHAR(10) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering DESC'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,      
     p.*,pd.id as subId,pd.langid,pd.title,pd.brief,pd.detail,MetaTitle,MetaKeyword,MetaDecription,pd.titleurl     
      FROM PNK_Country p INNER JOIN PNK_Countrydesc  pd ON p.id = pd.mainid       
     --left join PNK_Countrycategorydesc nc on p.categoryid=nc.mainid 
     WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 ';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.title like ''%''' + '+@name2+' + '''%''';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX( CAST(p.categoryid  AS varchar) ,@cateId2 )> 0 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Id = @Id2 ';
			--SET @select = @select + ' and CHARINDEX( CAST(p.Id  AS varchar) ,@Id2 )> 0 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,postDate,updateDate,ordering ,    
    subId,langid,title,brief,detail,MetaTitle,MetaKeyword,MetaDecription,TitleUrl ) AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000),
	  @Id2 VARCHAR(10)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 VARCHAR(10),     
      @Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@cateId
		,@Id
		,@Total2 OUT

	SET @total = @Total2;
END












GO
/****** Object:  StoredProcedure [dbo].[ExchangeRate_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  Congtt
-- Create date: 23/09/2014
-- Description: Danh danh sach ExchangeRate   
-- =============================================    
/*
	
	DECLARE @p7 INT

	SET @p7 = 0

	EXEC [ExchangeRate_Get] @langId = 1
		,@name = NULL
		,@pageIndex = 1
		,@pageSize = 10
		,@cateId = NULL
		,@Id = Null
		,@total = @p7 OUTPUT

	SELECT @p7


*/
CREATE PROCEDURE [dbo].[ExchangeRate_Get] @langId INT = NULL
	,@name VARCHAR(255) = NULL
	,@cateId VARCHAR(1000) = NULL
	,@Id VARCHAR(10) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering DESC'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,      
     p.*,pd.id as subId,pd.langid,pd.title,pd.brief,pd.detail,MetaTitle,MetaKeyword,MetaDecription,pd.titleurl   
	 ,pd.Amount  
      FROM PNK_ExchangeRate p INNER JOIN PNK_ExchangeRatedesc  pd ON p.id = pd.mainid       
     --left join PNK_ExchangeRatecategorydesc nc on p.categoryid=nc.mainid 
     WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 ';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.title like ''%''' + '+@name2+' + '''%''';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX( CAST(p.categoryid  AS varchar) ,@cateId2 )> 0 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Id = @Id2 ';
			--SET @select = @select + ' and CHARINDEX( CAST(p.Id  AS varchar) ,@Id2 )> 0 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT]  AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000),
	  @Id2 VARCHAR(10)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 VARCHAR(10),     
      @Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@cateId
		,@Id
		,@Total2 OUTPUT

	SET @total = @Total2;
END


GO
/****** Object:  StoredProcedure [dbo].[Location_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

/*

	DECLARE @return_value INT
	,@total INT

	EXEC @return_value = [dbo].[Location_Get] @langId = 1
	,@published = N'1'
	,@pageSize = 11
	,@pageIndex = 1
	,@total = @total OUTPUT

	SELECT @total AS N'@total'

	SELECT 'Return Value' = @return_value
	GO



*/
CREATE PROCEDURE [dbo].[Location_Get]
		@langId INT = null,
		@name VARCHAR(255) = null,
		@published nchar(1) = null,
		@pageSize int = 10,
		@pageIndex int = 1,
		@field nvarchar(100) = 'l.ordering DESC',
		@total int output 
AS
BEGIN
	DECLARE @select nvarchar(max),
			@Paramlist nvarchar(max);
	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,
					l.*,ld.id as subId,ld.langid,ld.name
					 FROM PNK_location l INNER JOIN PNK_locationdesc ld on l.id = ld.mainid WHERE 1=1';
					 
	/*@langId*/
	if(@langId is not null)
	begin
		set @select = @select + ' and ld.langid = @langId2';
	end
	
	/****@content***/
	if(@name is not null)
	begin
	 set @select = @select + ' and ld.Name like ''%'+'+@name2+'+'%''';
	end	
	
	/**@published**/
	if(@published is not null)
	begin
		set @select = @select + ' and l.Published = @published2 ';
	end
	
	declare @table nvarchar(max);
	set @table = 'WITH [RESULT](row, Id, parentid,ordering,postdate,published,updatedate,pathtree,subId,langid,name) AS ( ';
	
	
	-- paging 
	declare @pagingSql nvarchar(max);
	declare @startRow int;
    declare @endRow   int;
	
	set @pagingSql	= 'SELECT * FROM [RESULT] WHERE row between ';
	set @startRow	= (@pageIndex - 1) * @pageSize + 1;
	set @endRow		= @startRow + @pageSize - 1;
    set @pagingSql	= @pagingSql + convert(varchar(10), @startRow);
	set @pagingSql	= @pagingSql + ' AND ' ;
	set @pagingSql	= @pagingSql + convert(varchar(10), @endRow);
	
	declare @sql nvarchar(max);
	set  @sql = ' ';
	
	set @sql = @table + @select + ') ' + @pagingsql;
	
	
	set @Paramlist = N'
						@langId2 INT,
						@name2 VARCHAR(255),
						@published2 nchar(1)';
	exec SP_EXECUTESQL  @sql,
						@Paramlist,
						@langId2 = @langId,
						@name2 = @name,
						@published2 = @published
	
	declare @Total2 int;
	set @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	set @Paramlist = N'
						@langId2 INT,
						@name2 VARCHAR(255),
						@published2 nchar(1),
						@Total2 int out';
						
	exec sp_executeSql @sql,
						@Paramlist, 
						 @langId,
						 @name,
						 @published,
						@Total2 out
	set @total = @Total2;
END

















GO
/****** Object:  StoredProcedure [dbo].[Product_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  CongTT
-- Create date: 2015/08/22
-- Description: Lấy danh sách danh mục con
-- =============================================    
/*

	DECLARE @p7 INT
	SET @p7 = 0
	EXEC Product_Get @langId = 1
		,@name = NULL
		,@published  = 1
		,@pageIndex = 1
		,@pageSize = 100
		,@cateId =Null
		,@Id = Null
		,@hot =  Null
		,@total = @p7 OUTPUT
	SELECT @p7

*/
CREATE PROCEDURE [dbo].[Product_Get] @langId INT = NULL
	,@name NVARCHAR(max) = NULL
	,@published NCHAR(1) = NULL
	,@cateId VARCHAR(max) = NULL
	,@Id VARCHAR(max) = NULL
	,@hot VARCHAR(1) = NULL
	,@feature VARCHAR(1) = NULL
	,@post VARCHAR(1) = NULL
	,@userId INT = NULL
	,@tag NVARCHAR(max) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering desc'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	--set @cateId=REPLACE(@cateId,'','')
	PRINT @cateId

	SET @select = 'SELECT ROW_NUMBER() OVER (
		ORDER BY ' + @field + '
		) AS row
	,p.*
	,pd.id AS subId
	,pd.langid
	,pd.title
	,pd.brief
	,pd.detail
	,pd.position
	,pd.utility
	,pd.design
	,pd.pictures
	,pd.payment
	,pd.contact
	,nc.NAME AS categorynamedesc
	,nc.nameurl AS categoryurldesc
	,nc.Brief AS categoryBrief
	,nc.Detail AS categoryDetail
	,nc.MetaTitle AS categoryMetaTitle
	,nc.MetaKeyword AS categoryMetaKeyword
	,nc.MetaDecription AS categoryMetaDecription
	,pd.titleurl
	,pd.metatitle
	,pd.metadescription
	,pd.metakeyword
	,pd.h1
	,pd.h2
	,pd.h3
FROM PNK_product p
INNER JOIN PNK_productdesc pd ON p.id = pd.mainid
LEFT JOIN PNK_productcategorydesc nc ON p.categoryid = nc.mainid
WHERE 1 = 1
';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 and nc.langid = @langId2';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Published = @published2 ';
	END

	/****@name***/
	IF (@name IS NOT NULL)
	BEGIN
		--SET @select = @select + ' and pd.TitleUrl like ''%''' + '+@name2+' + '''%''';
		SET @select = @select + ' and  NameUrl =  @name2';
	END

	/****@tag***/
	IF (@tag IS NOT NULL)
	BEGIN
		SET @select = @select + ' and Utility =  @tag2';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' AND CategoryId IN (' + @cateId + ') ';
			--SET @select = @select + ' AND CHARINDEX(CAST(CategoryId AS VARCHAR), @cateId2) >0 ';
			--SET @select = @select + ' and p.categoryid  = @cateId2 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX(@Id2,titleurl)>0';
	END

	/*@Hot*/
	IF (@Hot IS NOT NULL)
	BEGIN
		SET @select = @select + ' and  hot =@hot2 ';
	END

	/*@feature*/
	IF (@feature IS NOT NULL)
	BEGIN
		SET @select = @select + ' and feature =@feature2 ';
	END

	/*@post*/
	IF (@post IS NOT NULL)
	BEGIN
		SET @select = @select + ' and post =@post2 ';
	END

	/*@userId*/
	IF (@userId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and UpdateBy =@userId2 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,hot,feature,postDate,updateDate,ordering,longitude, latitude, price,area,district,bedroom
	,bathroom,code,status,province,website,post,cost,UpdateBy,page,ImageType,ImageFont, subId,langid,title,brief,detail,position,utility,design,pictures,payment,contact,categorynamedesc,categoryurldesc
	,categoryBrief,categoryDetail,categoryMetaTitle,categoryMetaKeyword,categoryMetaDecription
	,titleurl
	,metatitle,metadescription,metakeyword,h1,h2,h3) AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
		@langId2 INT ,   
		@published2 nchar(1),
		@name2 NVARCHAR(255) ,      
		@cateId2 VARCHAR(1000),
		@Id2 NVARCHAR(255),
		@hot2 VARCHAR(1),
		@feature2 VARCHAR(1),
		@post2 VARCHAR(1),
		@userid2 INT,
		@tag2 NVARCHAR(255) ';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@published2 = @published
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id
		,@hot2 = @Hot
		,@feature2 = @feature
		,@post2 = @post
		,@userid2 = @userId
		,@tag2 = @tag

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N' 
      @langId2 INT ,    
	  @published2 nchar(1),
      @name2 NVARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 NVARCHAR(255),     
	  @hot2 VARCHAR(1), 
	  @feature2 VARCHAR(1), 
	  @post2 VARCHAR(1), 
	  @userid2 INT, 
	  @tag2 NVARCHAR(255),
      @Total2 int out ';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@published
		,@name
		,@cateId
		,@Id
		,@Hot
		,@feature
		,@post
		,@userId
		,@tag
		,@Total2 OUTPUT

	SET @total = @Total2;
END








GO
/****** Object:  StoredProcedure [dbo].[Product_GetRelate]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*

	DECLARE @p7 INT

	SET @p7 = NULL

	EXEC [Product_GetRelate] @langId = 1
	,@name = NULL
	,@pageIndex = 1
	,@pageSize = 6
	,@cateId = NULL
	,@Id = NULL
	,@total = @p7 OUTPUT

	SELECT @p7

*/
CREATE PROCEDURE [dbo].[Product_GetRelate] @langId INT = NULL
	,@name NVARCHAR(255) = NULL
	,@cateId VARCHAR(1000) = NULL
	,@Id VARCHAR(1000) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering DESC'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = 'SELECT ROW_NUMBER() OVER (
		ORDER BY ' + @field + '
		) AS row
	,p.*
	,pd.id AS subId
	,pd.langid
	,pd.title
	,pd.brief
	,pd.detail
	,pd.position
	,pd.utility
	,pd.design
	,pd.pictures
	,pd.payment
	,pd.contact
	,nc.NAME AS categorynamedesc
	,nc.nameurl AS categoryurldesc
	,nc.Brief AS categoryBrief
	,nc.Detail AS categoryDetail
	,nc.MetaTitle AS categoryMetaTitle
	,nc.MetaKeyword AS categoryMetaKeyword
	,nc.MetaDecription AS categoryMetaDecription
	,pd.titleurl
	,pd.metatitle
	,pd.metadescription
	,pd.metakeyword
	,pd.h1
	,pd.h2
	,pd.h3
	FROM PNK_product p
	INNER JOIN PNK_productdesc pd ON p.id = pd.mainid
	LEFT JOIN PNK_productcategorydesc nc ON p.categoryid = nc.mainid
	WHERE 1 = 1
	';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 and nc.langid = @langId2';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX(@name2,nc.nameurl)>0 ';
			--SET @select = @select + ' and nc.nameurl = @name2 ';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' AND CategoryId IN (' + @cateId + ') ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		--SET @select = @select + ' and CHARINDEX(@Id2,titleurl)>0';
		SET @select = @select + ' and pd.titleurl<>  @Id2 ';
	END

	-- paging
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,hot,feature,postDate,updateDate,ordering,longitude, latitude, price,area,district,bedroom
	,bathroom,code,status,province,website,post,cost,UpdateBy,page,ImageType,ImageFont, subId,langid,title,brief,detail,position,utility,design,pictures,payment,contact,categorynamedesc,categoryurldesc
	,categoryBrief,categoryDetail,categoryMetaTitle,categoryMetaKeyword,categoryMetaDecription
	,titleurl
	,metatitle,metadescription,metakeyword,h1,h2,h3) AS ( ';

	-- paging 
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [result] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'@langId2 INT ,
						@name2 VARCHAR(255) ,
						@cateId2 VARCHAR(1000),
						@Id2 VARCHAR(1000)';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [result]';
	SET @Paramlist = N'
					@langId2 INT
					,@name2 VARCHAR(255)
					,@cateId2 VARCHAR(1000)
					,@Id2 VARCHAR(1000)
					,@Total2 INT OUT
					';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@cateId
		,@Id
		,@Total2 OUTPUT

	SET @total = @Total2;
END




GO
/****** Object:  StoredProcedure [dbo].[Product_GetSearch]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  CongTT
-- Create date: 2015/08/22
-- Description: Lấy danh sách danh mục con
-- =============================================    
/*

	DECLARE @p7 INT
	SET @p7 = 0
	EXEC [Product_GetSearch] @langId = 1
		,@name = NULL
		,@published  = 1
		,@pageIndex = 1
		,@pageSize = 100
		,@cateId =Null
		,@Id = Null
		,@hot =  Null
		,@total = @p7 OUTPUT
	SELECT @p7

*/
CREATE PROCEDURE [dbo].[Product_GetSearch] @langId INT = NULL
	,@name NVARCHAR(max) = NULL
	,@published NCHAR(1) = NULL
	,@cateId VARCHAR(max) = NULL
	,@Id VARCHAR(max) = NULL
	,@hot VARCHAR(1) = NULL
	,@feature VARCHAR(1) = NULL
	,@post VARCHAR(1) = NULL
	,@userId INT = NULL
	,@tag NVARCHAR(max) = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'p.ordering desc'
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	--set @cateId=REPLACE(@cateId,'','')
	PRINT @cateId

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,      
     p.*,pd.id as subId,pd.langid,pd.title,pd.brief,pd.detail,pd.position,pd.utility,pd.design,pd.pictures,pd.payment,pd.contact
     ,nc.name as categorynamedesc,nc.nameurl as categoryurldesc ,pd.titleurl,pd.metatitle,pd.metadescription,pd.metakeyword,pd.h1,pd.h2,pd.h3 FROM PNK_product p
	 INNER JOIN PNK_productdesc  pd ON p.id = pd.mainid  
     left join PNK_productcategorydesc nc on p.categoryid=nc.mainid WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 and nc.langid = @langId2';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Published = @published2 ';
	END

	/****@name***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.TitleUrl like ''%''' + '+@name2+' + '''%''';		
	END

	/****@tag***/
	IF (@tag IS NOT NULL)
	BEGIN
		SET @select = @select + ' and Utility =  @tag2';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' AND CategoryId IN (' + @cateId + ') ';
			--SET @select = @select + ' AND CHARINDEX(CAST(CategoryId AS VARCHAR), @cateId2) >0 ';
			--SET @select = @select + ' and p.categoryid  = @cateId2 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX(@Id2,titleurl)>0';
	END

	/*@Hot*/
	IF (@Hot IS NOT NULL)
	BEGIN
		SET @select = @select + ' and  hot =@hot2 ';
	END

	/*@feature*/
	IF (@feature IS NOT NULL)
	BEGIN
		SET @select = @select + ' and feature =@feature2 ';
	END

	/*@post*/
	IF (@post IS NOT NULL)
	BEGIN
		SET @select = @select + ' and post =@post2 ';
	END

	/*@userId*/
	IF (@userId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and userid =@userId2 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,hot,feature,postDate,updateDate,ordering,longitude, latitude, price,area,district,bedroom
	,bathroom,code,status,province,website,post,cost,userid,page,ImageType,ImageFont,  subId,langid,title,brief,detail,position,utility,design,pictures,payment,contact,categorynamedesc,categoryurldesc,titleurl
	,metatitle,metadescription,metakeyword,h1,h2,h3) AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
		@langId2 INT ,   
		@published2 nchar(1),
		@name2 NVARCHAR(255) ,      
		@cateId2 VARCHAR(1000),
		@Id2 NVARCHAR(255),
		@hot2 VARCHAR(1),
		@feature2 VARCHAR(1),
		@post2 VARCHAR(1),
		@userid2 INT,
		@tag2 NVARCHAR(255) ';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@published2 = @published
		,@name2 = @name
		,@cateId2 = @cateId
		,@Id2 = @Id
		,@hot2 = @Hot
		,@feature2 = @feature
		,@post2 = @post
		,@userid2 = @userId
		,@tag2 = @tag

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N' 
      @langId2 INT ,    
	  @published2 nchar(1),
      @name2 NVARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 NVARCHAR(255),     
	  @hot2 VARCHAR(1), 
	  @feature2 VARCHAR(1), 
	  @post2 VARCHAR(1), 
	  @userid2 INT, 
	  @tag2 NVARCHAR(255),
      @Total2 int out ';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@published
		,@name
		,@cateId
		,@Id
		,@Hot
		,@feature
		,@post
		,@userId
		,@tag
		,@Total2 OUTPUT

	SET @total = @Total2;
END















GO
/****** Object:  StoredProcedure [dbo].[Product_UpdatePage]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Congtt
-- Create date: 
-- Description:	
-- =============================================
/*

	EXEC [Product_UpdatePage] 6

*/
CREATE PROCEDURE [dbo].[Product_UpdatePage] @productCategoryId INT = 0, @page VARCHAR(500) = NULL
AS
BEGIN
	UPDATE PNK_product
	SET Page = @page
	WHERE CategoryId = @productCategoryId
END















GO
/****** Object:  StoredProcedure [dbo].[ProductCategory_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*

	DECLARE @p12 INT

	SET @p12 = 9000

	EXEC [ProductCategory_Get] @langId = 1,
	@name = NULL,
	@parentid = NULL,
	@tree = 1,
	@pageIndex = 1,
	@pageSize = 9999,
	@published = NULL,
	@field = NULL,
	@id = null,
	@uncludeMe = 1,	
	@total = @p12 OUTPUT

	SELECT @p12


*/

CREATE PROCEDURE [dbo].[ProductCategory_Get] @langId INT = NULL
	,@name VARCHAR(255) = NULL
	,@id INT = NULL
	,@parentid INT = NULL
	,@tree BIT = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@uncludeMe BIT = 1
	,@field NVARCHAR(100) = 'p.pathtree'
	,@published NCHAR(1) = NULL
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @field = ISNULL(@field, 'p.pathtree')
	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,p.*,pd.id as subId,pd.langid,pd.name,pd.nameurl,pd.Brief
	,pd.Detail,pd.MetaTitle,pd.MetaKeyword,pd.MetaDecription,pd.h1,pd.h2,pd.h3 
	FROM PNK_productcategory p 
	INNER JOIN PNK_productcategorydesc  pd ON p.id = pd.mainid WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2';
	END

	/****@name***/
	IF (@name IS NOT NULL)
	BEGIN
		--SET @select = @select + ' and pd.NameUrl like ''%''' + '+@name2+' + '''%''';
		SET @select = @select + ' and pd.NameUrl =@name2';
	END

	/*@id*/
	IF (@id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.id = @id2';
	END

	/*@parentid*/
	IF (@parentid IS NOT NULL)
	BEGIN
		IF (@tree = 1)
			SET @select = @select + ' and p.parentid in (SELECT id FROM dbo.fc_GetAllChildProductCategory(@parentid2,ISNULL(@uncludeMe2,1))) ';
		ELSE
			SET @select = @select + ' and p.parentid = @parentid2 ';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Published = @published2 ';
	END

	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,parentid,published,ordering,postdate,updatedate,pathtree,BaseImage,SmallImage,ThumbnailImage,page,pagedetail,ImageType,ImageFont, subId,langid,name,nameurl
	,Brief,Detail,MetaTitle,MetaKeyword,MetaDecription,h1,h2,h3 ) AS ( ';

	-- paging 
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;
	SET @Paramlist = N'

						@langId2 INT,
						@name2 VARCHAR(255),
						@published2 NCHAR(1),
						@id2 INT,
						@parentid2 INT,
						@uncludeMe2 BIT=1,
						@tree2 BIT';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@langId2 = @langId
		,@name2 = @name
		,@published2 = @published
		,@id2 = @id
		,@parentid2 = @parentid
		,@uncludeMe2 = @uncludeMe
		,@tree2 = @tree

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'

						@langId2 INT,
						@name2 VARCHAR(255),
						@published2 NCHAR(1),
						@id2 INT,
						@parentid2 INT,
						@uncludeMe2 BIT=1,
						@tree2 BIT,

						@Total2 int out';

	PRINT @sql

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@published
		,@id
		,@parentid
		,@uncludeMe
		,@tree
		,@Total2 OUTPUT

	SET @total = @Total2;
END







GO
/****** Object:  StoredProcedure [dbo].[ProductCategory_GetChild]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Congtt
-- Create date: 24/12/2014
-- Description:	Lấy danh sách Product Category
-- =============================================
/*

	DECLARE @return_value INT
	,@total INT

	SELECT @total = 5

	EXEC @return_value = [dbo].[ProductCategory_GetChild] @IDCategory = 5
	,@unclude_me = 1
	,@total = @total OUTPUT

	SELECT @total AS N'@total'

	SELECT 'Return Value' = @return_value
	GO

*/
CREATE PROCEDURE [dbo].[ProductCategory_GetChild] @IDCategory INT, @unclude_me BIT = 0, @total INT OUT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	INTO #tmp
	FROM fc_GetAllChildProductCategory(@IDCategory, @unclude_me)

	SELECT *
	FROM #tmp

	SET @Total = (
			SELECT Count(*)
			FROM #tmp
			)
		--SET @Total = (
		--		SELECT count(*)
		--		FROM fc_GetAllChildProductCategory(@IDCategory, @unclude_me)
		--		)
END















GO
/****** Object:  StoredProcedure [dbo].[ProductCategory_Tree_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	DECLARE @p11 INT

	SET @p11 = 19

	EXEC [ProductCategory_Tree_Get] @langId = 1,
		@name = NULL,
		@parentid = NULL,
		@treeNameUrl=NULL,
		@tree =0,
		@pageIndex = 1,
		@pageSize = 1000,
		@published = NULL,
		@field = N'p.ordering desc',
		@id = NULL,
		@uncludeMe = 1,
		@total = @p11 OUTPUT

	SELECT @p11



*/
CREATE PROCEDURE [dbo].[ProductCategory_Tree_Get] @langId INT = NULL
	,@name VARCHAR(8000) = NULL
	,@id INT = NULL
	,@parentid VARCHAR(50) = NULL
	,@treeNameUrl VARCHAR(8000) = NULL
	,@tree BIT = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@uncludeMe BIT = 1
	,@field NVARCHAR(100) = 'p.ordering'
	,@published NCHAR(1) = NULL
	,@total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max) = ''
		,@Paramlist NVARCHAR(max) = ''
		,@Where NVARCHAR(max) = ''
		,@WhereCTE NVARCHAR(max) = ''
		,@WhereHi NVARCHAR(max) = NULL
		,@sql NVARCHAR(max) = '';

	SET @field = ISNULL(@field, 'p.ordering desc')

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @Where = @Where + ' and pd.langid = @langId2';
	END

	/****@name***/
	IF (@name IS NOT NULL)
	BEGIN
		--SET @select = @select + ' and pd.NameUrl like ''%''' + '+@name2+' + '''%''';
		SET @WhereCTE = @WhereCTE + ' and H.NameUrl =@name2';
	END

	/****@treeNameUrl***/
	IF (@treeNameUrl IS NOT NULL)
	BEGIN
		SET @WhereCTE = @WhereCTE + ' and C.TreeNameUrl =@treeNameUrl2';
	END

	/*@id*/
	IF (@id IS NOT NULL)
	BEGIN
		SET @WhereCTE = @WhereCTE + ' and C.id = @id2';
	END

	/*@parentid*/
	IF (@parentid IS NOT NULL)
	BEGIN
		IF (@tree = 1)
		BEGIN
			SET @WhereCTE = @WhereCTE + ' and C.ID in (SELECT id FROM dbo.fc_GetAllChildProductCategory(@parentid2,ISNULL(@uncludeMe2,1))) ';
		END
		ELSE
			SET @WhereCTE = @WhereCTE + ' and C.ID IN  (' + @parentid + ') ';
	END

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @Where = @Where + ' and p.Published = @published2 ';
	END

	-----------------------------------------------------
	SET @select = N'SELECT * INTO #Hierarchy FROM( SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,p.*,pd.id as subId,pd.langid,pd.name,pd.nameurl,pd.Brief
	,pd.Detail,pd.MetaTitle,pd.MetaKeyword,pd.MetaDecription,pd.h1,pd.h2,pd.h3 
	FROM PNK_productcategory p 
	INNER JOIN PNK_productcategorydesc  pd ON p.id = pd.mainid WHERE 1=1 ' + @Where + 
		'
	) AS #Hierarchy
	;WITH MyCTE
	AS (
		SELECT 
		ID,
		NAME,
		CAST(Name AS NVARCHAR(4000)) AS TreeNameUrlUnicode,
		CAST(NameUrl AS VARCHAR(8000)) AS TreeNameUrl,
		CAST(ID AS VARCHAR(255)) AS TreeId, 1 AS TreeLevel
		FROM #Hierarchy T1
		WHERE T1.ParentID=0 
		
		UNION ALL
	
		SELECT 
		T2.ID,
		T2.NAME,
		item.TreeNameUrlUnicode + ''/'' + CAST(T2.Name AS NVARCHAR(4000)) AS TreeNameUrlUnicode,
		item.TreeNameUrl + ''/'' + CAST(T2.NameUrl AS VARCHAR(8000)) AS TreeNameUrl,
		CAST(TreeId + ''/'' + CAST(T2.ID AS VARCHAR(255)) AS VARCHAR(255)) AS TreeId, TreeLevel + 1
		FROM #Hierarchy T2
		INNER JOIN MyCTE item ON item.ID = T2.ParentID
		)	
	SELECT ROW_NUMBER() OVER (
			ORDER BY H.pathtree
			) AS row, C.ID, Replicate(''.'', (TreeLevel-1) * 4) + C.NAME AS ''TreeName'',C.TreeNameUrlUnicode,C.TreeNameUrl,
	TreeId, TreeLevel, H.*
	FROM MyCTE C
	LEFT JOIN #Hierarchy H ON h.id = c.ID WHERE 1=1 ' + @WhereCTE + 
		'
	ORDER BY TreeId, Ordering asc drop table #Hierarchy; ';

	----------------------------
	DECLARE @table NVARCHAR(max);

	SET @sql = @select

	PRINT @sql

	SET @Paramlist = N'
						@langId2 INT,
						@name2 VARCHAR(255),
						@published2 NCHAR(1),@id2 INT,
						@parentid2 VARCHAR(50),
						@treeNameUrl2 VARCHAR(8000),
						@uncludeMe2 BIT=1,
						@tree2 BIT,
						@Total2 int out';

	DECLARE @Total2 INT;

	EXEC sp_executeSql @sql
		,@Paramlist
		,@langId
		,@name
		,@published
		,@id
		,@parentid
		,@treeNameUrl
		,@uncludeMe
		,@tree
		,@Total2 OUTPUT

	SET @total = 9000;
END


GO
/****** Object:  StoredProcedure [dbo].[ProductCategory_UpdatePathTree]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Congtt
-- Create date: 
-- Description:	
-- =============================================
/*



	EXEC ProductCategory_UpdatePathTree 29,35



*/
CREATE PROCEDURE [dbo].[ProductCategory_UpdatePathTree] @parentId INT = 0
	,@productCategoryId INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @idOrdering INT
		,@parentPath VARCHAR(500)
		,@pathTree VARCHAR(500)

	-----------------Neu la danh muc cha thi @parentId=0: @pathTree co dang 0997-1---------------------
	IF (@parentId = 0)
	BEGIN
		SET @idOrdering = (
				SELECT TOP 1 ordering
				FROM PNK_productcategory
				WHERE id = @productCategoryId
				)
		SET @pathTree = '.' + (
				SELECT dbo.GetBottomPath(@idOrdering, @productCategoryId)
				)
	END
			-----------------Neu la danh muc con thi @parentId <> 0: @pathTree co dang 0997-1---------------------
	ELSE
	BEGIN
		---------------Get Parent path---------------------
		SET @parentPath = (
				SELECT TOP 1 pathtree
				FROM PNK_productcategory
				WHERE id = @parentId
				)
		-----------------Set ordering of id-------------------
		SET @idOrdering = (
				SELECT TOP 1 ordering
				FROM PNK_productcategory
				WHERE id = @productCategoryId
				)

		--PRINT @idOrdering
		DECLARE @idPath VARCHAR(500)
		set @idPath = (
				SELECT dbo.GetBottomPath(@idOrdering, @productCategoryId)
				)

		--PRINT @idPath
		-----------------Path parent + Path id-------------------
		SET @pathTree = @parentPath + '.' + @idPath
	END

	-----------------Print ket qua kiem tra-------------------
	PRINT '@pathTree ' + @pathTree

	---------------Update column pathtree-------------------
	UPDATE PNK_productcategory
	SET pathtree = @pathTree
	WHERE id = @productCategoryId
END







GO
/****** Object:  StoredProcedure [dbo].[ProgramTour_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  Congtt
-- Create date: 23/09/2014
-- Description: Danh danh sach ContentStatic   
-- =============================================    
/*
	
	DECLARE @p7 INT

	SET @p7 = 0

	EXEC [ProgramTour_Get] @langId = 1
		,@name = NULL
		,@pageIndex = 1
		,@pageSize = 10
		,@cateId = NULL
		,@Id = Null
		,@total = @p7 OUTPUT

	SELECT @p7


*/
CREATE PROCEDURE [dbo].[ProgramTour_Get] @langId INT = NULL, @name VARCHAR(255) = NULL, @cateId VARCHAR(1000) = NULL, @Id VARCHAR(10) = NULL, @pageSize INT = 10, @pageIndex INT = 1, @field NVARCHAR(100) = 'p.ordering ', @total INT OUTPUT
AS
BEGIN
	DECLARE @select NVARCHAR(max), @Paramlist NVARCHAR(max);

	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY ' + @field + ') as row,      
     p.*,pd.id as subId,pd.langid,pd.title,pd.brief,pd.detail,MetaTitle,MetaKeyword,MetaDecription,pd.titleurl     
      FROM PNK_ProgramTour p INNER JOIN PNK_ProgramTourdesc  pd ON p.id = pd.mainid      
    
     WHERE 1=1';

	/*@langId*/
	IF (@langId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.langid = @langId2 ';
	END

	/****@content***/
	IF (@name IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pd.title like ''%''' + '+@name2+' + '''%''';
	END

	/*@cateId*/
	IF (@cateId IS NOT NULL)
	BEGIN
		SET @select = @select + ' and CHARINDEX( CAST(p.categoryid  AS varchar) ,@cateId2 )> 0 ';
	END

	/*@Id*/
	IF (@Id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and p.Id = @Id2 ';
			--SET @select = @select + ' and CHARINDEX( CAST(p.Id  AS varchar) ,@Id2 )> 0 ';
	END

	-- paging      
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row, id,categoryid,image,published,postDate,updateDate,ordering,phone, resource , ImageType,ImageFont,   
    subId,langid,title,brief,detail,MetaTitle,MetaKeyword,MetaDecription,TitleUrl ) AS ( ';

	-- paging       
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql;

	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000),
	  @Id2 VARCHAR(10)';

	EXEC SP_EXECUTESQL @sql, @Paramlist, @langId2 = @langId, @name2 = @name, @cateId2 = @cateId, @Id2 = @Id

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'      
      @langId2 INT ,      
      @name2 VARCHAR(255) ,      
      @cateId2 VARCHAR(1000), 
	  @Id2 VARCHAR(10),     
      @Total2 int out';

	EXEC sp_executeSql @sql, @Paramlist, @langId, @name, @cateId, @Id, @Total2 OUT

	SET @total = @Total2;
END




GO
/****** Object:  StoredProcedure [dbo].[UploadImage_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  Congtt
-- Create date: 23/09/2014
-- Description: Danh danh sach Images   
-- =============================================    
/*

	declare @p2 int
	set @p2=0
	exec [UploadImage_Get]
	@id=NULL
	,@productid=NULL
	,@published = '1'
	,@pageIndex = 1
	,@pageSize = 10 
	,@total=@p2 output
	select @p2


*/
CREATE PROCEDURE [dbo].[UploadImage_Get] (
	@id NVARCHAR(50) = NULL
	,@productid NVARCHAR(max) = NULL
	,@published NCHAR(1) = NULL
	,@Type INT = NULL
	,@pageSize INT = 10
	,@pageIndex INT = 1
	,@field NVARCHAR(100) = 'a.Position,a.ordering DESC'
	,@total INT OUTPUT
	)
AS
BEGIN
	DECLARE @select NVARCHAR(max)
		,@Paramlist NVARCHAR(max);

	SET @select = 'SELECT ROW_NUMBER() OVER (ORDER BY id) as row,id,name,published,imagepath,ordering,postdate,updatedate

		,productid,type,LongiTude,Latitude

	 from PNK_uploadimage pu WHERE 1=1';

	/****@id***/
	IF (@id IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pu.id like ''%''' + '+@id+' + '''%''';
	END

	/*@productid*/
	IF (@productid IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pu.productid IN (' + @productid + ')';
			--SET @select = @select + ' and pu.productid = @productid2';
	END
	ELSE
		SET @select = @select + ' and pu.productid IS NULL';

	/**@published**/
	IF (@published IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pu.Published = @published2 ';
	END

	/**@type**/
	IF (@type IS NOT NULL)
	BEGIN
		SET @select = @select + ' and pu.type = @type2 ';
	END
	ELSE
		SET @select = @select + ' and pu.type IS NULL ';

	-- paging
	DECLARE @table NVARCHAR(max);

	SET @table = 'WITH [RESULT](row,id,name,published,imagepath,ordering,postdate,updatedate,productid,type,LongiTude,Latitude ) AS ( ';

	-- paging 
	DECLARE @pagingSql NVARCHAR(max);
	DECLARE @startRow INT;
	DECLARE @endRow INT;

	SET @pagingSql = 'SELECT * FROM [RESULT] WHERE row between ';
	SET @startRow = (@pageIndex - 1) * @pageSize + 1;
	SET @endRow = @startRow + @pageSize - 1;
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @startRow);
	SET @pagingSql = @pagingSql + ' AND ';
	SET @pagingSql = @pagingSql + convert(VARCHAR(10), @endRow);

	DECLARE @sql NVARCHAR(max);

	SET @sql = ' ';
	SET @sql = @table + @select + ') ' + @pagingsql;

	PRINT @sql

	SET @Paramlist = N'@id2  nvarchar(50),

						@productid2  nvarchar(max),						

						@published2 nchar(1),

						@type2  int';

	EXEC SP_EXECUTESQL @sql
		,@Paramlist
		,@id2 = @id
		,@productid2 = @productid
		,@type2 = @type
		,@published2 = @published

	DECLARE @Total2 INT;

	SET @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	SET @Paramlist = N'

						@id2  nvarchar(50),

						@productid2 nvarchar(max),

						@published2 nchar(1),

						@type2  int,

						@Total2 int out';

	EXEC sp_executeSql @sql
		,@Paramlist
		,@id
		,@productid
		,@published
		,@type
		,@Total2 OUTPUT

	SET @total = @Total2;
END


GO
/****** Object:  StoredProcedure [dbo].[User_Get]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*

	DECLARE	@return_value int,
		@total int

	SELECT	@total = 10

	EXEC	@return_value = [dbo].[User_Get]
		@published = N'1',
		@pageSize = 11,
		@pageIndex = 1,
		@total = @total OUTPUT

	SELECT	@total as N'@total'

	SELECT	'Return Value' = @return_value

	GO


*/
CREATE PROCEDURE [dbo].[User_Get]
	@isnewsletter CHAR(1) = null,
	@name  nvarchar(50) = null,
	@published nchar(1) = null,
	@pageSize int = 10,
	@pageIndex int = 1,
	@field nvarchar(100) = 'u.username DESC',
	@total int output      
AS
BEGIN
	DECLARE @select nvarchar(max),
			@Paramlist nvarchar(max);
	SET @select = ' SELECT ROW_NUMBER() OVER (ORDER BY '+@field+' ) as row,
					u.* ,ld.name as LocationDesc  
					FROM PNK_user AS u left join PNK_locationdesc ld on u.locationid = ld.mainid WHERE 1=1';
					
	/**@isnewsletter**/
	if(@isnewsletter is not null)
	begin
		set @select = @select + ' and u.isnewsletter = @isnewsletter2 ';
	end
	
	/****@content***/
	if(@name is not null)
	begin
	 set @select = @select + ' and (u.fullname like ''%'+@name+'%'' or  u.username like ''%'+@name+'%'' )';
	end	
	
	/**@published**/
	if(@published is not null)
	begin
		set @select = @select + ' and u.Published = @published2 ';
	end
	
	-- paging
	declare @table nvarchar(max);
	set @table = 'WITH [RESULT](row, id,fullName,username,password,phone,address,email,
				isNewsletter,role,published,postDate,updateDate,token,mobile,locationId,Image,
				LocationDesc ) AS ( ';
	
	-- paging 
	declare @pagingSql nvarchar(max);
	declare @startRow int;
    declare @endRow   int;
	
	set @pagingSql	= 'SELECT * FROM [RESULT] WHERE row between ';
	set @startRow	= (@pageIndex - 1) * @pageSize + 1;
	set @endRow		= @startRow + @pageSize - 1;
    set @pagingSql	= @pagingSql + convert(varchar(10), @startRow);
	set @pagingSql	= @pagingSql + ' AND ' ;
	set @pagingSql	= @pagingSql + convert(varchar(10), @endRow);
	
	declare @sql nvarchar(max);
	set  @sql = ' ';
	
	set @sql = @table + @select + ') ' + @pagingsql;
	
	
	set @Paramlist = N'
						@isnewsletter2 CHAR(1) ,
						@name2  nvarchar(50) ,
						@published2 nchar(1) ';
	exec SP_EXECUTESQL  @sql,
						@Paramlist,
						@isnewsletter2 = @isnewsletter,
						@name2 = @name,
						@published2 = @published
						
	
	declare @Total2 int;
	set @sql = @table + @select + ') select @Total2= count(row)  from [RESULT]';
	set @Paramlist = N'
						@isnewsletter2 CHAR(1) ,
						@name2  nvarchar(50) ,
						@published2 nchar(1),
						@Total2 int out';
						
	exec sp_executeSql  @sql,
						@Paramlist, 
						@isnewsletter,
						 @name,
						 @published,
						@Total2 out
	set @total = @Total2;
	print @select
END




















GO
/****** Object:  UserDefinedFunction [dbo].[fc_GetAllChildProductcategory]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*

SELECT * FROM dbo.fc_GetAllChildProductCategory(23,1)

*/
CREATE FUNCTION [dbo].[fc_GetAllChildProductcategory] (
	@IDCategory INT
	,@unclude_me BIT = 0
	)
RETURNS @tbl_Result TABLE (
	id INT
	,parentid INT
	)
AS
BEGIN
	IF (@unclude_me = 1)
	BEGIN
		INSERT INTO @tbl_Result (
			id
			,parentid
			)
		SELECT id
			,parentid
		FROM PNK_ProductCategory WITH (NOLOCK)
		WHERE id = @IDCategory
	END

	INSERT INTO @tbl_Result (
		id
		,parentid
		)
	SELECT id
		,parentid
	FROM PNK_ProductCategory WITH (NOLOCK)
	WHERE parentid = @IDCategory;

	WHILE (1 = 1)
	BEGIN
		INSERT INTO @tbl_Result (
			id
			,parentid
			)
		SELECT id
			,parentid
		FROM PNK_ProductCategory WITH (NOLOCK)
		WHERE parentid IN (
				SELECT id
				FROM @tbl_Result
				)
			AND parentid NOT IN (
				SELECT parentid
				FROM @tbl_Result
				);

		IF @@ROWCOUNT <= 0
			BREAK
	END

	RETURN
END



















GO
/****** Object:  UserDefinedFunction [dbo].[fuCapitalizeFirstLetter]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Congtt
-- Create date: 
-- Description:	Capitalize First Letter
-- =============================================
CREATE FUNCTION [dbo].[fuCapitalizeFirstLetter] (
	--string need to format
	@string NVARCHAR(200) --increase the variable size depending on your needs.
	)
RETURNS NVARCHAR(200)
AS
BEGIN
	--Declare Variables
	DECLARE @Index INT
		,@ResultString NVARCHAR(200) --result string size should equal to the @string variable size
		--Initialize the variables

	SET @Index = 1
	SET @ResultString = ''

	--Run the Loop until END of the string
	WHILE (@Index < LEN(@string) + 1)
	BEGIN
		IF (@Index = 1) --first letter of the string
		BEGIN
			--make the first letter capital
			SET @ResultString = @ResultString + UPPER(SUBSTRING(@string, @Index, 1))
			SET @Index = @Index + 1 --increase the index
		END
				-- IF the previous character is space or '-' or next character is '-'
		ELSE IF (
				(
					SUBSTRING(@string, @Index - 1, 1) = ' '
					OR SUBSTRING(@string, @Index - 1, 1) = '-'
					OR SUBSTRING(@string, @Index + 1, 1) = '-'
					)
				AND @Index + 1 <> LEN(@string)
				)
		BEGIN
			--make the letter capital
			SET @ResultString = @ResultString + UPPER(SUBSTRING(@string, @Index, 1))
			SET @Index = @Index + 1 --increase the index
		END
		ELSE -- all others
		BEGIN
			-- make the letter simple
			SET @ResultString = @ResultString + LOWER(SUBSTRING(@string, @Index, 1))
			SET @Index = @Index + 1 --incerase the index
		END
	END --END of the loop

	IF (@@ERROR <> 0) -- any error occur return the sEND string
	BEGIN
		SET @ResultString = @string
	END

	-- IF no error found return the new string
	RETURN @ResultString
END



















GO
/****** Object:  UserDefinedFunction [dbo].[fuChuyenCoDauThanhKhongDau]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Congtt@fpt.com.vn
-- Create date: 16/09/2014
-- Description:	Chuyen tu co dau sang khong dau
-- =============================================
/*

	SELECT dbo.fuRemoveUnicode (N'hmweb Các hàm số thông dụng trong Excel')

*/
create FUNCTION [dbo].[fuChuyenCoDauThanhKhongDau] (@strInput NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS
BEGIN
	SET @strInput = rtrim(ltrim(lower(@strInput)))

	IF @strInput IS NULL
		RETURN @strInput

	IF @strInput = ''
		RETURN @strInput

	DECLARE @text NVARCHAR(50)
		, @i INT

	SET @text = '-''`~!@#$%^&*()?><:|}{,./\"''='';–'

	SELECT @i = PATINDEX('%[' + @text + ']%', @strInput)

	WHILE @i > 0
	BEGIN
		SET @strInput = replace(@strInput, substring(@strInput, @i, 1), '')
		SET @i = patindex('%[' + @text + ']%', @strInput)
	END

	SET @strInput = replace(@strInput, ' ', ' ')

	DECLARE @RT NVARCHAR(4000)
	DECLARE @SIGN_CHARS NCHAR(136)
	DECLARE @UNSIGN_CHARS NCHAR(136)

	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế
 ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý' + NCHAR(272) + NCHAR(208)
	SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee
 iiiiiooooooooooooooouuuuuuuuuuyyyyy'

	DECLARE @COUNTER INT
	DECLARE @COUNTER1 INT

	SET @COUNTER = 1

	WHILE (@COUNTER <= LEN(@strInput))
	BEGIN
		SET @COUNTER1 = 1

		WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
		BEGIN
			IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1, 1)) = UNICODE(SUBSTRING(@strInput, @COUNTER, 1))
			BEGIN
				IF @COUNTER = 1
					SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1, 1) + SUBSTRING(@strInput, @COUNTER + 1, LEN(@strInput) - 1)
				ELSE
					SET @strInput = SUBSTRING(@strInput, 1, @COUNTER - 1) + SUBSTRING(@UNSIGN_CHARS, @COUNTER1, 1) + SUBSTRING(@strInput, @COUNTER + 1, LEN(@strInput) - @COUNTER)

				BREAK
			END

			SET @COUNTER1 = @COUNTER1 + 1
		END

		SET @COUNTER = @COUNTER + 1
	END

	SET @strInput = replace(@strInput, ' ', '-')

	RETURN lower(@strInput)
END




















GO
/****** Object:  UserDefinedFunction [dbo].[GetBottomPath]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[GetBottomPath]
(
	@ordering int,
	@id int
)
RETURNS nvarchar(20)
AS
BEGIN
	declare @temp int;
	declare @t nvarchar(20);
	set @temp = 1000 - @ordering;
	set @t = REPLACE(STR(@temp, 4), SPACE(1), '0');
	return @t  + '-' + convert(varchar(3), @id);
END




















GO
/****** Object:  Table [dbo].[PNK_Banner]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Banner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Position] [tinyint] NOT NULL,
	[OutPage] [tinyint] NULL,
	[LinkUrl] [nvarchar](4000) NULL,
	[Image] [nvarchar](127) NULL,
	[Name] [nvarchar](500) NULL,
	[Detail] [nvarchar](max) NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[ClickCount] [int] NULL,
	[Ordering] [int] NOT NULL,
	[Published] [char](1) NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[ArrPageName] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_Booking]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Booking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Ordering] [int] NULL,
	[PostDate] [datetime] NOT NULL,
	[Published] [char](1) NULL,
	[UpdateDate] [datetime] NOT NULL,
	[PathTree] [nvarchar](500) NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[PhoneNumber] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[RequestTour] [nvarchar](500) NULL,
	[ExpectedDepartureDate] [nvarchar](500) NULL,
	[NumberOfAduts] [nvarchar](500) NULL,
	[NumberOfChildren] [nvarchar](500) NULL,
	[HotelType] [nvarchar](500) NULL,
	[ArrivalPort] [nvarchar](500) NULL,
	[RoomType] [nvarchar](500) NULL,
	[RoomOther] [nvarchar](500) NULL,
	[BedType] [nvarchar](500) NULL,
	[BedOther] [nvarchar](500) NULL,
	[VisaOfNeed] [nvarchar](500) NULL,
	[SpecialRequest] [nvarchar](500) NULL,
	[TravelBefore] [nvarchar](500) NULL,
	[ReceiveNewsLetters] [nvarchar](500) NULL,
	[KnowThrough] [nvarchar](500) NULL,
	[PaymentMethod] [nvarchar](500) NULL,
	[Distance] [nvarchar](100) NULL,
	[FlightArrivalNo] [nvarchar](100) NULL,
	[FlightArrivalDate] [nvarchar](500) NULL,
	[FlightArrivaTime] [nvarchar](500) NULL,
	[FlightDepartureDate] [nvarchar](500) NULL,
	[FlightDepartureTime] [nvarchar](500) NULL,
	[CustomerHeight] [nvarchar](500) NULL,
	[CustomerAge] [nvarchar](500) NULL,
	[HotelName] [nvarchar](500) NULL,
	[HotelAddress] [nvarchar](500) NULL,
	[Country] [nvarchar](50) NULL,
	[PickUpLocation] [nvarchar](2000) NULL,
	[Address] [nvarchar](2000) NULL,
	[FirstName] [nvarchar](2000) NULL,
	[LastName] [nvarchar](2000) NULL,
	[City] [nvarchar](2000) NULL,
	[NumberOfInfant] [nvarchar](2000) NULL,
	[Total] [nvarchar](50) NULL,
	[PaymentStatus] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_BookingDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_BookingDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NULL,
	[LangId] [tinyint] NULL,
	[Name] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_BookingGroup]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_BookingGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Ordering] [int] NULL,
	[GroupType] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_BookingPrice]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_BookingPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Value] [float] NULL,
	[PriceClass] [nvarchar](500) NULL,
	[ProductId] [int] NULL,
	[Ordering] [int] NULL,
	[Min] [int] NULL,
	[Max] [int] NULL,
	[GroupType] [nvarchar](500) NULL,
	[Published] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_Cities]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Cities](
	[Id] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[StateId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_Configuration]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_Configuration](
	[Key_Name] [nvarchar](50) NOT NULL,
	[Value_Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Key_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_ContentStatic]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_ContentStatic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryid] [int] NOT NULL,
	[image] [nvarchar](127) NULL,
	[published] [char](1) NULL,
	[postdate] [datetime] NOT NULL,
	[updatedate] [datetime] NOT NULL,
	[ordering] [int] NOT NULL,
	[phone] [nvarchar](500) NULL,
	[resource] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ContentStaticdesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_ContentStaticdesc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mainid] [int] NOT NULL,
	[langid] [tinyint] NOT NULL,
	[title] [nvarchar](300) NULL,
	[titleurl] [nvarchar](300) NULL,
	[brief] [nvarchar](max) NULL,
	[detail] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](512) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaDecription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_Countries]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Countries](
	[id] [int] NOT NULL,
	[sortname] [varchar](3) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[phonecode] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_Countries_Cities]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_Countries_Cities](
	[Id] [int] NOT NULL,
	[CountryId] [int] NULL,
	[Country] [nvarchar](50) NULL,
	[ISO2] [nvarchar](50) NULL,
	[ISO3] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[POP] [float] NULL,
	[Province] [nvarchar](50) NULL,
	[PhoneCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_Country]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[image] [nvarchar](127) NULL,
	[Published] [char](1) NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Ordering] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_CountryDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_CountryDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[LangId] [tinyint] NOT NULL,
	[Title] [nvarchar](300) NULL,
	[TitleUrl] [nvarchar](300) NULL,
	[Brief] [nvarchar](max) NULL,
	[Detail] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](512) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaDecription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_ExchangeRate]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_ExchangeRate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Image] [nvarchar](127) NULL,
	[Published] [char](1) NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Ordering] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ExchangeRateDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_ExchangeRateDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[LangId] [tinyint] NOT NULL,
	[Title] [nvarchar](300) NULL,
	[TitleUrl] [nvarchar](300) NULL,
	[Brief] [nvarchar](max) NULL,
	[Detail] [nvarchar](max) NULL,
	[Amount] [numeric](20, 4) NULL,
	[FromCurrency] [nvarchar](50) NULL,
	[ToCurrency] [nvarchar](50) NULL,
	[MetaTitle] [nvarchar](512) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaDecription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_Location]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Ordering] [int] NULL,
	[PostDate] [datetime] NOT NULL,
	[Published] [char](1) NULL,
	[UpdateDate] [datetime] NOT NULL,
	[PathTree] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_LocationDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_LocationDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NULL,
	[LangId] [tinyint] NULL,
	[Name] [nvarchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_Product]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Image] [nvarchar](1000) NULL,
	[Published] [char](1) NULL,
	[Hot] [char](1) NULL,
	[Feature] [char](1) NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Ordering] [int] NOT NULL,
	[LongiTude] [nvarchar](1000) NULL,
	[Latitude] [nvarchar](1000) NULL,
	[Price] [nvarchar](1000) NULL,
	[Area] [nvarchar](1000) NULL,
	[District] [nvarchar](1000) NULL,
	[Bedroom] [nvarchar](1000) NULL,
	[Bathroom] [nvarchar](1000) NULL,
	[Code] [nvarchar](1000) NULL,
	[Status] [nvarchar](1000) NULL,
	[Province] [nvarchar](1000) NULL,
	[Website] [nvarchar](1000) NULL,
	[Post] [varchar](40) NULL,
	[Cost] [nvarchar](1000) NULL,
	[UpdateBy] [nvarchar](1000) NULL,
	[Page] [varchar](max) NULL,
	[ImageType] [int] NULL,
	[ImageFont] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ProductCategory]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_ProductCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[Published] [char](1) NULL,
	[Ordering] [int] NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[PathTree] [varchar](500) NULL,
	[BaseImage] [nvarchar](255) NULL,
	[SmallImage] [nvarchar](255) NULL,
	[ThumbnailImage] [nvarchar](255) NULL,
	[Page] [nvarchar](max) NULL,
	[PageDetail] [nvarchar](max) NULL,
	[ImageType] [int] NULL,
	[ImageFont] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ProductcategoryDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_ProductcategoryDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[LangId] [tinyint] NOT NULL,
	[Name] [nvarchar](127) NULL,
	[NameUrl] [varchar](127) NULL,
	[Brief] [nvarchar](max) NULL,
	[Detail] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](512) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaDecription] [nvarchar](max) NULL,
	[H1] [nvarchar](max) NULL,
	[H2] [nvarchar](max) NULL,
	[H3] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ProductDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_ProductDesc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MainId] [int] NOT NULL,
	[LangId] [tinyint] NOT NULL,
	[Title] [nvarchar](300) NULL,
	[Brief] [nvarchar](max) NULL,
	[Detail] [nvarchar](max) NULL,
	[Require] [nvarchar](max) NULL,
	[TitleUrl] [nvarchar](300) NULL,
	[Position] [nvarchar](max) NULL,
	[Utility] [nvarchar](max) NULL,
	[Design] [nvarchar](max) NULL,
	[Pictures] [nvarchar](max) NULL,
	[Payment] [nvarchar](max) NULL,
	[Contact] [nvarchar](max) NULL,
	[Metadescription] [nvarchar](max) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](max) NULL,
	[H1] [nvarchar](max) NULL,
	[H2] [nvarchar](max) NULL,
	[H3] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_ProgramTour]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_ProgramTour](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoryid] [int] NOT NULL,
	[image] [nvarchar](127) NULL,
	[published] [char](1) NULL,
	[postdate] [datetime] NOT NULL,
	[updatedate] [datetime] NOT NULL,
	[ordering] [int] NOT NULL,
	[phone] [nvarchar](500) NULL,
	[resource] [nvarchar](max) NULL,
	[ImageType] [int] NULL,
	[ImageFont] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_ProgramTourDesc]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_ProgramTourDesc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mainid] [int] NOT NULL,
	[langid] [tinyint] NOT NULL,
	[title] [nvarchar](300) NULL,
	[titleurl] [nvarchar](300) NULL,
	[brief] [nvarchar](max) NULL,
	[detail] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](512) NULL,
	[MetaKeyword] [nvarchar](max) NULL,
	[MetaDecription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PNK_States]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_States](
	[Id] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[CountryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_UploadImage]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_UploadImage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Published] [char](1) NULL,
	[ImagePath] [nvarchar](1000) NULL,
	[Ordering] [int] NULL,
	[PostDate] [datetime] NULL,
	[Updatedate] [datetime] NULL,
	[ProductId] [int] NULL,
	[Type] [int] NULL,
	[LongiTude] [varchar](200) NULL,
	[Latitude] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_User]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PNK_User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](200) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](255) NULL,
	[Email] [varchar](50) NOT NULL,
	[IsNewsletter] [char](1) NULL,
	[Role] [tinyint] NOT NULL,
	[Published] [char](1) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Token] [varchar](32) NULL,
	[Mobile] [varchar](20) NULL,
	[LocationId] [int] NULL,
	[Image] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PNK_VatGroup]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PNK_VatGroup](
	[Id] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[VATPercent] [int] NULL,
	[LastDate] [nchar](8) NULL,
	[UserId] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sd_xml]    Script Date: 15/04/2017 10:28:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sd_xml](
	[id] [int] NOT NULL,
	[xmlcontent] [xml] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[PNK_Banner] ON 

INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (10, 1, 0, NULL, N'blx-d-n0829082016113534.jpg', NULL, NULL, NULL, NULL, 1, 1, N'1', CAST(0x0000A6370005A362 AS DateTime), CAST(0x0000A672009F1CAB AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (11, 1, 0, NULL, N'blx-d-n0329082016113559.jpg', NULL, NULL, NULL, NULL, 1, 2, N'1', CAST(0x0000A637015AFC01 AS DateTime), CAST(0x0000A672009F21D2 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (12, 1, 0, N'http://www.google.com', N'slide-125082016025526.jpg', NULL, NULL, NULL, NULL, 1, 3, N'1', CAST(0x0000A637015B06A0 AS DateTime), CAST(0x0000A672009F262C AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (13, 1, 0, N'htttp://www.google.com', N'easy-design-slider2p1b29082016053836.jpg', NULL, NULL, NULL, NULL, 1, 4, N'1', CAST(0x0000A637015B0E8D AS DateTime), CAST(0x0000A672009F2A99 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (14, 2, 1, N'http://flc-twintowers.com.vn/', N'logo108092016085421.png', NULL, NULL, NULL, NULL, 1, 5, N'1', CAST(0x0000A67B0092C554 AS DateTime), CAST(0x0000A67B009322C4 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (15, 2, 1, N'http://www.muongthanh.com/', N'mtlogogroup08092016085732.png', NULL, NULL, NULL, NULL, 1, 6, N'1', CAST(0x0000A67B0093AC0F AS DateTime), CAST(0x0000A67B0093AC0F AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (16, 2, 1, N'http://flcquynhon.com.vn/en/home/', N'logo (1)08092016085808.png', NULL, NULL, NULL, NULL, 1, 7, N'1', CAST(0x0000A67B0093D5B4 AS DateTime), CAST(0x0000A67B0093D5B4 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (18, 2, 0, N'http://bepdongduong.vn/', N'bepdon21092016034636.png', NULL, NULL, NULL, NULL, 1, 9, N'1', CAST(0x0000A68801041465 AS DateTime), CAST(0x0000A6F000FDC8A5 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (19, 2, 0, NULL, N'vinamilk121092016034702.png', NULL, NULL, NULL, NULL, 1, 10, N'1', CAST(0x0000A68801042469 AS DateTime), CAST(0x0000A68801042469 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (20, 2, 0, NULL, N'hongha21092016034722.png', NULL, NULL, NULL, NULL, 1, 11, N'1', CAST(0x0000A688010437F8 AS DateTime), CAST(0x0000A688010437F8 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (21, 2, 1, N'mediamart.vn', N'2016-12-28_16592703012017034041.jpg', NULL, NULL, NULL, NULL, 1, 12, N'1', CAST(0x0000A688010445D9 AS DateTime), CAST(0x0000A6F00102B790 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (22, 2, 0, N'www.winline.vn', N'logo-121092016034756.jpg', NULL, NULL, NULL, NULL, 1, 13, N'1', CAST(0x0000A688010460C1 AS DateTime), CAST(0x0000A6F000FCFB24 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (23, 2, 1, N'http://songtra-motor.com/', N'2016-12-28_16592703012017034041.jpg', NULL, NULL, NULL, NULL, 1, 14, N'1', CAST(0x0000A68801047683 AS DateTime), CAST(0x0000A6F00102A86B AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (24, 2, 0, NULL, N'rico21092016034838.png', NULL, NULL, NULL, NULL, 1, 15, N'1', CAST(0x0000A68801049391 AS DateTime), CAST(0x0000A68801049391 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (25, 2, 1, N'http://saigontrans.com.vn/', N'2016-12-28_16592703012017034041.jpg', NULL, NULL, NULL, NULL, 1, 16, N'1', CAST(0x0000A6880105BA69 AS DateTime), CAST(0x0000A6F001029977 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (26, 2, 0, N'http://www.ananacomputer.com/', N'news_1410176131_385693_408819282473145_266148719_n21092016035306.jpg', NULL, NULL, NULL, NULL, 1, 17, N'1', CAST(0x0000A6880105CB31 AS DateTime), CAST(0x0000A6F000FC30E5 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (27, 2, 0, N'http://www.collagengfc.com/', N'2014-11-18_11301321092016035322.png', NULL, NULL, NULL, NULL, 1, 18, N'1', CAST(0x0000A6880105DD4F AS DateTime), CAST(0x0000A6F000FB8CC7 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (28, 2, 0, N'http://www.mobiistar.vn/', N'news_1410766454_mobiistar21092016035337.jpg', NULL, NULL, NULL, NULL, 1, 19, N'1', CAST(0x0000A6880105EFD0 AS DateTime), CAST(0x0000A6F000FAB6ED AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (29, 2, 1, N'http://nemvanthanh.vn/vi/', N'news_1410972499_VanThanh21092016035350.jpg', NULL, NULL, NULL, NULL, 1, 20, N'1', CAST(0x0000A6880105FD07 AS DateTime), CAST(0x0000A6ED01062403 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (30, 2, 1, N'http://haiyencomputer.vn/', N'2016-12-28_16592703012017034041.jpg', NULL, NULL, NULL, NULL, 1, 21, N'1', CAST(0x0000A6880106227D AS DateTime), CAST(0x0000A6F001028D56 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (31, 2, 1, N'www.nongduochai.com', N'2016-12-28_16592703012017034041.jpg', NULL, NULL, NULL, NULL, 1, 22, N'1', CAST(0x0000A6F000FE6F03 AS DateTime), CAST(0x0000A6F0010263EB AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (32, 2, 1, N'http://bba.vn', N'logo-bo-ba-2-03012017034020.jpg', NULL, NULL, NULL, NULL, 1, 23, N'1', CAST(0x0000A6F000FEA74E AS DateTime), CAST(0x0000A6F001024B03 AS DateTime), N'tmp')
INSERT [dbo].[PNK_Banner] ([Id], [Position], [OutPage], [LinkUrl], [Image], [Name], [Detail], [Height], [Width], [ClickCount], [Ordering], [Published], [PostDate], [UpdateDate], [ArrPageName]) VALUES (33, 2, 1, N'http://vietnamcyclingtours.vn/', N'logoVNT03012017033121.jpg', NULL, NULL, NULL, NULL, 1, 24, N'1', CAST(0x0000A6F000FEDE03 AS DateTime), CAST(0x0000A6F000FFD273 AS DateTime), N'tmp')
SET IDENTITY_INSERT [dbo].[PNK_Banner] OFF
SET IDENTITY_INSERT [dbo].[PNK_BookingGroup] ON 

INSERT [dbo].[PNK_BookingGroup] ([Id], [Name], [Ordering], [GroupType]) VALUES (1, N'foody', NULL, NULL)
SET IDENTITY_INSERT [dbo].[PNK_BookingGroup] OFF
SET IDENTITY_INSERT [dbo].[PNK_BookingPrice] ON 

INSERT [dbo].[PNK_BookingPrice] ([ID], [Name], [Value], [PriceClass], [ProductId], [Ordering], [Min], [Max], [GroupType], [Published]) VALUES (1, N'a', 109000, N'a', 3212, 2, 1, 2, N'foody', N'1')
SET IDENTITY_INSERT [dbo].[PNK_BookingPrice] OFF
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_address_en', N'14 villages, communes Dambri Bao Loc - Lam Dong')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_address_vi', N'<strong>Lầu 07, Số 34 Hoàng Việt</strong><br> Quận Tân Bình, TP.HCM')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_address1_en', N'Thôn 14 xã Đambri Bảo Lộc - Lâm Đồng')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_address1_vi', N'Addr: 7th floor, No 34 Hoang Viet,  Ward 4, Tan Binh District, Ho Chi Minh City')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_analytic', N'21')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_company_name_en', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_company_name_vi', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_email', N'<strong>nvtrinh@epmdesigns.com</strong><br>support@epmdesigns.com')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_fax', N'093 8283846')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_fbfanpage', N'https://www.facebook.com/facebook')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_fblike', NULL)
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_footer', N'<div class="col-md-6">
<div class="footer-navi">www.epmdesigns.com @&nbsp;2016 All Rights Reserved.</div>
</div>

<div class="col-md-6">
<div class="footer-navi floatright">&nbsp;</div>
</div>
')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_h1', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_h2', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_h3', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_latitude', N'10.3517932')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_location', N'635681135622382720p4DLx.jpg')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_logoFooter', N'636086267956917642y5BFo.png')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_logoHeader', N'636276360402033666b7NZz.png')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_longitude', N'106.3682486')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_phone', N'<strong>093 8283846</strong><br> 0903 971772')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_rate', NULL)
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_sitename', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_skypeid', N'AM: 08h -12h, PM 13h30-17h30')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_time', N'6h00 AM-19h00 PM')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_working', N'Thời gian làm việc')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'config_yahooid', N'<p><span style="font-size:14px;">Ch&uacute;ng t&ocirc;i l&agrave; những Anh Em lu&ocirc;n lu&ocirc;n kh&ocirc;ng ngừng ph&aacute;t triển khoa học c&ocirc;ng nghệ. Tập thể c&aacute;n bộ, kỹ sư EPM &nbsp;l&agrave; một đội ngũ trẻ, được đ&agrave;o tạo b&agrave;i bản, chuy&ecirc;n nghiệp nhiều kinh nghiệm triển khai c&aacute;c dự &aacute;n Thương mại điện tử, B2C, B2B, C&aacute;c dự &aacute;n Marketing Online&nbsp;cho doanhh nghiệp, c&oacute; ho&agrave;i b&atilde;o, say m&ecirc; chinh phục khoa học c&ocirc;ng nghệ v&agrave; lu&ocirc;n lao động hết m&igrave;nh để phục vụ kh&aacute;ch h&agrave;ng.&nbsp;</span></p>
')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'googleplus', N'https://plus.google.com/u/0/')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'metaDescription', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'metaKeyword', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'title', N'Foody')
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'twitter', NULL)
INSERT [dbo].[PNK_Configuration] ([Key_Name], [Value_Name]) VALUES (N'vchat', N'2')
SET IDENTITY_INSERT [dbo].[PNK_ContentStatic] ON 

INSERT [dbo].[PNK_ContentStatic] ([id], [categoryid], [image], [published], [postdate], [updatedate], [ordering], [phone], [resource]) VALUES (7, 1, N'IMG_108623082016112706_R.jpg', N'1', CAST(0x0000A66B00B72D6D AS DateTime), CAST(0x0000A68801726F32 AS DateTime), 1, N'33', NULL)
INSERT [dbo].[PNK_ContentStatic] ([id], [categoryid], [image], [published], [postdate], [updatedate], [ordering], [phone], [resource]) VALUES (8, 1, NULL, N'1', CAST(0x0000A6790108B67C AS DateTime), CAST(0x0000A6F2000D2EDD AS DateTime), 2, N'33', NULL)
INSERT [dbo].[PNK_ContentStatic] ([id], [categoryid], [image], [published], [postdate], [updatedate], [ordering], [phone], [resource]) VALUES (9, 1, NULL, N'1', CAST(0x0000A67901100033 AS DateTime), CAST(0x0000A68701425906 AS DateTime), 3, N'33', NULL)
INSERT [dbo].[PNK_ContentStatic] ([id], [categoryid], [image], [published], [postdate], [updatedate], [ordering], [phone], [resource]) VALUES (10, 1, NULL, N'1', CAST(0x0000A6790113FFA2 AS DateTime), CAST(0x0000A67B01080429 AS DateTime), 4, N'33', NULL)
SET IDENTITY_INSERT [dbo].[PNK_ContentStatic] OFF
SET IDENTITY_INSERT [dbo].[PNK_ContentStaticdesc] ON 

INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (13, 7, 1, N'Count', NULL, NULL, N'<section class="blox  dark      w-animate  w-start_animation" style=" padding-top:80px; padding-bottom:14px; background-size: cover; min-height:px;  background-color:#00c2e5;">
<div class="max-overlay" style="background-color:">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="99" data-effecttype="counter"><i class="icon-counter sl-badge"></i><span class="max-count">99</span><span class="suf-counter">%</span>

<h5>SATISFIED CUSTOMRES</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="18" data-effecttype="counter"><i class="icon-counter sl-trophy"></i><span class="max-count">18</span>

<h5>WINNING AWARDS</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="206" data-effecttype="counter"><i class="icon-counter sl-layers"></i><span class="max-count">206</span>

<h5>EPMCMS INSTALLS</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="73" data-effecttype="counter"><i class="icon-counter sl-cup"></i><span class="max-count">73</span>

<h5>DAILY COFFE</h5>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (14, 7, 2, N'1', NULL, NULL, N'<section class="blox  dark      w-animate  w-start_animation" style=" padding-top:80px; padding-bottom:14px; background-size: cover; min-height:px;  background-color:#00c2e5;">
<div class="max-overlay" style="background-color:">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="99" data-effecttype="counter"><i class="icon-counter sl-badge"></i><span class="max-count">99</span><span class="suf-counter">%</span>

<h5>SATISFIED CUSTOMRES</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="18" data-effecttype="counter"><i class="icon-counter sl-trophy"></i><span class="max-count">18</span>

<h5>WINNING AWARDS</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="206" data-effecttype="counter"><i class="icon-counter sl-layers"></i><span class="max-count">206</span>

<h5>WORDPRESS INSTALLS</h5>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="f-counter max-counter counted" data-counter="73" data-effecttype="counter"><i class="icon-counter sl-cup"></i><span class="max-count">73</span>

<h5>DAILY COFFE</h5>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (15, 8, 1, N'Hãy để chúng tôi giúp bạn', NULL, N'<p>Ch&uacute;ng t&ocirc;i sẽ gi&uacute;p bạn đạt được mục ti&ecirc;u của m&igrave;nh v&agrave; ph&aacute;t triển doanh nghiệp của bạn.</p>
', N'<section class="parallax-sec dark  blox aligncenter w-animate  w-start_animation" data-stellar-background-ratio="0.7" style=" background: url(&quot;/Images/blx-d-p04.jpg&quot;) ;">
<div class="wpb_row vc_row-fluid " data-stellar-ratio="1" style="top: 0px;">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-8">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<hr class="vertical-space2" />
<div class="wpb_text_column wpb_content_element  wpb_animate_when_almost_visible wpb_appear wpb_start_animation">
<div class="wpb_wrapper">
<h4 style="text-align: center; font-size: 44px;"><strong>H&atilde;y để ch&uacute;ng t&ocirc;i gi&uacute;p bạn?</strong></h4>

<p style="text-align: center; font-size: 16px;">Ch&uacute;ng t&ocirc;i sẽ gi&uacute;p bạn đạt được mục ti&ecirc;u của m&igrave;nh v&agrave; ph&aacute;t triển doanh nghiệp của bạn.</p>
</div>
</div>
<a class="button theme-skin large" href="/yeu-cau/vn" target="_blank">Gửi y&ecirc;u cầu cho ch&uacute;ng t&ocirc;i</a>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" /></div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (16, 8, 2, N'Hãy để chúng tôi giúp bạn', NULL, N'<p>Ch&uacute;ng t&ocirc;i sẽ gi&uacute;p bạn đạt được mục ti&ecirc;u của m&igrave;nh v&agrave; ph&aacute;t triển doanh nghiệp của bạn.</p>
', N'<section class="parallax-sec dark  blox aligncenter w-animate  w-start_animation" data-stellar-background-ratio="0.7" style="padding-bottom: 40px; background: url(&quot;/Images/blx-d-p04.jpg&quot;) 50% -25.8px / cover no-repeat;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid " data-stellar-ratio="1" style="top: 0px;">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-8">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<hr class="vertical-space2" />
<div class="wpb_text_column wpb_content_element  wpb_animate_when_almost_visible wpb_appear wpb_start_animation">
<div class="wpb_wrapper">
<h4 style="text-align: center; font-size: 44px;"><strong>Let us help you?</strong></h4>

<p style="text-align: center; font-size: 16px;">We will help you achieve your goals and grow your business.</p>
</div>
</div>
<a class="button theme-skin large" href="/yeu-cau/vn" target="_blank">Send request to us</a>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" /></div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (17, 9, 1, N'Mọi thứ trở nên đơn giản', NULL, NULL, N'<section class="blox  dark      w-animate  w-start_animation" style="padding-top: px; padding-bottom: px; background: url(''/Images/pt-bg02.jpg'') repeat; background-position: center center; min-height: px; background-color: #00c2e5;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="aligncenter wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h2 style="text-align: center;">Mọi thứ trở n&ecirc;n đơn giản</h2>

<p style="text-align: center;">Ch&uacute;ng t&ocirc;i đang x&acirc;y dựng c&acirc;y cầu web để kết nối mục ti&ecirc;u của kh&aacute;ch h&agrave;ng với thực tế</p>
</div>
</div>
<a class="button white  medium bordered-bot " href="/giao-dien/vn" id="ctl00_mainContent_ctl00_hypTemplate" target="_blank">C&aacute;c website ti&ecirc;u biểu</a></div>
</div>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (18, 9, 2, N'Everything becomes simple', NULL, NULL, N'<section class="blox  dark      w-animate  w-start_animation" style="padding-top: px; padding-bottom: px; background: url(''/Images/pt-bg02.jpg'') repeat; background-position: center center; min-height: px; background-color: #00c2e5;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="aligncenter wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h2 style="text-align: center;">Everything becomes simple</h2>

<p style="text-align: center;">We are building bridges to connect the web client goals with reality</p>
</div>
</div>
<a class="button white  medium bordered-bot " href="/giao-dien/vn" target="_blank">The representative website</a></div>
</div>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</div>
</div>
</section>
', NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (19, 10, 1, N'Slogan', NULL, N'<p style="text-align: center;"><span style="font-size:48px;line-height: 70px;">Ch&uacute;ng t&ocirc;i l&agrave; c&ocirc;ng ty thiết kế<br />
&nbsp;s&aacute;ng tạo v&agrave; niềm đam m&ecirc; c&ocirc;ng nghệ.</span></p>
', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ContentStaticdesc] ([id], [mainid], [langid], [title], [titleurl], [brief], [detail], [MetaTitle], [MetaKeyword], [MetaDecription]) VALUES (20, 10, 2, N'Slogan', NULL, N'<h1>We are a creative agency<br />
with a passion for design.</h1>
', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PNK_ContentStaticdesc] OFF
SET IDENTITY_INSERT [dbo].[PNK_Product] ON 

INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3, 3, N'crop_green-landscape-nature-full-HD-wallpaper22052015010413.jpg', N'1', N'1', N'0', CAST(0x0000A47101850F88 AS DateTime), CAST(0x0000A4A00011AE99 AS DateTime), 3, NULL, NULL, N'12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (5, 3, N'crop_a22052015010351.jpg', N'1', N'1', N'0', CAST(0x0000A485017B5580 AS DateTime), CAST(0x0000A56A00FFEC45 AS DateTime), 9, NULL, NULL, N'1', N'SD125042015110051.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (9, 3, N'k02012016073107.jpg', N'1', N'1', N'0', CAST(0x0000A48A015890D4 AS DateTime), CAST(0x0000A5810143820D AS DateTime), 1, NULL, NULL, N'1', N'Salary-Report-VN_230042015085401.pdf', NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'1', NULL, N'1', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (11, 3, N'crop_mediterranean-beach-wallpaper22052015010216.jpg', N'1', N'1', N'0', CAST(0x0000A48A01591936 AS DateTime), CAST(0x0000A4A000112594 AS DateTime), 1, NULL, NULL, N'121', N'BG330042015085543.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'1', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (15, 0, NULL, N'1', N'1', N'0', CAST(0x0000A4AD017E4696 AS DateTime), CAST(0x0000A4AD017E4696 AS DateTime), 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (20, 0, N'crop_12704062015115823.jpg', N'0', N'0', N'0', CAST(0x0000A4AE0000BA9B AS DateTime), CAST(0x0000A4AE0000BA9B AS DateTime), 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (25, 0, NULL, N'1', N'0', N'0', CAST(0x0000A4FB0187C59D AS DateTime), CAST(0x0000A4FB0187C59D AS DateTime), 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (26, 0, N'crop_h21082015114646.jpg', N'1', N'0', N'0', CAST(0x0000A4FB0187E865 AS DateTime), CAST(0x0000A4FB0187E865 AS DateTime), 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (27, 0, NULL, N'1', N'0', N'0', CAST(0x0000A4FB01882B25 AS DateTime), CAST(0x0000A4FB01882B25 AS DateTime), 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (28, 0, NULL, N'1', N'0', N'0', CAST(0x0000A4FB01885ADB AS DateTime), CAST(0x0000A4FB01885ADB AS DateTime), 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2044, 0, N'chanly27022016121125.jpg', N'1', N'0', N'0', CAST(0x0000A5B900C8E863 AS DateTime), CAST(0x0000A5B900C90447 AS DateTime), 36, NULL, NULL, N'1', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2045, 0, N'chanly27022016121236.jpg', N'1', N'0', N'0', CAST(0x0000A5B900C93B74 AS DateTime), CAST(0x0000A5B900C97BA7 AS DateTime), 37, NULL, NULL, N'1', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2046, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CA9AAD AS DateTime), CAST(0x0000A5B900CABE01 AS DateTime), 38, NULL, NULL, N'0', N'0', N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2047, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CAF743 AS DateTime), CAST(0x0000A5B900CAFB24 AS DateTime), 39, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2048, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CB6DD9 AS DateTime), CAST(0x0000A5B900CB9118 AS DateTime), 40, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2049, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CBBC03 AS DateTime), CAST(0x0000A5B900CBD48C AS DateTime), 41, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2050, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CC2C5C AS DateTime), CAST(0x0000A5B900CC4BC7 AS DateTime), 42, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2051, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CC905B AS DateTime), CAST(0x0000A5B900CCAB20 AS DateTime), 43, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (2052, 0, NULL, N'1', N'0', N'0', CAST(0x0000A5B900CDF0E4 AS DateTime), CAST(0x0000A5B900CEB45B AS DateTime), 44, NULL, NULL, N'0', N'0', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/Category.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3044, 5, N'a03052016043532_R.jpg', N'0', N'1', N'1', CAST(0x0000A5FA0184E9EC AS DateTime), CAST(0x0000A60E017D3A6D AS DateTime), 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/Blog/blog.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3045, 6, N'j03052016044930_R.jpg', N'1', N'0', N'0', CAST(0x0000A5FA018A4307 AS DateTime), CAST(0x0000A5FB0115483B AS DateTime), 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3046, 5, N'p22052016111950_R.jpg', N'1', N'0', N'0', CAST(0x0000A60E01807F80 AS DateTime), CAST(0x0000A60E01807F80 AS DateTime), 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/Blog/blog.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3047, 5, N'Watch22052016112007_R.jpg', N'1', N'0', N'0', CAST(0x0000A60E01809BAA AS DateTime), CAST(0x0000A60E0180AA53 AS DateTime), 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/Blog/blog.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3048, 10, N'theme_129052016022953_R.png', N'0', N'0', N'0', CAST(0x0000A610006EB233 AS DateTime), CAST(0x0000A61500293223 AS DateTime), 49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3050, 0, NULL, N'1', N'0', N'0', CAST(0x0000A619000CFD77 AS DateTime), CAST(0x0000A619000CFD77 AS DateTime), 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3051, 18, N'CÔNG TY TNHH XUẤT NHẬP KHẨU TM MINH THÁI08062016114626_R.png', N'0', N'0', N'0', CAST(0x0000A619000D10D9 AS DateTime), CAST(0x0000A61F0187CE36 AS DateTime), 51, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3053, 0, NULL, N'1', N'1', N'1', CAST(0x0000A62E01894827 AS DateTime), CAST(0x0000A62E01894827 AS DateTime), 52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3055, 0, N'Cicle23062016115245_R.png', N'1', N'0', N'0', CAST(0x0000A62E018A7334 AS DateTime), CAST(0x0000A62E018A7334 AS DateTime), 53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3058, 0, N'eespacer327062016112441_R.jpg', N'1', N'0', N'0', CAST(0x0000A6320181D1CD AS DateTime), CAST(0x0000A6320181D1CD AS DateTime), 57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3060, 36, N'history429062016011045_R.jpg', N'1', N'0', N'0', CAST(0x0000A63400D93F66 AS DateTime), CAST(0x0000A63400D93F66 AS DateTime), 58, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3062, 41, N'owatonna29062016011405_R.jpg', N'1', N'0', N'0', CAST(0x0000A63400DBB06F AS DateTime), CAST(0x0000A63400DBB06F AS DateTime), 60, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3067, 50, N'testimonials_img_29d4502072016121802.jpg', N'1', N'0', N'0', CAST(0x0000A6360171F99B AS DateTime), CAST(0x0000A6370004F771 AS DateTime), 65, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3068, 50, N'testimonials_img_302072016121753.jpg', N'1', N'0', N'0', CAST(0x0000A636017587BE AS DateTime), CAST(0x0000A6370004EC8D AS DateTime), 66, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3072, 0, N'vision-exercise-104072016045032_R.jpg', N'1', N'0', N'0', CAST(0x0000A63901181EB6 AS DateTime), CAST(0x0000A63901181EB6 AS DateTime), 70, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3074, 0, N'value04072016053645.jpg', N'1', N'0', N'0', CAST(0x0000A639012253C9 AS DateTime), CAST(0x0000A639012253C9 AS DateTime), 72, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3080, 41, NULL, N'1', N'0', N'0', CAST(0x0000A6400171E322 AS DateTime), CAST(0x0000A6400171E322 AS DateTime), 77, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3081, 0, NULL, N'1', N'0', N'0', CAST(0x0000A6400185A45D AS DateTime), CAST(0x0000A6400185A45D AS DateTime), 78, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3082, 41, NULL, N'1', N'0', N'0', CAST(0x0000A6400185AE01 AS DateTime), CAST(0x0000A6400185AE01 AS DateTime), 79, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3083, 32, NULL, N'1', N'0', N'0', CAST(0x0000A6400185B6C2 AS DateTime), CAST(0x0000A6400185B6C2 AS DateTime), 80, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3084, 41, NULL, N'1', N'0', N'0', CAST(0x0000A6400185BEFF AS DateTime), CAST(0x0000A6400185BEFF AS DateTime), 81, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3090, 31, N'65894914072016045413_R.jpg', N'0', N'0', N'0', CAST(0x0000A64301169425 AS DateTime), CAST(0x0000A6430116C37B AS DateTime), 86, NULL, NULL, N'0', NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/BlogManagement/BlogDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3092, 61, N'Task LV15072016010413.jpg', N'1', N'0', N'0', CAST(0x0000A644001187BE AS DateTime), CAST(0x0000A6450000D634 AS DateTime), 88, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/ResourceMangement/Resource.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3093, 0, NULL, N'1', N'0', N'0', CAST(0x0000A6450005CEC2 AS DateTime), CAST(0x0000A6450005CEC2 AS DateTime), 89, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3095, 0, NULL, N'1', N'0', N'0', CAST(0x0000A65C017D6C78 AS DateTime), CAST(0x0000A65C017D6C78 AS DateTime), 90, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3096, 63, N'ipad-2-air-perspective-mockup-graphictwister-118082016044102.jpg', N'1', N'0', N'0', CAST(0x0000A65C017EF5AA AS DateTime), CAST(0x0000A6660112F371 AS DateTime), 91, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/TemplateManagement/TemplateDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3097, 63, N'FeaturedImage18082016044005.jpg', N'1', N'1', N'1', CAST(0x0000A65D000B6F9C AS DateTime), CAST(0x0000A6660112B07D AS DateTime), 92, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/TemplateManagement/TemplateDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3098, 64, N'blx-d-p0631082016101058.jpg', N'1', N'0', N'0', CAST(0x0000A65D00101DB5 AS DateTime), CAST(0x0000A68F01888DCF AS DateTime), 93, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3099, 72, NULL, N'1', N'0', N'0', CAST(0x0000A65D0023F88F AS DateTime), CAST(0x0000A67A010A4A06 AS DateTime), 94, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3100, 71, NULL, N'1', N'0', N'0', CAST(0x0000A664010F58F3 AS DateTime), CAST(0x0000A66401533619 AS DateTime), 95, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3101, 74, N'xedap_master15102016012732.jpg', N'1', N'0', N'0', CAST(0x0000A664014E4BE6 AS DateTime), CAST(0x0000A6A00018388B AS DateTime), 96, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3103, 66, NULL, N'1', N'0', N'0', CAST(0x0000A66901847198 AS DateTime), CAST(0x0000A67A0108C59A AS DateTime), 98, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="li_vallet" ></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3106, 75, NULL, N'1', N'0', N'0', CAST(0x0000A66B010EC77D AS DateTime), CAST(0x0000A67C00096421 AS DateTime), 101, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3107, 75, N'gear25082016051618.png', N'1', N'0', N'0', CAST(0x0000A66B010EDAA5 AS DateTime), CAST(0x0000A67C00094EC2 AS DateTime), 102, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3108, 75, N'hw-ico-123082016045404.png', N'1', N'0', N'0', CAST(0x0000A66B010EEE13 AS DateTime), CAST(0x0000A67C00005FE7 AS DateTime), 103, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3109, 76, N'tc-manq-223082016093015.jpg', N'1', N'0', N'0', CAST(0x0000A66B016250D3 AS DateTime), CAST(0x0000A67A016D8426 AS DateTime), 104, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3110, 0, NULL, N'1', N'0', N'0', CAST(0x0000A66B01656A5E AS DateTime), CAST(0x0000A66B01656A5E AS DateTime), 105, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3112, 0, NULL, N'1', N'0', N'0', CAST(0x0000A66B01658DB6 AS DateTime), CAST(0x0000A66B01658DB6 AS DateTime), 107, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3116, 77, NULL, N'1', N'0', N'0', CAST(0x0000A66B0165D6C4 AS DateTime), CAST(0x0000A6ED010A06F7 AS DateTime), 111, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3117, 65, N'easy-design-slider1p825082016121327.jpg', N'1', N'0', N'0', CAST(0x0000A66C010C3E03 AS DateTime), CAST(0x0000A66D0003B4E2 AS DateTime), 112, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3118, 80, N'blg-pg-blx225082016121314.jpg', N'1', N'0', N'0', CAST(0x0000A66C01806E76 AS DateTime), CAST(0x0000A68E00ECB4A0 AS DateTime), 113, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CompanyManagement/CompanyDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3119, 0, NULL, N'1', N'0', N'0', CAST(0x0000A67101820B1E AS DateTime), CAST(0x0000A67101820B1E AS DateTime), 114, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3120, 66, N'blx-d-p09jpg03092016103603.jpg', N'1', N'0', N'0', CAST(0x0000A67101824AF9 AS DateTime), CAST(0x0000A67A01091DD9 AS DateTime), 115, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="li_t-shirt" ></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3121, 66, NULL, N'1', N'0', N'0', CAST(0x0000A67101829544 AS DateTime), CAST(0x0000A674000D5003 AS DateTime), 116, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="li_bulb" ></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3122, 81, NULL, N'1', N'0', N'0', CAST(0x0000A672000029B7 AS DateTime), CAST(0x0000A6790103A6DE AS DateTime), 117, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3123, 88, N'blx-d-p1204092016014813.jpg', N'1', N'0', N'1', CAST(0x0000A67200FA50B1 AS DateTime), CAST(0x0000A67C00021401 AS DateTime), 118, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-screen-desktop" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3124, 89, N'blx-d-n03 (1)04092016020050.jpg', N'1', N'0', N'1', CAST(0x0000A67200FA618B AS DateTime), CAST(0x0000A67C00004ABC AS DateTime), 119, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-layers" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3125, 90, N'blx-d-p1104092016020648.jpg', N'1', N'0', N'1', CAST(0x0000A67200FA6FE5 AS DateTime), CAST(0x0000A6860112B344 AS DateTime), 120, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-equalizer" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3127, 84, N'flc20092016083316.png', N'1', N'0', N'0', CAST(0x0000A6720112F361 AS DateTime), CAST(0x0000A6870171EE56 AS DateTime), 122, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3128, 86, N'01_large20092016041049.jpg', N'1', N'0', N'0', CAST(0x0000A6720126AC76 AS DateTime), CAST(0x0000A687010AAF94 AS DateTime), 123, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3129, 108, N'01_master20092016094439.jpg', N'1', N'0', N'0', CAST(0x0000A672012705CD AS DateTime), CAST(0x0000A68700A1CDE0 AS DateTime), 124, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3131, 91, N'blx-d-p14 (1)04092016020757.jpg', N'1', N'0', N'1', CAST(0x0000A67700E8E949 AS DateTime), CAST(0x0000A67C00024650 AS DateTime), 126, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-globe-alt" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3132, 92, N'blx-d-p14 (1)04092016020918.jpg', N'1', N'0', N'1', CAST(0x0000A67700E947D7 AS DateTime), CAST(0x0000A67A000C2A20 AS DateTime), 127, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-mouse" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3133, 93, N'blx-d-n0408092016033956.jpg', N'1', N'0', N'1', CAST(0x0000A67700E974D5 AS DateTime), CAST(0x0000A7530171A791 AS DateTime), 128, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-mouse" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3135, 99, N'blg-n1-420x33006092016022632.jpg', N'1', N'0', N'0', CAST(0x0000A67900EE45BE AS DateTime), CAST(0x0000A67B009D38FF AS DateTime), 130, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3136, 98, N'blg-n2-420x33006092016023805.jpg', N'1', N'0', N'0', CAST(0x0000A67900F1540B AS DateTime), CAST(0x0000A67B009D3088 AS DateTime), 131, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3137, 0, N'blog13-420x33006092016023936.jpg', N'1', N'0', N'0', CAST(0x0000A67900F1AA99 AS DateTime), CAST(0x0000A67900F1AA99 AS DateTime), 132, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3138, 95, N'blog13-420x33006092016024008.jpg', N'1', N'0', N'0', CAST(0x0000A67900F1CD85 AS DateTime), CAST(0x0000A67B009D2876 AS DateTime), 133, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3139, 0, NULL, N'1', N'0', N'0', CAST(0x0000A67B0008DDB9 AS DateTime), CAST(0x0000A67B0008DDB9 AS DateTime), 134, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3140, 96, N'1208092016123911.jpg', N'1', N'0', N'0', CAST(0x0000A67B00095299 AS DateTime), CAST(0x0000A67B009D1B9A AS DateTime), 135, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3141, 96, N'108092016011551.jpg', N'1', N'0', N'0', CAST(0x0000A67B0014DC0C AS DateTime), CAST(0x0000A67B009D11FF AS DateTime), 136, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3142, 104, N'blx-d-p1108092016035206.jpg', N'1', N'0', N'0', CAST(0x0000A67B00A6624D AS DateTime), CAST(0x0000A686010DFCD6 AS DateTime), 137, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3143, 103, N'blx-d-n0408092016041152.jpg', N'1', N'0', N'0', CAST(0x0000A67B00A6930A AS DateTime), CAST(0x0000A686010C9F41 AS DateTime), 138, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3144, 107, N'blx-d-n0408092016045734.jpg', N'1', N'0', N'1', CAST(0x0000A67B010F498D AS DateTime), CAST(0x0000A75301813834 AS DateTime), 139, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 2, N'<i class="sl-globe-alt" style=""></i>')
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3145, 0, NULL, N'1', N'0', N'0', CAST(0x0000A67C0003BA8E AS DateTime), CAST(0x0000A67C0003BA8E AS DateTime), 140, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3146, 106, N'blx-d-n0409092016122759.jpg', N'1', N'0', N'0', CAST(0x0000A67C00049E1A AS DateTime), CAST(0x0000A686011039E9 AS DateTime), 141, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3147, 105, N'blx-d-n0409092016124136.jpg', N'1', N'0', N'0', CAST(0x0000A67C000A53ED AS DateTime), CAST(0x0000A686010D862E AS DateTime), 142, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3148, 102, N'blx-d-p1609092016011249.jpg', N'1', N'0', N'0', CAST(0x0000A67C00137742 AS DateTime), CAST(0x0000A69200E9028F AS DateTime), 143, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3149, 0, N'20160331092110546_dd68a306dab043519128e247bf66a1cc20092016041246.jpeg', N'1', N'0', N'0', CAST(0x0000A687010B37BD AS DateTime), CAST(0x0000A687010B37BD AS DateTime), 144, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3150, 87, N'20160331092110546_dd68a306dab043519128e247bf66a1cc20092016041730.jpeg', N'1', N'0', N'0', CAST(0x0000A687010C820D AS DateTime), CAST(0x0000A687010C820D AS DateTime), 145, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3151, 84, N'01_large20092016041940.jpg', N'1', N'0', N'0', CAST(0x0000A687010D1897 AS DateTime), CAST(0x0000A687011450A3 AS DateTime), 146, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3152, 87, N'20160328151017002_09e89a45cf6842a38c571dbedae3a7f620092016042040.jpeg', N'1', N'0', N'0', CAST(0x0000A687010D60CF AS DateTime), CAST(0x0000A687010D60CF AS DateTime), 147, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3153, 87, N'20160913162046027_e9e1da76fbb44a39aa6d50c4563818b720092016042113.jpeg', N'1', N'0', N'0', CAST(0x0000A687010D8527 AS DateTime), CAST(0x0000A687010D8527 AS DateTime), 148, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3154, 0, N'20160315095046296_ca70edbcfb26458a9d74c59f1e1cc4ba20092016042745.jpeg', N'1', N'0', N'0', CAST(0x0000A687010F515B AS DateTime), CAST(0x0000A687010F515B AS DateTime), 149, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3155, 109, N'20160401081937109_f15a590adb13474ca9121212600adcac20092016042848.jpeg', N'1', N'0', N'0', CAST(0x0000A687010F98BA AS DateTime), CAST(0x0000A687010F98BA AS DateTime), 150, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3156, 109, N'20160315095046296_ca70edbcfb26458a9d74c59f1e1cc4ba20092016043011.jpeg', N'1', N'0', N'0', CAST(0x0000A687010FFE02 AS DateTime), CAST(0x0000A687010FFE02 AS DateTime), 151, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3157, 84, N'20160401082024687_760312900d364cf7a6511b544de265ae20092016043335.jpeg', N'1', N'0', N'0', CAST(0x0000A6870110E990 AS DateTime), CAST(0x0000A6870110E990 AS DateTime), 152, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3158, 110, N'20160315095624437_4a046a42f5654ef18161aef4f434e4a420092016043645.jpeg', N'1', N'0', N'0', CAST(0x0000A6870111C860 AS DateTime), CAST(0x0000A68701793A4F AS DateTime), 153, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3159, 84, N'01_624352af-5a7b-4c01-7f1e-ec876c935038_master20092016043725.png', N'1', N'0', N'0', CAST(0x0000A68701120C88 AS DateTime), CAST(0x0000A68701120C88 AS DateTime), 154, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3160, 110, N'20160826155802675_17d74ed00b784fe79a7a4af7b07436c420092016050914.jpeg', N'1', N'0', N'0', CAST(0x0000A687011AB6DD AS DateTime), CAST(0x0000A687011AB6DD AS DateTime), 155, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
GO
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3161, 110, N'20160331110011093_3595712b7bca49f68832054422b88b8420092016051005.jpeg', N'1', N'0', N'0', CAST(0x0000A687011B0A30 AS DateTime), CAST(0x0000A687011B0A30 AS DateTime), 156, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3162, 110, N'20160315095624437_4a046a42f5654ef18161aef4f434e4a420092016051145.jpeg', N'1', N'0', N'0', CAST(0x0000A687011B6B72 AS DateTime), CAST(0x0000A687011B6B72 AS DateTime), 157, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3163, 110, N'01_large (1)20092016051238.jpg', N'1', N'0', N'0', CAST(0x0000A687011BA566 AS DateTime), CAST(0x0000A687011BA566 AS DateTime), 158, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3164, 0, N'20160503102301105_3160f0172ef4433ba98cc713de7b958320092016100708.jpeg', N'1', N'0', N'0', CAST(0x0000A687016C8C6D AS DateTime), CAST(0x0000A687016C8C6D AS DateTime), 159, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3165, 110, N'20160622152807154_72c6168f60cc4bfea7a6e01005f5eca620092016100758.jpeg', N'1', N'0', N'0', CAST(0x0000A687016CE11A AS DateTime), CAST(0x0000A687016CE11A AS DateTime), 160, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3166, 110, N'20160826160045309_e8d2f3b8d58e4558861bfd5771e1c86c20092016101018.jpeg', N'1', N'0', N'0', CAST(0x0000A687016D68E2 AS DateTime), CAST(0x0000A687016D68E2 AS DateTime), 161, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3167, 109, N'01_master20092016101137.png', N'1', N'0', N'0', CAST(0x0000A687016DE2EE AS DateTime), CAST(0x0000A687016DE2EE AS DateTime), 162, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3168, 109, N'20160406154559921_95e1fc133ba4436bbeddc27b054b36fb20092016101411.jpeg', N'1', N'0', N'0', CAST(0x0000A687016E7DD4 AS DateTime), CAST(0x0000A687016E7DD4 AS DateTime), 163, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3169, 109, N'20160331104113265_e1908f1c1fef4d4595bf0b574ec3864d20092016101545.jpeg', N'1', N'0', N'0', CAST(0x0000A687016EE32A AS DateTime), CAST(0x0000A687016EE32A AS DateTime), 164, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3170, 0, N'01_100eb5e0-d820-4d41-4875-84cb09e7eb59_large20092016102239.jpg', N'1', N'0', N'0', CAST(0x0000A6870170C863 AS DateTime), CAST(0x0000A6870170C863 AS DateTime), 165, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3171, 0, N'20160915080848382_209545ef07a849ebaac77b29cd7e53e720092016102251.jpeg', N'1', N'0', N'0', CAST(0x0000A6870170F0E6 AS DateTime), CAST(0x0000A6870170F0E6 AS DateTime), 166, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3172, 108, N'01_100eb5e0-d820-4d41-4875-84cb09e7eb59_master20092016102426.jpg', N'1', N'0', N'0', CAST(0x0000A687017150DC AS DateTime), CAST(0x0000A687017150DC AS DateTime), 167, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3173, 108, N'20160915080848382_209545ef07a849ebaac77b29cd7e53e720092016102525.jpeg', N'1', N'0', N'0', CAST(0x0000A68701718C04 AS DateTime), CAST(0x0000A68701718C04 AS DateTime), 168, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3174, 108, N'01_master20092016102852.png', N'1', N'0', N'0', CAST(0x0000A6870172A77D AS DateTime), CAST(0x0000A6870172A77D AS DateTime), 169, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3175, 84, N'01_e4eaa41f-c7ef-4159-51c6-01f0ba826f4f_master20092016103103.jpg', N'1', N'0', N'0', CAST(0x0000A687017337DC AS DateTime), CAST(0x0000A687017337DC AS DateTime), 170, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3176, 84, N'01_3b5a7452-bc31-4368-472d-4dc356bef57e_large20092016103306.jpg', N'1', N'0', N'0', CAST(0x0000A6870173B968 AS DateTime), CAST(0x0000A6870173B968 AS DateTime), 171, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3177, 86, N'01_aed2635e-3d14-4025-7a23-9a0516f8d920_large20092016105014.jpg', N'1', N'0', N'1', CAST(0x0000A6870178774D AS DateTime), CAST(0x0000A688011D22A2 AS DateTime), 172, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3178, 86, N'01_c7965107-7b2e-4c33-6f76-d1fdd8c85f18_large20092016105106.jpg', N'1', N'0', N'0', CAST(0x0000A6870178C933 AS DateTime), CAST(0x0000A6870178C933 AS DateTime), 173, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3179, 86, N'ST giay dep thoi trang MT20092016105221.jpg', N'1', N'0', N'0', CAST(0x0000A6870179099B AS DateTime), CAST(0x0000A6870179099B AS DateTime), 174, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3180, 86, N'Me va be 2_master20092016105851.jpg', N'1', N'0', N'1', CAST(0x0000A687017AD68E AS DateTime), CAST(0x0000A688011CD313 AS DateTime), 175, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3181, 86, N'me va be MT 20092016105948.jpg', N'1', N'0', N'0', CAST(0x0000A687017B1244 AS DateTime), CAST(0x0000A687017B1244 AS DateTime), 176, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3182, 111, N'01_master20092016110745.jpg', N'1', N'0', N'0', CAST(0x0000A687017D4D72 AS DateTime), CAST(0x0000A687017D4D72 AS DateTime), 177, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3183, 111, N'20160728162500033_62d65a0807ef43c5b306483a6c76f4f520092016110847.jpeg', N'1', N'0', N'0', CAST(0x0000A687017D8D78 AS DateTime), CAST(0x0000A687017D8D78 AS DateTime), 178, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3184, 111, N'20160831173028635_196ce59c99764f398674a357f612ba1620092016110924.jpeg', N'1', N'0', N'1', CAST(0x0000A687017DBAE4 AS DateTime), CAST(0x0000A688011C8EB3 AS DateTime), 179, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3185, 111, N'20160906135520693_4d9b1fc935424738a4b9ab8a06ff305120092016111034.jpeg', N'1', N'0', N'0', CAST(0x0000A687017E07AE AS DateTime), CAST(0x0000A687017E07AE AS DateTime), 180, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3186, 111, N'20160315145214953_9429feb1fd464934b638c4b50236b02920092016111224.png', N'1', N'0', N'0', CAST(0x0000A687017E7488 AS DateTime), CAST(0x0000A687017E7488 AS DateTime), 181, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3187, 111, N'20160310132601156_baaea497d879445baa5750711c1f7b2220092016111403.png', N'1', N'0', N'1', CAST(0x0000A687017EE7CB AS DateTime), CAST(0x0000A688011D8FBA AS DateTime), 182, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3188, 85, N'20160331105845390_2e983d7bc2a945139c7485417497433b20092016112112.jpeg', N'1', N'0', N'0', CAST(0x0000A6870180FBAF AS DateTime), CAST(0x0000A687018212AD AS DateTime), 183, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3189, 85, N'20160315094906125_f14bb17e8f794cba92878e353897edc420092016112159.jpeg', N'1', N'0', N'0', CAST(0x0000A687018136FD AS DateTime), CAST(0x0000A687018136FD AS DateTime), 184, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3190, 85, N'01_master20092016112257.jpg', N'1', N'0', N'1', CAST(0x0000A68701817048 AS DateTime), CAST(0x0000A68800BDB90B AS DateTime), 185, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3191, 74, N'kidsland_desktop_master20092016112337.jpg', N'1', N'0', N'1', CAST(0x0000A6870181B7FC AS DateTime), CAST(0x0000A68800BDB5FE AS DateTime), 186, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3192, 85, N'20160315095440875_b9aad9d1bfaf4bea867a8a9bbe1ff36920092016112448.jpeg', N'1', N'0', N'0', CAST(0x0000A687018204FC AS DateTime), CAST(0x0000A687018204FC AS DateTime), 187, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3193, 85, N'20160720145652417_ada4eed7a6cc4c76ae8fb630016a5bec20092016112932.jpeg', N'1', N'0', N'0', CAST(0x0000A687018345F0 AS DateTime), CAST(0x0000A687018345F0 AS DateTime), 188, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3194, 74, N'desert (1)14042017101022.jpg', N'1', N'0', N'1', CAST(0x0000A6870185BE33 AS DateTime), CAST(0x0000A75500A7A9D4 AS DateTime), 189, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3195, 74, N'desert14042017100932.jpg', N'1', N'0', N'1', CAST(0x0000A6870185FAFF AS DateTime), CAST(0x0000A75500A76F83 AS DateTime), 190, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3196, 74, N'lunch-big14042017100834.jpg', N'1', N'0', N'1', CAST(0x0000A68701862735 AS DateTime), CAST(0x0000A75500A72921 AS DateTime), 191, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3197, 97, N'127092016101327.jpg', N'1', N'0', N'0', CAST(0x0000A68E016E088F AS DateTime), CAST(0x0000A68E016EFA21 AS DateTime), 192, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3198, 98, N'ban-hang-hieu-qua-0327092016101935.jpg', N'1', N'0', N'0', CAST(0x0000A68E016FF04E AS DateTime), CAST(0x0000A68E016FF04E AS DateTime), 193, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3199, 98, N'Hang-ton-kho-227092016102422.jpg', N'1', N'0', N'0', CAST(0x0000A68E0171409B AS DateTime), CAST(0x0000A68E0171409B AS DateTime), 194, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3200, 95, N'82-Kinh_nghiem_vang_cua_nguoi_thanh_cong_anh_0127092016103354_R.jpg', N'1', N'0', N'0', CAST(0x0000A68E01728379 AS DateTime), CAST(0x0000A68E0173E860 AS DateTime), 195, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3201, 95, N'kinh-nghiem-vang-tu-nguoi-thanh-cong-0127092016103324_R.jpg', N'1', N'0', N'0', CAST(0x0000A68E01735722 AS DateTime), CAST(0x0000A68E0173C5FD AS DateTime), 196, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3202, 99, N'quang-cao-online-anh-0327092016103929.png', N'1', N'0', N'0', CAST(0x0000A68E017567C6 AS DateTime), CAST(0x0000A68E0175C686 AS DateTime), 197, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3203, 99, N'quang-cao-online-0327092016104332.jpg', N'1', N'0', N'0', CAST(0x0000A68E0176835F AS DateTime), CAST(0x0000A68E0176C591 AS DateTime), 198, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3204, 96, N'xu-huong-kinh-doanh-0327092016104631.jpg', N'1', N'0', N'0', CAST(0x0000A68E0177580B AS DateTime), CAST(0x0000A68E0177580B AS DateTime), 199, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3205, 76, N'kinh-nghiem-vang-tu-nguoi-thanh-cong-0127092016105008.jpg', N'1', N'0', N'0', CAST(0x0000A68E01785E2C AS DateTime), CAST(0x0000A68E017936F8 AS DateTime), 200, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3206, 76, N'1436751381-tu-van-tuyen-sinh-tieng-anh--16627092016105207.jpg', N'1', N'0', N'0', CAST(0x0000A68E0178E3F9 AS DateTime), CAST(0x0000A68E0178E3F9 AS DateTime), 201, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3207, 76, N'av_327092016105458.jpg', N'1', N'0', N'0', CAST(0x0000A68E0179AA57 AS DateTime), CAST(0x0000A6ED010AF24D AS DateTime), 202, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3208, 99, N'19-Quan_ly_van_hanh_anh_0327092016111027.png', N'1', N'0', N'0', CAST(0x0000A68E017DE9B6 AS DateTime), CAST(0x0000A68E0180B4EE AS DateTime), 203, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3209, 109, N'01_master ruou01102016024424.png', N'1', N'0', N'0', CAST(0x0000A69200F2F37C AS DateTime), CAST(0x0000A69200F2F37C AS DateTime), 204, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3210, 0, N'01_fa21d760-266a-4758-69fd-24f507e7496c_master01102016030052.png', N'1', N'0', N'0', CAST(0x0000A69200F77A4A AS DateTime), CAST(0x0000A69200F77A4A AS DateTime), 205, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3211, 0, N'01_e18736d4-2362-4b9d-525a-16931abdaca9_large14102016114418.jpg', N'1', N'0', N'1', CAST(0x0000A69F01873EED AS DateTime), CAST(0x0000A69F01873EE9 AS DateTime), 206, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3212, 87, N'breakfast14042017100745.jpg', N'1', N'0', N'1', CAST(0x0000A69F01891A39 AS DateTime), CAST(0x0000A75500A6FC05 AS DateTime), 207, NULL, NULL, N'0', N'Half Day', NULL, N'5:00PM - 10:00PM', N'0', NULL, NULL, N'Day Trips', N'12', N'10', N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3213, 0, N'01_37624c2e-8070-4b99-689a-e98a184d28ff_large15102016125614.jpg', N'1', N'0', N'0', CAST(0x0000A6A0000F7F28 AS DateTime), CAST(0x0000A6A0000F7F28 AS DateTime), 208, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3214, 0, N'01_bbda73c4-112b-427d-69c2-91b5cf136632_master15102016010255.jpg', N'1', N'0', N'0', CAST(0x0000A6A000114FDE AS DateTime), CAST(0x0000A6A000114FDE AS DateTime), 209, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3215, 86, N'01_bbda73c4-112b-427d-69c2-91b5cf136632_master15102016010849.jpg', N'1', N'0', N'0', CAST(0x0000A6A00012EC33 AS DateTime), CAST(0x0000A6A00012EC33 AS DateTime), 210, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3216, 87, N'01_998d3c06-7afa-432f-6934-499854f72796_master15102016011043.png', N'1', N'0', N'0', CAST(0x0000A6A00013985D AS DateTime), CAST(0x0000A6A00013985D AS DateTime), 211, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3217, 87, N'01_4d9d3d5d-4984-4254-733c-2cf5e5987765_master15102016012259.jpg', N'1', N'0', N'0', CAST(0x0000A6A00016D013 AS DateTime), CAST(0x0000A6A00016D013 AS DateTime), 212, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3218, 85, N'01_f71bc4e4-6863-413e-4b89-838f23f7fb44_master15102016013311.jpg', N'1', N'0', N'0', CAST(0x0000A6A00019A622 AS DateTime), CAST(0x0000A6A00019A622 AS DateTime), 213, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3219, 87, N'01_mastershop my pham15102016073631.jpg', N'1', N'0', N'0', CAST(0x0000A6A0007D694E AS DateTime), CAST(0x0000A6A0007D694E AS DateTime), 214, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3220, 87, N'81_master15102016073735.png', N'1', N'0', N'0', CAST(0x0000A6A0007DB673 AS DateTime), CAST(0x0000A6A0007DB673 AS DateTime), 215, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3221, 108, N'01_46b9df60-2905-4959-46d3-2a217bcb102c_master15102016074434.png', N'1', N'0', N'0', CAST(0x0000A6A0007F737E AS DateTime), CAST(0x0000A6A0007FA0E7 AS DateTime), 216, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3222, 118, N'01_66d3bdb1-856a-49da-59c8-6443c82710eb_master15102016074736.jpg', N'1', N'0', N'1', CAST(0x0000A6A0007F7F4D AS DateTime), CAST(0x0000A75301795E82 AS DateTime), 217, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3223, 118, N'01_988239e1-95e2-4162-4d5f-bb685991d85b_master15102016074927.jpg', N'1', N'0', N'1', CAST(0x0000A6A00080F527 AS DateTime), CAST(0x0000A7530179572F AS DateTime), 218, NULL, NULL, N'0', N'Half Day', NULL, NULL, N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'congtt', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3224, 0, NULL, N'1', N'0', N'0', CAST(0x0000A6A6017950CC AS DateTime), CAST(0x0000A6A6017950CC AS DateTime), 219, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', NULL, 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3225, 112, N'up_rest24102016045704.jpg', N'1', N'0', N'0', CAST(0x0000A6A601799005 AS DateTime), CAST(0x0000A6A901176266 AS DateTime), 220, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3226, 113, N'slider-imagesPOS (1)18112016093722.jpg', N'1', N'0', N'0', CAST(0x0000A6A6017A55D3 AS DateTime), CAST(0x0000A6C3000B5F59 AS DateTime), 221, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/ServiceManagement/Service.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3227, 115, N'blx-d-n0418112016093353.jpg', N'1', N'0', N'0', CAST(0x0000A6A6017EA280 AS DateTime), CAST(0x0000A6C3000AB125 AS DateTime), 222, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3228, 114, N'blx-d-n0418112016095437.jpg', N'1', N'0', N'0', CAST(0x0000A6A6017EBFDC AS DateTime), CAST(0x0000A6C3000E001D AS DateTime), 223, NULL, NULL, N'0', NULL, NULL, NULL, N'0', NULL, NULL, NULL, NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3229, 116, N'blx-d-n0418112016102734.jpg', N'1', N'0', N'0', CAST(0x0000A6C200AC4753 AS DateTime), CAST(0x0000A75401762343 AS DateTime), 224, NULL, NULL, N'0', N'Half Day', NULL, N'5:00PM - 10:00PM', N'0', NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'admin', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_Product] ([Id], [CategoryId], [Image], [Published], [Hot], [Feature], [PostDate], [UpdateDate], [Ordering], [LongiTude], [Latitude], [Price], [Area], [District], [Bedroom], [Bathroom], [Code], [Status], [Province], [Website], [Post], [Cost], [UpdateBy], [Page], [ImageType], [ImageFont]) VALUES (3230, 117, N'blg-n1-720x38812042017091758.jpg', N'1', N'1', N'1', CAST(0x0000A753000D0A69 AS DateTime), CAST(0x0000A75300994487 AS DateTime), 225, NULL, NULL, N'0', N'Half Day', NULL, NULL, NULL, NULL, NULL, N'Day Trips', NULL, NULL, N'1', N'congtt', N'Pages/GalleryManagement/Video.ascx', 1, NULL)
SET IDENTITY_INSERT [dbo].[PNK_Product] OFF
SET IDENTITY_INSERT [dbo].[PNK_ProductCategory] ON 

INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (42, 0, N'0', 1, CAST(0x0000A63400E00B6E AS DateTime), CAST(0x0000A755010AF7E7 AS DateTime), N'.0999-42', N'vision-exercise-104072016051233.jpg', N'0', NULL, N'Pages/home.ascx', N'Pages/home.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (62, 0, N'0', 4, CAST(0x0000A65C00B01F5B AS DateTime), CAST(0x0000A6A6017862B7 AS DateTime), N'.0996-62', N'blx-d-p09jpg03092016103635.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (64, 0, N'1', 2, CAST(0x0000A65D000FE4FA AS DateTime), CAST(0x0000A7550109EB45 AS DateTime), N'.0998-64', N'blx-d-p14 (1)04092016111405.jpg', N'0', NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (65, 0, N'0', 5, CAST(0x0000A65D00138B48 AS DateTime), CAST(0x0000A674000C224A AS DateTime), N'.0995-65', NULL, NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (66, 0, N'0', 6, CAST(0x0000A65D00139E95 AS DateTime), CAST(0x0000A679010712CD AS DateTime), N'.0994-66', NULL, NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (68, 0, N'1', 23, CAST(0x0000A65D0013BB8F AS DateTime), CAST(0x0000A755010A61D3 AS DateTime), N'.0977-68', N'blx-d-p13 (1)06092016094242.jpg', N'0', NULL, N'Pages/contact/contact.ascx', N'Pages/contact/contact.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (72, 0, N'0', 12, CAST(0x0000A65D0023857B AS DateTime), CAST(0x0000A674000F1813 AS DateTime), N'.0988-72', NULL, NULL, NULL, N'Pages/CategoryManagement/Category.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (73, 0, N'0', 13, CAST(0x0000A6610168AF58 AS DateTime), CAST(0x0000A66A01849C7E AS DateTime), N'.0987-73', NULL, NULL, NULL, N'Pages/SearchManagement/search.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (74, 62, N'1', 14, CAST(0x0000A664014E361A AS DateTime), CAST(0x0000A6760175BD91 AS DateTime), N'.0997-62.0986-74', N'blx-d-p09jpg03092016104043.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (75, 0, N'0', 15, CAST(0x0000A66B010EA178 AS DateTime), CAST(0x0000A6720004C461 AS DateTime), N'.0985-75', NULL, NULL, NULL, N'Pages/CategoryManagement/Category.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', NULL, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (76, 0, N'0', 16, CAST(0x0000A66B0125639D AS DateTime), CAST(0x0000A68801763437 AS DateTime), N'.0984-76', NULL, NULL, NULL, N'Pages/CategoryManagement/Category.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (77, 0, N'0', 17, CAST(0x0000A66B01650364 AS DateTime), CAST(0x0000A67A0109CDF5 AS DateTime), N'.0983-77', NULL, NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (80, 0, N'0', 18, CAST(0x0000A66C017F7455 AS DateTime), CAST(0x0000A6A601774BFB AS DateTime), N'.0982-80', N'blx-d-p06 (1)03092016110340.jpg', NULL, NULL, N'Pages/CompanyManagement/CompanyDetail.ascx', N'Pages/CompanyManagement/CompanyDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (81, 0, N'0', 19, CAST(0x0000A671018B6C4C AS DateTime), CAST(0x0000A67B00FF7CED AS DateTime), N'.0981-81', N'blx-d-p1108092016033009.jpg', NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (82, 0, N'1', 3, CAST(0x0000A67200FA0877 AS DateTime), CAST(0x0000A75401870608 AS DateTime), N'.0997-82', N'blx-d-p06 (1)03092016110506.jpg', N'0', NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (83, 0, N'0', 21, CAST(0x0000A672010961B5 AS DateTime), CAST(0x0000A67301765246 AS DateTime), N'.0979-83', N'blx-d-p0631082016104249.jpg', NULL, NULL, N'Pages/contact/request.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, N'aaa')
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (84, 62, N'1', 22, CAST(0x0000A6720112A174 AS DateTime), CAST(0x0000A687009E1997 AS DateTime), N'.0997-62.0978-84', N'blx-d-p09jpg03092016104033.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (85, 62, N'1', 23, CAST(0x0000A6720114CF06 AS DateTime), CAST(0x0000A68701807E70 AS DateTime), N'.0997-62.0977-85', N'blx-d-p09jpg03092016103814.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (86, 62, N'1', 24, CAST(0x0000A67201150C65 AS DateTime), CAST(0x0000A687009E8F99 AS DateTime), N'.0997-62.0976-86', N'blx-d-p09jpg03092016103804.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/TemplateDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (87, 62, N'1', 25, CAST(0x0000A67201268EC6 AS DateTime), CAST(0x0000A755000274FB AS DateTime), N'.0996-62.0975-87', N'blx-d-p09jpg03092016103706.jpg', N'0', NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (88, 82, N'1', 26, CAST(0x0000A67700DCCDFA AS DateTime), CAST(0x0000A67B0188F103 AS DateTime), N'.0997-82.0974-88', N'blx-d-p09jpg0309201609303704092016014742.jpg', NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (89, 82, N'1', 27, CAST(0x0000A67700E6A9C2 AS DateTime), CAST(0x0000A67B01891A87 AS DateTime), N'.0997-82.0973-89', NULL, NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (90, 82, N'1', 28, CAST(0x0000A67700E80694 AS DateTime), CAST(0x0000A67B0189E94F AS DateTime), N'.0997-82.0972-90', NULL, NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (91, 82, N'1', 29, CAST(0x0000A67700E8BBD8 AS DateTime), CAST(0x0000A67B018ABF33 AS DateTime), N'.0997-82.0971-91', N'blx-d-n0408092016033804.jpg', NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (92, 82, N'1', 30, CAST(0x0000A67700E927F7 AS DateTime), CAST(0x0000A67B00FFAE2B AS DateTime), N'.0997-82.0970-92', N'blx-d-p1108092016033052.jpg', NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (93, 82, N'1', 31, CAST(0x0000A67700E963F6 AS DateTime), CAST(0x0000A67B018A1E6F AS DateTime), N'.0997-82.0969-93', N'blx-d-n0408092016033848.jpg', NULL, NULL, N'Pages/CategoryManagement/CategoryDetail.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (94, 0, N'1', 22, CAST(0x0000A67701843D77 AS DateTime), CAST(0x0000A755010A8F0D AS DateTime), N'.0978-94', N'easy-design-slider2p606092016022909.jpg', N'0', NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (95, 94, N'1', 32, CAST(0x0000A67B009CA114 AS DateTime), CAST(0x0000A68E016D443E AS DateTime), N'.0978-94.0968-95', N'blx-d-n0808092016093432.jpg', NULL, NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (96, 94, N'1', 33, CAST(0x0000A67B009CC777 AS DateTime), CAST(0x0000A68E016C53A8 AS DateTime), N'.0978-94.0967-96', N'blx-d-p1308092016093557.jpg', NULL, NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (97, 94, N'1', 34, CAST(0x0000A67B009CD66D AS DateTime), CAST(0x0000A68E016C7FA4 AS DateTime), N'.0978-94.0966-97', N'blx-d-p14 (1)08092016093516.jpg', NULL, NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (98, 94, N'1', 35, CAST(0x0000A67B009CE553 AS DateTime), CAST(0x0000A68E016CEC3B AS DateTime), N'.0978-94.0965-98', N'easy-design-slider2p608092016093357.jpg', NULL, NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (99, 94, N'1', 36, CAST(0x0000A67B009CF3A8 AS DateTime), CAST(0x0000A68E016CFC51 AS DateTime), N'.0978-94.0964-99', N'blx-d-p14 (1)08092016093317.jpg', NULL, NULL, N'Pages/BlogManagement/Blog.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (100, 0, N'0', 4, CAST(0x0000A67B00A37B76 AS DateTime), CAST(0x0000A69000A9E0C6 AS DateTime), N'.0996-100', N'bannerdv08092016112259.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (101, 0, N'1', 2, CAST(0x0000A67B00A4AD99 AS DateTime), CAST(0x0000A755010A3462 AS DateTime), N'.0998-101', NULL, N'0', NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/ServiceManagement/Service.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (102, 100, N'1', 37, CAST(0x0000A67B00A8F64B AS DateTime), CAST(0x0000A67F00994AD8 AS DateTime), N'.0996-100.0963-102', N'blx-d-p1608092016032243.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (103, 100, N'1', 38, CAST(0x0000A67B00B463E7 AS DateTime), CAST(0x0000A67F009A3413 AS DateTime), N'.0996-100.0962-103', N'blx-d-p1608092016032213.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (104, 100, N'1', 39, CAST(0x0000A67B00B4D28A AS DateTime), CAST(0x0000A67F009B5E51 AS DateTime), N'.0996-100.0961-104', N'bannerdv08092016112209.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (105, 100, N'1', 40, CAST(0x0000A67B00B4F9A9 AS DateTime), CAST(0x0000A68F0179CBF2 AS DateTime), N'.0996-100.0960-105', N'blx-d-p1608092016032134.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/BlogManagement/BlogDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (106, 82, N'1', 29, CAST(0x0000A67B00B578D4 AS DateTime), CAST(0x0000A67B00FE6C57 AS DateTime), N'.0997-82.0971-106', N'blx-d-p1608092016032616.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (107, 82, N'1', 28, CAST(0x0000A67B00B59FD2 AS DateTime), CAST(0x0000A67B00FF5E01 AS DateTime), N'.0997-82.0972-107', N'blx-d-p1108092016032940.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (108, 62, N'1', 41, CAST(0x0000A687009D98C8 AS DateTime), CAST(0x0000A68701705B10 AS DateTime), N'.0997-62.0959-108', N'blx-d-p1620092016102106.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (109, 62, N'1', 42, CAST(0x0000A687010EBB31 AS DateTime), CAST(0x0000A687011D03BF AS DateTime), N'.0997-62.0958-109', N'blx-d-p1620092016051739.jpg', NULL, NULL, N'Pages/CategoryManagement/Category.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (110, 62, N'1', 43, CAST(0x0000A687011A740A AS DateTime), CAST(0x0000A687011CDE6E AS DateTime), N'.0997-62.0957-110', N'blx-d-p1120092016051708.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (111, 62, N'1', 44, CAST(0x0000A687017BF5FF AS DateTime), CAST(0x0000A687017C80F4 AS DateTime), N'.0997-62.0956-111', N'blx-d-p1120092016110347.jpg', NULL, NULL, N'Pages/TemplateManagement/Template.ascx', N'Pages/TemplateManagement/Template.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (112, 101, N'1', 45, CAST(0x0000A6A6017AE105 AS DateTime), CAST(0x0000A6A901161F8B AS DateTime), N'.0998-101.0955-112', N'slider-imagesPOS (1)24102016045230.jpg', NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (113, 101, N'1', 46, CAST(0x0000A6A6017B392F AS DateTime), CAST(0x0000A6A6017B392F AS DateTime), N'.0998-101.0954-113', NULL, NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/ServiceManagement/Service.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (114, 101, N'1', 47, CAST(0x0000A6A6017C7C79 AS DateTime), CAST(0x0000A6A6017C979B AS DateTime), N'.0998-101.0953-114', NULL, NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (115, 101, N'1', 48, CAST(0x0000A6A6017D0388 AS DateTime), CAST(0x0000A6A6017D0388 AS DateTime), N'.0998-101.0952-115', NULL, NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (116, 101, N'1', 49, CAST(0x0000A6A6017FD749 AS DateTime), CAST(0x0000A6A6017FD749 AS DateTime), N'.0998-101.0951-116', NULL, NULL, NULL, N'Pages/ServiceManagement/Service.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (117, 0, N'1', 50, CAST(0x0000A75300097326 AS DateTime), CAST(0x0000A75300097326 AS DateTime), N'.0950-117', NULL, NULL, NULL, N'Pages/GalleryManagement/Video.ascx', N'Pages/GalleryManagement/Video.ascx', 1, NULL)
INSERT [dbo].[PNK_ProductCategory] ([Id], [ParentId], [Published], [Ordering], [PostDate], [UpdateDate], [PathTree], [BaseImage], [SmallImage], [ThumbnailImage], [Page], [PageDetail], [ImageType], [ImageFont]) VALUES (118, 0, N'1', 51, CAST(0x0000A75301793954 AS DateTime), CAST(0x0000A75301793954 AS DateTime), N'.0949-118', NULL, NULL, NULL, N'Pages/CategoryManagement/Category.ascx', N'Pages/CategoryManagement/CategoryDetail.ascx', 1, NULL)
SET IDENTITY_INSERT [dbo].[PNK_ProductCategory] OFF
SET IDENTITY_INSERT [dbo].[PNK_ProductcategoryDesc] ON 

INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (83, 42, 1, N'Trang chủ', N'trang-chu', NULL, NULL, N'Trang chủ', N'Trang chủ', N'Trang chủ', N'Trang chủ', N'Trang chủ', N'Trang chủ')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (84, 42, 2, N'home', N'home', NULL, NULL, N'home', N'home', N'home', N'home', N'home', N'home')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (123, 62, 1, N'giao diện', N'giao-dien', N'CHỌN MẪU THIẾT KẾ BẠN YÊU THÍCH', N'<p>Sản phẩm</p>
', N'giao diện', N'giao diện', N'giao diện', N'giao diện', N'giao diện', N'giao diện')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (124, 62, 2, N'Template', N'template', NULL, NULL, N'Template', N'Template', N'Template', N'Template', N'Template', N'Template')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (127, 64, 1, N'About us', N'about-us', N'About us', NULL, N'About us', N'About us', N'About us', N'About us', N'About us', N'About us')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (128, 64, 2, N'Introduction', N'introduction', NULL, NULL, N'Introduction', N'Introduction', N'Introduction', N'Introduction', N'Introduction', N'Introduction')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (129, 65, 1, N'web lưu trữ', N'web-luu-tru', NULL, NULL, N'web lưu trữ', N'web lưu trữ', N'web lưu trữ', N'web lưu trữ', N'web lưu trữ', N'web lưu trữ')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (130, 65, 2, N'Web Hosting', N'web-hosting', NULL, NULL, N'Web Hosting', N'Web Hosting', N'Web Hosting', N'Web Hosting', N'Web Hosting', N'Web Hosting')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (131, 66, 1, N'Tính năng', N'tinh-nang', NULL, NULL, N'Tính năng', N'Tính năng', N'Tính năng', N'Tính năng', N'Tính năng', N'Tính năng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (132, 66, 2, N'Function', N'function', NULL, NULL, N'Function', N'Function', N'Function', N'Function', N'Function', N'Function')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (135, 68, 1, N'Contact ', N'contact-', N'Contact ', NULL, N'Contact', N'Contact', N'Contact', N'Contact', N'Contact', N'Contact')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (136, 68, 2, N'Contact', N'contact', NULL, NULL, N'Contact', N'Contact', N'Contact', N'Contact', N'Contact', N'Contact')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (143, 72, 1, N'Khách hàng', N'khach-hang', N'Các dự án thực hiện', NULL, N'Khách hàng', N'Khách hàng', N'Khách hàng', N'Khách hàng', N'Khách hàng', N'Khách hàng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (144, 72, 2, N'Slogan', N'slogan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (145, 73, 1, N'Tìm kiếm', N'tim-kiem', NULL, NULL, N'Tìm kiếm', N'Tìm kiếm', N'Tìm kiếm', N'Tìm kiếm', N'Tìm kiếm', N'Tìm kiếm')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (146, 73, 2, N'Search', N'search', NULL, NULL, N'Search', N'Search', N'Search', N'Search', N'Search', N'Search')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (147, 74, 1, N'Thủ công - Mỹ nghệ - Quà tặng', N'thu-cong--my-nghe--qua-tang', N'Thủ công - Mỹ nghệ - Quà tặng', NULL, N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (148, 74, 2, N'Thủ công - Mỹ nghệ - Quà tặng', N'thu-cong--my-nghe--qua-tang', N'Thủ công - Mỹ nghệ - Quà tặng', NULL, N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng', N'Thủ công - Mỹ nghệ - Quà tặng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (149, 75, 1, N'LỢI ÍCH', N'loi-ich', N'KHÁM PHÁ CÁC LỢI ÍCH MANG LẠI HIỆU QUẢ CHO BẠN', NULL, N'LỢI ÍCH', N'LỢI ÍCH', N'LỢI ÍCH', N'LỢI ÍCH', N'LỢI ÍCH', N'LỢI ÍCH')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (150, 75, 2, N'Chỉnh sửa giao diện', N'chinh-sua-giao-dien', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (151, 76, 1, N'Ý kiến khách hàng', N'y-kien-khach-hang', N'Đã có tới hơn 100 khách hàng sử dụng và hài lòng với chúng tôi', NULL, N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'Ý kiến khách hàng', N'Ý kiến khách hàng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (152, 76, 2, N'Ý kiến khách hàng', N'y-kien-khach-hang', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (153, 77, 1, N'Tại sao chọn chúng tôi?', N'tai-sao-chon-chung-toi', NULL, NULL, N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (154, 77, 2, N'WHY CHOOSE US', N'why-choose-us', NULL, NULL, N'WHY CHOOSE US', N'WHY CHOOSE US', N'WHY CHOOSE US', N'WHY CHOOSE US', N'WHY CHOOSE US', N'WHY CHOOSE US')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (159, 80, 1, N'Bảng giá', N'bang-gia', NULL, NULL, N'Bảng giá', N'Bảng giá', N'Bảng giá', N'Bảng giá', N'Bảng giá', N'Bảng giá')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (160, 80, 2, N'Quotation', N'quotation', NULL, NULL, N'Quotation', N'Quotation', N'Quotation', N'Quotation', N'Quotation', N'Quotation')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (161, 81, 1, N'Quy trình phát triển website', N'quy-trinh-phat-trien-website', NULL, NULL, N'Quy trình phát triển website', N'Quy trình phát triển website', N'Quy trình phát triển website', N'Quy trình phát triển website', N'Quy trình phát triển website', N'Quy trình phát triển website')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (162, 81, 2, N'OUR PROCESS', N'our-process', NULL, NULL, N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (163, 82, 1, N'Why chose us', N'why-chose-us', N'Chúng tôi cung cấp các dịch vu: Thiết kế Website, pháp triển các ứng dụng Webpage Application, Application Mobile, Marketing Online, SEO, Google Adworld, CPC, Social media marketing and Ecommer.', NULL, N'Why chose us', N'Why chose us', N'Why chose us', N'Why chose us', N'Why chose us', N'Why chose us')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (164, 82, 2, N'Services', N'services', N'We offer a wide range of Digital Marketing & Web Development Services. Our services include web design, web development, Social media marketing, SEO & more.', NULL, N'Services', N'Services', N'Services', N'Services', N'Services', N'Services')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (165, 83, 1, N'Yêu cầu', N'yeu-cau', NULL, NULL, N'Yêu cầu', N'Yêu cầu', N'Yêu cầu', N'Yêu cầu', N'Yêu cầu', N'Yêu cầu')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (166, 83, 2, N'Yêu cầu', N'yeu-cau', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (167, 84, 1, N'Nhà hàng- khách sạn- Ẩm thực', N'nha-hang-khach-san-am-thuc', NULL, NULL, N'Nhà hàng- khách sạn- Ẩm thực', N'Nhà hàng- khách sạn- Ẩm thực', N'Nhà hàng- khách sạn- Ẩm thực', N'Nhà hàng- khách sạn- Ẩm thực', N'Nhà hàng- khách sạn- Ẩm thực', N'Nhà hàng- khách sạn- Ẩm thực')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (168, 84, 2, N'Ẩm thực ăn uống', N'am-thuc-an-uong', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (169, 85, 1, N'Giáo dục - y tế', N'giao-duc--y-te', NULL, NULL, N'Giáo dục - y tế', N'Giáo dục - y tế', N'Giáo dục - y tế', N'Giáo dục - y tế', N'Giáo dục - y tế', N'Giáo dục - y tế')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (170, 85, 2, N'Doanh nghiệp', N'doanh-nghiep', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (171, 86, 1, N'Siêu thị - Web shop - cửa hàng', N'sieu-thi--web-shop--cua-hang', NULL, NULL, N'Siêu thị - Web shop - cửa hàng', N'Siêu thị - Web shop - cửa hàng', N'Siêu thị - Web shop - cửa hàng', N'Siêu thị - Web shop - cửa hàng', N'Siêu thị - Web shop - cửa hàng', N'Siêu thị - Web shop - cửa hàng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (172, 86, 2, N'Web shop - cửa hàng', N'web-shop--cua-hang', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (173, 87, 1, N'Thời trang - Mỹ phẩm-Spa', N'thoi-trang--my-phamspa', NULL, NULL, N'Thời trang - Mỹ phẩm-Spa', N'Thời trang - Mỹ phẩm-Spa', N'Thời trang - Mỹ phẩm-Spa', N'Thời trang - Mỹ phẩm-Spa', N'Thời trang - Mỹ phẩm-Spa', N'Thời trang - Mỹ phẩm-Spa')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (174, 87, 2, N'Mỹ phẩm-làm đẹp', N'my-phamlam-dep', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (175, 88, 1, N'Thiết kế Website', N'thiet-ke-website', NULL, NULL, N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (176, 88, 2, N'Website Design', N'website-design', NULL, NULL, N'Website Design', N'Website Design', N'Website Design', N'Website Design', N'Website Design', N'Website Design')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (177, 89, 1, N'Phát triển ứng dụng Web', N'phat-trien-ung-dung-web', NULL, NULL, N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (178, 89, 2, N'Web Development', N'web-development', NULL, NULL, N'Web Development', N'Web Development', N'Web Development', N'Web Development', N'Web Development', N'Web Development')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (179, 90, 1, N'Dịch vụ SEO Website', N'dich-vu-seo-website', NULL, NULL, N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (180, 90, 2, N'SEO Optimization', N'seo-optimization', NULL, NULL, N'SEO Optimization', N'SEO Optimization', N'SEO Optimization', N'SEO Optimization', N'SEO Optimization', N'SEO Optimization')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (181, 91, 1, N'Tiếp thị mạng xã hội', N'tiep-thi-mang-xa-hoi', NULL, NULL, N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (182, 91, 2, N'Social Marketing', N'social-marketing', NULL, NULL, N'Social Marketing', N'Social Marketing', N'Social Marketing', N'Social Marketing', N'Social Marketing', N'Social Marketing')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (183, 92, 1, N'Pay Per Click', N'pay-per-click', NULL, NULL, N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (184, 92, 2, N'Pay Per Click', N'pay-per-click', NULL, NULL, N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (185, 93, 1, N'Tiếp thị di động', N'tiep-thi-di-dong', N'Mobile Marketing is the latest technology that helps you attract more new customers –customers that spend more money, more frequently!!! We can help you launch a successful mobile marketing campaign to connect, communicate and keep your customers coming through the door again and again.', NULL, N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (186, 93, 2, N'Mobile Marketing', N'mobile-marketing', NULL, NULL, N'Mobile Marketing', N'Mobile Marketing', N'Mobile Marketing', N'Mobile Marketing', N'Mobile Marketing', N'Mobile Marketing')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (187, 94, 1, N'News', N'news', N'News', NULL, N'News', N'News', N'News', N'News', N'News', N'News')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (188, 94, 2, N'Blog', N'blog', NULL, NULL, N'Blog', N'Blog', N'Blog', N'Blog', N'Blog', N'Blog')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (189, 95, 1, N'Bài học thành công', N'bai-hoc-thanh-cong', NULL, NULL, N'Bài học thành công', N'Bài học thành công', N'Bài học thành công', N'Bài học thành công', N'Bài học thành công', N'Bài học thành công')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (190, 95, 2, N'Cloud Computing', N'cloud-computing', NULL, NULL, N'Cloud Computing', N'Cloud Computing', N'Cloud Computing', N'Cloud Computing', N'Cloud Computing', N'Cloud Computing')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (191, 96, 1, N'Bí quyết kinh doanh', N'bi-quyet-kinh-doanh', NULL, NULL, N'Bí quyết kinh doanh', N'Bí quyết kinh doanh', N'Bí quyết kinh doanh', N'Bí quyết kinh doanh', N'Bí quyết kinh doanh', N'Bí quyết kinh doanh')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (192, 96, 2, N'IT News', N'it-news', NULL, NULL, N'IT News', N'IT News', N'IT News', N'IT News', N'IT News', N'IT News')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (193, 97, 1, N'Kinh nghiệm vàng', N'kinh-nghiem-vang', NULL, NULL, N'Kinh nghiệm vàng', N'Kinh nghiệm vàng', N'Kinh nghiệm vàng', N'Kinh nghiệm vàng', N'Kinh nghiệm vàng', N'Kinh nghiệm vàng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (194, 97, 2, N'Networking', N'networking', NULL, NULL, N'Networking', N'Networking', N'Networking', N'Networking', N'Networking', N'Networking')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (195, 98, 1, N'Bán hàng hiệu quả', N'ban-hang-hieu-qua', NULL, NULL, N'Bán hàng hiệu quả', N'Bán hàng hiệu quả', N'Bán hàng hiệu quả', N'Bán hàng hiệu quả', N'Bán hàng hiệu quả', N'Bán hàng hiệu quả')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (196, 98, 2, N'Security', N'security', NULL, NULL, N'Security', N'Security', N'Security', N'Security', N'Security', N'Security')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (197, 99, 1, N'Quảng Cáo Online', N'quang-cao-online', NULL, NULL, N'Quảng Cáo Online', N'Quảng Cáo Online', N'Quảng Cáo Online', N'Quảng Cáo Online', N'Quảng Cáo Online', N'Quảng Cáo Online')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (198, 99, 2, N'Tech Debates', N'tech-debates', NULL, NULL, N'Tech Debates', N'Tech Debates', N'Tech Debates', N'Tech Debates', N'Tech Debates', N'Tech Debates')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (199, 100, 1, N'Thiết kế in ấn', N'thiet-ke-in-an', NULL, NULL, N'Thiết kế in ấn', N'Thiết kế in ấn', N'Thiết kế in ấn', N'Thiết kế in ấn', N'Thiết kế in ấn', N'Thiết kế in ấn')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (200, 100, 2, N'Print Design', N'print-design', NULL, NULL, N'Print Design', N'Print Design', N'Print Design', N'Print Design', N'Print Design', N'Print Design')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (201, 101, 1, N'Tour', N'tour', N'Sản phẩm', NULL, N'Tour', N'Tour', N'Tour', N'Tour', N'Tour', N'Tour')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (202, 101, 2, N'Software', N'software', NULL, NULL, N'Software', N'Software', N'Software', N'Software', N'Software', N'Software')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (203, 102, 1, N'Bộ nhận diện thương hiệu', N'bo-nhan-dien-thuong-hieu', N'Bộ nhận diện thương hiệu', NULL, N'Bộ nhận diện thương hiệu', N'Bộ nhận diện thương hiệu', N'Bộ nhận diện thương hiệu', N'Bộ nhận diện thương hiệu', N'Bộ nhận diện thương hiệu', N'Bộ nhận diện thương hiệu')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (204, 102, 2, N'The brand indentity', N'the-brand-indentity', NULL, NULL, N'The brand indentity', N'The brand indentity', N'The brand indentity', N'The brand indentity', N'The brand indentity', N'The brand indentity')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (205, 103, 1, N'Thiết kế logo, namecard', N'thiet-ke-logo-namecard', NULL, NULL, N'Thiết kế logo, namecard', N'Thiết kế logo, namecard', N'Thiết kế logo, namecard', N'Thiết kế logo, namecard', N'Thiết kế logo, namecard', N'Thiết kế logo, namecard')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (206, 103, 2, N'Logo design, namecard', N'logo-design-namecard', NULL, NULL, N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (207, 104, 1, N'Ấn phẩm Quảng cáo', N'an-pham-quang-cao', N'Ấn phẩm Quảng cáo', NULL, N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (208, 104, 2, N'Advertising publications', N'advertising-publications', NULL, NULL, N'Advertising publications', N'Advertising publications', N'Advertising publications', N'Advertising publications', N'Advertising publications', N'Advertising publications')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (209, 105, 1, N'Ấn phẩm văn phòng', N'an-pham-van-phong', N'Ấn phẩm văn phòng', NULL, N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (210, 105, 2, N'Publications Office', N'publications-office', NULL, NULL, N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (211, 106, 1, N'Quảng Cáo Google', N'quang-cao-google', N'Quảng Cáo Google', NULL, N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (212, 106, 2, N'Quảng Cáo Google', N'quang-cao-google', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (213, 107, 1, N'Quảng Cáo Facebook', N'quang-cao-facebook', N'Quảng Cáo Facebook', NULL, N'Quảng Cáo Facebook', N'Quảng Cáo Facebook', N'Quảng Cáo Facebook', N'Quảng Cáo Facebook', N'Quảng Cáo Facebook', N'Quảng Cáo Facebook')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (214, 107, 2, N'Quảng Cáo Facebook', N'quang-cao-facebook', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (215, 108, 1, N'Nhà đất bất động sản', N'nha-dat-bat-dong-san', N'Nhà đất bất động sản', NULL, N'Nhà đất bất động sản', N'Nhà đất bất động sản', N'Nhà đất bất động sản', N'Nhà đất bất động sản', N'Nhà đất bất động sản', N'Nhà đất bất động sản')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (216, 108, 2, N'Nhà đất bất động sản', N'nha-dat-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (217, 109, 1, N'Nông sản - thực phẩm', N'nong-san--thuc-pham', N'Nông sản - thực phẩm', NULL, N'Nông sản - thực phẩm', N'Nông sản - thực phẩm', N'Nông sản - thực phẩm', N'Nông sản - thực phẩm', N'Nông sản - thực phẩm', N'Nông sản - thực phẩm')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (218, 109, 2, N'Nông sản - nông nghiệp- thực phẩm', N'nong-san--nong-nghiep-thuc-pham', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (219, 110, 1, N'Thiết kế nội ngoại thất', N'thiet-ke-noi-ngoai-that', N'Thiết kế nội ngoại thất', NULL, N'Thiết kế nội ngoại thất', N'Thiết kế nội ngoại thất', N'Thiết kế nội ngoại thất', N'Thiết kế nội ngoại thất', N'Thiết kế nội ngoại thất', N'Thiết kế nội ngoại thất')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (220, 110, 2, N'Thiết kế nội ngoại thất', N'thiet-ke-noi-ngoai-that', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (221, 111, 1, N'Dịch vụ tiệc cưới- hoa- thuê xe', N'dich-vu-tiec-cuoi-hoa-thue-xe', N'Dịch vụ tiệc cưới- hoa- thuê xe', NULL, N'Dịch vụ tiệc cưới- hoa- thuê xe', N'Dịch vụ tiệc cưới- hoa- thuê xe', N'Dịch vụ tiệc cưới- hoa- thuê xe', N'Dịch vụ tiệc cưới- hoa- thuê xe', N'Dịch vụ tiệc cưới- hoa- thuê xe', N'Dịch vụ tiệc cưới- hoa- thuê xe')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (222, 111, 2, N'Dịch vụ tiệc cưới- hoa- thuê xe', N'dich-vu-tiec-cuoi-hoa-thue-xe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (223, 112, 1, N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'phan-mem-quan-ly-ban-hang-pos-cua-hang-shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', NULL, N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop', N'Phần mềm quản lý bán hàng POS, cửa hàng, shop')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (224, 112, 2, N'Phần mềm quản lý bán hàng POS', N'phan-mem-quan-ly-ban-hang-pos', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (225, 113, 1, N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'phan-mem-quan-ly-nha-hang-cafe-bida-karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', NULL, N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (226, 113, 2, N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'phan-mem-quan-ly-nha-hang-cafe-bida-karaoke', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (227, 114, 1, N'Phần mềm quản lý hiệu vàng', N'phan-mem-quan-ly-hieu-vang', N'Phần mềm quản lý hiệu vàng', NULL, N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (228, 114, 2, N'Phần mềm quản lý hiệu vàng', N'phan-mem-quan-ly-hieu-vang', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (229, 115, 1, N'Phần mềm quản lý cửa hàng điện thoại', N'phan-mem-quan-ly-cua-hang-dien-thoai', N'Phần mềm quản lý cửa hàng điện thoại', NULL, N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (230, 115, 2, N'Phần mềm quản lý cửa hàng điện thoại', N'phan-mem-quan-ly-cua-hang-dien-thoai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (231, 116, 1, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'phan-mem-ban-hang-kho-hang-cong-no-sm', N'Phần mềm bán hàng, kho hàng, công nợ SM', NULL, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (232, 116, 2, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'phan-mem-ban-hang-kho-hang-cong-no-sm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (233, 117, 1, N'Video', N'video', NULL, NULL, N'Video', N'Video', N'Video', N'Video', N'Video', N'Video')
GO
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (234, 117, 2, N'Video', N'video', NULL, NULL, N'Video', N'Video', N'Video', N'Video', N'Video', N'Video')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (235, 118, 1, N'Other Tour', N'other-tour', NULL, NULL, N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour')
INSERT [dbo].[PNK_ProductcategoryDesc] ([Id], [MainId], [LangId], [Name], [NameUrl], [Brief], [Detail], [MetaTitle], [MetaKeyword], [MetaDecription], [H1], [H2], [H3]) VALUES (236, 118, 2, N'Other Tour', N'other-tour', NULL, NULL, N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour', N'Other Tour')
SET IDENTITY_INSERT [dbo].[PNK_ProductcategoryDesc] OFF
SET IDENTITY_INSERT [dbo].[PNK_ProductDesc] ON 

INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (5, 3, 1, N'John Vandeley', N'Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.', N'<p>
	<span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span></p>
', NULL, N'john-vandeley', NULL, NULL, NULL, NULL, NULL, NULL, N'John Vandeley', N'John Vandeley', N'John Vandeley', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (6, 3, 2, N'John Vandeley', N'Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.', N'<p>
	<span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span><span style="color: rgb(0, 0, 0); font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; line-height: 17.142858505249px;">Have you ever felt worried that your party will not raise up to your guest expectations? In design, vertical rhythm is the structure that guides a reader''s eye through the content. Good vertical rhythm makes a layout more balanced and beautiful and its content more readable. The time signature in sheet music visually depicts a song''s rhythm, while for us, the lines of the baseline grid depict the rhythm of our content and give us guidelines.</span></p>
', NULL, N'john-vandeley', NULL, NULL, NULL, NULL, NULL, NULL, N'John Vandeley', N'John Vandeley', N'John Vandeley', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (9, 5, 1, N'SD1', N'SD1SD1SD1', N'<p>SD1</p>
', NULL, N'sd1', NULL, NULL, NULL, NULL, NULL, NULL, N'SD1', N'SD1', N'SD1', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (10, 5, 2, N'SD1', N'SD1SD1SD1', N'<p>SD1</p>
', NULL, N'sd1', NULL, NULL, NULL, NULL, NULL, NULL, N'SD1', N'SD1', N'SD1', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (17, 9, 1, N'Thi Thiên', N'Thi Thiên', N'<p>Thi Thi&ecirc;n</p>
', NULL, N'thi-thien', NULL, N'sachboilinh1', N'sach-boi-linh1', NULL, NULL, NULL, N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (18, 9, 2, N'fasdf', N'fsda', N'<p>Thi Thi&ecirc;n</p>
', NULL, N'fasdf', NULL, NULL, N'<p>sach-boi-linh1</p>
', NULL, NULL, NULL, N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên', N'Thi Thiên')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (19, 11, 1, N'àd', N'fds', N'<p>
	fsdfsd</p>
', NULL, N'ad', NULL, N'sach-boi-linh', N'Sách bồi linh', NULL, NULL, NULL, N'fsd', N'fdsf', N'sdfdsfsd', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (20, 11, 2, N'àd', N'fds', N'<p>
	fsdfsd</p>
', NULL, N'ad', NULL, NULL, N'<p>
	Sách bồi linh</p>
', NULL, NULL, NULL, N'fsd', N'fdsf', N'fdsf', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (27, 15, 1, N'v3', N'v3', N'<p>v3</p>
', NULL, N'v3', NULL, NULL, NULL, NULL, NULL, NULL, N'v3', N'v3', N'v3', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (28, 15, 2, N'v3', N'v3', N'<p>v3</p>
', NULL, N'v3', NULL, NULL, NULL, NULL, NULL, NULL, N'v3', N'v3', N'v3', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (37, 20, 1, N'test', N'test', N'<p>test</p>
', NULL, N'test', NULL, NULL, NULL, NULL, NULL, NULL, N'test', N'test', N'test', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (38, 20, 2, N'test', N'test', N'<p>test</p>
', NULL, N'test', NULL, NULL, NULL, NULL, NULL, NULL, N'test', N'test', N'test', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (47, 25, 1, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', N'test d', N'test d', N'test d')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (48, 25, 2, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', N'test d', N'test d', N'test d')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (49, 26, 1, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (50, 26, 2, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (51, 27, 1, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', N'test d', N'test d', N'test d')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (52, 27, 2, N'test d', N'test d', NULL, NULL, N'test-d', NULL, NULL, NULL, NULL, NULL, NULL, N'test d', N'test d', N'test d', N'test d', N'test d', N'test d')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (53, 28, 1, N'testd', N'testd', NULL, NULL, N'testd', NULL, NULL, NULL, NULL, NULL, NULL, N'testd', NULL, N'testd', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (54, 28, 2, N'testd', N'testd', NULL, NULL, N'testd', NULL, NULL, NULL, NULL, NULL, NULL, N'testd', NULL, N'testd', NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2085, 2044, 1, N'BT1', N'Gioi thieu', N'<p>chi tiet bai viet</p>
', NULL, N'bt1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2086, 2044, 2, N'BT1', N'Gioi thieu', N'<p>chi tiet bai viet</p>
', NULL, N'bt1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2087, 2045, 1, N'KP1', N'Gioi thieu', N'<p>Chi tiet</p>
', NULL, N'kp1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2088, 2045, 2, N'KP1', N'Gioi thieu', N'<p>Chi tiet</p>
', NULL, N'kp1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2089, 2046, 1, N'KP1', N'KP1KP1', N'<p>KP1KP1KP1KP1KP1KP1</p>
', NULL, N'kp1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2090, 2046, 2, N'KP1', N'KP1KP1', N'<p>KP1KP1KP1KP1KP1KP1</p>
', NULL, N'kp1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2091, 2047, 1, N'fdsfsfs', N'fsdf', N'<p>fsdd</p>
', NULL, N'fdsfsfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2092, 2047, 2, N'fdsfsfs', N'fsdf', N'<p>fsdd</p>
', NULL, N'fdsfsfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2093, 2048, 1, N'123', N'1', NULL, NULL, N'123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2094, 2048, 2, N'12', N'1', NULL, NULL, N'12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2095, 2049, 1, N'2', N'1', NULL, NULL, N'2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2096, 2049, 2, N'1', N'1', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2097, 2050, 1, N'1a', N'1', NULL, NULL, N'1a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2098, 2050, 2, N'1', N'1', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2099, 2051, 1, N'12', N'1', NULL, NULL, N'12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2100, 2051, 2, N'1', N'1', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2101, 2052, 1, N'1afdsffs', NULL, NULL, NULL, N'1afdsffs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (2102, 2052, 2, N'1a', NULL, NULL, NULL, N'1a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3085, 3044, 1, N'avn', NULL, N'<p>fdsafsafsa</p>
', NULL, N'avn', NULL, NULL, NULL, NULL, NULL, NULL, N'avn', N'avn', N'avn', N'avn', N'avn', N'avn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3086, 3044, 2, N'aeng', NULL, N'<p>fdsafsafsa</p>
', NULL, N'aeng', NULL, NULL, NULL, NULL, NULL, NULL, N'avn', N'avn', N'avn', N'aeng', N'aeng', N'aeng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3087, 3045, 1, N'j', NULL, N'<p><iframe allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/Jvos5_3nH4I" width="560"></iframe></p>
', NULL, N'j', NULL, NULL, NULL, NULL, NULL, NULL, N'j', N'j', N'j', N'j', N'j', N'j')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3088, 3045, 2, N'j', NULL, N'<p><iframe allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/Jvos5_3nH4I" width="560"></iframe></p>
', NULL, N'j', NULL, NULL, NULL, NULL, NULL, NULL, N'j', N'j', N'j', N'j', N'j', N'j')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3089, 3046, 1, N'a', N'a', N'<p>a</p>
', NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'a', N'a', N'a', N'a', N'a', N'a')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3090, 3046, 2, N'a', N'a', N'<p>a</p>
', NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'a', N'a', N'a', N'a', N'a', N'a')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3091, 3047, 1, N'b', N'b', NULL, NULL, N'b', NULL, NULL, NULL, NULL, NULL, NULL, N'b', N'b', N'b', N'b', N'b', N'b')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3092, 3047, 2, N'b', N'b', NULL, NULL, N'b', NULL, NULL, NULL, NULL, NULL, NULL, N'b', N'b', N'b', N'b', N'b', N'b')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3093, 3048, 1, N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', NULL, NULL, N'rau-cu-qua-xuat-khau', NULL, NULL, NULL, NULL, NULL, NULL, N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3094, 3048, 2, N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', NULL, NULL, N'rau-cu-qua-xuat-khau', NULL, NULL, NULL, NULL, NULL, NULL, N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3097, 3050, 1, N'Ly thủy tinh', N'Ly thủy tinh', NULL, NULL, N'ly-thuy-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3098, 3050, 2, N'Ly thủy tinh', N'Ly thủy tinh', NULL, NULL, N'ly-thuy-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3099, 3051, 1, N'Ly thủy tinh', N'Ly thủy tinh', NULL, NULL, N'ly-thuy-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3100, 3051, 2, N'Ly thủy tinh', N'Ly thủy tinh', NULL, NULL, N'ly-thuy-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3103, 3053, 1, N'ấ', NULL, NULL, NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'ấ', N'ấ', N'ấ', N'ấ', N'ấ', N'ấ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3104, 3053, 2, N'ấ', NULL, NULL, NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'ấ', N'ấ', N'ấ', N'ấ', N'ấ', N'ấ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3107, 3055, 1, N'sfd', NULL, NULL, NULL, N'sfd', NULL, NULL, NULL, NULL, NULL, NULL, N'sfd', N'sfd', N'sfd', N'sfd', N'sfd', N'sfd')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3108, 3055, 2, N'sfd', NULL, NULL, NULL, N'sfd', NULL, NULL, NULL, NULL, NULL, NULL, N'sfd', N'sfd', N'sfd', N'sfd', N'sfd', N'sfd')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3113, 3058, 1, N'Triple Insulating with ExtremEdge™', N'Viracon now offers the ExtremEdge™ spacer ', NULL, NULL, N'triple-insulating-with-extremedge™', NULL, NULL, NULL, NULL, NULL, NULL, N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3114, 3058, 2, N'Triple Insulating with ExtremEdge™', N'Viracon now offers the ExtremEdge™ spacer ', NULL, NULL, N'triple-insulating-with-extremedge™', NULL, NULL, NULL, NULL, NULL, NULL, N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™', N'Triple Insulating with ExtremEdge™')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3117, 3060, 1, N'Our story, so far.', N'Our story', N'<p><strong><span style="color:rgb(78, 155, 205)">Our story, so far.</span></strong><br />
After four decades, 100,000 buildings, and 500,000,000 square feet of glazing installed in some of the most remarkable buildings throughout the world, you learn a thing or two about what&#39;s important for each project.</p>

<p><br />
&nbsp;</p>

<table border="0" style="border-collapse:collapse; border-spacing:0px; color:rgb(93, 93, 93); font-family:dinweb,sans-serif; line-height:16.003px; width:675px">
	<tbody>
		<tr>
			<td style="text-align:center"><img alt="Viracon Announcement- Owatonna, MN" src="http://viracon.com/images/history1.jpg" style="border:0px; height:466px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - Owatonna, MN" src="http://viracon.com/images/history2.jpg" style="border:0px; height:233px; width:335px" /><br />
			<img alt="Viracon 800 Bldg Construction - Owatonna, MN" src="http://viracon.com/images/history3.jpg" style="border:0px; height:233px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Viracon Announcement - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking and 800 Bldg Construction<br />
			Owatonna, MN</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">1970</span></strong><br />
			Completed construction of Viracon&#39;s 45,000 square foot glass fabrication plant, employing twenty people. Fabricated insulating and laminated glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1971</span></strong><br />
			Added tempering line, making Viracon the only company to house three lines under one roof.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1979</span></strong><br />
			Added second laminating line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1984</span></strong><br />
			Expanded 53,000 square feet to house an upgraded horizontal tempering line and warehouse space.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon 300 Bldg Construction - Owatonna, MN" src="http://viracon.com/images/history4.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Laminating Line Employees - Owatonna, MN" src="http://viracon.com/images/history5.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">300 Bldg Construction - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Laminating Line Employees - Owatonna, MN</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p>Since 1970, when Viracon was established with 20 employees by founder James L. Martineau, Viracon has expanded its facilities to perform more glass fabricating processes at a single site than any other fabricator in the world.&nbsp;<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1985</span></strong><br />
			Expanded laminating line, constructed an automated glass cutting line and expanded office space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1986</span></strong><br />
			Completed construction of a 48,000 square foot coatings facility launching Viracon into the high-performance glass coatings market. Expanded tempering line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1987</span></strong><br />
			Added 71,000 square feet for warehouse space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1988</span></strong><br />
			Added 57,000 square feet for a new tempering line and office space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1991</span></strong><br />
			Added 63,000 square feet through an acquisition to house Viracon&#39;s research and development department, an indoor firing range and warehouse space.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Ariel View of Viracon Campus - Owatonna, MN" src="http://viracon.com/images/history9.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - Statesboro, GA" src="http://viracon.com/images/history6.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Aerial View of Viracon Campus - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking - Statesboro, GA</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">1992</span></strong><br />
			Expanded the coatings facility to 45,000 square feet to add another coating line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1994</span></strong><br />
			Completed construction of another 138,000 square feet for new tempering and insulating lines, expanded the coatings facility and added two security product laminating lines.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1996</span></strong><br />
			Planned expansion of 128,500 square feet to add another automated insulating line, cutting line, Silk-Screening line, and more warehouse space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1998</span></strong><br />
			Completed construction of new 330,000 square foot full production fabrication facility in Statesboro, Georgia.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2001</span></strong><br />
			Acquired a 157,000 square foot office and warehouse facility in Owatonna, Minnesota. Added a silk-screening line and CNC hole-drilling, edge-polishing and shape-cutting equipment.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Statesboro" src="http://viracon.com/images/history14.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Statesboro Employees - Statesboro, GA" src="http://viracon.com/images/history7.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Statesboro Plant Construction</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Statesboro Employees - Statesboro, GA</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p>For more than 2,500 architects and designers, Viracon is a prime single-source resource for not only fabrication but for consulting and technical help as well. Every day, customers rely on us for design assistance, budget costing, ROI costing, quoting, specification writing and review, project coordination, job site inspections, product performance information and detailed technical assistance for our entire line of innovative glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2002</span></strong><br />
			Added automatic seaming for improved glass edge quality, and edge-polishing equipment.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2003</span></strong><br />
			Added heat-soaking equipment making Viracon the only company to publish a warranty for glass breakage with heat-soaked glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2004</span></strong><br />
			Added CNC hole-drilling equipment to accommodate the growth in structural wall applications.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Viracon Facility - Statesboro, GA" src="http://viracon.com/images/history8.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - St. George, UT" src="http://viracon.com/images/history10.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Viracon Facility - Statesboro, GA</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking - St. George, UT</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">2005</span></strong><br />
			Added 65,000 square feet to the Statesboro, GA, facility for expanded coating, insulating, and silk-screening capabilities.<br />
			<br />
			Added three new tempering furnaces and a silk-screening line to the Owatonna, MN facility.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2006</span></strong><br />
			Added a tempering line to Statesboro, GA facility and expanded Owatonna, MN facility with insulating and coating capacity.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2007</span></strong><br />
			Completed construction of new 210,000 square foot full production fabrication facility in St. George, Utah. There are two insulating lines, a tempering line, laminating line, coating line and a silk-screening line.<br />
			<br />
			Updated the Owatonna, MN facility with a new tempering & cutting line, added heat soak capacity, new special fabrication equipment and an over-sized insulating line.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Ribbon cutting ceremony - St. George, UT" src="http://viracon.com/images/history11.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon St. George Facility - St. George, UT" src="http://viracon.com/images/history12.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Ribbon cutting ceremony - St. George, UT</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">St. George Facility - St. George, UT</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">2008</span></strong><br />
			Added a new tempering line to the St. George, UT facility and a new silk-screen line to the Statesboro, GA facility.&nbsp;<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2010</span></strong><br />
			Acquired 100 percent of the stock of Glassec Vidros de Seguranca Ltda, the leading architectural glass fabricator in Brazil, now named Glassec Viracon. The operation produces laminated, insulating, tempered, heat strengthened and silk-screened glass. The 100,000 square foot facility is located in Nazar&eacute; Paulista and employs 250 employees.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Glassec Viracon Facility - Nazaré Paulista, Brazil" src="http://viracon.com/images/history13.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Glassec Viracon Employees" src="http://viracon.com/images/history15.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Glassec Viracon Facility - Nazar&eacute; Paulista, Brazil</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Glassec Viracon Employees</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center">
			<p>Today, Viracon has grown to become an international market-leader as a key subsidiary of Apogee Enterprises, Inc. (NASDAQ: APOG).</p>
			</td>
		</tr>
	</tbody>
</table>
', NULL, N'our-story-so-far', NULL, NULL, NULL, NULL, NULL, NULL, N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3118, 3060, 2, N'Our story, so far.', N'Our story', N'<p><strong><span style="color:rgb(78, 155, 205)">Our story, so far.</span></strong><br />
After four decades, 100,000 buildings, and 500,000,000 square feet of glazing installed in some of the most remarkable buildings throughout the world, you learn a thing or two about what&#39;s important for each project.</p>

<p><br />
&nbsp;</p>

<table border="0" style="border-collapse:collapse; border-spacing:0px; color:rgb(93, 93, 93); font-family:dinweb,sans-serif; line-height:16.003px; width:675px">
	<tbody>
		<tr>
			<td style="text-align:center"><img alt="Viracon Announcement- Owatonna, MN" src="http://viracon.com/images/history1.jpg" style="border:0px; height:466px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - Owatonna, MN" src="http://viracon.com/images/history2.jpg" style="border:0px; height:233px; width:335px" /><br />
			<img alt="Viracon 800 Bldg Construction - Owatonna, MN" src="http://viracon.com/images/history3.jpg" style="border:0px; height:233px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Viracon Announcement - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking and 800 Bldg Construction<br />
			Owatonna, MN</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">1970</span></strong><br />
			Completed construction of Viracon&#39;s 45,000 square foot glass fabrication plant, employing twenty people. Fabricated insulating and laminated glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1971</span></strong><br />
			Added tempering line, making Viracon the only company to house three lines under one roof.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1979</span></strong><br />
			Added second laminating line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1984</span></strong><br />
			Expanded 53,000 square feet to house an upgraded horizontal tempering line and warehouse space.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon 300 Bldg Construction - Owatonna, MN" src="http://viracon.com/images/history4.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Laminating Line Employees - Owatonna, MN" src="http://viracon.com/images/history5.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">300 Bldg Construction - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Laminating Line Employees - Owatonna, MN</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p>Since 1970, when Viracon was established with 20 employees by founder James L. Martineau, Viracon has expanded its facilities to perform more glass fabricating processes at a single site than any other fabricator in the world.&nbsp;<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1985</span></strong><br />
			Expanded laminating line, constructed an automated glass cutting line and expanded office space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1986</span></strong><br />
			Completed construction of a 48,000 square foot coatings facility launching Viracon into the high-performance glass coatings market. Expanded tempering line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1987</span></strong><br />
			Added 71,000 square feet for warehouse space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1988</span></strong><br />
			Added 57,000 square feet for a new tempering line and office space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1991</span></strong><br />
			Added 63,000 square feet through an acquisition to house Viracon&#39;s research and development department, an indoor firing range and warehouse space.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Ariel View of Viracon Campus - Owatonna, MN" src="http://viracon.com/images/history9.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - Statesboro, GA" src="http://viracon.com/images/history6.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Aerial View of Viracon Campus - Owatonna, MN</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking - Statesboro, GA</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">1992</span></strong><br />
			Expanded the coatings facility to 45,000 square feet to add another coating line.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1994</span></strong><br />
			Completed construction of another 138,000 square feet for new tempering and insulating lines, expanded the coatings facility and added two security product laminating lines.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1996</span></strong><br />
			Planned expansion of 128,500 square feet to add another automated insulating line, cutting line, Silk-Screening line, and more warehouse space.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">1998</span></strong><br />
			Completed construction of new 330,000 square foot full production fabrication facility in Statesboro, Georgia.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2001</span></strong><br />
			Acquired a 157,000 square foot office and warehouse facility in Owatonna, Minnesota. Added a silk-screening line and CNC hole-drilling, edge-polishing and shape-cutting equipment.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Statesboro" src="http://viracon.com/images/history14.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Statesboro Employees - Statesboro, GA" src="http://viracon.com/images/history7.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Statesboro Plant Construction</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Statesboro Employees - Statesboro, GA</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p>For more than 2,500 architects and designers, Viracon is a prime single-source resource for not only fabrication but for consulting and technical help as well. Every day, customers rely on us for design assistance, budget costing, ROI costing, quoting, specification writing and review, project coordination, job site inspections, product performance information and detailed technical assistance for our entire line of innovative glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2002</span></strong><br />
			Added automatic seaming for improved glass edge quality, and edge-polishing equipment.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2003</span></strong><br />
			Added heat-soaking equipment making Viracon the only company to publish a warranty for glass breakage with heat-soaked glass.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2004</span></strong><br />
			Added CNC hole-drilling equipment to accommodate the growth in structural wall applications.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Viracon Facility - Statesboro, GA" src="http://viracon.com/images/history8.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon Groundbreaking - St. George, UT" src="http://viracon.com/images/history10.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Viracon Facility - Statesboro, GA</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Groundbreaking - St. George, UT</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">2005</span></strong><br />
			Added 65,000 square feet to the Statesboro, GA, facility for expanded coating, insulating, and silk-screening capabilities.<br />
			<br />
			Added three new tempering furnaces and a silk-screening line to the Owatonna, MN facility.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2006</span></strong><br />
			Added a tempering line to Statesboro, GA facility and expanded Owatonna, MN facility with insulating and coating capacity.<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2007</span></strong><br />
			Completed construction of new 210,000 square foot full production fabrication facility in St. George, Utah. There are two insulating lines, a tempering line, laminating line, coating line and a silk-screening line.<br />
			<br />
			Updated the Owatonna, MN facility with a new tempering & cutting line, added heat soak capacity, new special fabrication equipment and an over-sized insulating line.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Viracon Ribbon cutting ceremony - St. George, UT" src="http://viracon.com/images/history11.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Viracon St. George Facility - St. George, UT" src="http://viracon.com/images/history12.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Ribbon cutting ceremony - St. George, UT</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">St. George Facility - St. George, UT</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
			<p><strong><span style="color:rgb(78, 155, 205)">2008</span></strong><br />
			Added a new tempering line to the St. George, UT facility and a new silk-screen line to the Statesboro, GA facility.&nbsp;<br />
			<br />
			<strong><span style="color:rgb(78, 155, 205)">2010</span></strong><br />
			Acquired 100 percent of the stock of Glassec Vidros de Seguranca Ltda, the leading architectural glass fabricator in Brazil, now named Glassec Viracon. The operation produces laminated, insulating, tempered, heat strengthened and silk-screened glass. The 100,000 square foot facility is located in Nazar&eacute; Paulista and employs 250 employees.</p>
			</td>
		</tr>
		<tr>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td style="text-align:center"><img alt="Glassec Viracon Facility - Nazaré Paulista, Brazil" src="http://viracon.com/images/history13.jpg" style="border:0px; height:250px; width:335px" /></td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center"><img alt="Glassec Viracon Employees" src="http://viracon.com/images/history15.jpg" style="border:0px; height:250px; width:335px" /></td>
		</tr>
		<tr>
			<td style="text-align:center">Glassec Viracon Facility - Nazar&eacute; Paulista, Brazil</td>
			<td style="text-align:center">&nbsp;</td>
			<td style="text-align:center">Glassec Viracon Employees</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:center">
			<p>Today, Viracon has grown to become an international market-leader as a key subsidiary of Apogee Enterprises, Inc. (NASDAQ: APOG).</p>
			</td>
		</tr>
	</tbody>
</table>
', NULL, N'our-story-so-far', NULL, NULL, NULL, NULL, NULL, NULL, N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.', N'Our story, so far.')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3121, 3062, 1, N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'<p>Trở th&agrave;nh c&ocirc;ng ty&nbsp;Thương mại v&agrave; dịch vụ kỹ thuật chuy&ecirc;n nghiệp&nbsp;cung cấp c&aacute;c&nbsp;giải ph&aacute;p K&iacute;nh kiến tr&uacute;c&nbsp;&nbsp;từ c&aacute;c thương hiệu nổi tiếng thế giới.&nbsp;</p>
', NULL, N'bai-gioi-thieu-ngan-footer', NULL, NULL, NULL, NULL, NULL, NULL, N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3122, 3062, 2, N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'<p>Trở th&agrave;nh c&ocirc;ng ty&nbsp;Thương mại v&agrave; dịch vụ kỹ thuật chuy&ecirc;n nghiệp&nbsp;cung cấp c&aacute;c&nbsp;giải ph&aacute;p K&iacute;nh kiến tr&uacute;c&nbsp;&nbsp;từ c&aacute;c thương hiệu nổi tiếng thế giới.&nbsp;</p>
', NULL, N'bai-gioi-thieu-ngan-footer', NULL, NULL, NULL, NULL, NULL, NULL, N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer', N'Bài giới thiệu ngắn footer')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3131, 3067, 1, N'Hoàng Anh', N'Kinh doanh
', N'<p>Với đội ngũ c&ocirc;ng nh&acirc;n c&oacute; tay nghề cao đ&atilde; qua đ&agrave;o tạo, m&aacute;y m&oacute;c thiết bị dụng cụ thi c&ocirc;ng hiện đại c&ugrave;ng sự hỗ trợ của lực lượng kỹ thuật c&oacute; tr&igrave;nh độ chuy&ecirc;n m&ocirc;n, kinh nghiệm, năng động, nhiệt t&igrave;nh. T&ocirc;i sẽ nhờ Life&#39;s Values gi&uacute;p đỡ tiếp.</p>
', NULL, N'hoang-anh', NULL, NULL, NULL, NULL, NULL, NULL, N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3132, 3067, 2, N'Hoàng Anh', N'Kinh doanh
', N'<p>Với đội ngũ c&ocirc;ng nh&acirc;n c&oacute; tay nghề cao đ&atilde; qua đ&agrave;o tạo, m&aacute;y m&oacute;c thiết bị dụng cụ thi c&ocirc;ng hiện đại c&ugrave;ng sự hỗ trợ của lực lượng kỹ thuật c&oacute; tr&igrave;nh độ chuy&ecirc;n m&ocirc;n, kinh nghiệm, năng động, nhiệt t&igrave;nh. T&ocirc;i sẽ nhờ Life&#39;s Values gi&uacute;p đỡ tiếp.</p>
', NULL, N'hoang-anh', NULL, NULL, NULL, NULL, NULL, NULL, N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh', N'Hoàng Anh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3133, 3068, 1, N'Huyền Trâm', N'Giám đốc công ty may
', N'<p>C&aacute;c KCN sử dụng ng&agrave;y c&agrave;ng hiệu quả cơ sở hạ tầng v&agrave; đẩy mạnh hợp t&aacute;c sản xuất, tăng cường mối li&ecirc;n kết ng&agrave;nh trong ph&aacute;t triển kinh tế; c&oacute; t&aacute;c động t&iacute;ch cực v&agrave;o qu&aacute; tr&igrave;nh chuyển dịch cơ cấu kinh tế theo hướng c&ocirc;ng nghiệp h&oacute;a, hiện đại h&oacute;a. T&ocirc;i rất h&agrave;i l&ograve;ng.</p>
', NULL, N'huyen-tram', NULL, NULL, NULL, NULL, NULL, NULL, N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3134, 3068, 2, N'Huyền Trâm', N'Giám đốc công ty may
', N'<p>C&aacute;c KCN sử dụng ng&agrave;y c&agrave;ng hiệu quả cơ sở hạ tầng v&agrave; đẩy mạnh hợp t&aacute;c sản xuất, tăng cường mối li&ecirc;n kết ng&agrave;nh trong ph&aacute;t triển kinh tế; c&oacute; t&aacute;c động t&iacute;ch cực v&agrave;o qu&aacute; tr&igrave;nh chuyển dịch cơ cấu kinh tế theo hướng c&ocirc;ng nghiệp h&oacute;a, hiện đại h&oacute;a. T&ocirc;i rất h&agrave;i l&ograve;ng.</p>
', NULL, N'huyen-tram', NULL, NULL, NULL, NULL, NULL, NULL, N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm', N'Huyền Trâm')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3141, 3072, 1, N'Sứ mệnh của Life''s Value', NULL, N'<p>Gia tăng gi&aacute; trị l&acirc;u d&agrave;i cho c&aacute;c Bất động sản thương mai&nbsp;bằng việc đem đến những sản phẩm&nbsp;k&iacute;nh kiến tr&uacute;c c&oacute; chất lượng cao nhất&nbsp;,&nbsp;chủng loại phong ph&uacute; nhất để&nbsp;tạo n&ecirc;n những mặt đứng đặc biệt.</p>

<p>L&agrave; địa chỉ tin cậy m&agrave; chủ đầu tư dự &aacute;n v&agrave; kiến tr&uacute;c sư nổi tiếng t&igrave;m đến khi cần tư vấn , thiết kế v&agrave; lựa chọn k&iacute;nh kiến tr&uacute;c cho Mặt dựng c&ocirc;ng tr&igrave;nh.</p>
', NULL, N'su-menh-cua-lifes-value', NULL, NULL, NULL, NULL, NULL, NULL, N'Sứ mệnh của Life''s Value', N'Sứ mệnh của Life''s Value', N'Sứ mệnh của Life''s Value', N'Sứ mệnh của Life''s Value', N'Sứ mệnh của Life''s Value', N'Sứ mệnh của Life''s Value')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3142, 3072, 2, N'Mission', NULL, N'<p>Gia tăng gi&aacute; trị l&acirc;u d&agrave;i cho c&aacute;c Bất động sản thương mai&nbsp;bằng việc đem đến những sản phẩm&nbsp;k&iacute;nh kiến tr&uacute;c c&oacute; chất lượng cao nhất&nbsp;,&nbsp;chủng loại phong ph&uacute; nhất để&nbsp;tạo n&ecirc;n những mặt đứng đặc biệt.</p>

<p>L&agrave; địa chỉ tin cậy m&agrave; chủ đầu tư dự &aacute;n v&agrave; kiến tr&uacute;c sư nổi tiếng t&igrave;m đến khi cần tư vấn , thiết kế v&agrave; lựa chọn k&iacute;nh kiến tr&uacute;c cho Mặt dựng c&ocirc;ng tr&igrave;nh.</p>
', NULL, N'mission', NULL, NULL, NULL, NULL, NULL, NULL, N'Mission', N'Mission', N'Mission', N'Mission', N'Mission', N'Mission')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3145, 3074, 1, N'Giá trị của Life''s Values', NULL, N'<p>Ch&uacute;ng t&ocirc;i tin rằng bất cứ sự th&agrave;nh c&ocirc;ng n&agrave;o của LV cũng đều xuất ph&aacute;t từ nỗ lực của tập thể C&aacute;n bộ nh&acirc;n vi&ecirc;n LV, những người tự h&agrave;o tạo n&ecirc;n v&agrave; duy tr&igrave; c&aacute;c gi&aacute; trị cốt l&otilde;i của c&ocirc;ng ty:&nbsp;</p>

<p>&nbsp;</p>

<ul>
	<li>Ch&uacute;ng ta lu&ocirc;n suy nghĩ v&agrave; h&agrave;nh động&nbsp;ch&iacute;nh trực, đ&uacute;ng đắn, c&ocirc;ng bằng&nbsp;đối với với mọi đối t&aacute;c v&agrave; trong mọi c&ocirc;ng việc.</li>
	<li>Ch&uacute;ng ta tin rằng th&agrave;nh c&ocirc;ng của ch&uacute;ng ta gắn liền với việc tạo ra c&aacute;c gi&aacute; trị kh&aacute;c biệt v&agrave; l&acirc;u d&agrave;i cho c&aacute;c dự &aacute;n Bất động sản, vượt hơn những g&igrave; kh&aacute;ch h&agrave;ng mong đợi.</li>
	<li>Ch&uacute;ng ta tạo m&ocirc;i trường để mọi người trong c&ocirc;ng ty đều được đối xử c&ocirc;ng bằng ; &quot;tiếng n&oacute;i ri&ecirc;ng&quot; của từng người ch&uacute;ng ta đều được t&ocirc;n trọng lắng nghe.&nbsp;</li>
	<li>Ch&uacute;ng ta l&agrave;m việc tận t&acirc;m, chuy&ecirc;n nghiệp , s&aacute;ng tạo với tinh thần đồng đội cao nhất.</li>
	<li>&nbsp;</li>
</ul>
', NULL, N'gia-tri-cua-lifes-values', NULL, NULL, NULL, NULL, NULL, NULL, N'Giá trị của Life''s Values', N'Giá trị của Life''s Values', N'Giá trị của Life''s Values', N'Giá trị của Life''s Values', N'Giá trị của Life''s Values', N'Giá trị của Life''s Values')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3146, 3074, 2, N'Values ', NULL, N'<p>Ch&uacute;ng t&ocirc;i tin rằng bất cứ sự th&agrave;nh c&ocirc;ng n&agrave;o của LV cũng đều xuất ph&aacute;t từ nỗ lực của tập thể C&aacute;n bộ nh&acirc;n vi&ecirc;n LV, những người tự h&agrave;o tạo n&ecirc;n v&agrave; duy tr&igrave; c&aacute;c gi&aacute; trị cốt l&otilde;i của c&ocirc;ng ty:&nbsp;</p>

<p>&nbsp;</p>

<ul>
	<li>Ch&uacute;ng ta lu&ocirc;n suy nghĩ v&agrave; h&agrave;nh động&nbsp;ch&iacute;nh trực, đ&uacute;ng đắn, c&ocirc;ng bằng&nbsp;đối với với mọi đối t&aacute;c v&agrave; trong mọi c&ocirc;ng việc.</li>
	<li>Ch&uacute;ng ta tin rằng th&agrave;nh c&ocirc;ng của ch&uacute;ng ta gắn liền với việc tạo ra c&aacute;c gi&aacute; trị kh&aacute;c biệt v&agrave; l&acirc;u d&agrave;i cho c&aacute;c dự &aacute;n Bất động sản, vượt hơn những g&igrave; kh&aacute;ch h&agrave;ng mong đợi.</li>
	<li>Ch&uacute;ng ta tạo m&ocirc;i trường để mọi người trong c&ocirc;ng ty đều được đối xử c&ocirc;ng bằng ; &quot;tiếng n&oacute;i ri&ecirc;ng&quot; của từng người ch&uacute;ng ta đều được t&ocirc;n trọng lắng nghe.&nbsp;</li>
	<li>Ch&uacute;ng ta l&agrave;m việc tận t&acirc;m, chuy&ecirc;n nghiệp , s&aacute;ng tạo với tinh thần đồng đội cao nhất.</li>
	<li>&nbsp;</li>
</ul>
', NULL, N'values-', NULL, NULL, NULL, NULL, NULL, NULL, N'Values ', N'Values ', N'Values ', N'Values ', N'Values ', N'Values ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3157, 3080, 1, N'fsda', NULL, NULL, NULL, N'fsda', NULL, NULL, NULL, NULL, NULL, NULL, N'fsda', N'fsda', N'fsda', N'fsda', N'fsda', N'fsda')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3158, 3080, 2, N'fsda', NULL, NULL, NULL, N'fsda', NULL, NULL, NULL, NULL, NULL, NULL, N'fsda', N'fsda', N'fsda', N'fsda', N'fsda', N'fsda')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3159, 3081, 1, N'af', N'fsdf', NULL, NULL, N'af', NULL, NULL, NULL, NULL, NULL, NULL, N'af', N'af', N'af', N'af', N'af', N'af')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3160, 3081, 2, N'af', N'fsdf', NULL, NULL, N'af', NULL, NULL, NULL, NULL, NULL, NULL, N'af', N'af', N'af', N'af', N'af', N'af')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3161, 3082, 1, N'fsdaffsd', N'fsdf', NULL, NULL, N'fsdaffsd', NULL, NULL, NULL, NULL, NULL, NULL, N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3162, 3082, 2, N'fsdaffsd', N'fsdf', NULL, NULL, N'fsdaffsd', NULL, NULL, NULL, NULL, NULL, NULL, N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd', N'fsdaffsd')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3163, 3083, 1, N'fdsa', N'sdf', NULL, NULL, N'fdsa', NULL, NULL, NULL, NULL, NULL, NULL, N'fdsa', N'fdsa', N'fdsa', N'fdsa', N'fdsa', N'fdsa')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3164, 3083, 2, N'fdsa', N'sdf', NULL, NULL, N'fdsa', NULL, NULL, NULL, NULL, NULL, NULL, N'fdsa', N'fdsa', N'fdsa', N'fdsa', N'fdsa', N'fdsa')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3165, 3084, 1, N'1', N'2', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, N'1', N'1', N'1', N'1', N'1', N'1')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3166, 3084, 2, N'1', N'2', NULL, NULL, N'1', NULL, NULL, NULL, NULL, NULL, NULL, N'1', N'1', N'1', N'1', N'1', N'1')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3177, 3090, 1, N'sdfà', N'fsadfà', N'<p>fds</p>
', NULL, N'sdfa', NULL, NULL, NULL, NULL, NULL, NULL, N'sdfà', N'sdfà', N'sdfà', N'sdfà', N'sdfà', N'sdfà')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3178, 3090, 2, N'sdfà', N'fsadfà', N'<p>fds</p>
', NULL, N'sdfa', NULL, NULL, NULL, NULL, NULL, NULL, N'sdfà', N'sdfà', N'sdfà', N'sdfà', N'sdfà', N'sdfà')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3181, 3092, 1, N'Bird Friendly Glassaa', N'Bird Friendly Glass', NULL, NULL, N'bird-friendly-glassaa', NULL, NULL, NULL, NULL, NULL, NULL, N'Bird Friendly Glassaa', N'Bird Friendly Glassaa', N'Bird Friendly Glassaa', N'Bird Friendly Glassaa', N'Bird Friendly Glassaa', N'Bird Friendly Glassaa')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3182, 3092, 2, N'Bird Friendly Glass', N'Bird Friendly Glass', NULL, NULL, N'bird-friendly-glass', NULL, NULL, NULL, NULL, NULL, NULL, N'Bird Friendly Glassaa', N'Bird Friendly Glassaa', N'Bird Friendly Glass', N'Bird Friendly Glass', N'Bird Friendly Glass', N'Bird Friendly Glass')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3183, 3093, 1, N'fsdaffsdf', N'fsda', N'<p>sfd</p>
', NULL, N'fsdaffsdf', NULL, NULL, NULL, NULL, NULL, NULL, N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3184, 3093, 2, N'fsdaffsdf', N'fsda', NULL, NULL, N'fsdaffsdf', NULL, NULL, NULL, NULL, NULL, NULL, N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf', N'fsdaffsdf')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3187, 3095, 1, N'Phân phun qua lá', N'Phân phun qua lá', N'<p>Ph&acirc;n phun qua l&aacute;</p>
', NULL, N'phan-phun-qua-la', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3188, 3095, 2, N'Phân phun qua lá', N'Phân phun qua lá', NULL, NULL, N'phan-phun-qua-la', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3189, 3096, 1, N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phương Pháp Sử Dụng Phân Bón Qua Lá

Phân bón lá bổ sung thêm thức ăn đặc biệt là vi lượng để kích thích cho cây trồng ra lá, ra hoa nhanh hơn. Phân bón lót có tác dụng với rau, cây ăn quả, hoa hơn so với ở trên cây lan, loài sống phụ sinh', N'<h1>Phương Ph&aacute;p Sử Dụng Ph&acirc;n B&oacute;n Qua L&aacute;</h1>

<p>Ph&acirc;n b&oacute;n l&aacute; bổ sung th&ecirc;m thức ăn đặc biệt l&agrave; vi lượng để k&iacute;ch th&iacute;ch cho c&acirc;y trồng ra l&aacute;, ra hoa nhanh hơn. Ph&acirc;n b&oacute;n l&oacute;t c&oacute; t&aacute;c dụng với rau, c&acirc;y ăn quả, hoa hơn so với ở tr&ecirc;n c&acirc;y lan, lo&agrave;i sống phụ sinh</p>

<p><strong>Theo c&aacute;c nh&agrave; khoa học, b&oacute;n ph&acirc;n qua l&aacute; thậm ch&iacute; c&ograve;n tốt cho c&acirc;y hơn l&agrave; b&oacute;n qua rễ, bởi đ&acirc;y l&agrave; c&aacute;ch nhanh nhất m&agrave; chất dĩnh dưỡng được c&acirc;y hấp thụ .</strong></p>

<p><strong>Những ưu điểm khi b&oacute;n ph&acirc;n qua l&aacute;:</strong>Khi b&oacute;n qua l&aacute;, chất dinh dưỡng cung cấp cho c&acirc;y trồng qua hệ thống kh&iacute; khổng ở bề mặt l&aacute;. Theo số liệu đ&atilde; được c&ocirc;ng bố, hiệu suất sử dụng chất dinh dưỡng qua l&aacute; đạt tới 95%. Trong khi đ&oacute;, b&oacute;n qua đất, c&acirc;y chỉ sử dụng được 45-50% chất dinh dưỡng. Sở dĩ như vậy l&agrave; v&igrave; tổng diện t&iacute;ch bề mặt c&aacute;c l&aacute; tr&ecirc;n một c&acirc;y rộng gấp 15-20 lần diện t&iacute;ch đất được che phủ bởi c&agrave;nh v&agrave; l&aacute;, nghĩa l&agrave; diện t&iacute;ch hấp thụ chất dinh dưỡng của l&aacute; rộng hơn rất nhiều so với diện t&iacute;ch đất trồng của một c&acirc;y. Qua kh&iacute; khổng, c&aacute;c chất dinh dưỡng được dẫn đến c&aacute;c tế b&agrave;o, m&ocirc; c&acirc;y để sử dụng.</p>

<p>Trong th&agrave;nh phần chất dinh dưỡng của ph&acirc;n b&oacute;n l&aacute; ngo&agrave;i c&aacute;c nguy&ecirc;n tố đa lượng như đạm, l&acirc;n, kali c&ograve;n c&oacute; c&aacute;c nguy&ecirc;n tố trung lượng v&agrave; vi lượng như Fe, Zn, Cu, Mg,&hellip; c&aacute;c nguy&ecirc;n tố n&agrave;y tuy c&oacute; h&agrave;m lượng &iacute;t nhưng lại giữ vai tr&ograve; rất quan trọng v&igrave; trong m&ocirc;i trường đất thường thiếu hoặc kh&ocirc;ng c&oacute;. Do đ&oacute;, khi bổ sung c&aacute;c chất n&agrave;y trực tiếp qua l&aacute; sẽ gi&uacute;p đ&aacute;p ứng đủ nhu cầu v&agrave; c&acirc;n đối dinh dưỡng cho c&acirc;y n&ecirc;n tạo điều kiện cho c&acirc;y ph&aacute;t triển đầy đủ trong từng giai đoạn sinh trưởng. Ph&acirc;n b&oacute;n l&aacute; c&oacute; t&aacute;c dụng đặc biệt trong những trường hợp cần bổ sung khẩn cấp chất dinh dưỡng đạm, l&acirc;n, kali hay c&aacute;c nguy&ecirc;n tố trung, vi lượng.</p>

<p>Trong th&agrave;nh phần của ph&acirc;n b&oacute;n l&aacute; c&ograve;n tăng cường điều h&ograve;a sinh trưởng, tăng khả năng hấp thụ dưỡng chất k&iacute;ch th&iacute;ch đ&acirc;m chồi, đẻ nh&aacute;nh, ra hoa, đậu tr&aacute;i, giảm hiện tượng rụng tr&aacute;i non, tr&aacute;i to đẹp, phẩm chất ngon v&agrave; tăng cường khả năng đề kh&aacute;ng chống chịu s&acirc;u bệnh.</p>

<p>A. Kh&aacute;i Niệm Về Ph&acirc;n B&oacute;n<br />
Ph&acirc;n b&oacute;n l&agrave; thức ăn của c&acirc;y trồng, thiếu ph&acirc;n c&acirc;y kh&ocirc;ng thể sinh trưởng v&agrave; cho năng suất, phẩm chất cao. Ph&acirc;n b&oacute;n c&oacute; vai tr&ograve; rất quan trọng trong việc th&acirc;m canh tăng năng suất, bảo vệ c&acirc;y trồng v&agrave; n&acirc;ng cao độ ph&igrave; nhi&ecirc;u của đất.</p>

<p><strong>Mời bạn xem video clip:</strong></p>

<p><span style="font-family:inherit; font-size:inherit"><iframe class="youtube-player" height="412" src="http://www.youtube.com/embed/SMufLl5yJB4?version=3&rel=1&fs=1&autohide=2&showsearch=0&showinfo=1&iv_load_policy=1&wmode=transparent" style="margin: 0px; padding: 0px; border-width: 0px; border-style: initial; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; max-width: 100%;" width="678"></iframe></span></p>

<p><strong>I. C&acirc;y h&uacute;t thức ăn nhờ g&igrave;?</strong><br />
1. Nhờ bộ rễ: Kh&ocirc;ng phải to&agrave;n bộ c&aacute;c phần của rễ đều h&uacute;t dinh dưỡng m&agrave; l&agrave; nhờ miền l&ocirc;ng h&uacute;t rất nhỏ tr&ecirc;n rễ tơ. Từ một rễ c&aacute;i, bộ rễ được ph&acirc;n nh&aacute;nh rất nhiều cấp, nhờ vậy tổng cộng diện t&iacute;ch h&uacute;t dinh dưỡng từ đất của c&acirc;y rất lớn. Rễ h&uacute;t nước trong đất v&agrave; một số nguy&ecirc;n tố h&ograve;a tan trong dung dịch đất như: đạm, l&acirc;n, kali, lưu huỳnh, manh&ecirc;, canxi v&agrave; c&aacute;c nguy&ecirc;n tố vi lượng kh&aacute;c, bộ rễ l&agrave; cơ quan ch&iacute;nh lấy thức ăn cho c&acirc;y.<br />
2- Nhờ bộ l&aacute;: Bộ l&aacute; v&agrave; c&aacute;c bộ phận kh&aacute;c tr&ecirc;n mặt đất, kể cả vỏ c&acirc;y cũng c&oacute; thể hấp thu trực tiếp c&aacute;c dưỡng chất. Ở tr&ecirc;n l&aacute; c&oacute; rất nhiều lỗ nhỏ (kh&iacute; khổng). Kh&iacute; khổng l&agrave; nơi hấp thụ c&aacute;c chất dinh dưỡng bằng con đường phun qua l&aacute;. Tr&ecirc;n c&acirc;y một l&aacute; mầm (đơn tử diệp) kh&iacute; khổng thường ph&acirc;n bố cả 2 mặt l&aacute;, thậm ch&iacute; mặt tr&ecirc;n l&aacute; nhiều hơn mặt dưới l&aacute; như: L&uacute;a , l&uacute;a m&igrave;&hellip;, tr&ecirc;n c&acirc;y ăn tr&aacute;i (c&acirc;y th&acirc;n gỗ) kh&iacute; khổng thường tập trung nhiều ở mặt dưới l&aacute;. Khi d&ugrave;ng ph&acirc;n b&oacute;n l&aacute; phải theo đặc điểm c&acirc;y trồng v&agrave; đ&uacute;ng hướng dẫn th&igrave; l&aacute; c&acirc;y mới hấp thụ cao được.</p>

<p><strong>Khi n&agrave;o bắt buộc phải b&oacute;n ph&acirc;n qua l&aacute;:</strong>&ndash; Rễ c&ograve;n đầy đủ nhưng c&acirc;y kh&ocirc;ng hấp thu được dinh dưỡng. Nguy&ecirc;n nh&acirc;n l&agrave; do: Chất dinh dưỡng bị bất động h&oacute;a do c&aacute;c vi sinh vật; Chất dinh dưỡng bị cố định do m&ocirc;i trường đất v&agrave; c&aacute;c chất hữu cơ; Sự nhiễm mặn (độ EC qu&aacute; cao sẽ giới hạn khả năng hấp thụ nước của rễ c&acirc;y); Sự bất động li&ecirc;n hệ tới độ pH (sự oxy h&oacute;a kim loại ở độ pH cao hoặc sự bất động của Mo ở pH thấp); Sự bất c&acirc;n đối dinh dưỡng trong đất (sự đối kh&aacute;ng giữa c&aacute;c ion như K v&agrave; Ca); Thiếu oxy (đất ngập nước); Sự hoạt động của rễ thấp (nhiệt độ thấp quanh v&ugrave;ng rễ trong thời kỳ ra hoa v&agrave; đậu tr&aacute;i); Thiếu nước để c&aacute;c chất dinh dưỡng ngấm v&agrave;o (kh&ocirc; hạn).</p>

<p>&ndash; Rễ bị tổn thương hoặc kh&ocirc;ng c&ograve;n do c&ocirc;n tr&ugrave;ng, nấm bệnh tấn c&ocirc;ng hoặc tổn thương cơ học (do xới x&aacute;o khi chăm b&oacute;n l&agrave;m đứt rễ).</p>

<p>&ndash; Rễ vẫn hấp thu nhưng c&acirc;y đang cần một lượng lớn chất dinh dưỡng v&agrave;o thời kỳ ra hoa, kết tr&aacute;i. Muốn c&acirc;y tăng năng suất, phải phun th&ecirc;m qua l&aacute;.</p>

<p>&ndash; B&oacute;n ph&acirc;n qua l&aacute; cũng c&oacute; thể được chỉ định khi nhu cầu tập trung dinh dưỡng v&agrave;o c&aacute;c vị tr&iacute; chuy&ecirc;n biệt b&ecirc;n trong c&acirc;y vượt qu&aacute; khả năng ph&acirc;n phối dinh dưỡng b&ecirc;n trong c&acirc;y.</p>

<p>+ Điều n&agrave;y thường xảy ra nhất trong những v&ugrave;ng trọng điểm của c&aacute;c loại tr&aacute;i c&acirc;y lớn hoặc c&aacute;c ch&ugrave;m đậu v&agrave; li&ecirc;n quan tới cả hai sự kiện l&agrave; nhu cầu tập trung cao độ v&agrave;o một v&ugrave;ng chuy&ecirc;n biệt nhiều nguy&ecirc;n tố trong tr&aacute;i c&acirc;y như N, K v&agrave; hệ quả của khả năng cơ động thấp ở c&aacute;c m&ocirc; libe đối với một số nguy&ecirc;n tố n&agrave;o đ&oacute;, như Ca, B chẳng hạn.</p>

<p>+ Khả năng cơ động c&aacute;c nguy&ecirc;n tố b&ecirc;n trong c&acirc;y cũng c&oacute; thể bị hạn chế nếu hoa ph&aacute;t triển trước l&aacute; v&agrave; do đ&oacute; dẫn đến t&igrave;nh trạng hạn chế sự chuyển dịch dinh dưỡng trong c&aacute;c m&ocirc; mao dẫn.</p>

<p>+ Trong c&aacute;c thời kỳ hạn h&aacute;n hoặc ẩm độ kh&ocirc;ng kh&iacute; cao cũng c&oacute; thể hạn chế sự chuyển vận trong c&aacute;c mạch mao dẫn v&agrave; ngăn cản sự ph&acirc;n phối c&aacute;c dưỡng chất bất động bởi c&aacute;c m&ocirc; libe.</p>
', NULL, N'phan-vi-sinh-phun-qua-la-–-cho-cay-cong-nghiep', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3190, 3096, 2, N'Phân phun qua lá', N'Phân phun qua lá', NULL, NULL, N'phan-phun-qua-la', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân Vi sinh phun qua lá – cho cây công nghiệp', N'Phân phun qua lá', N'Phân phun qua lá', N'Phân phun qua lá')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3191, 3097, 1, N'Phân bón lá vx-09', N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá', N'<p>fsadf</p>
', NULL, N'phan-bon-la-vx09', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3192, 3097, 2, N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá', N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá', N'<p>fsadf</p>
', NULL, N'phan-bon-la-vx09-sieu-chong-nghet-re-va-vang-la', NULL, NULL, NULL, NULL, NULL, NULL, N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09', N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá', N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá', N'Phân bón lá vx-09 siêu chống nghẹt rễ và vàng lá')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3193, 3098, 1, N'Giới thiệu', N'Chúng tôi là ai', N'<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="row-wrapper-x">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p><span style="color:rgb(99, 99, 99); font-family:tahoma,geneva,sans-serif; font-size:12px">Ch&uacute;ng t&ocirc;i l&agrave; những Anh Em lu&ocirc;n lu&ocirc;n kh&ocirc;ng ngừng ph&aacute;t triển khoa học c&ocirc;ng nghệ. Tập thể c&aacute;n bộ, kỹ sư EPM &nbsp;l&agrave; một đội ngũ trẻ, được đ&agrave;o tạo b&agrave;i bản, chuy&ecirc;n nghiệp nhiều kinh nghiệm triển khai c&aacute;c dự &aacute;n Thương mại điện tử, B2C, B2B, C&aacute;c dự &aacute;n Marketing Online&nbsp;cho doanhh nghiệp, c&oacute; ho&agrave;i b&atilde;o, say m&ecirc; chinh phục khoa học c&ocirc;ng nghệ v&agrave; lu&ocirc;n lao động hết m&igrave;nh để phục vụ kh&aacute;ch h&agrave;ng. Ch&uacute;ng t&ocirc;i lu&ocirc;n mang đến cho kh&aacute;ch h&agrave;ng những giải ph&aacute;p CNTT tối ưu nhất đồng thời hỗ trợ kh&aacute;ch h&agrave;ng nhằm đạt được những th&agrave;nh t&iacute;ch cao nhất trong c&ocirc;ng t&aacute;c v&agrave; s&aacute;t c&aacute;nh c&ugrave;ng kh&aacute;ch h&agrave;ng ph&aacute;t triển bền vững.</span><br />
&nbsp;</p>

<p><strong>Non Stop - Kh&ocirc;ng ngừng ph&aacute;t triển</strong><span style="color:rgb(99, 99, 99); font-family:tahoma,geneva,sans-serif; font-size:12px">: Đội ngũ EPM&nbsp;kh&ocirc;ng ngừng học hỏi, lu&ocirc;n lu&ocirc;n cập nhật những giải ph&aacute;p c&ocirc;ng nghệ ti&ecirc;n nhiết nhất, triển khai chuyển giao cho kh&aacute;ch h&agrave;ng, đi c&ugrave;ng với kh&aacute;ch h&agrave;ng ph&aacute;t triển bền vững.</span><br />
<br />
<strong>Expert - Chuy&ecirc;n nghiệp</strong><span style="color:rgb(99, 99, 99); font-family:tahoma,geneva,sans-serif; font-size:12px">: Thể hiện một doanh nghiệp lu&ocirc;n phấn đấu kh&ocirc;ng ngừng v&igrave; mục ti&ecirc;u x&acirc;y dựng nguồn nh&acirc;n lực chất lượng cao, c&aacute;c chuy&ecirc;n gia giỏi, c&aacute;c nh&agrave; quản l&yacute; c&oacute; năng lực thực sự. B&ecirc;n cạnh đ&oacute;, &aacute;p dụng quy tr&igrave;nh quản l&yacute; chất lượng chuẩn mực thống nhất, hiệu quả v&agrave; li&ecirc;n tục được cải tiến. Đ&acirc;y l&agrave; chiến lược ph&aacute;t triển l&acirc;u d&agrave;i, xuy&ecirc;n suốt v&agrave; li&ecirc;n tục m&agrave; EPM lu&ocirc;n nỗ lực ho&agrave;n thiện</span><br />
<br />
<strong>Trust - Sự tin cậy</strong><span style="color:rgb(99, 99, 99); font-family:tahoma,geneva,sans-serif; font-size:12px">: EPM&nbsp;Ch&uacute;ng t&ocirc;i lu&ocirc;n thể hiện h&igrave;nh ảnh của một doanh nghiệp đ&aacute;ng tin cậy, lu&ocirc;n giữ vững uy t&iacute;n của m&igrave;nh th&ocirc;ng qua những cam kết l&acirc;u d&agrave;i với kh&aacute;ch h&agrave;ng, cam kết bảo mật mọi th&ocirc;ng tin dữ liệu khi ch&uacute;ng t&ocirc;i l&agrave;m việc với kh&aacute;ch h&agrave;ng.</span></p>

<p>&nbsp;</p>
</div>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="" src="/Admin/Images/services.png" style="height:300px; width:500px" /></div>
</div>

<hr /></div>
</div>
</div>
</div>

<div class="wpb_row vc_row-fluid " style="top: 0px;">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12 ">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</div>
</div>

<div class="row-wrapper-x">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12 meeting">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr />
<div class="max-title max-title4">
<h3>meet <strong>our team</strong></h3>
</div>

<hr />
<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="" src="/Admin/Images/TUVANVIEN.jpg" style="height:296px; width:270px" />
<h3>Niki Andrews</h3>

<h5>Chief Customer Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="" src="/Admin/Images/mr-khanh.png" style="height:300px; width:307px" />
<h3>Tom Ford</h3>

<h5>Chief Product Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="" src="/Admin/Images/IMG_0195.JPG" style="height:300px; width:225px" />
<h3>Sarah Peterson</h3>

<h5>Chief Technology Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="" src="/Admin/Images/Nguyen_Thanh_An.jpg" style="height:300px; width:270px" />
<h3>David Anderson</h3>

<h5>Executive Vice President</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>
</div>

<hr /></div>
</div>
</div>
</div>
</div>
</div>
', NULL, N'gioi-thieu', NULL, NULL, NULL, NULL, NULL, NULL, N'Giới thiệu', N'Giới thiệu', N'Giới thiệu', N'Giới thiệu', N'Giới thiệu', N'Giới thiệu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3194, 3098, 2, N'Introduction', N'Introduction', N'<div class="row-wrapper-x" style="line-height: 20.8px;">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>Easyhost offers superior, reliable and affordable Web Hosting to individuals and small businesses. Founded in 2001, Easyhost has quickly grown to become a leader in Performance Web Hosting</p>

<h5><strong>Philosophy</strong></h5>

<p>Our company philosophy is to create the kind of website that most businesses want: easy to find, stylish and appealing, quick loading, mobile responsive and easy to buy from.</p>

<h5><strong>Mission</strong></h5>

<p>We&rsquo;ve designed our entire process and products around providing everything a small businesses needs when they&rsquo;re starting out &ndash; ensuring that working with us is always a quick, easy and hassle-free experience. We give our clients full control of their website without a ridiculous price tag, and our friendly team offers their expertise even after your website is live</p>
</div>
</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="add12" class="attachment-full vc_single_image-img" src="http://webnus.biz/themes/easyweb/host/wp-content/uploads/2016/02/add12.jpg?0200da" style="height:506px; width:576px" /></div>
</div>

<hr /></div>
</div>
</div>
</div>

<div class="wpb_row vc_row-fluid " style="line-height: 20.8px; top: 0px;">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</div>
</div>

<div class="row-wrapper-x" style="line-height: 20.8px;">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row" style="line-height: 20.8px;">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12 meeting">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr />
<div class="max-title max-title4">
<h2>meet&nbsp;<strong>our team</strong></h2>
</div>

<hr />
<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="Niki Andrews" src="http://webnus.biz/themes/easyweb/host/wp-content/uploads/2016/01/ourteam4_02.jpg?0200da" />
<h3>Niki Andrews</h2>

<h5>Chief Customer Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="Tom Ford" src="http://webnus.biz/themes/easyweb/host/wp-content/uploads/2016/01/ourteam4_03.jpg?0200da" />
<h3>Tom Ford</h2>

<h5>Chief Product Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="Sarah Peterson" src="http://webnus.biz/themes/easyweb/host/wp-content/uploads/2016/01/ourteam4_01.jpg?0200da" />
<h3>Sarah Peterson</h2>

<h5>Chief Technology Officer</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper"><img alt="David Anderson" src="http://webnus.biz/themes/easyweb/host/wp-content/uploads/2016/01/ourteam4_04.jpg?0200da" />
<h3>David Anderson</h2>

<h5>Executive Vice President</h5>

<div class="social-team">&nbsp;</div>

<hr /></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
', NULL, N'introduction', NULL, NULL, NULL, NULL, NULL, NULL, N'Giới thiệu', N'Giới thiệu', N'Introduction', N'Introduction', N'Introduction', N'Introduction')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3195, 3099, 1, N'Slogon Template', NULL, N'<p>Mang đến sự thịnh vượn, bền vững cho nền c&ocirc;ng nghệ số</p>
', NULL, N'slogon-template', NULL, NULL, NULL, NULL, NULL, NULL, N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3196, 3099, 2, N'Slogon Template', N'Mang đến sự thịnh vượn, bền vững cho nền nông nghiệp', NULL, NULL, N'slogon-template', NULL, NULL, NULL, NULL, NULL, NULL, N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template', N'Slogon Template')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3197, 3100, 1, N'a', N'aafsd', N'<p>fdsafsdaf</p>
', NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'a', N'a', N'a', N'a', N'a', N'a')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3198, 3100, 2, N'a', N'aafsd', NULL, NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'a', N'a', N'a', N'a', N'a', N'a')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3199, 3101, 1, N'shop xe đạp', N'shop xe đạp', N'<p>G1G1G1G1G1</p>
', NULL, N'shop-xe-dap', NULL, NULL, NULL, NULL, NULL, NULL, N'shop xe đạp', N'shop xe đạp', N'shop xe đạp', N'shop xe đạp', N'shop xe đạp', N'shop xe đạp')
GO
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3200, 3101, 2, N'Ly thủy tinh', N'Ly thủy tinh', NULL, NULL, N'ly-thuy-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'shop xe đạp', N'shop xe đạp', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh', N'Ly thủy tinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3203, 3103, 1, N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi sẽ tư vấn giúp bạn xây dựng thương hiệu vững mạnh, ý tưởng sáng tạo và độc đáo mang lại chiến dịch tiếp thị cho doanh nghiệp bạn luôn luôn gắn liền với cuộc sống thân thiện , phong phú,..', NULL, NULL, N'chung-toi-la-doi-ngu-sang-tao', NULL, NULL, NULL, NULL, NULL, NULL, N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3204, 3103, 2, N'Tính năng FB', N'Tính năng FB', NULL, NULL, N'tinh-nang-fb', NULL, NULL, NULL, NULL, NULL, NULL, N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Chúng tôi là đội ngũ sáng tạo', N'Tính năng FB', N'Tính năng FB', N'Tính năng FB')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3209, 3106, 1, N'Dịch vụ SEO Website', N'Dễ dàng SEO phục vụ cho những khách hàng đòi hỏi một cách tiếp cận đầy đủ các dịch vụ chuyên sâu để tìm kiếm tiếp thị công cụ', NULL, NULL, N'dich-vu-seo-website', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3210, 3106, 2, N'Chỉnh sửa giao diện website của bạn', N'Bạn có thể hoàn toàn tự chỉnh sửa mọi thứ trên giao diện website của bạn, từ tên miền đến bố cục, màu sắc, nội dung', NULL, NULL, N'chinh-sua-giao-dien-website-cua-ban', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'SEO OPTIMIZATION', N'Chỉnh sửa giao diện website của bạn', N'Chỉnh sửa giao diện website của bạn', N'Chỉnh sửa giao diện website của bạn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3211, 3107, 1, N'Phát triển ứng dụng Web', N'Cách tiếp cận mới của chúng tôi để phát triển và xây dựng tình yêu sâu sắc đối với trang web của bạn', NULL, NULL, N'phat-trien-ung-dung-web', NULL, NULL, NULL, NULL, NULL, NULL, N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3212, 3107, 2, N'Không cần thiết kế', N'Bạn có thể chọn từ hàng trăm giao diện chuyên nghiệp, hướng tới người mua hàng hoặc tự thiết kế giao diện riêng bằng HTML và CSS', NULL, NULL, N'khong-can-thiet-ke', NULL, NULL, NULL, NULL, NULL, NULL, N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'WEB DEVELOPMENT', N'Không cần thiết kế', N'Không cần thiết kế', N'Không cần thiết kế')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3213, 3108, 1, N'Thiết kế Website', N'Một thiết kế trang web độc đáo là một phần quan trọng của xây dựng thương hiệu và tiếp thị quá trình kinh doanh của bạn', NULL, NULL, N'thiet-ke-website', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3214, 3108, 2, N'Quản trị thân thiện mobile', N'Quản lý website trên cả máy tính lẫn tablet, mobile, ở bất kì nơi đâu.', NULL, NULL, N'quan-tri-than-thien-mobile', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế Website', N'Thiết kế Website', N'WEBSITE DESIGN', N'Quản trị thân thiện mobile', N'Quản trị thân thiện mobile', N'Quản trị thân thiện mobile')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3215, 3109, 1, N'Mr.Dũng', N'CEO covi.vn', N'<p><span style="color:rgb(34, 34, 34); font-family:consolas,lucida console,monospace; font-size:12px">T&ocirc;i rất h&agrave;i l&ograve;ng với sản phẩm v&agrave;&nbsp;dịch vụ của EPM Design, dễ quản trị, cập nhật!</span></p>
', NULL, N'mrdung', NULL, NULL, NULL, NULL, NULL, NULL, N'Mr.Dũng', N'Mr.Dũng', N'Mr.Dũng', N'Mr.Dũng', N'Mr.Dũng', N'Mr.Dũng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3216, 3109, 2, N'John Smith', N'Media Agency', NULL, NULL, N'john-smith', NULL, NULL, NULL, NULL, NULL, NULL, N'Mr.Dũng', N'Mr.Dũng', N'Mr.Dũng', N'John Smith', N'John Smith', N'John Smith')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3217, 3110, 1, N'Giao diện', N'Hàng trăm mẫu giao diện chuyên nghiệp tương thích với nhiều loại thiết bị.', NULL, NULL, N'giao-dien', NULL, NULL, NULL, NULL, NULL, NULL, N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3218, 3110, 2, N'Giao diện', N'Hàng trăm mẫu giao diện chuyên nghiệp tương thích với nhiều loại thiết bị.', NULL, NULL, N'giao-dien', NULL, NULL, NULL, NULL, NULL, NULL, N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3221, 3112, 1, N'Giao diện', N'Hàng trăm mẫu giao diện chuyên nghiệp tương thích với nhiều loại thiết bị.', NULL, NULL, N'giao-dien', NULL, NULL, NULL, NULL, NULL, NULL, N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3222, 3112, 2, N'Giao diện', N'Hàng trăm mẫu giao diện chuyên nghiệp tương thích với nhiều loại thiết bị.', NULL, NULL, N'giao-dien', NULL, NULL, NULL, NULL, NULL, NULL, N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện', N'Giao diện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3229, 3116, 1, N'Tại sao chọn chúng tôi?', NULL, N'<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="" src="/ckfinder/userfiles/images/trans-pg-px6.jpg" style="width: 487px; height: 400px;" /></div>
</figure>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space4" />
<hr class="vertical-space2" />
<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Thực hiện tối ưu h&oacute;a Website</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Phương ph&aacute;p ph&aacute;t triển được chứng minh hiệu quả</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Tập trung v&agrave;o y&ecirc;u cầu kinh doanh giảm chi ph&iacute;, tăng doanh thu&nbsp;</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Chất lượng Website kh&ocirc;ng so s&aacute;nh được</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4><font><font>Ch&uacute;ng t&ocirc;i nhanh ch&oacute;ng đ&aacute;p ứng nhanh nhu cầu của&nbsp;kh&aacute;ch h&agrave;ng</font></font></h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4><font><font>Cung cấp c&aacute;c dịch vụ v&agrave; giải ph&aacute;p ph&ugrave; hợp cho doanh nghiệp của bạn</font></font></h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4><font><font>Kh&ocirc;ng lo lắng v&igrave; ch&uacute;ng t&ocirc;i c&oacute;&nbsp;đội ngũ chuy&ecirc;n gia&nbsp;ph&aacute;t triển web kinh nghiệm</font></font></h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>C&aacute;c chuy&ecirc;n gia ph&aacute;t triển Web được chứng nhận c&aacute;c chứng chỉ quốc tế</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4><font><font>Ch&uacute;ng t&ocirc;i x&acirc;y dựng website&nbsp;tự động tương&nbsp;th&iacute;ch&nbsp;với c&aacute;c&nbsp;m&agrave;n h&igrave;nh thiết bị</font></font></h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Kinh nghiệm quản l&yacute; c&aacute;c dự &aacute;n lớn</h4>
</article>
</div>
</div>
</div>
</section>
', NULL, N'tai-sao-chon-chung-toi', NULL, NULL, NULL, NULL, NULL, NULL, N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3230, 3116, 2, N'WHY CHOOSE US', NULL, N'<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px6" class="vc_single_image-img attachment-full" height="476" sizes="(max-width: 580px) 100vw, 580px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px6.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px6-300x246.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px6.jpg 580w" width="580" /></div>
</figure>
</div>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space4" />
<hr class="vertical-space2" />
<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>The Websites we make are optimized</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Our Agile Methodology of development is proven and effective</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Strong focus on business requirements and ROI</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>No compromise on quality of website</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>We&rsquo;re quick to response to the clients need</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Delivering services and solutions right for your business</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>No worrying as we have an expert web development team</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Our web developers are experienced and certified</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>We build responsive websites that auto adapt to device screens</h4>
</article>

<article class="icon-box5"><i class="sl-check" style=" color:#00c2e5;"></i>

<h4>Extensive project management experience</h4>
</article>
</div>
</div>
</div>
</section>
', NULL, N'why-choose-us', NULL, NULL, NULL, NULL, NULL, NULL, N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'Tại sao chọn chúng tôi?', N'WHY CHOOSE US', N'WHY CHOOSE US', N'WHY CHOOSE US')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3231, 3117, 1, N'Website doanh nghiệp', N'CHO MỘT WEBSITE DOANH NGHIỆP THÀNH CÔNG', N'<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="w-pricing-table pt-type5">
<div class="pt-header">BRONZE
<h3>ADVANCED PLAN</h3>

<h4>$43,15<small>/MO</small></h4>

<h5>Or $354 Yearly!</h5>
</div>

<ul>
	<li>1 Website</li>
	<li>Free domain with annual plan</li>
	<li>100 GB Storage</li>
	<li>Unlimited Bandwidth</li>
	<li>1000 Email Addresses</li>
</ul>

<div class="pt-footer"><a class="magicmore" href="#">get started</a></div>
</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="w-pricing-table pt-type5">
<div class="pt-header">silver
<h3>ADVANCED PLAN</h3>

<h4>$43,15<small>/MO</small></h4>

<h5>Or $354 Yearly!</h5>
</div>

<ul>
	<li>1 Website</li>
	<li>Free domain with annual plan</li>
	<li>100 GB Storage</li>
	<li>Unlimited Bandwidth</li>
	<li>1000 Email Addresses</li>
</ul>

<div class="pt-footer"><a class="magicmore" href="#">get started</a></div>
</div>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="w-pricing-table pt-type5">
<div class="pt-header">GOLD
<h3>ADVANCED PLAN</h3>

<h4>$43,15<small>/MO</small></h4>

<h5>Or $354 Yearly!</h5>
</div>

<ul>
	<li>1 Website</li>
	<li>Free domain with annual plan</li>
	<li>100 GB Storage</li>
	<li>Unlimited Bandwidth</li>
	<li>1000 Email Addresses</li>
</ul>

<div class="pt-footer"><a class="magicmore" href="#">get started</a></div>
</div>

<hr /></div>
</div>
</div>
', NULL, N'website-doanh-nghiep', NULL, NULL, NULL, NULL, NULL, NULL, N'Website doanh nghiệp', N'Website doanh nghiệp', N'Website doanh nghiệp', N'Website doanh nghiệp', N'Website doanh nghiệp', N'Website doanh nghiệp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3232, 3117, 2, N'a', N'a', NULL, NULL, N'a', NULL, NULL, NULL, NULL, NULL, NULL, N'Website doanh nghiệp', N'Website doanh nghiệp', N'Website doanh nghiệp', N'a', N'a', N'a')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3233, 3118, 1, N'Website cho doanh nghiệp', N'CÔNG NGHỆ HIỆN ĐẠI HÃY LỰA CHỌN NHANH', N'<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link href="/Plugin/bang-gia-chili-comp/Content/banggiacomp.css" rel="stylesheet" />
<div class="main-page page-chilicomp">
<section class="section no-padding">
<div class="container">
<div class="heading-page lagre-heading text-uppercase"><span style="font-size:24px;">CHO MỘT WEBSITE DOANH NGHIỆP TH&Agrave;NH C&Ocirc;NG</span></div>

<div class="row">
<div class="col-md-12">
<div class="tbl-price-package chili-comp-pack-info">
<div class="heading-table-price-stt clearfix">
<div class="column stt-question"><span class="q-caption">BẠN CHỌN G&Oacute;I N&Agrave;O</span> <span class="q-symbol">?</span></div>

<div class="column stt-package-name">
<div class="package-child-name">Start COMP</div>

<div class="price">99.000</div>
<span>VNĐ / Th&aacute;ng</span></div>

<div class="column stt-package-name popular">
<div class="package-child-name">Speed COMP</div>

<div class="price">199.000</div>
<span>VNĐ / Th&aacute;ng</span></div>

<div class="column stt-package-name stt-supperspeed-name">
<div class="package-child-name">Success COMP</div>

<div class="price">299.000</div>
<span>VNĐ / Th&aacute;ng</span></div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Quản trị nội dung<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Số lượng b&agrave;i viết <i class="fa fa-question-circle tooltips" title="Số lượng bài viết tối đa có thể nhập vào website."></i></span></div>

<div class="column package-1 module-value"><span class="f-20">200</span></div>

<div class="column package-2 module-value"><span class="f-20">500</span></div>

<div class="column package-3 module-value"><span class="f-20">1.000</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Quản l&yacute; theo chuy&ecirc;n mục <i class="fa fa-question-circle tooltips" title="Giúp quá trình quản lý bài viết dễ dàng hơn."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Xem trước khi xuất bản <i class="fa fa-question-circle tooltips" title="Giúp hạn chế việc xảy ra sai lỗi trong khi nhập bài viết."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Nội dung nh&aacute;p <i class="fa fa-question-circle tooltips" title="Giúp bạn lưu trữ những bài viết cho website mà chưa muốn cho hiển thị ra ngoài."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>C&ocirc;ng cụ bi&ecirc;n soạn trực quan <i class="fa fa-question-circle tooltips" title="Giao diện soạn thảo rõ ràng, công cụ hỗ trợ soạn thảo phong phú."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>C&aacute; nh&acirc;n h&oacute;a c&ocirc;ng cụ soạn thảo <i class="fa fa-question-circle tooltips" title="Hỗ trợ bổ sung chức năng cho công cụ soạn thảo."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Ng&ocirc;n ngữ <i class="fa fa-question-circle tooltips" title="Số lượng ngôn ngữ được hiển thị trên website."></i></span></div>

<div class="column package-1 module-value"><span>Đa ng&ocirc;n ngữ<em>*</em></span></div>

<div class="column package-2 module-value"><span>Đa ng&ocirc;n ngữ<em>*</em></span></div>

<div class="column package-3 module-value"><span>Đa ng&ocirc;n ngữ<em>*</em></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Quản l&yacute; h&igrave;nh ảnh<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Thư viện h&igrave;nh ảnh <i class="fa fa-question-circle tooltips" title="Quản lý hình ảnh dễ dàng."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Ph&oacute;ng to thu nhỏ ảnh <i class="fa fa-question-circle tooltips" title="Hình ảnh có thể dễ dàng được tùy chỉnh kích thước."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Cắt ảnh <i class="fa fa-question-circle tooltips" title="Cắt ảnh theo tỉ lệ, kích thước,…"></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Xoay ảnh <i class="fa fa-question-circle tooltips" title="Xoay chiều ảnh linh hoạt."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Thiết kế banner <i class="fa fa-question-circle tooltips" title="Hỗ trợ thiết kế banner cho website."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Giao diện - Bố cục<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Th&ecirc;m bớt menu ch&iacute;nh <i class="fa fa-question-circle tooltips" title="Bổ sung thêm menu chính để làm cho nội dung website của bạn thêm phong phú."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Điều chỉnh bố cục trang <i class="fa fa-question-circle tooltips" title="Sắp xếp lại bố cục các phần của trang mà không ảnh hưởng đến tính năng của nó."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Tương th&iacute;ch thiết bị di động <i class="fa fa-question-circle tooltips" title="Dựa trên kỹ thuật Responsive, giao diện sẽ tự động điều chỉnh kích thước và bố cục để phù hợp khi xem trên PC, Smartphone hoặc máy tính bảng."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Đổi giao diện kh&aacute;c<em>* </em><i class="fa fa-question-circle tooltips" title="Thay đổi giao diện của website, bạn chỉ được chọn các mẫu cần thay đổi trong cùng phân hệ CHILI Comp. Việc thay đổi mẫu sẽ không làm mất dữ liệu hiện có trên website của bạn."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>T&ugrave;y chỉnh m&agrave;u sắc<em>* </em><i class="fa fa-question-circle tooltips" title="Bạn không thích màu mặc định hoặc muốn đổi mới website. CHILI sẽ hỗ trợ thay đổi tone màu chủ đạo của website."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Chức năng li&ecirc;n hệ<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Form li&ecirc;n hệ <i class="fa fa-question-circle tooltips" title="Form mẫu dành cho khách hàng khi gửi thông tin liên hệ từ website."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Quản l&yacute; nhiều form <i class="fa fa-question-circle tooltips" title="Bạn có thể quản lý nhiều kiểu form liên hệ chuyên nghiệp khác nhau."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-close"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>T&ugrave;y chỉnh nội dung form <i class="fa fa-question-circle tooltips" title="Nội dung form liên hệ có thể được tùy chỉnh dễ dàng."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Nhận mail khi c&oacute; li&ecirc;n hệ <i class="fa fa-question-circle tooltips" title="Khi khách hàng gửi liên hệ từ website, bạn sẽ nhận được mail thông báo."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>T&iacute;ch hợp m&atilde; chống spam (reCaptcha) <i class="fa fa-question-circle tooltips" title="Việc tạo mã recaptcha giúp chống auto spam, chống đăng nhập tự động…"></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Quản l&yacute; người d&ugrave;ng<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Quản l&yacute; th&ocirc;ng tin c&aacute; nh&acirc;n <i class="fa fa-question-circle tooltips" title="Thông tin cá nhân của thành viên quản trị có thể được chỉnh sửa và quản lý dễ dàng."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Tạo th&ecirc;m người d&ugrave;ng cung cấp <i class="fa fa-question-circle tooltips" title="Tạo thêm người dùng cung cấp nhanh chóng"></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-close"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">SEO - Mạng x&atilde; hội<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Đường dẫn th&acirc;n thiện <i class="fa fa-question-circle tooltips" title="Giúp người dùng dễ hiều và dễ nhớ hơn đồng thời nó cũng hỗ trợ cho việc SEO website."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>T&ugrave;y chỉnh URL <i class="fa fa-question-circle tooltips" title="Tùy chỉnh URL để hỗ trợ SEO cho website của bạn."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Thay đổi quy tắc URL <i class="fa fa-question-circle tooltips" title="Quy tắc thiết lập đường dẫn URL có thể thay đổi linh hoạt."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Like, share Facebook <i class="fa fa-question-circle tooltips" title="Liên kết like, share facebook để đem bài viết của website tới với nhiều đối tượng khách hàng hơn."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Facebook comment <i class="fa fa-question-circle tooltips" title="Giúp website của bạn tương tác với người dùng của mạng xã hội facebook."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>
<!--/buy button-->

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Th&ocirc;ng số hosting<span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Dung lượng <i class="fa fa-question-circle tooltips" title="Là tổng dung lượng ổ cứng trên máy chủ để bạn lưu trữ dữ liệu cho website của mình."></i></span></div>

<div class="column package-1 module-value"><span>300 MB</span></div>

<div class="column package-2 module-value"><span>Kh&ocirc;ng giới hạn</span></div>

<div class="column package-3 module-value"><span>Kh&ocirc;ng giới hạn</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Băng th&ocirc;ng <i class="fa fa-question-circle tooltips" title="Khi sử dụng dịch vụ của CHILI, bạn không cần bận tâm về băng thông, cho dù có rất nhiều khách truy cập vào website của bạn hàng tháng thì CHILI vẫn đảm bảo sự ổn định."></i></span></div>

<div class="column package-1 module-value"><span>Kh&ocirc;ng giới hạn</span></div>

<div class="column package-2 module-value"><span>Kh&ocirc;ng giới hạn</span></div>

<div class="column package-3 module-value"><span>Kh&ocirc;ng giới hạn</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Chạy với t&ecirc;n miền ri&ecirc;ng <i class="fa fa-question-circle tooltips" title="Chạy website của bạn với 1 tên miền tùy chọn bất kỳ."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>

<div class="group-module clearfix">
<div class="heading-group-module clearfix">Khuyến m&atilde;i <span></span></div>

<div class="group-module-content clearfix">
<div class="row-module clearfix">
<div class="column module-name"><span>Miễn ph&iacute; t&ecirc;n miền <i class="fa fa-question-circle tooltips" title="Dòng địa chỉ để người dùng nhập vào trình duyệt khi muốn truy cập Website của bạn."></i></span></div>

<div class="column package-1 module-value"><span>epmdesign.vn</span></div>

<div class="column package-2 module-value"><span>T&ecirc;n miền Quốc tế năm đầu</span></div>

<div class="column package-3 module-value"><span>T&ecirc;n miền Quốc tế theo giời gian đăng k&yacute;</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Hỗ trợ nhập th&ocirc;ng tin cơ bản <i class="fa fa-question-circle tooltips" title="Bao gồm bài viết và sản phẩm."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Thiết kế banner lần đầu <i class="fa fa-question-circle tooltips" title="Hỗ trợ thiết kế banner lần đầu tiên cho website của bạn."></i></span></div>

<div class="column package-1 module-value"><span>1 banner</span></div>

<div class="column package-2 module-value"><span>3 banner</span></div>

<div class="column package-3 module-value"><span>5 banner</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Nhập liệu lần đầu ti&ecirc;n <i class="fa fa-question-circle tooltips" title="Hỗ trợ nhập liệu lần đầu tiên cho website của bạn."></i></span></div>

<div class="column package-1 module-value"><span>20 b&agrave;i viết</span></div>

<div class="column package-2 module-value"><span>60 b&agrave;i viết</span></div>

<div class="column package-3 module-value"><span>80 b&agrave;i viết</span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Ẩn logo EPM&nbsp;<i class="fa fa-question-circle tooltips" title="Ẩn dòng thông tin bản quyền về CHILI dưới chân trang."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-close"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-close"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Trang đang x&acirc;y dựng <i class="fa fa-question-circle tooltips" title="Trang thay thế khi khách hàng vào website của bạn trong thời gian bảo trì, nâng cấp."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>

<div class="row-module clearfix">
<div class="column module-name"><span>Hỗ trợ theo chuẩn 525.600 <i class="fa fa-question-circle tooltips" title="Cam kết phục vụ bằng sự hiểu biết và tận tâm. Nhân viên Hỗ trợ của chúng tôi làm việc liên tục để đem lại sự an tâm cho bạn."></i></span></div>

<div class="column package-1 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-2 module-value"><span><i class="fa fa-check"></i></span></div>

<div class="column package-3 module-value"><span><i class="fa fa-check"></i></span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
</div>
', NULL, N'website-cho-doanh-nghiep', NULL, NULL, NULL, NULL, NULL, NULL, N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho doanh nghiệp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3234, 3118, 2, N'Website cho shop', N'NỀN TẢNG CHO SHOP MUA MAY BÁN ĐẮT', N'<p><iframe frameborder="0" scrolling="yes" src="/Plugin/bang-gia-chili-comp/bang-gia-comp.html"></iframe></p>
', NULL, N'website-cho-shop', NULL, NULL, NULL, NULL, NULL, NULL, N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho doanh nghiệp', N'Website cho shop', N'Website cho shop', N'Website cho shop')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3235, 3119, 1, N'Nhóm hỗ trợ luôn sẵn sàng', N'Đội hỗ trợ của chúng tôi là luôn bên bạn bất cứ khi nào, bất kỳ nơi đâu.', NULL, NULL, N'nhom-ho-tro-luon-san-sang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3236, 3119, 2, N'Nhóm hỗ trợ luôn sẵn sàng', N'Đội hỗ trợ của chúng tôi là luôn bên bạn bất cứ khi nào, bất kỳ nơi đâu.', NULL, NULL, N'nhom-ho-tro-luon-san-sang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3237, 3120, 1, N'Dịch vụ tích hợp hoàn chỉnh', N'Chúng tôi có thể cung cấp một giải pháp tổng thể đầy đủ ngoài việc thiết kế website và Marketing Online', NULL, NULL, N'dich-vu-tich-hop-hoan-chinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3238, 3120, 2, N'Dịch vụ tích hợp hoàn chỉnh', N'Chúng tôi có thể cung cấp một dịch vụ đầy đủ ngoài việc thiết kế website ban đầu', NULL, NULL, N'dich-vu-tich-hop-hoan-chinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh', N'Dịch vụ tích hợp hoàn chỉnh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3239, 3121, 1, N'Nhóm hỗ trợ luôn sẵn sàng', N'Đội hỗ trợ của chúng tôi luôn bên bạn bất cứ khi nào, bất kỳ nơi đâu.', N'<div class="tool-content-title" style="box-sizing: border-box; text-align: center; margin-bottom: 90px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; line-height: 18.5714px;">
<h1>&nbsp;</h1>
</div>
', NULL, N'nhom-ho-tro-luon-san-sang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3240, 3121, 2, N'Nhóm hỗ trợ luôn sẵn sàng', N'Đội hỗ trợ của chúng tôi luôn bên bạn bất cứ khi nào, bất kỳ nơi đâu.', NULL, NULL, N'nhom-ho-tro-luon-san-sang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng', N'Nhóm hỗ trợ luôn sẵn sàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3241, 3122, 1, N'Quy trình', NULL, N'<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="buy-process-wrap">
<div class="buy-process-items">
<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Planning</strong></h4>

<p>Hiểu những g&igrave; bạn muốn cho trang web của bạn v&agrave; l&agrave;m thế n&agrave;o để bạn thực hiện n&oacute;.</p>
</div>
<span>1</span>

<div class="icon-wrapper"><i class="fa fa-calendar"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Development</strong></h4>

<p>Ch&uacute;ng t&ocirc;i ph&aacute;t triển hệ thống quản l&yacute; nội dung cho kh&aacute;ch h&agrave;ng, gi&uacute;p kh&aacute;ch h&agrave;ng dễ d&agrave;ng sử dụng nhất</p>
</div>
<span>2</span>

<div class="icon-wrapper"><i class="fa fa-keyboard-o"></i></div>
</div>

<div class="buy-process-item featured">
<div class="text-wrap">
<h4><strong>Review & Test</strong></h4>

<p>Sau khi trang web đ&atilde; sẵn s&agrave;ng, n&oacute; sẽ được kiểm tra v&agrave; thử nghiệm để đảm bảo chạy tốt nhất</p>
</div>
<span>3</span>

<div class="icon-wrapper"><i class="fa fa-flask"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Launch </strong></h4>

<p>Sau khi thử nghiệm th&agrave;nh c&ocirc;ng c&aacute;c sản phẩm được đưa v&agrave;o webssite / triển khai cho kh&aacute;ch h&agrave;ng họ sử dụng</p>
</div>
<span>4</span>

<div class="icon-wrapper"><i class="fa fa-paper-plane"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Maintenance</strong></h4>

<p>Đ&acirc;y l&agrave; một bước quan trọng m&agrave; chắc chắn rằng trang web của bạn hoạt động c&oacute; hiệu quả nhất cho mọi l&uacute;c</p>
</div>
<span>5</span>

<div class="icon-wrapper"><i class="fa fa-shield"></i></div>
</div>
</div>
</div>
</div>
</div>
</div>
', NULL, N'quy-trinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Quy trình', N'Quy trình', N'Quy trình', N'Quy trình', N'Quy trình', N'Quy trình')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3242, 3122, 2, N'OUR PROCESS', NULL, N'<section class="wpb_row   w-animate full-row w-start_animation"><div class="wpb_column vc_column_container vc_col-sm-12"><div class="vc_column-inner "><div class="wpb_wrapper"><div class="buy-process-wrap"><div class="buy-process-items"><div class="buy-process-item"><div class="text-wrap"><h4><strong>Planning</strong></h4><p>Understanding what you want out of your site and how do you plant to implement it.</p></div> <span>1</span><div class="icon-wrapper"> <i class="fa fa-calendar"></i></div></div><div class="buy-process-item"><div class="text-wrap"><h4><strong>Development</strong></h4><p>We develop content management systems for clients who need more than just the basics</p></div> <span>2</span><div class="icon-wrapper"> <i class="fa fa-keyboard-o"></i></div></div><div class="buy-process-item featured"><div class="text-wrap"><h4><strong>Review & Test</strong></h4><p>Once the site is ready, it should be checked and tested to ensure an error free working</p></div> <span>3</span><div class="icon-wrapper"> <i class="fa fa-flask"></i></div></div><div class="buy-process-item"><div class="text-wrap"><h4><strong>Launch </strong></h4><p>After successful testing the product is delivered / deployed to the customer for their use</p></div> <span>4</span><div class="icon-wrapper"> <i class="fa fa-paper-plane"></i></div></div><div class="buy-process-item"><div class="text-wrap"><h4><strong>Maintenance</strong></h4><p>It is an important step which makes sure that your site works with efficiency all the time</p></div> <span>5</span><div class="icon-wrapper"> <i class="fa fa-shield"></i></div></div></div></div></div></div></div></section>', NULL, N'our-process', NULL, NULL, NULL, NULL, NULL, NULL, N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS', N'OUR PROCESS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3243, 3123, 1, N'Thiết kế Website', N'EPM Design sẽ làm việc với bạn để tìm ra những gì bạn cần từ trang web của bạn', N'<p><img alt="" src="/Admin/Images/tkw.jpg" style="float:right; height:393px; width:420px" />C&aacute;c trang web ch&uacute;ng t&ocirc;i sản xuất được sạch sẽ v&agrave; tươi mới, mỗi thiết kế độc đ&aacute;o.&nbsp;Hơn nữa, ch&uacute;ng t&ocirc;i nỗ lực để đảm bảo tất cả c&aacute;c trang web của ch&uacute;ng t&ocirc;i đ&aacute;p ứng c&aacute;c ti&ecirc;u chuẩn tiếp cận theo y&ecirc;u cầu của Hiệp hội World Wide Web.&nbsp;trang web của ch&uacute;ng t&ocirc;i được kiểm tra ở c&aacute;c tr&igrave;nh duyệt th&ocirc;ng dụng nhất ở độ ph&acirc;n giải m&agrave;n h&igrave;nh kh&aacute;c nhau.​</p>
', NULL, N'thiet-ke-website', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website', N'Thiết kế Website')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3244, 3123, 2, N'WEBSITE DESIGN', N'Affordable Website Design & Development', N'<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-8">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<hr class="vertical-space2" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>Affordable Website Design & Development</strong></h3>

<p style="text-align: center;"><strong>Web designing is an art!</strong> Your website design shows your business insight. A well known saying is <em>&ldquo;First impression is the lasting one&rdquo;</em>. In web technologies, your website is the first entity that interacts with the visitor, so your website should speak itself!</p>

<p style="text-align: center;">The websites we produce are clean and fresh, <strong>each uniquely designed</strong>. Furthermore, we endeavor to ensure all our sites meet the accessibility standards demanded by the <a href="http://en.wikipedia.org/wiki/W3C">World Wide Web Consortium</a>. Our websites are tested in the most commonly used browsers at different screen resolutions.</p>
</div>
</div>

<hr class="vertical-space1" />
<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h1 style="text-align: center;">Service <strong>Process</strong></h1>
</div>
</div>

<div class="our-process-wrap">
<div class="our-process-item "><i class="fa fa-lightbulb-o"></i>

<h4><strong>STRATEGY</strong></h4>

<p>Define objective brand analysis, keyword research and positioning strategy.</p>
</div>

<div class="our-process-item "><i class="fa fa-laptop"></i>

<h4><strong>DESIGN</strong></h4>

<p>We settle on some initial design drafts for your website and choose one concept.</p>
</div>

<div class="our-process-item "><i class="fa fa-keyboard-o"></i>

<h4><strong>DEVELOP</strong></h4>

<p>To make the content, information architecture, visual design all work and function together.</p>
</div>

<div class="our-process-item "><i class="fa fa-line-chart"></i>

<h4><strong>DEPLOY</strong></h4>

<p>Our team of experts are always available for any updates you may need.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>
</section>
</div>
</section>

<section class="blox      w-animate  w-start_animation" style="padding-top: px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h1 style="text-align: center;">Service&nbsp;<strong>Includes</strong></h1>
</div>
</div>

<hr class="vertical-space2" />
<div class="vc_row wpb_row vc_inner vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Responsive Website Design</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Usability and Competition Analysis</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Information Architecture Design</h4>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>User Experience Design</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Website Content Strategy</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Installation & Setup</h4>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>CMS and e-Commerce Integration</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Cross Browser and Platform Testing</h4>
</article>

<hr class="vertical-space1" />
<article class="icon-box5"><i class="sl-check" style=""></i>

<h4>Maintenance</h4>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>
</div>
</div>
</section>
', NULL, N'website-design', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế Website', N'Thiết kế Website', N'WEBSITE DESIGN', N'WEBSITE DESIGN', N'WEBSITE DESIGN', N'WEBSITE DESIGN')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3245, 3124, 1, N'Phát triển ứng dụng Web', N'Chúng tôi cung cấp dịch vụ phát triển web cho bất kỳ loại hình kinh doanh hoặc ngành công nghiệp', N'<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="aligncenter wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" /><i class="fa-keyboard-o" style="font-size: 64px; color: #d6d6d6;"></i>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>Development</strong></h3>

<p style="text-align: center;">When the limitations of the packaged CMS or E-commerce solution are standing in the way of the customers agenda we are offering our custom website development option. We have extensive experience developing sites and apps of all types, complexities and budgets.</p>
</div>
</div>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="aligncenter wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /><i class="li_bulb" style="font-size: 64px; color: #d6d6d6;"></i>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>Our Approach</strong></h3>

<p style="text-align: center;">Our approach is to go back to basics and work out what our clients &ndash; and their users &ndash; actually need to do. We build these from the ground up, using industry standard development frameworks so it&rsquo;s perfectly tailored to your needs and sustainable in the long term.</p>
</div>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</section>
</div>
</section>

<section class="blox      w-animate  w-start_animation" style="padding-top: 70px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f6f8f9;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="max-title max-title3">
<h2>Our <strong>Process</strong></h2>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">&nbsp;</div>
</section>

<section class="wpb_row   w-animate full-row w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="buy-process-wrap">
<div class="buy-process-items">
<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Planning</strong></h4>

<p>Understanding what you want out of your site and how do you plant to implement it.</p>
</div>
<span>1</span>

<div class="icon-wrapper"><i class="fa fa-calendar"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Development</strong></h4>

<p>We develop content management systems for clients who need more than just the basics</p>
</div>
<span>2</span>

<div class="icon-wrapper"><i class="fa fa-keyboard-o"></i></div>
</div>

<div class="buy-process-item featured">
<div class="text-wrap">
<h4><strong>Review & Test</strong></h4>

<p>Once the site is ready, it should be checked and tested to ensure an error free working</p>
</div>
<span>3</span>

<div class="icon-wrapper"><i class="fa fa-flask"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Launch </strong></h4>

<p>After successful testing the product is delivered / deployed to the customer for their use</p>
</div>
<span>4</span>

<div class="icon-wrapper"><i class="fa fa-paper-plane"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Maintenance</strong></h4>

<p>It is an important step which makes sure that your site works with efficiency all the time</p>
</div>
<span>5</span>

<div class="icon-wrapper"><i class="fa fa-shield"></i></div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="max-title max-title3">
<h2>What we <strong>Offer</strong></h2>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Web Enablement of Any Legacy Applications</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Customized Web Portal Solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Community Site Development</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Custom Social Network development</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>E Commerce Solutions</h4>
</article>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Internet and Intranet solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Specific Custom Applications as per client Demand</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Corporate Web Based Solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Business Applications</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Payment processor integrations</h4>
</article>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="max-title max-title3">
<h2>Why Choose <strong>Us</strong></h2>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>The Websites we make are optimized</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Our Agile Methodology of development is proven and effective</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Strong focus on business requirements and ROI</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>No compromise on quality of website</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>We&rsquo;re quick to response to the clients need</h4>
</article>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Delivering services and solutions right for your business</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>No worrying as we have an expert web development team</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Our web developers are experienced and certified</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>We build responsive websites that auto adapt to device screens</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Extensive project management experience</h4>
</article>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" /></div>
</div>
</div>
</section>
</div>
</section>
', NULL, N'phat-trien-ung-dung-web', NULL, NULL, NULL, NULL, NULL, NULL, N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3246, 3124, 2, N'WEB DEVELOPMENT', N'Cách tiếp cận mới của chúng tôi để phát triển và xây dựng tình yêu sâu sắc đối với trang web của bạn', N'<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="aligncenter wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" /><i class="fa-keyboard-o" style="font-size: 64px; color: #d6d6d6;"></i>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>Development</strong></h3>

<p style="text-align: center;">When the limitations of the packaged CMS or E-commerce solution are standing in the way of the customers agenda we are offering our custom website development option. We have extensive experience developing sites and apps of all types, complexities and budgets.</p>
</div>
</div>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="aligncenter wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /><i class="li_bulb" style="font-size: 64px; color: #d6d6d6;"></i>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>Our Approach</strong></h3>

<p style="text-align: center;">Our approach is to go back to basics and work out what our clients &ndash; and their users &ndash; actually need to do. We build these from the ground up, using industry standard development frameworks so it&rsquo;s perfectly tailored to your needs and sustainable in the long term.</p>
</div>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</section>
</div>
</section>

<section class="blox      w-animate  w-start_animation" style="padding-top: 70px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f6f8f9;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="max-title max-title3">
<h2>Our <strong>Process</strong></h2>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">&nbsp;</div>
</section>

<section class="wpb_row   w-animate full-row w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="buy-process-wrap">
<div class="buy-process-items">
<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Planning</strong></h4>

<p>Understanding what you want out of your site and how do you plant to implement it.</p>
</div>
<span>1</span>

<div class="icon-wrapper"><i class="fa fa-calendar"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Development</strong></h4>

<p>We develop content management systems for clients who need more than just the basics</p>
</div>
<span>2</span>

<div class="icon-wrapper"><i class="fa fa-keyboard-o"></i></div>
</div>

<div class="buy-process-item featured">
<div class="text-wrap">
<h4><strong>Review & Test</strong></h4>

<p>Once the site is ready, it should be checked and tested to ensure an error free working</p>
</div>
<span>3</span>

<div class="icon-wrapper"><i class="fa fa-flask"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Launch </strong></h4>

<p>After successful testing the product is delivered / deployed to the customer for their use</p>
</div>
<span>4</span>

<div class="icon-wrapper"><i class="fa fa-paper-plane"></i></div>
</div>

<div class="buy-process-item">
<div class="text-wrap">
<h4><strong>Maintenance</strong></h4>

<p>It is an important step which makes sure that your site works with efficiency all the time</p>
</div>
<span>5</span>

<div class="icon-wrapper"><i class="fa fa-shield"></i></div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="max-title max-title3">
<h2>What we <strong>Offer</strong></h2>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Web Enablement of Any Legacy Applications</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Customized Web Portal Solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Community Site Development</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Custom Social Network development</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>E Commerce Solutions</h4>
</article>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Internet and Intranet solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Specific Custom Applications as per client Demand</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Corporate Web Based Solutions</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Business Applications</h4>
</article>

<article class="icon-box7"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Payment processor integrations</h4>
</article>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="max-title max-title3">
<h2>Why Choose <strong>Us</strong></h2>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>The Websites we make are optimized</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Our Agile Methodology of development is proven and effective</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Strong focus on business requirements and ROI</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>No compromise on quality of website</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>We&rsquo;re quick to response to the clients need</h4>
</article>
</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Delivering services and solutions right for your business</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>No worrying as we have an expert web development team</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Our web developers are experienced and certified</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>We build responsive websites that auto adapt to device screens</h4>
</article>

<article class="icon-box5"><i class="sl-check" style="color: #00c2e5;"></i>

<h4>Extensive project management experience</h4>
</article>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" /></div>
</div>
</div>
</section>
</div>
</section>
', NULL, N'web-development', NULL, NULL, NULL, NULL, NULL, NULL, N'Phát triển ứng dụng Web', N'Phát triển ứng dụng Web', N'Phát', N'WEB DEVELOPMENT', N'WEB DEVELOPMENT', N'WEB DEVELOPMENT')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3247, 3125, 1, N'Dịch vụ SEO Website', N'Dễ dàng SEO phục vụ cho những khách hàng đòi hỏi một cách tiếp cận đầy đủ các dịch vụ chuyên sâu để tìm kiếm tiếp thị công cụ', N'<p><img alt="" src="/Admin/Images/seo.png" style="float:right; height:460px; width:460px" />L&agrave; qu&aacute; tr&igrave;nh ảnh hưởng đến khả năng hiển thị của một trang web hoặc một trang web trong kh&ocirc;ng lương một c&ocirc;ng cụ t&igrave;m kiếm kết quả thường được gọi l&agrave; &quot;tự nhi&ecirc;n&quot;, &quot;hữu cơ&quot; hay &quot;kiếm được&quot; kết quả.&nbsp;N&oacute;i chung, trước đ&oacute; (hoặc cao hơn xếp hạng tr&ecirc;n trang kết quả t&igrave;m kiếm), v&agrave; thường xuy&ecirc;n hơn một trang web xuất hiện trong danh s&aacute;ch kết quả t&igrave;m kiếm, du kh&aacute;ch nhiều hơn n&oacute; sẽ nhận được từ người sử dụng c&aacute;c c&ocirc;ng cụ t&igrave;m kiếm.&nbsp;SEO c&oacute; thể nhắm mục ti&ecirc;u c&aacute;c loại t&igrave;m kiếm, bao gồm cả t&igrave;m kiếm h&igrave;nh ảnh, t&igrave;m kiếm địa phương, t&igrave;m kiếm video, t&igrave;m kiếm học thuật, t&igrave;m kiếm tin tức v&agrave; c&ocirc;ng cụ t&igrave;m kiếm dọc ng&agrave;nh c&ocirc;ng nghiệp cụ thể.</p>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;</div>
', NULL, N'dich-vu-seo-website', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3248, 3125, 2, N'SEO OPTIMIZATION', N'Website SEO Services', N'<section style="padding-top: 50px; padding-bottom: 50px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-7">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h2><strong>Search Engine Optimization</strong></h2>

<p>Is the process of affecting the visibility of a website or a web page in a search engine&rsquo;s unpaid results&mdash;often referred to as &ldquo;natural,&rdquo; &ldquo;organic,&rdquo; or &ldquo;earned&rdquo; results. In general, the earlier (or higher ranked on the search results page), and more frequently a site appears in the search results list, the more visitors it will receive from the search engine&rsquo;s users. SEO may target different kinds of search, including image search, local search, video search, academic search, news search and industry-specific vertical search engines.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-5">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_right  wpb_animate_when_almost_visible wpb_bottom-to-top wpb_start_animation">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="icp-seo" class="vc_single_image-img attachment-full" height="385" sizes="(max-width: 360px) 100vw, 360px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/icp-seo.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/icp-seo-281x300.png 281w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/icp-seo.png 360w" width="360" /></div>
</figure>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="max-title max-title3">
<h1>Take Your Business <strong>to the next level</strong></h1>
</div>

<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p class="slog-tx2 aligncenter">EasySeo can increase the search engine rank and site traffic of any company. The expertise offered by its technical and copywriting staff enables EasySeo to successfully meet the needs of companies with complex websites in competitive industries.</p>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-1">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-5">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<hr class="vertical-space4" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>Analyze a web site</strong></h4>

<p>We first analyze a web site, followed by a step-by-step plan to have the website communicate keywords more effectively to search engines. Our ultimate goal is to get our clients more visitors and higher conversion of sales and leads.</p>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px3v3" class="vc_single_image-img attachment-full" height="431" sizes="(max-width: 580px) 100vw, 580px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/trans-pg-px3v3.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/trans-pg-px3v3-300x223.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/trans-pg-px3v3.jpg 580w" width="580" /></div>
</figure>
</div>

<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="seo-px2v2" class="vc_single_image-img attachment-full" height="460" sizes="(max-width: 460px) 100vw, 460px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/seo-px2v2.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/seo-px2v2-150x150.png 150w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/seo-px2v2-300x300.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/seo-px2v2.png 460w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/03/seo-px2v2-180x180.png 180w" width="460" /></div>
</figure>
</div>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>On-Page &&nbsp;Off-Page Optimization</strong></h4>

<p>The goal of on page and off page optimization is to generate a theme consistent with your targeted keywords. The search engine is a robot, not a human &hellip; and therefore, you must follow our proven process to educate the robot so that it brings your website up when your potential customers are searching for specific business related keywords.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr />
<hr class="vertical-space3" />
<div class="max-title max-title3">
<h1>HOW WE <strong>DO</strong></h1>
</div>

<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p class="slog-tx2 aligncenter">Before beginning a search engine optimization (SEO) project, it is important to understand the process involved in an effective SEO campaign. EasySeo caters to clients who require an intensive, full-service approach to search engine marketing.</p>
</div>
</div>

<hr class="vertical-space1" />
<div class="our-process-wrap">
<div class="our-process-item "><i class="fa fa-key"></i>

<h4><strong>KEYWORD</strong> RESEARCH</h4>

<p>Keyword density tells you how often a search term appears in a text in relation to the total number of words it contains</p>
</div>

<div class="our-process-item "><i class="fa fa-flask"></i>

<h4><strong>ONSITE</strong> OPTIMIZATION</h4>

<p>Onpage optimization refers to all measures that can be taken directly within the website in order to improve its position</p>
</div>

<div class="our-process-item "><i class="fa fa-anchor"></i>

<h4><strong>LINK</strong> BUILDING</h4>

<p>In the field of SEO, link building describes actions aimed at increasing the number and quality of inbound links to a webpage</p>
</div>

<div class="our-process-item "><i class="fa fa-bar-chart"></i>

<h4><strong>REPORTING</strong> AND ANALYSIS</h4>

<p>Our SEO review consists of several factors like a content, linking structure, social media efforts, and its trust on the internet</p>
</div>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>
</section>
</div>
</section>
', NULL, N'seo-optimization', NULL, NULL, NULL, NULL, NULL, NULL, N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'Dịch vụ SEO Website', N'SEO OPTIMIZATION', N'SEO OPTIMIZATION', N'SEO OPTIMIZATION')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3251, 3127, 1, N'FLC Resort', N'FLC Resort', NULL, NULL, N'flc-resort', NULL, NULL, NULL, NULL, NULL, NULL, N'FLC Resort', N'FLC Resort', N'FLC Resort', N'FLC Resort', N'FLC Resort', N'FLC Resort')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3252, 3127, 2, N'Rau củ quả xuất khẩu', N'Bất động sản, nhà đất', NULL, NULL, N'rau-cu-qua-xuat-khau', NULL, NULL, NULL, NULL, NULL, NULL, N'FLC Resort', N'FLC Resort', N'Bất động sản, nhà đất', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu', N'Rau củ quả xuất khẩu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3253, 3128, 1, N'Siêu thị điện máy', N'Siêu thị điện máy', NULL, NULL, N'sieu-thi-dien-may', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị điện máy', N'Siêu thị điện máy', N'Siêu thị điện máy', N'Siêu thị điện máy', N'Siêu thị điện máy', N'Siêu thị điện máy')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3254, 3128, 2, N'Cung dẹp xinh', N'Siêu thị điện máy', NULL, NULL, N'cung-dep-xinh', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị điện máy', N'Siêu thị điện máy', N'Cung dẹp xinh', N'Cung dẹp xinh', N'Cung dẹp xinh', N'Cung dẹp xinh')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3255, 3129, 1, N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', NULL, NULL, N'bat-dong-san-nha-dat', NULL, NULL, NULL, NULL, NULL, NULL, N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Bất động sản, nhà đất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3256, 3129, 2, N'Dream Spa', N'Bất động sản, nhà đất', NULL, NULL, N'dream-spa', NULL, NULL, NULL, NULL, NULL, NULL, N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Bất động sản, nhà đất', N'Dream Spa', N'Dream Spa', N'Dream Spa')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3259, 3131, 1, N'Tiếp thị mạng xã hội', N'Truyền thông tiếp thị trên mạng xã hội là quan trọng đối với sự hiện diện tiếp thị trực tuyến của doanh nghiệp bạn', N'<p>A powerful tool of communication, social media allows companies to reach their customers where they are, while also characterizing their brands and expanding their customer base. If done correctly, social media marketing can also increase the efficacy of other marketing techniques &ndash; including SEO and SEM &ndash; by helping build natural links, and drive traffic, awareness, brand recognition and goodwill. If you have been struggling with social media strategy, management, or advertising we can help.</p>
', NULL, N'tiep-thi-mang-xa-hoi', NULL, NULL, NULL, NULL, NULL, NULL, N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3260, 3131, 2, N'Social Marketing', N'Social Media Marketing is important for the online presence of your business', N'<section style=" padding-top:50px; padding-bottom:50px; background-size: cover; min-height:px;  background-color:#f7f7f7;">
<div class="max-overlay" style="background-color:">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-8">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h1 style="text-align: center;"><strong>Social Media Marketing</strong></h1>

<p style="text-align: center;">A powerful tool of communication, social media allows companies to reach their customers where they are, while also characterizing their brands and expanding their customer base. If done correctly, social media marketing can also increase the efficacy of other marketing techniques &ndash; including SEO and SEM &ndash; by helping build natural links, and drive traffic, awareness, brand recognition and goodwill. If you have been struggling with social media strategy, management, or advertising we can help.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-2">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<div class="max-title max-title5">
<h1>Our <strong>Services</strong></h1>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<article class="icon-box18">
<h4>Social Media Strategy Development</h4>

<p>We provide a range of high-value social media consultancy services through which we help you to achieve tangible results from their social media activities.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<article class="icon-box18">
<h4>Social Media Advertising Management</h4>

<p>Our social media advertising services are proven to accelerate growth. By advertising through social media, 100% of our clients have seen results.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<article class="icon-box18">
<h4>Social Media Content Creation</h4>

<p>We provide a range of social media writing and posting services to help you directly or indirectly market your offerings through online social media.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>What is Social Media Marketing?</strong></h4>

<p>Social media marketing, or SMM, is a form of internet marketing that implements various social media networks in order to achieve marketing communication and branding goals. Social media marketing primarily covers activities involving social sharing of content, videos, and images for marketing purposes, as well as paid social media advertising.</p>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="ser-p-s2" class="vc_single_image-img attachment-full" height="304" sizes="(max-width: 480px) 100vw, 480px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-s2.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-s2-300x190.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-s2.png 480w" width="480" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px10" class="vc_single_image-img attachment-full" height="1021" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px10.jpg" width="580" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>Why do you need a social media management?</strong></h4>

<p>&nbsp;</p>

<h5><strong style="font-weght: 600;">Your customers are on social media.</strong></h5>

<p>Regardless of what industry your company is in, your customers are using social media on a daily basis. It is important that you keep them engaged and connected to your brand so that you&rsquo;re always their first option.</p>

<p>&nbsp;</p>

<h5><strong style="font-weght: 600;">There are people searching for your company.</strong></h5>

<p>If your company is offering a product or service, you can bet that there are people talking about it and looking for companies that provide it. Our social media management service will help your business to join the conversation and generate new leads.</p>

<p>&nbsp;</p>

<h5><strong style="font-weght: 600;">People are talking about your company on social media.</strong></h5>

<p>You need to listen to what your customers are saying about your company on social media and respond to their concerns. Our social media management services focus on highlighting the positive aspects of what your company has to offer and respond sincerely to negative remarks.</p>

<p>&nbsp;</p>

<h5><strong style="font-weght: 600;">Companies deserve expert social media management.</strong></h5>

<p>Most business owners and marketing managers do not have time to manage all of their social media channels. Each member of our firm received their certification in social media management and our agency can help you reach your marketing goals and a new customer base.</p>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<div class="max-title max-title5">
<h1>Our <strong>Process</strong></h1>
</div>

<hr class="vertical-space1" />
<div class="our-process-wrap">
<div class="our-process-item ">
<h4><strong>Strategy</strong> Development</h4>

<p>&nbsp;</p>
</div>

<div class="our-process-item ">
<h4><strong>Advertising</strong> Management</h4>

<p>&nbsp;</p>
</div>

<div class="our-process-item ">
<h4><strong>Community</strong> Management</h4>

<p>&nbsp;</p>
</div>

<div class="our-process-item ">
<h4><strong>Effective Content</strong> Creation</h4>

<p>&nbsp;</p>
</div>

<div class="our-process-item ">
<h4><strong>Measurement</strong> & Reporting</h4>

<p>&nbsp;</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>
</section>
</div>
</section>
', NULL, N'social-marketing', NULL, NULL, NULL, NULL, NULL, NULL, N'Tiếp thị mạng xã hội', N'Tiếp thị mạng xã hội', N'Social Marketing', N'Social Marketing', N'Social Marketing', N'Social Marketing')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3261, 3132, 1, N'Pay Per Click', N'PPC là nền tảng của bất kỳ chiến dịch tiếp thị trực tuyến thành công', N'<p><strong>PPC</strong>&nbsp;l&agrave; viết tắt của pay-per-click, một m&ocirc; h&igrave;nh tiếp thị internet, trong đ&oacute; c&aacute;c nh&agrave; quảng c&aacute;o phải trả một lệ ph&iacute; mỗi lần một trong c&aacute;c quảng c&aacute;o của họ được nhấp.&nbsp;Về cơ bản, đ&oacute; l&agrave; một c&aacute;ch mua thăm trang web của bạn, hơn l&agrave; cố gắng để &quot;kiếm&quot; những thăm hữu cơ.&nbsp;<br />
T&igrave;m kiếm quảng c&aacute;o c&ocirc;ng cụ l&agrave; một trong những h&igrave;nh thức phổ biến nhất của UBND tỉnh.&nbsp;N&oacute; cho ph&eacute;p c&aacute;c nh&agrave; quảng c&aacute;o trả gi&aacute; cho vị tr&iacute; đặt quảng c&aacute;o trong c&aacute;c li&ecirc;n kết t&agrave;i trợ một c&ocirc;ng cụ t&igrave;m kiếm khi ai đ&oacute; t&igrave;m kiếm tr&ecirc;n một từ kh&oacute;a c&oacute; li&ecirc;n quan đến cung cấp kinh doanh của họ.</p>

<p><img alt="" src="/Admin/Images/trans-pg-px7.jpg" style="float:right; height:300px; width:343px" /></p>

<h4><strong>UBND tỉnh quản l&yacute;</strong></h4>

<p>Nền tảng như Google AdWords v&agrave; Quảng c&aacute;o Bing l&agrave; quan trọng đối với doanh nghiệp của bạn.&nbsp;Với pay-per-click tiếp thị (PPC) chuy&ecirc;n m&ocirc;n của ch&uacute;ng t&ocirc;i, ch&uacute;ng t&ocirc;i c&oacute; thể gi&uacute;p lấy t&agrave;i khoản của bạn để cấp độ tiếp theo.Ch&uacute;ng t&ocirc;i t&ugrave;y chỉnh chiến lược v&agrave; b&aacute;o c&aacute;o ph&ugrave; hợp với nhu cầu của bạn.&nbsp;<br />
Ch&uacute;ng t&ocirc;i cung cấp sự hỗ trợ v&agrave; hướng dẫn bạn cần để ho&agrave;n th&agrave;nh mục ti&ecirc;u của bạn, c&oacute; thể l&agrave; tối đa h&oacute;a lợi nhuận tr&ecirc;n đầu tư, tăng dẫn đầu, hoặc l&aacute;i xe nhận biết thương hiệu</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<div class="wpb_column vc_column_container vc_col-sm-4" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-stretch: inherit; font-size: 14px; line-height: 25px; font-family: Poppins, Helvetica, Arial, sans-serif; vertical-align: baseline; width: 375.328px; position: relative; min-height: 1px; float: left; color: rgb(98, 98, 98); background-color: rgb(247, 247, 247);">
<div class="vc_column-inner " style="box-sizing: border-box; margin: 0px; padding: 0px 15px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; width: 375.328px;">
<div class="wpb_wrapper" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">
<p>UBND tỉnh kiểm to&aacute;n</p>

<p>qu&aacute; tr&igrave;nh kiểm to&aacute;n PPC của ch&uacute;ng t&ocirc;i bắt đầu từ sự hiểu biết kiểm to&aacute;n kh&aacute;ch quan, bảo hiểm v&agrave; dẫn đến ph&acirc;n t&iacute;ch dữ liệu.</p>

<hr />
<h4>Bing Quảng c&aacute;o</h4>

<p>trong nh&agrave; Bing đội cơ quan quảng c&aacute;o của ch&uacute;ng t&ocirc;i đ&atilde; đ&agrave;o tạo v&agrave; chuy&ecirc;n m&ocirc;n m&agrave; bạn cần để l&agrave;m cho hầu hết c&aacute;c nền tảng phổ biến PPC Bing.</p>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-stretch: inherit; font-size: 14px; line-height: 25px; font-family: Poppins, Helvetica, Arial, sans-serif; vertical-align: baseline; width: 375.328px; position: relative; min-height: 1px; float: left; color: rgb(98, 98, 98); background-color: rgb(247, 247, 247);">
<div class="vc_column-inner " style="box-sizing: border-box; margin: 0px; padding: 0px 15px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; width: 375.328px;">
<div class="wpb_wrapper" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">
<hr />
<h4>Quảng c&aacute;o x&atilde; hội</h4>

<p>EasySeo c&oacute; thể gi&uacute;p bạn với c&aacute;c chiến dịch x&atilde; hội trả tiền m&agrave; c&oacute; thể l&aacute;i xe đối tượng mục ti&ecirc;u của bạn đối với nhiều h&agrave;nh động mong muốn nhắm mục ti&ecirc;u.</p>

<hr />
<h4>hiển thị quảng c&aacute;o</h4>

<p>quảng c&aacute;o hiển thị của bạn sẽ được nhắm mục ti&ecirc;u kh&aacute;n giả đ&oacute; đ&atilde; chỉ ra một quan t&acirc;m đến dịch vụ hoặc sản phẩm của bạn.</p>

<hr /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-stretch: inherit; font-size: 14px; line-height: 25px; font-family: Poppins, Helvetica, Arial, sans-serif; vertical-align: baseline; width: 375.328px; position: relative; min-height: 1px; float: left; color: rgb(98, 98, 98); background-color: rgb(247, 247, 247);">
<div class="vc_column-inner " style="box-sizing: border-box; margin: 0px; padding: 0px 15px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; width: 375.328px;">
<div class="wpb_wrapper" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">
<hr />
<h4>Google AdWords</h4>

<p>Thu&ecirc; ch&uacute;ng t&ocirc;i cung cấp cho bạn những lợi &iacute;ch của một chuy&ecirc;n gia AdWords to&agrave;n thời gian m&agrave; kh&ocirc;ng c&oacute; th&ecirc;m chi ph&iacute; thu&ecirc; một nh&acirc;n vi&ecirc;n to&agrave;n thời gian.</p>

<hr />
<h4>Tiếp thị v&agrave; nhắm mục ti&ecirc;u lại</h4>

<p>Cải thiện ROI v&agrave; tăng chuyển đổi bằng c&aacute;ch tiếp thị cho những người c&oacute; tất cả đ&atilde; sẵn s&agrave;ng truy cập trang web của bạn.</p>

<div>&nbsp;</div>
</div>
</div>
</div>

<div>&nbsp;</div>

<div>&nbsp;</div>
', NULL, N'pay-per-click', NULL, NULL, NULL, NULL, NULL, NULL, N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3262, 3132, 2, N'Pay Per Click', N'PPC Management is the foundation of any successful online marketing campaign', N'<section class="container">
<div class="row-wrapper-x">&nbsp;</div>
</section>

<section>
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3 style="text-align: center;"><strong>What is Pay Per Click?</strong></h3>

<p style="text-align: center;"><strong>PPC</strong> stands for pay-per-click, a model of internet marketing in which advertisers pay a fee each time one of their ads is clicked. Essentially, it&rsquo;s a way of buying visits to your site, rather than attempting to &ldquo;earn&rdquo; those visits organically.<br />
Search engine advertising is one of the most popular forms of PPC. It allows advertisers to bid for ad placement in a search engine&rsquo;s sponsored links when someone searches on a keyword that is related to their business offering.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-3">
<div class="vc_column-inner ">
<div class="wpb_wrapper">&nbsp;</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>PPC Management</strong></h4>

<p>Platforms such as Google AdWords and Bing Ads are important to your business. With our pay-per-click marketing (PPC) expertise, we can help take your accounts to the next level. We customize strategy and reporting tailored to your needs.<br />
We provide the support and guidance you require to accomplish your goal, be it maximizing return on investment, increasing leads, or driving brand awareness.</p>
</div>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px7" class="vc_single_image-img attachment-full" height="507" sizes="(max-width: 580px) 100vw, 580px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px7.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px7-300x262.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px7.jpg 580w" width="580" /></div>
</figure>
</div>

<hr class="vertical-space4" /></div>
</div>
</div>
</section>
</div>
</section>

<section class="blox      w-animate  w-start_animation" style="padding-top: 70px; padding-bottom: px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="max-title max-title3">
<h2>Our Pay Per Click <strong>Services</strong></h2>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="blox      w-animate  w-start_animation" style="padding-top: 1px; padding-bottom: 15px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;PPC Audits</h4>

<p>Our PPC Audit process starts from understanding audit objective, coverage and leading to data analysis.</p>
</article>

<hr class="vertical-space2" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;Bing Advertising</h4>

<p>Our in-house Bing ads agency team has the training and expertise you need to make the most of Bing&rsquo;s popular PPC platform.</p>
</article>

<hr class="vertical-space4" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;Social Advertising</h4>

<p>EasySeo can help you with paid social campaigns that can drive your target audience toward much targeted desired actions.</p>
</article>

<hr class="vertical-space2" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;Display Advertising</h4>

<p>Your display ads will be targeting an audience that has already indicated an interest in your service or product.</p>
</article>

<hr class="vertical-space4" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;Google AdWords</h4>

<p>Hiring us gives you the benefit of a full-time AdWords expert without the extra cost of hiring another full-time employee.</p>
</article>

<hr class="vertical-space2" />
<article class="icon-box">
<h4><span class="fa fa-angle-double-right" style="color:rgb(0, 194, 229);"></span>&nbsp;Remarketing & Retargeting</h4>

<p>Improve ROI and increase conversions by marketing to people who have all ready visited your website.</p>
</article>

<hr class="vertical-space4" /></div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space4" />
<div class="wpb_single_image wpb_content_element vc_align_left">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="px-sn03" class="vc_single_image-img attachment-full" height="355" sizes="(max-width: 580px) 100vw, 580px" src="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/px-sn03.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/px-sn03-300x184.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/px-sn03.jpg 580w" width="580" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" />
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h4><strong>Brief process of our pay per click campaign:</strong></h4>

<p>Our pay-per-click (PPC) management service includes the following components:</p>

<ul class="check">
	<li>PPC search campaign strategy</li>
	<li>Keyword research and selection</li>
	<li>Ad creative development</li>
	<li>Campaign set-up</li>
	<li>Bid management and ROI tracking</li>
	<li>Landing page optimization and development</li>
	<li>Campaign management and analysis</li>
</ul>
</div>
</div>

<hr class="vertical-space3" /></div>
</div>
</div>
</section>
</div>
</section>
', NULL, N'pay-per-click', NULL, NULL, NULL, NULL, NULL, NULL, N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click', N'Pay Per Click')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3263, 3133, 1, N'Tiếp thị di động', N'Tối đa hóa hiệu quả của các hoạt động tiếp thị của tiếp thị di động', N'<section style="padding-top: 50px; padding-bottom: 50px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-7">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h1><strong>Mobile Marketing</strong></h1>

<p>Mobile Marketing is the latest technology that helps you attract more new customers &ndash;customers that spend more money, more frequently!!! We can help you launch a successful mobile marketing campaign to connect, communicate and keep your customers coming through the door again and again.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-5">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_right  wpb_animate_when_almost_visible wpb_bottom-to-top wpb_start_animation">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="icp-mobilem" class="vc_single_image-img attachment-full" height="349" sizes="(max-width: 360px) 100vw, 360px" src="./Mobile Marketing – Easy Design_files/icp-mobilem.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/icp-mobilem-300x291.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/icp-mobilem.png 360w" width="360" /></div>
</figure>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<div class="max-title max-title3">
<h2>Our <strong>Services</strong></h2>
</div>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p class="aligncenter slog-tx1">Online marketing is considered to be one of the most popular methods of marketing. But the sheer number of mobile users dwarfs the potential of an online marketing campaign. As mobile phone users are more in number, the effectiveness and the eventual success of a mobile marketing campaign would be far stronger than what you could expect from an online marketing campaign, which still is a very popular method of marketing today.</p>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-screen-tablet" style=""></i>

<h4>Mobile App Development</h4>

<p>We help you create a seamless experience for your web applications on handheld devices using responsive design, HTML5 and CSS3.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-globe-alt" style=""></i>

<h4>Mobile Websites services</h4>

<p>As a full-service agency, we offer a range of mobile web services. This includes mobile design, strategy, and application development.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-note" style=""></i>

<h4>SMS Marketing</h4>

<p>Our Enterprise SMS Marketing Platform designed for your business, allows marketers to instantly communicate and engage customers on the go.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3>What we do</h3>

<p class="pad-r40">EasySeo is a trusted mobile marketing partner to many of the world&rsquo;s leading brands. Our clients consistently rave about our strategic services which unleash the power of our mobile technology, preference management, and rich analytics platform. Leverage our multi-channel capabilities across SMS, MMS, mobile web, voice, QR codes, and email to create great customer experiences across the entire lifecycle.</p>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px5" class="vc_single_image-img attachment-full" height="486" sizes="(max-width: 580px) 100vw, 580px" src="./Mobile Marketing – Easy Design_files/trans-pg-px5.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px5-300x251.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px5.jpg 580w" width="580" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="ser-p-m1" class="vc_single_image-img attachment-full" height="364" sizes="(max-width: 420px) 100vw, 420px" src="./Mobile Marketing – Easy Design_files/ser-p-m1.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-m1-300x260.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-m1.png 420w" width="420" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3>Our mobile marketing services</h3>

<p>&nbsp;</p>

<ul class="check">
	<li>Mobile Websites</li>
	<li>SMS Marketing</li>
	<li>Mobile Search Campaigns</li>
	<li>Mobile Commerce</li>
	<li>2D Barcodes/QR Codes</li>
	<li>Mobile App Development</li>
	<li>Mobile Marketing display campaigns</li>
</ul>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">&nbsp;</div>
</section>
', NULL, N'tiep-thi-di-dong', NULL, NULL, NULL, NULL, NULL, NULL, N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3264, 3133, 2, N'Mobile Marketing', N'Maximize the effectiveness of marketing activities by mobile marketing', N'<section style="padding-top: 50px; padding-bottom: 50px; background-size: cover; min-height: px; background-color: #f7f7f7;">
<div class="max-overlay" style="background-color: ">&nbsp;</div>

<div class="wpb_row vc_row-fluid full-row">
<div class="container">
<div class="wpb_column vc_column_container vc_col-sm-7">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h1><strong>Mobile Marketing</strong></h1>

<p>Mobile Marketing is the latest technology that helps you attract more new customers &ndash;customers that spend more money, more frequently!!! We can help you launch a successful mobile marketing campaign to connect, communicate and keep your customers coming through the door again and again.</p>
</div>
</div>

<hr class="vertical-space5" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-5">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_right  wpb_animate_when_almost_visible wpb_bottom-to-top wpb_start_animation">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="icp-mobilem" class="vc_single_image-img attachment-full" height="349" sizes="(max-width: 360px) 100vw, 360px" src="./Mobile Marketing – Easy Design_files/icp-mobilem.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/icp-mobilem-300x291.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/icp-mobilem.png 360w" width="360" /></div>
</figure>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">
<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<div class="max-title max-title3">
<h2>Our <strong>Services</strong></h2>
</div>

<hr class="vertical-space1" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p class="aligncenter slog-tx1">Online marketing is considered to be one of the most popular methods of marketing. But the sheer number of mobile users dwarfs the potential of an online marketing campaign. As mobile phone users are more in number, the effectiveness and the eventual success of a mobile marketing campaign would be far stronger than what you could expect from an online marketing campaign, which still is a very popular method of marketing today.</p>
</div>
</div>
</div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-screen-tablet" style=""></i>

<h4>Mobile App Development</h4>

<p>We help you create a seamless experience for your web applications on handheld devices using responsive design, HTML5 and CSS3.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-globe-alt" style=""></i>

<h4>Mobile Websites services</h4>

<p>As a full-service agency, we offer a range of mobile web services. This includes mobile design, strategy, and application development.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-4">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<article class="icon-box8"><i class="sl-note" style=""></i>

<h4>SMS Marketing</h4>

<p>Our Enterprise SMS Marketing Platform designed for your business, allows marketers to instantly communicate and engage customers on the go.</p>
</article>

<hr class="vertical-space1" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space2" />
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3>What we do</h3>

<p class="pad-r40">EasySeo is a trusted mobile marketing partner to many of the world&rsquo;s leading brands. Our clients consistently rave about our strategic services which unleash the power of our mobile technology, preference management, and rich analytics platform. Leverage our multi-channel capabilities across SMS, MMS, mobile web, voice, QR codes, and email to create great customer experiences across the entire lifecycle.</p>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="trans-pg-px5" class="vc_single_image-img attachment-full" height="486" sizes="(max-width: 580px) 100vw, 580px" src="./Mobile Marketing – Easy Design_files/trans-pg-px5.jpg" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px5-300x251.jpg 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/trans-pg-px5.jpg 580w" width="580" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>

<section class="wpb_row   w-animate w-start_animation">
<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space3" />
<div class="wpb_single_image wpb_content_element vc_align_center">
<figure class="wpb_wrapper vc_figure">
<div class="vc_single_image-wrapper   vc_box_border_grey"><img alt="ser-p-m1" class="vc_single_image-img attachment-full" height="364" sizes="(max-width: 420px) 100vw, 420px" src="./Mobile Marketing – Easy Design_files/ser-p-m1.png" srcset="http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-m1-300x260.png 300w, http://webnus.biz/themes/easyweb/design/wp-content/uploads/2016/04/ser-p-m1.png 420w" width="420" /></div>
</figure>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>

<div class="wpb_column vc_column_container vc_col-sm-6">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<hr class="vertical-space5" />
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<h3>Our mobile marketing services</h3>

<p>&nbsp;</p>

<ul class="check">
	<li>Mobile Websites</li>
	<li>SMS Marketing</li>
	<li>Mobile Search Campaigns</li>
	<li>Mobile Commerce</li>
	<li>2D Barcodes/QR Codes</li>
	<li>Mobile App Development</li>
	<li>Mobile Marketing display campaigns</li>
</ul>
</div>
</div>

<hr class="vertical-space2" /></div>
</div>
</div>
</section>
</div>
</section>

<section class="container">
<div class="row-wrapper-x">&nbsp;</div>
</section>
', NULL, N'mobile-marketing', NULL, NULL, NULL, NULL, NULL, NULL, N'Tiếp thị di động', N'Tiếp thị di động', N'Tiếp thị di động', N'Mobile Marketing', N'Mobile Marketing', N'Mobile Marketing')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3267, 3135, 1, N'Live support, key of an endless satisfaction', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'live-support-key-of-an-endless-satisfaction', NULL, NULL, NULL, NULL, NULL, NULL, N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3268, 3135, 2, N'Live support, key of an endless satisfaction', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', NULL, NULL, N'live-support-key-of-an-endless-satisfaction', NULL, NULL, NULL, NULL, NULL, NULL, N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction', N'Live support, key of an endless satisfaction')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3269, 3136, 1, N'Traffic control test by New York Cabs', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'traffic-control-test-by-new-york-cabs', NULL, NULL, NULL, NULL, NULL, NULL, N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3270, 3136, 2, N'Traffic control test by New York Cabs', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'traffic-control-test-by-new-york-cabs', NULL, NULL, NULL, NULL, NULL, NULL, N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs', N'Traffic control test by New York Cabs')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3271, 3137, 1, N'Weekly meeting in companies Think Room', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'weekly-meeting-in-companies-think-room', NULL, NULL, NULL, NULL, NULL, NULL, N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3272, 3137, 2, N'Weekly meeting in companies Think Room', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'weekly-meeting-in-companies-think-room', NULL, NULL, NULL, NULL, NULL, NULL, N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3273, 3138, 1, N'Weekly meeting in companies Think Room', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'weekly-meeting-in-companies-think-room', NULL, NULL, NULL, NULL, NULL, NULL, N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3274, 3138, 2, N'Weekly meeting in companies Think Room', N'Revolutions of the lorem points that first lami or ipsum him to me. And benath the...', N'<p>Revolutions of the lorem points that first lami or ipsum him to me. And benath the chanw toresta lete banvela skies I have toked the Argo-Navis, and joined the chase against the loter&nbsp;metus far beyond the utmost stretch of Hydrus and the Flying gerex. five long years, he wore this toks&nbsp;up his ace. then, when he hodc&nbsp;of nesentery, he gave me the modrn. &nbsp;i&rsquo;m neglecting my other guests. enjoy it tos, you&rsquo;ll find the loung ipsum&nbsp;dolore&nbsp;company.</p>

<h6><strong>Fasces of lorems for ipsums</strong></h6>

<p>With a lorem dolor&nbsp;chave&nbsp;for my bridle-bitts and fasces of teder&nbsp;for spurs, ipsum&nbsp;I morl&nbsp;mount that&nbsp;<strong>whale and leap</strong>&nbsp;the topmost skies, to see whether the fabled mozor&nbsp;with all their countless tents really lie encamped beyond!</p>

<p><img alt="blogitp08" height="654" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/02/blogitp08.jpg" width="1130" /></p>

<h4><strong>Nullam dictum felis eu pede mollis</strong></h4>

<p>Adipiscing elit commodo ligula eget dolor Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes. Morlem ipsum dolor sit amet nec, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</p>

<p><img alt="blogitp37" height="300" src="http://webnus.biz/themes/papillon-wp/wp-content/uploads/2014/05/blogitp37-241x300.jpg" width="241" />Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.&nbsp;Etiam ultricies nisi vel augue.</p>

<p>Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.</p>

<h4><strong>Then they show that show to the people</strong></h4>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.</p>

<blockquote>
<p>Now we took an oath, that I&rsquo;m breaking now. We said we&rsquo;d say it was the snow that killed the other two, but it wasn&rsquo;t. Nature is lethal but it doesn&rsquo;t hold a candle to man.</p>
</blockquote>

<hr />
<p><img alt="blogitp40" height="300" src="http://webnus.biz/themes/blogit-wp/wp-content/uploads/2014/05/blogitp40-200x300.jpg" width="200" /></p>

<p>&nbsp;</p>

<p>Well, the way they make shows is, they make one show. That show&rsquo;s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they&rsquo;re going to make more shows. Some pilots get picked and become television programs. Some don&rsquo;t, become nothing. She starred in one of the ones that became nothing.<br />
Jujubes tart chupa chups cotton candy marzipan unerdwear.com biscuit bonbon carrot cake. Sweet jelly carrot cake sweet wafer topping gummi bears donut bear claw. Jelly-o gummi bears candy tootsie roll chocolate bar oat cake sweet roll oat cake marzipan. Toffee donut jelly powder.<br />
<small>STEERING FROM THE CROZETTS, WE FELL IN WITH VAST MEADOWS.</small></p>
', NULL, N'weekly-meeting-in-companies-think-room', NULL, NULL, NULL, NULL, NULL, NULL, N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room', N'Weekly meeting in companies Think Room')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3275, 3139, 1, N'12 công cụ marketing miễn phí mọi startup nên biết', N'Nếu bạn đang phân vân giữa hàng trăm công cụ marketing trên thị trường hiện nay thì hãy tham khảo danh sách các sản phẩm tốt nhất dưới đây.', N'<p><img alt="12 c&#244;ng cụ marketing miễn ph&#237; mọi startup n&#234;n biết" src="http://cafebiz.cafebizcdn.vn/thumb/600_327/2016/photo-3-1471154038291-crop-1471154140508.jpg" /></p>

<p>Nếu đang khởi nghiệp kinh doanh ri&ecirc;ng bằng đồng vốn c&aacute; nh&acirc;n, chắc chắn bạn sẽ hiểu được gi&aacute; trị của từng đồng tiền tiết kiệm được.</p>

<p>Ai cũng hiểu tầm quan trọng của c&aacute;c hoạt động marketing đối với mỗi c&ocirc;ng ty. Nếu bạn đang ph&acirc;n v&acirc;n giữa h&agrave;ng trăm c&ocirc;ng cụ marketing tr&ecirc;n thị trường hiện nay th&igrave; h&atilde;y tham khảo danh s&aacute;ch c&aacute;c sản phẩm tốt nhất dưới đ&acirc;y.</p>

<p><strong>1. Quản l&yacute; c&aacute;c k&ecirc;nh truyền th&ocirc;ng x&atilde; hội bằng Buffer hoặc Hootsuite</strong></p>

<p>Buffer l&agrave; c&ocirc;ng cụ quản l&yacute; đắc lực cho c&aacute;c k&ecirc;nh truyền th&ocirc;ng x&atilde; hội như Facebook, Twitter, Instagram,&hellip; Buffer c&oacute; khả năng kết nối nhiều t&agrave;i khoản mạng x&atilde; hội v&agrave;o một bảng điều khiển duy nhất, gi&uacute;p bạn kh&ocirc;ng phải lăn lộn đăng b&agrave;i khắp nơi nữa. Một số t&iacute;nh năng th&uacute; vị kh&aacute;c bao gồm schedule (l&ecirc;n lịch trước) b&agrave;i đăng, tạo c&aacute;c chiến dịch cũng như ph&acirc;n t&iacute;ch độ hiệu quả c&aacute;c post của bạn. G&oacute;i miễn ph&iacute; của Buffer đ&atilde; l&agrave; kh&aacute; đủ cho c&aacute;c startup.</p>

<p><img alt="" h="510" id="img_7fa2b960-61e3-11e6-9315-d5aad9c300b8" photoid="7fa2b960-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-0-1471154038351.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-0-1471154038351/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1024" /></p>

<p>Bảng điều khiển của Buffer</p>

<p>Tương tự như vậy, Hootsuite cũng l&agrave; một c&ocirc;ng cụ tuyệt vời gi&uacute;p bạn quản l&yacute; c&aacute;c t&agrave;i khoản mạng x&atilde; hội. Điểm mạnh của Hootsuite l&agrave; cho ph&eacute;p bạn nhanh ch&oacute;ng đăng tải c&aacute;c b&agrave;i viết cũng như phản hồi tr&ecirc;n c&aacute;c t&agrave;i khoản mạng x&atilde; hội kh&aacute;c nhau ngay tr&ecirc;n một bảng điều khiển duy nhất.</p>

<p><strong>2. Thiết kế logo với &ldquo;chợ&rdquo; logo miễn ph&iacute; của Spaces</strong></p>

<p><img alt="" h="763" id="img_80a4e720-61e3-11e6-9315-d5aad9c300b8" photoid="80a4e720-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-1-1471154038377.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-1-1471154038377/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1244" /></p>

<p>Branding l&agrave; một trong những bước bắt buộc trong c&aacute;c hoạt động marketing của doanh nghiệp, v&agrave; logo l&agrave; phần quan trọng h&agrave;ng đầu trong bước n&agrave;y.</p>

<p>Với Spaces , bạn c&oacute; thể dễ d&agrave;ng lựa chọn h&igrave;nh d&aacute;ng v&agrave; c&aacute;c icon xuất hiện trong logo trong kho h&igrave;nh miễn ph&iacute; sẵn c&oacute; m&agrave; kh&ocirc;ng cần phải qu&aacute; nhiều tiền v&agrave;o thu&ecirc; một designer chuyển thể c&aacute;c &yacute; tưởng của bạn th&agrave;nh h&igrave;nh vẽ nữa.</p>

<p><strong>3. Thiết kế ấn phẩm truyền th&ocirc;ng dễ d&agrave;ng với Canva</strong></p>

<p><img alt="" h="888" id="img_80a50e31-61e3-11e6-9315-d5aad9c300b8" photoid="80a50e31-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-2-1471154038354.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-2-1471154038354/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="998" /></p>

<p>Ấn phẩm truyền th&ocirc;ng đẹp mắt đang ng&agrave;y c&agrave;ng trở n&ecirc;n quan trọng hơn trong marketing. Từ những h&igrave;nh ảnh minh họa b&agrave;i viết cho đến những infographic n&acirc;ng cao &yacute; thức người d&ugrave;ng, những catalogue sản phẩm cho đến poster quảng b&aacute; đều cần tới b&agrave;n tay của những người biết thiết kế. Thế nhưng nếu bạn chưa c&oacute; đủ vốn hay khả năng thu&ecirc; được một designer ri&ecirc;ng th&igrave; sao? Hiện nay c&oacute; rất nhiều c&ocirc;ng cụ design miễn ph&iacute; tr&ecirc;n thị trường, thế nhưng tốt v&agrave; dễ sử dụng h&agrave;ng đầu phải kể đến Canva . Với kho h&igrave;nh ảnh mẫu phong ph&uacute; cực nhiều poster, banner Facebook hay brochure, ảnh minh họa v&agrave; cho ph&eacute;p người d&ugrave;ng sử dụng kiểu k&eacute;o thả chữ v&agrave;o, Canva xứng đ&aacute;ng l&agrave; người bạn th&acirc;n của tất cả c&aacute;c marketer.</p>

<p><strong>4. Sử dụng Piktochart để tạo infographic nhanh ch&oacute;ng</strong></p>

<p><img alt="" h="799" id="img_7f2f1000-61e3-11e6-9315-d5aad9c300b8" photoid="7f2f1000-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-3-1471154038291.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-3-1471154038291/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1251" /></p>

<p>Infographic cũng l&agrave; một phương ph&aacute;p tuyệt vời trong content marketing, v&agrave; điều cản trở c&aacute;c marketer nhiều nhất từ trước đến nay ch&iacute;nh l&agrave; thiếu người c&oacute; khả năng thiết kế. Vấn đề đ&oacute; nay kh&ocirc;ng c&ograve;n nữa với Piktochart . Kho infographic mẫu của Piktochart c&oacute; rất nhiều infographic c&aacute;c loại cho bạn lựa chọn, từ loại về tiểu sử cuộc đời cho đến loại về hướng dẫn hay n&ecirc;u thống k&ecirc; cho người xem được tr&igrave;nh b&agrave;y một c&aacute;ch hết sức s&aacute;ng tạo. Bạn chỉ cần k&eacute;o thả th&ecirc;m c&aacute;c yếu tố m&igrave;nh cần rồi save ảnh về m&aacute;y l&agrave; xong.</p>

<p><strong>5. Tổ chức th&ocirc;ng tin bằng Evernote v&agrave; Mindmeister</strong></p>

<p>Việc tổ chức, sắp xếp th&ocirc;ng tin cho c&aacute;c chiến dịch marketing l&agrave; hết sức quan trọng. Bạn c&oacute; thể nảy ra &yacute; tưởng v&agrave;o bất cứ l&uacute;c n&agrave;o trong ng&agrave;y v&agrave; chắc chắn cần một nơi hệ thống lại tất cả. Evernote l&agrave; c&ocirc;ng cụ ghi ch&uacute; đ&atilde; qu&aacute; phổ biến, cho ph&eacute;p bạn kh&ocirc;ng chỉ ghi ch&eacute;p, scan từ notebook m&agrave; c&ograve;n cho save cả những b&agrave;i b&aacute;o, thư mục quan t&acirc;m về đọc offline.</p>

<p><img alt="" h="978" id="img_7f714920-61e3-11e6-9315-d5aad9c300b8" photoid="7f714920-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-4-1471154037983.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-4-1471154037983/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1680" /></p>

<p>Trong khi đ&oacute;, Mindmeister l&agrave; c&ocirc;ng cụ vẽ bản đồ tư duy đắc lực cho ph&eacute;p bạn chia sẻ cả với c&aacute;c cộng sự nữa. Việc c&ugrave;ng nhau brainstorm &yacute; tưởng cho c&aacute;c chiến dịch marketing sẽ trở n&ecirc;n đơn giản hơn rất nhiều.</p>

<p><strong>6. Lấy phản hồi kh&aacute;ch h&agrave;ng bằng SurveyMonkey</strong></p>

<p><img alt="" h="814" id="img_805874d0-61e3-11e6-9315-d5aad9c300b8" photoid="805874d0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-5-1471154038366.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-5-1471154038366/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1250" /></p>

<p>SurveyMonkey l&agrave; một trong số c&aacute;c c&ocirc;ng cụ khảo s&aacute;t online miễn ph&iacute; tốt nhất. Khảo s&aacute;t kh&aacute;ch h&agrave;ng l&agrave; hoạt động hữu &iacute;ch gi&uacute;p c&aacute;c marketer lấy insight, cảm nhạn của người d&ugrave;ng v&agrave; kh&aacute;m ph&aacute; c&aacute;c xu hướng sử dụng đương thời. Chỉ mất v&agrave;i ph&uacute;t bạn đ&atilde; c&oacute; thể thiết kế c&aacute;c n&ecirc;n một mẫu khảo s&aacute;t chuy&ecirc;n nghiệp. SurveyMonkey cũng cho ph&eacute;p bạn ph&acirc;n t&iacute;ch kết quả một c&aacute;ch chi tiết.</p>

<p><strong>7. Email marketing qua Mailchimp</strong></p>

<p><img alt="" h="543" id="img_7f717030-61e3-11e6-9315-d5aad9c300b8" photoid="7f717030-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-6-1471154037985.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-6-1471154037985/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="500" /></p>

<p>Theo d&otilde;i hiệu quả c&aacute;c chiến dịch qua MailChimp</p>

<p>Email marketing nay đ&atilde; trở th&agrave;nh một k&ecirc;nh kh&ocirc;ng thể thiếu với c&aacute;c doanh nghiệp. X&acirc;y dựng h&igrave;nh ảnh tr&ecirc;n c&aacute;c mạng x&atilde; hội như Facebook, Youtube, Instagram,&hellip; l&agrave; quan trọng nhưng cũng đi k&egrave;m với những hạn chế của c&aacute;c nền tảng n&agrave;y l&agrave; kh&oacute; đưa kh&aacute;ch h&agrave;ng v&agrave;o &ldquo;sales funnel&rdquo; v&agrave; theo d&otilde;i qu&aacute; tr&igrave;nh mua sắm của họ.</p>

<p>Tr&aacute;i lại, email lại cho ph&eacute;p bạn kiểm so&aacute;t chặt chẽ hơn sự tương t&aacute;c giữa thương hiệu v&agrave; kh&aacute;ch h&agrave;ng cũng như &ldquo;nu&ocirc;i&rdquo; kh&aacute;ch h&agrave;ng từ giai đoạn bắt đầu tiếp cận thương hiệu cho đến khi quyết định mua sản phẩm. Mailchimp l&agrave; c&ocirc;ng cụ email marketing miễn ph&iacute; cho ph&eacute;p bạn dễ d&agrave;ng đo lường c&aacute;c chiến dịch truyền th&ocirc;ng qua mail.</p>

<p><strong>8. Growth hacking bằng Sniply</strong></p>

<p>L&agrave; một marketer c&oacute; lẽ bạn kh&ocirc;ng c&ograve;n qu&aacute; xa lạ với thuật ngữ &ldquo;growth hacking&rdquo; &ndash; c&aacute;c chiến lược tăng lượng người d&ugrave;ng tức th&igrave; một c&aacute;ch s&aacute;ng tạo v&agrave; &iacute;t tốn k&eacute;m.</p>

<p>Một trong những thủ thuật growth hacking hiệu quả l&agrave; share lại c&aacute;c post từ những chuy&ecirc;n gia nổi tiếng trong ng&agrave;nh để x&acirc;y dựng sự tin tưởng cho người d&ugrave;ng, Thế nhưng những nội dung bạn share lại thường nằm ở c&aacute;c website kh&aacute;c m&agrave; bạn kh&ocirc;ng c&oacute; quyền kiểm so&aacute;t n&ecirc;n thường người đọc sẽ &ldquo;ng&oacute; lơ&rdquo; lu&ocirc;n website/page của bạn khi được dẫn sang nguồn kh&aacute;c. Hiểu điều n&agrave;y, Sniply cho ph&eacute;p bạn gắn n&uacute;t k&ecirc;u gọi h&agrave;nh động (Call to action) v&agrave;o bất cứ nội dung g&igrave; bạn chia sẻ. N&oacute; gi&uacute;p bạn gắn một n&uacute;t quay lại/k&ecirc;u gọi h&agrave;nh động v&agrave;o một hộp thoại b&ecirc;n g&oacute;c tr&aacute;i m&agrave;n h&igrave;nh để người đọc c&oacute; thể quay trở lại website của bạn.</p>

<p><img alt="" h="626" id="img_80584dc0-61e3-11e6-9315-d5aad9c300b8" photoid="80584dc0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-7-1471154038373.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-7-1471154038373/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1024" /></p>

<p>V&iacute; dụ về sử dụng Sniply để k&ecirc;u gọi kh&aacute;ch h&agrave;ng quay lại trang</p>

<p><strong>9. Lấy nội dung từ c&aacute;c website bằng Scraper</strong></p>

<p><img alt="" h="813" id="img_7f717032-61e3-11e6-9315-d5aad9c300b8" photoid="7f717032-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-8-1471154038309.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-8-1471154038309/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1181" /></p>

<p>&nbsp;</p>

<p>Scraper (Data Miner) l&agrave; một tiện &iacute;ch Chrome cho ph&eacute;p lấy hết dữ liệu tr&ecirc;n một website n&agrave;o đ&oacute; rồi xuất n&oacute; ra file Excel để tiện theo d&otilde;i. Đ&acirc;y l&agrave; một c&aacute;ch tuyệt vời để lấy th&ocirc;ng tin kh&aacute;ch h&agrave;ng từ c&aacute;c đối thủ. Một khi đ&atilde; c&oacute; được những danh s&aacute;ch kh&aacute;ch h&agrave;ng đ&aacute;ng gi&aacute; n&agrave;y, bạn c&oacute; thể sử dụng cold email hay cold call để thu phục họ.</p>

<p><strong>10. T&igrave;m kiếm th&ocirc;ng tin ch&iacute;nh x&aacute;c bằng Rapportive</strong></p>

<p><img alt="" h="728" id="img_806964c0-61e3-11e6-9315-d5aad9c300b8" photoid="806964c0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-9-1471154038369.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-9-1471154038369/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1204" /></p>

<p>&nbsp;</p>

<p>Sẽ thế n&agrave;o nếu bạn nhận được email từ một kh&aacute;ch h&agrave;ng tiềm năng v&agrave; muốn biết th&ecirc;m th&ocirc;ng tin chi tiết của họ? Rapportive sẽ gi&uacute;p bạn dựa v&agrave;o email để tra ra ngay ảnh ch&acirc;n dung, nơi sống, nghề nghiệp, c&ocirc;ng ty, hồ sơ c&aacute; nh&acirc;n tr&ecirc;n LinkedIn,&hellip;v&agrave; hiển thị tất cả ngay tr&ecirc;n giao diện Gmail, rất tuyệt phải kh&ocirc;ng?</p>
', NULL, N'12-cong-cu-marketing-mien-phi-moi-startup-nen-biet', NULL, NULL, NULL, NULL, NULL, NULL, N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3276, 3139, 2, N'12 công cụ marketing miễn phí mọi startup nên biết', N'Nếu bạn đang phân vân giữa hàng trăm công cụ marketing trên thị trường hiện nay thì hãy tham khảo danh sách các sản phẩm tốt nhất dưới đây.', NULL, NULL, N'12-cong-cu-marketing-mien-phi-moi-startup-nen-biet', NULL, NULL, NULL, NULL, NULL, NULL, N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3277, 3140, 1, N'12 công cụ marketing miễn phí mọi startup nên biết', N'Nếu bạn đang phân vân giữa hàng trăm công cụ marketing trên thị trường hiện nay thì hãy tham khảo danh sách các sản phẩm tốt nhất dưới đây.', N'<p>Nếu đang khởi nghiệp kinh doanh ri&ecirc;ng bằng đồng vốn c&aacute; nh&acirc;n, chắc chắn bạn sẽ hiểu được gi&aacute; trị của từng đồng tiền tiết kiệm được.</p>

<p>Ai cũng hiểu tầm quan trọng của c&aacute;c hoạt động marketing đối với mỗi c&ocirc;ng ty. Nếu bạn đang ph&acirc;n v&acirc;n giữa h&agrave;ng trăm c&ocirc;ng cụ marketing tr&ecirc;n thị trường hiện nay th&igrave; h&atilde;y tham khảo danh s&aacute;ch c&aacute;c sản phẩm tốt nhất dưới đ&acirc;y.</p>

<p><strong>1. Quản l&yacute; c&aacute;c k&ecirc;nh truyền th&ocirc;ng x&atilde; hội bằng Buffer hoặc Hootsuite</strong></p>

<p>Buffer l&agrave; c&ocirc;ng cụ quản l&yacute; đắc lực cho c&aacute;c k&ecirc;nh truyền th&ocirc;ng x&atilde; hội như Facebook, Twitter, Instagram,&hellip; Buffer c&oacute; khả năng kết nối nhiều t&agrave;i khoản mạng x&atilde; hội v&agrave;o một bảng điều khiển duy nhất, gi&uacute;p bạn kh&ocirc;ng phải lăn lộn đăng b&agrave;i khắp nơi nữa. Một số t&iacute;nh năng th&uacute; vị kh&aacute;c bao gồm schedule (l&ecirc;n lịch trước) b&agrave;i đăng, tạo c&aacute;c chiến dịch cũng như ph&acirc;n t&iacute;ch độ hiệu quả c&aacute;c post của bạn. G&oacute;i miễn ph&iacute; của Buffer đ&atilde; l&agrave; kh&aacute; đủ cho c&aacute;c startup.</p>

<p><img alt="" h="510" id="img_7fa2b960-61e3-11e6-9315-d5aad9c300b8" photoid="7fa2b960-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-0-1471154038351.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-0-1471154038351/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1024" /></p>

<p>Bảng điều khiển của Buffer</p>

<p>Tương tự như vậy, Hootsuite cũng l&agrave; một c&ocirc;ng cụ tuyệt vời gi&uacute;p bạn quản l&yacute; c&aacute;c t&agrave;i khoản mạng x&atilde; hội. Điểm mạnh của Hootsuite l&agrave; cho ph&eacute;p bạn nhanh ch&oacute;ng đăng tải c&aacute;c b&agrave;i viết cũng như phản hồi tr&ecirc;n c&aacute;c t&agrave;i khoản mạng x&atilde; hội kh&aacute;c nhau ngay tr&ecirc;n một bảng điều khiển duy nhất.</p>

<p><strong>2. Thiết kế logo với &ldquo;chợ&rdquo; logo miễn ph&iacute; của Spaces</strong></p>

<p><img alt="" h="763" id="img_80a4e720-61e3-11e6-9315-d5aad9c300b8" photoid="80a4e720-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-1-1471154038377.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-1-1471154038377/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1244" /></p>

<p>Branding l&agrave; một trong những bước bắt buộc trong c&aacute;c hoạt động marketing của doanh nghiệp, v&agrave; logo l&agrave; phần quan trọng h&agrave;ng đầu trong bước n&agrave;y.</p>

<p>Với Spaces , bạn c&oacute; thể dễ d&agrave;ng lựa chọn h&igrave;nh d&aacute;ng v&agrave; c&aacute;c icon xuất hiện trong logo trong kho h&igrave;nh miễn ph&iacute; sẵn c&oacute; m&agrave; kh&ocirc;ng cần phải qu&aacute; nhiều tiền v&agrave;o thu&ecirc; một designer chuyển thể c&aacute;c &yacute; tưởng của bạn th&agrave;nh h&igrave;nh vẽ nữa.</p>

<p><strong>3. Thiết kế ấn phẩm truyền th&ocirc;ng dễ d&agrave;ng với Canva</strong></p>

<p><img alt="" h="888" id="img_80a50e31-61e3-11e6-9315-d5aad9c300b8" photoid="80a50e31-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-2-1471154038354.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-2-1471154038354/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="998" /></p>

<p>Ấn phẩm truyền th&ocirc;ng đẹp mắt đang ng&agrave;y c&agrave;ng trở n&ecirc;n quan trọng hơn trong marketing. Từ những h&igrave;nh ảnh minh họa b&agrave;i viết cho đến những infographic n&acirc;ng cao &yacute; thức người d&ugrave;ng, những catalogue sản phẩm cho đến poster quảng b&aacute; đều cần tới b&agrave;n tay của những người biết thiết kế. Thế nhưng nếu bạn chưa c&oacute; đủ vốn hay khả năng thu&ecirc; được một designer ri&ecirc;ng th&igrave; sao? Hiện nay c&oacute; rất nhiều c&ocirc;ng cụ design miễn ph&iacute; tr&ecirc;n thị trường, thế nhưng tốt v&agrave; dễ sử dụng h&agrave;ng đầu phải kể đến Canva . Với kho h&igrave;nh ảnh mẫu phong ph&uacute; cực nhiều poster, banner Facebook hay brochure, ảnh minh họa v&agrave; cho ph&eacute;p người d&ugrave;ng sử dụng kiểu k&eacute;o thả chữ v&agrave;o, Canva xứng đ&aacute;ng l&agrave; người bạn th&acirc;n của tất cả c&aacute;c marketer.</p>

<p><strong>4. Sử dụng Piktochart để tạo infographic nhanh ch&oacute;ng</strong></p>

<p><img alt="" h="799" id="img_7f2f1000-61e3-11e6-9315-d5aad9c300b8" photoid="7f2f1000-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-3-1471154038291.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-3-1471154038291/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1251" /></p>

<p>Infographic cũng l&agrave; một phương ph&aacute;p tuyệt vời trong content marketing, v&agrave; điều cản trở c&aacute;c marketer nhiều nhất từ trước đến nay ch&iacute;nh l&agrave; thiếu người c&oacute; khả năng thiết kế. Vấn đề đ&oacute; nay kh&ocirc;ng c&ograve;n nữa với Piktochart . Kho infographic mẫu của Piktochart c&oacute; rất nhiều infographic c&aacute;c loại cho bạn lựa chọn, từ loại về tiểu sử cuộc đời cho đến loại về hướng dẫn hay n&ecirc;u thống k&ecirc; cho người xem được tr&igrave;nh b&agrave;y một c&aacute;ch hết sức s&aacute;ng tạo. Bạn chỉ cần k&eacute;o thả th&ecirc;m c&aacute;c yếu tố m&igrave;nh cần rồi save ảnh về m&aacute;y l&agrave; xong.</p>

<p><strong>5. Tổ chức th&ocirc;ng tin bằng Evernote v&agrave; Mindmeister</strong></p>

<p>Việc tổ chức, sắp xếp th&ocirc;ng tin cho c&aacute;c chiến dịch marketing l&agrave; hết sức quan trọng. Bạn c&oacute; thể nảy ra &yacute; tưởng v&agrave;o bất cứ l&uacute;c n&agrave;o trong ng&agrave;y v&agrave; chắc chắn cần một nơi hệ thống lại tất cả. Evernote l&agrave; c&ocirc;ng cụ ghi ch&uacute; đ&atilde; qu&aacute; phổ biến, cho ph&eacute;p bạn kh&ocirc;ng chỉ ghi ch&eacute;p, scan từ notebook m&agrave; c&ograve;n cho save cả những b&agrave;i b&aacute;o, thư mục quan t&acirc;m về đọc offline.</p>

<p><img alt="" h="978" id="img_7f714920-61e3-11e6-9315-d5aad9c300b8" photoid="7f714920-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-4-1471154037983.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-4-1471154037983/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1680" /></p>

<p>Trong khi đ&oacute;, Mindmeister l&agrave; c&ocirc;ng cụ vẽ bản đồ tư duy đắc lực cho ph&eacute;p bạn chia sẻ cả với c&aacute;c cộng sự nữa. Việc c&ugrave;ng nhau brainstorm &yacute; tưởng cho c&aacute;c chiến dịch marketing sẽ trở n&ecirc;n đơn giản hơn rất nhiều.</p>

<p><strong>6. Lấy phản hồi kh&aacute;ch h&agrave;ng bằng SurveyMonkey</strong></p>

<p><img alt="" h="814" id="img_805874d0-61e3-11e6-9315-d5aad9c300b8" photoid="805874d0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-5-1471154038366.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-5-1471154038366/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1250" /></p>

<p>SurveyMonkey l&agrave; một trong số c&aacute;c c&ocirc;ng cụ khảo s&aacute;t online miễn ph&iacute; tốt nhất. Khảo s&aacute;t kh&aacute;ch h&agrave;ng l&agrave; hoạt động hữu &iacute;ch gi&uacute;p c&aacute;c marketer lấy insight, cảm nhạn của người d&ugrave;ng v&agrave; kh&aacute;m ph&aacute; c&aacute;c xu hướng sử dụng đương thời. Chỉ mất v&agrave;i ph&uacute;t bạn đ&atilde; c&oacute; thể thiết kế c&aacute;c n&ecirc;n một mẫu khảo s&aacute;t chuy&ecirc;n nghiệp. SurveyMonkey cũng cho ph&eacute;p bạn ph&acirc;n t&iacute;ch kết quả một c&aacute;ch chi tiết.</p>

<p><strong>7. Email marketing qua Mailchimp</strong></p>

<p><img alt="" h="543" id="img_7f717030-61e3-11e6-9315-d5aad9c300b8" photoid="7f717030-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-6-1471154037985.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-6-1471154037985/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="500" /></p>

<p>Theo d&otilde;i hiệu quả c&aacute;c chiến dịch qua MailChimp</p>

<p>Email marketing nay đ&atilde; trở th&agrave;nh một k&ecirc;nh kh&ocirc;ng thể thiếu với c&aacute;c doanh nghiệp. X&acirc;y dựng h&igrave;nh ảnh tr&ecirc;n c&aacute;c mạng x&atilde; hội như Facebook, Youtube, Instagram,&hellip; l&agrave; quan trọng nhưng cũng đi k&egrave;m với những hạn chế của c&aacute;c nền tảng n&agrave;y l&agrave; kh&oacute; đưa kh&aacute;ch h&agrave;ng v&agrave;o &ldquo;sales funnel&rdquo; v&agrave; theo d&otilde;i qu&aacute; tr&igrave;nh mua sắm của họ.</p>

<p>Tr&aacute;i lại, email lại cho ph&eacute;p bạn kiểm so&aacute;t chặt chẽ hơn sự tương t&aacute;c giữa thương hiệu v&agrave; kh&aacute;ch h&agrave;ng cũng như &ldquo;nu&ocirc;i&rdquo; kh&aacute;ch h&agrave;ng từ giai đoạn bắt đầu tiếp cận thương hiệu cho đến khi quyết định mua sản phẩm. Mailchimp l&agrave; c&ocirc;ng cụ email marketing miễn ph&iacute; cho ph&eacute;p bạn dễ d&agrave;ng đo lường c&aacute;c chiến dịch truyền th&ocirc;ng qua mail.</p>

<p><strong>8. Growth hacking bằng Sniply</strong></p>

<p>L&agrave; một marketer c&oacute; lẽ bạn kh&ocirc;ng c&ograve;n qu&aacute; xa lạ với thuật ngữ &ldquo;growth hacking&rdquo; &ndash; c&aacute;c chiến lược tăng lượng người d&ugrave;ng tức th&igrave; một c&aacute;ch s&aacute;ng tạo v&agrave; &iacute;t tốn k&eacute;m.</p>

<p>Một trong những thủ thuật growth hacking hiệu quả l&agrave; share lại c&aacute;c post từ những chuy&ecirc;n gia nổi tiếng trong ng&agrave;nh để x&acirc;y dựng sự tin tưởng cho người d&ugrave;ng, Thế nhưng những nội dung bạn share lại thường nằm ở c&aacute;c website kh&aacute;c m&agrave; bạn kh&ocirc;ng c&oacute; quyền kiểm so&aacute;t n&ecirc;n thường người đọc sẽ &ldquo;ng&oacute; lơ&rdquo; lu&ocirc;n website/page của bạn khi được dẫn sang nguồn kh&aacute;c. Hiểu điều n&agrave;y, Sniply cho ph&eacute;p bạn gắn n&uacute;t k&ecirc;u gọi h&agrave;nh động (Call to action) v&agrave;o bất cứ nội dung g&igrave; bạn chia sẻ. N&oacute; gi&uacute;p bạn gắn một n&uacute;t quay lại/k&ecirc;u gọi h&agrave;nh động v&agrave;o một hộp thoại b&ecirc;n g&oacute;c tr&aacute;i m&agrave;n h&igrave;nh để người đọc c&oacute; thể quay trở lại website của bạn.</p>

<p><img alt="" h="626" id="img_80584dc0-61e3-11e6-9315-d5aad9c300b8" photoid="80584dc0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-7-1471154038373.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-7-1471154038373/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1024" /></p>

<p>V&iacute; dụ về sử dụng Sniply để k&ecirc;u gọi kh&aacute;ch h&agrave;ng quay lại trang</p>

<p><strong>9. Lấy nội dung từ c&aacute;c website bằng Scraper</strong></p>

<p><img alt="" h="813" id="img_7f717032-61e3-11e6-9315-d5aad9c300b8" photoid="7f717032-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-8-1471154038309.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-8-1471154038309/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1181" /></p>

<p>&nbsp;</p>

<p>Scraper (Data Miner) l&agrave; một tiện &iacute;ch Chrome cho ph&eacute;p lấy hết dữ liệu tr&ecirc;n một website n&agrave;o đ&oacute; rồi xuất n&oacute; ra file Excel để tiện theo d&otilde;i. Đ&acirc;y l&agrave; một c&aacute;ch tuyệt vời để lấy th&ocirc;ng tin kh&aacute;ch h&agrave;ng từ c&aacute;c đối thủ. Một khi đ&atilde; c&oacute; được những danh s&aacute;ch kh&aacute;ch h&agrave;ng đ&aacute;ng gi&aacute; n&agrave;y, bạn c&oacute; thể sử dụng cold email hay cold call để thu phục họ.</p>

<p><strong>10. T&igrave;m kiếm th&ocirc;ng tin ch&iacute;nh x&aacute;c bằng Rapportive</strong></p>

<p><img alt="" h="728" id="img_806964c0-61e3-11e6-9315-d5aad9c300b8" photoid="806964c0-61e3-11e6-9315-d5aad9c300b8" rel="http://cafebiz.cafebizcdn.vn/2016/photo-9-1471154038369.jpg" src="http://cafebiz.cafebizcdn.vn/k:2016/photo-9-1471154038369/12congcumarketingmienphimoistartupnenbiet.jpg" type="photo" w="1204" /></p>

<p>&nbsp;</p>

<p>Sẽ thế n&agrave;o nếu bạn nhận được email từ một kh&aacute;ch h&agrave;ng tiềm năng v&agrave; muốn biết th&ecirc;m th&ocirc;ng tin chi tiết của họ? Rapportive sẽ gi&uacute;p bạn dựa v&agrave;o email để tra ra ngay ảnh ch&acirc;n dung, nơi sống, nghề nghiệp, c&ocirc;ng ty, hồ sơ c&aacute; nh&acirc;n tr&ecirc;n LinkedIn,&hellip;v&agrave; hiển thị tất cả ngay tr&ecirc;n giao diện Gmail, rất tuyệt phải kh&ocirc;ng?</p>
', NULL, N'12-cong-cu-marketing-mien-phi-moi-startup-nen-biet', NULL, NULL, NULL, NULL, NULL, NULL, N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3278, 3140, 2, N'12 công cụ marketing miễn phí mọi startup nên biết', N'Nếu bạn đang phân vân giữa hàng trăm công cụ marketing trên thị trường hiện nay thì hãy tham khảo danh sách các sản phẩm tốt nhất dưới đây.', NULL, NULL, N'12-cong-cu-marketing-mien-phi-moi-startup-nen-biet', NULL, NULL, NULL, NULL, NULL, NULL, N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết', N'12 công cụ marketing miễn phí mọi startup nên biết')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3279, 3141, 1, N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'Steve Jobs là nhân vật vĩ đại của làng công nghệ thế giới. Ông để lại dấu ấn trên ít nhất năm lĩnh vực: máy tính cá nhân với Apple II và Macintosh, âm nhạc với iPod và iTunes, điện thoại với iPhone, laptop với MacBook và hoạt hình với Pixar. ', N'<p>&Ocirc;ng đ&atilde; thay đổi cuộc sống của h&agrave;ng triệu người bằng c&ocirc;ng nghệ v&agrave; được biết tới như một trong những nh&agrave; điều h&agrave;nh v&agrave; chiến lược gia t&agrave;i năng nhất thế giới.</p>

<p>Bill Gates đ&atilde; từng chia sẻ: &ldquo;Lần đầu t&ocirc;i gặp Steve c&aacute;ch đ&acirc;y gần 30 năm. Ch&uacute;ng t&ocirc;i l&agrave; những đồng nghiệp, rồi l&agrave; đối thủ v&agrave; sau c&ugrave;ng ch&uacute;ng t&ocirc;i l&agrave; những người bạn suốt gần nửa cuộc đời. Hầu như kh&ocirc;ng ai tr&ecirc;n thế giới c&oacute; tầm ảnh hưởng như Steve. Đ&oacute;ng g&oacute;p của &ocirc;ng sẽ c&ograve;n t&aacute;c động tới nhiều thế hệ sau n&agrave;y. May mắn được l&agrave;m việc với Steve l&agrave; vinh dự lớn với bất cứ ai. T&ocirc;i thực sự nhớ &ocirc;ng ấy&rdquo;</p>

<p>Với cuộc đời v&agrave; những c&acirc;u chuyện của &ocirc;ng, kh&ocirc;ng ngạc nhi&ecirc;n khi &ocirc;ng&nbsp;được nhớ đến kh&ocirc;ng chỉ bởi sự nghiệp th&agrave;nh c&ocirc;ng vang dội m&agrave; c&ograve;n bởi những c&acirc;u n&oacute;i s&acirc;u sắc v&agrave; thấm th&iacute;a. Qua đ&oacute;, &ocirc;ng nhắc nhở ch&uacute;ng ta phải sống v&agrave; đam m&ecirc; một c&aacute;ch hết m&igrave;nh. V&agrave; th&agrave;nh c&ocirc;ng của cuộc đời&nbsp;kh&ocirc;ng phải l&agrave; trở th&agrave;nh một người gi&agrave;u c&oacute; nhất hay quyền lực nhất m&agrave; l&agrave; được l&agrave;m những điều m&igrave;nh th&iacute;ch. V&agrave; hơn hết hạnh ph&uacute;c l&agrave; được lao động, được tạo ra&nbsp;những thứ m&igrave;nh ấp ủ. V&agrave; để c&acirc;u chuyện v&agrave; th&agrave;nh quả của m&igrave;nh&nbsp;truyền cảm hứng cho nh&acirc;n loại.</p>

<p>Sau đ&acirc;y l&agrave;&nbsp;8 trong nhiều c&acirc;u n&oacute;i nổi tiếng của&nbsp;<em>Steve Jobs</em>&nbsp;về sự nghiệp, v&agrave; đam m&ecirc; đ&atilde; truyền cảm hứng cho triệu triệu người.</p>

<p><a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/1.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="360" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/1.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="640" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/22.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="406" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/22-650x406.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/32.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="433" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/32-650x433.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/42.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="366" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/42-650x366.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/52.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="406" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/52-650x406.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/6.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="366" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/6-650x366.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a>&nbsp;<a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/72.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="428" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/72.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="643" /></a></p>

<p><a href="http://blog.bizweb.vn/wp-content/uploads/2015/06/82.jpg"><img alt="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" height="364" src="http://blog.bizweb.vn/wp-content/uploads/2015/06/82-650x364.jpg" title="8 câu nói của Steve Jobs truyền cảm hứng cho bạn" width="650" /></a></p>
', NULL, N'8-cau-noi-cua-steve-jobs-truyen-cam-hung-cho-ban', NULL, NULL, NULL, NULL, NULL, NULL, N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3280, 3141, 2, N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'Steve Jobs là nhân vật vĩ đại của làng công nghệ thế giới.', NULL, NULL, N'8-cau-noi-cua-steve-jobs-truyen-cam-hung-cho-ban', NULL, NULL, NULL, NULL, NULL, NULL, N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn', N'8 câu nói của Steve Jobs truyền cảm hứng cho bạn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3281, 3142, 1, N'Ấn phẩm Quảng cáo', N'Việc định nghĩa thương hiệu một cách chính xác quả là một việc khó khăn, nó cũng là một câu hỏi muôn thưở mà không có một câu trả lời hay một đinh nghĩa chính xác. ', N'<p><img alt="" src="/Admin/Images/in-an-pham-van-phong.png" style="float: right; width: 846px; height: 418px;" /></p>

<p>Việc định nghĩa thương hiệu một c&aacute;ch ch&iacute;nh x&aacute;c quả l&agrave; một việc kh&oacute; khăn, n&oacute; cũng l&agrave; một c&acirc;u hỏi mu&ocirc;n thưở m&agrave; kh&ocirc;ng c&oacute; một c&acirc;u trả lời hay một đinh nghĩa ch&iacute;nh x&aacute;c.&nbsp;Tuy nhi&ecirc;n bạn c&oacute; thể hiểu đơn giản rằng&ldquo;Thương hiệu l&agrave; h&igrave;nh ảnh, cảm x&uacute;c, th&ocirc;ng điệp tức thời m&agrave; mọi người c&oacute; khi họ nghĩ về một c&ocirc;ng ty hoặc một sản phẩm. Một thương hiệu th&agrave;nh c&ocirc;ng đ&aacute;nh dấu một sản phẩm l&agrave; c&oacute; lợi thế cạnh tranh bền vững &ldquo;</p>

<p>Một doanh nghiệp phải tạo ra được bản sắc ri&ecirc;ng cho h&igrave;nh ảnh thương hiệu mới c&oacute; cơ hội ph&aacute;t triển trong việc chiếm vị tr&iacute; trong t&acirc;m tr&iacute; kh&aacute;ch h&agrave;ng v&agrave; v&agrave; tăng lợi nhuận cho doanh nghiệp.<br />
&nbsp;<br />
Thiết kế c&aacute;c ấn phẩm quảng c&aacute;o m&agrave;&nbsp;<strong>EPM</strong>&nbsp;tạo ra l&agrave; sự pha trộn h&agrave;i h&ograve;a giữa t&iacute;nh thẩm mỹ, sự ph&ugrave; hợp với yếu tố in ấn v&agrave; hiệu quả về chi ph&iacute;. V&igrave; thế bạn h&atilde;y y&ecirc;n t&acirc;m về sản phẩm của m&igrave;nh khi trao c&ocirc;ng việc cho ch&uacute;ng t&ocirc;i d&ugrave; đ&oacute; l&agrave; một quyển brochure, catalogue hay một bao b&igrave; sản phẩm.</p>

<p><strong>1. Thiết kế Catalogue:</strong><br />
L&agrave; doanh nghiệp bạn lu&ocirc;n cố gắng ở mức cao nhất để đưa sản phẩm, dịch vụ của m&igrave;nh đến được với kh&aacute;ch h&agrave;ng. Catalogue l&agrave; giải ph&aacute;p ho&agrave;n hảo cho vấn đề đ&oacute;. Catalogue gi&uacute;p bạn cung cấp những th&ocirc;ng tin về sản phẩm dịch vụ của m&igrave;nh tới kh&aacute;ch h&agrave;ng một c&aacute;ch trực quan v&agrave; sinh động. Gi&uacute;p tạo sự quan t&acirc;m v&agrave; phản hồi từ kh&aacute;ch h&agrave;ng.</p>

<p><strong>2.Thiết kế Brochure:</strong><br />
Brochure l&agrave; ấn phẩm quảng c&aacute;o quan trọng m&agrave; th&ocirc;ng qua n&oacute;, người đọc hiểu r&otilde; về c&ocirc;ng ty v&agrave; c&aacute;c hoạt động của c&ocirc;ng ty, h&igrave;nh th&agrave;nh n&ecirc;n kh&aacute;i niệm, t&acirc;m tư t&igrave;nh cảm ở họ đối với c&ocirc;ng ty v&agrave; sản phẩm của họ.</p>

<p><strong>3. Thiết kế tờ rơi, tờ gấp:</strong><br />
Tờ rơi, tờ gấp (Flyer) đ&atilde; từ l&acirc;u trở th&agrave;nh vật phẩm quảng c&aacute;o quen thuộc được c&aacute;c c&ocirc;ng ty sử dụng để quảng c&aacute;o b&aacute;n h&agrave;ng. Một thiết kế chuy&ecirc;n nghiệp, bắt mắt sẽ gi&uacute;p bạn tăng hiệu quả quảng c&aacute;o l&ecirc;n nhiều lần.</p>

<p><strong>4. Thiết kế Poster quảng c&aacute;o:</strong><br />
Poster thường được thiết kế v&agrave; in tr&ecirc;n khổ lớn v&agrave; l&agrave; lựa chọn cuả nhiều nh&agrave; quảng c&aacute;o. Để đạt hiệu quả tốt nhất về truyền th&ocirc;ng một quảng c&aacute;o Poster cần phải được thiết kế b&agrave;i bản từ kh&acirc;u &yacute; tưởng, chọn lọc h&igrave;nh ảnh, sắp xếp ng&ocirc;n từ cho tới kh&acirc;u thi c&ocirc;ng. EPM sẽ gi&uacute;p bạn thực hiện tất cả c&aacute;c c&ocirc;ng việc tr&ecirc;n một c&aacute;ch dễ d&agrave;ng v&agrave; đơn giản</p>

<p><strong>5. Thiết kế Profile c&ocirc;ng ty:</strong><br />
Profile c&ocirc;ng ty l&agrave; một t&agrave;i liệu giới thiệu về c&ocirc;ng ty d&agrave;nh cho kh&aacute;ch h&agrave;ng. Một c&ocirc;ng ty c&oacute; thể c&oacute; nhiều brochure giới thiệu sản phẩm nhưng chỉ c&oacute; một profile để n&oacute;i về m&igrave;nh. Th&ocirc;ng qua profile của c&ocirc;ng ty, kh&aacute;ch h&agrave;ng c&oacute; thể biết được mức độ chuy&ecirc;n nghiệp v&agrave; tầm cỡ quy m&ocirc; ng&agrave;nh nghề kinh doanh của c&ocirc;ng ty một c&aacute;ch kh&aacute;i qu&aacute;t.</p>

<p><strong>6. Thiết kế tem nh&atilde;n sản phẩm:</strong><br />
Tem nh&atilde;n l&agrave; yếu tố rất nhạy cảm, cần phải được đảm bảo c&aacute;c vấn đề về thẩm mỹ như in đẹp, r&otilde; n&eacute;t, độ d&iacute;nh cao, kh&ocirc;ng thể tẩy x&oacute;a hay b&oacute;c ra d&aacute;n lại. Tem nh&atilde;n cũng phải được đảm bảo về bản quyền sản xuất. Với chuy&ecirc;n m&ocirc;n của m&igrave;EPM&nbsp;sẽ cung cấp cho kh&aacute;ch h&agrave;ng c&aacute;c sản phẩm tem nh&atilde;n c&ocirc;ng nghệ mới, độ an to&agrave;n cao.</p>

<p><strong>7. Thiết kế Kẹp t&agrave;i liệu:</strong><br />
Kẹp t&agrave;i liệu (File Folder) được sử dụng để chứa t&agrave;i liệu kinh doanh, đồng thời cũng l&agrave; phương tiện marketing hiệu quả của doanh nghiệp. Một thiết kế đẹp sẽ để lại ấn tượng v&agrave; sự h&agrave;i l&ograve;ng cho kh&aacute;ch h&agrave;ng mỗi khi bạn sử dụng n&oacute;.</p>

<p><strong>8. Thiết kế Thực đơn nh&agrave; h&agrave;ng:</strong><br />
Một cuốn thực đơn tr&igrave;nh b&agrave;y bắt mắt sẽ n&acirc;ng tầm gi&aacute; trị của m&oacute;n ăn được phục vụ. Nếu bạn l&agrave; một chủ qu&aacute;n tinh tế v&agrave; muốn những thực kh&aacute;ch của bạn cảm nhận được điều đ&oacute; h&atilde;y để ch&uacute;ng t&ocirc;i gi&uacute;p bạn c&oacute; một thực đơn thật ấn tượng tr&ecirc;n mọi b&agrave;n ăn.</p>

<p><strong>9. Thiết kế Mẫu quảng c&aacute;o b&aacute;o ch&iacute;:</strong><br />
Nếu bạn quảng c&aacute;o tr&ecirc;n một tờ b&aacute;o địa phương hay trong tạp ch&iacute; lớn, quảng c&aacute;o được in ấn phải tạo ấn tượng rất chuy&ecirc;n nghiệp. Sử dụng bản in ấn tượng v&agrave; c&aacute;c h&igrave;nh ảnh bắt mắt để tập trung độc giả v&agrave;o những điểm l&agrave;m sản phẩm hay dịch vụ của bạn nổi bật so với c&aacute;c đối thủ cạnh tranh.</p>

<p><strong>10. Thiết kế Lịch Tết:</strong><br />
Ng&agrave;y nay việc tặng lịch cho kh&aacute;ch h&agrave;ng, đối t&aacute;c khi xu&acirc;n về đ&atilde; trở th&agrave;nh n&eacute;t văn ho&aacute; đẹp trong giao tiếp. Thiết kế một cuốn lịch xu&acirc;n đẹp vừa chuyển tải bao th&ocirc;ng điệp tốt l&agrave;nh đến người nhận, vừa c&oacute; &yacute; nghĩa vừa c&oacute; t&aacute;c dụng quảng c&aacute;o trong suốt một năm.</p>

<p><strong>11. Thiết kế B&igrave;a s&aacute;ch, tạp ch&iacute;:</strong><br />
Bạn cần tạo sự hấp dẫn cho một b&igrave;a s&aacute;ch hay một tạp ch&iacute;? C&oacute; một sự thật l&agrave; th&agrave;nh c&ocirc;ng của một ấn phẩm phụ thuộc nhiều v&agrave;o thiết kế b&igrave;a của ấn phẩm đ&oacute;. C&aacute;c họa sỹ thiết kế của EPM sẽ sẵn s&agrave;ng gi&uacute;p bạn tr&igrave;nh b&agrave;y b&igrave;a một cuốn s&aacute;ch, tạp ch&iacute; ấn tượng nhất.</p>

<p><strong>12. Thiết kế Bao b&igrave;, nh&atilde;n m&aacute;c sản phẩm:</strong><br />
Thiết kế bao b&igrave; sản phẩm l&agrave; sự kết hợp giữa nguy&ecirc;n liệu, cấu tr&uacute;c, c&aacute;ch tr&igrave;nh b&agrave;y, h&igrave;nh ảnh, m&agrave;u sắc v&agrave; những th&agrave;nh phần kh&aacute;c tạo ra sự thu h&uacute;t thị gi&aacute;c cho mục đ&iacute;ch truyền th&ocirc;ng mục ti&ecirc;u v&agrave; chiến lược marketing của một thương hiệu hay sản phẩm.</p>

<p><strong>13. Thiết kế t&uacute;i giấy:</strong><br />
Vừa c&oacute; c&ocirc;ng dụng thay thế cho loại t&uacute;i đựng b&igrave;nh thường vừa c&oacute; t&aacute;c dụng ghi dấu ấn h&igrave;nh ảnh thương hiệu doanh nghiệp, t&uacute;i giấy được thiết kế ấn tượng r&otilde; r&agrave;ng c&oacute; thể l&agrave;m tăng gi&aacute; trị cuả vật phẩm m&agrave; bạn định trao tặng.</p>

<p><strong>14. Thiết kế B&aacute;o c&aacute;o thường ni&ecirc;n:</strong><br />
Kh&ocirc;ng chỉ phơi b&agrave;y những con số, b&aacute;o c&aacute;o thường ni&ecirc;n c&ograve;n l&agrave; vũ kh&iacute; tối thượng của trong quan hệ của doanh nghiệp với c&aacute;c nh&agrave; đầu tư. Ch&iacute;nh v&igrave; thế thiết kế loại t&agrave;i liệu n&agrave;y cần một tư duy kh&aacute;c hơn so với việc thiết kế một brochure, catalogue, bao b&igrave; hoặc trang quảng c&aacute;o tr&ecirc;n b&aacute;o ch&iacute;.</p>

<p><strong>15. Chụp ảnh quảng c&aacute;o:</strong><br />
Một bức tranh c&oacute; gi&aacute; trị bằng ngh&igrave;n lời n&oacute;i. Để th&ocirc;ng điệp quảng c&aacute;o cuả bạn đến thẳng với tiềm thức kh&aacute;ch h&agrave;ng bạn cần c&oacute; những h&igrave;nh ảnh quảng c&aacute;o thật ấn tượng. Dịch vụ chụp ảnh quảng c&aacute;o của EPM cung cấp c&aacute;c h&igrave;nh thức chụp ảnh đa dạng ph&ugrave; hợp với nhiều loại h&igrave;nh quảng c&aacute;o.</p>

<p><strong>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i thiết kế bộ ấn phẩm quảng c&aacute;o theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.com</a>&nbsp;hoặc Hotline: 093 8283846, đội ngũ chuy&ecirc;n vi&ecirc;n sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</strong></p>
', NULL, N'an-pham-quang-cao', NULL, NULL, NULL, NULL, NULL, NULL, N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3282, 3142, 2, N'ADVERTISING PUBLICATIONS', N'The brand defines accurately is a difficult job, it is also a persistent question without an answer or an exact definition.', N'<p>&nbsp;But you can understand simply that &quot;Brands are images, feelings, instant messages that people have when they think about a company or a product. A successful brand is a product marked with a sustainable competitive advantage &quot;</p>

<p>A business must create its own identity for the new brand image development opportunities to occupy the position in the minds of customers and and increase profits for businesses.&nbsp;<br />
<br />
Design Publications advertising that&nbsp;<strong>EPM</strong>creating a mix between aesthetic harmony, conformity with elements of print and cost-effective. So you can rest assured your product when given the job to us whether it is a brochure, catalog or a product packaging.</p>

<p><strong>1. Design Catalogue:&nbsp;</strong><br />
As a business you are always trying to bring the highest level of products and its services accessible to customers. Catalogue is the perfect solution to that problem. Catalog helps you to provide information about their products and services to customers visually and vividly. Help create interest and feedback from customers.</p>

<p><strong>2 The design Brochure:&nbsp;</strong><br />
Brochure is advertising publications through its important that readers understand the company and the company&#39;s operations, forming concepts, sentiments in their minds, for companies and products their.</p>

<p><strong>3. Design brochures, leaflets:&nbsp;</strong><br />
Leaflets and brochures (Flyer) has long since become a familiar advertising material used by companies to promote sales. A professionally designed, eye-catching will help you increase advertising effectiveness by many times.</p>

<p><strong>4. Poster advertising design:&nbsp;</strong><br />
Poster often designed and printed on large format and is the choice of many advertisers. To achieve the best performance of advertising media a poster must be designed from the stage all the ideas, image selection, arrangement of words to the stage of construction. EPM will help you do all the work in a simple and easy way</p>

<p><strong>5. Design Company Profile:&nbsp;</strong><br />
Profile company is introducing a document for the client company. A company can have multiple product brochure but only one to talk about his profile. Through the company&#39;s profile, customers can know the level of professionalism and caliber of business scope of the company broadly.</p>

<p><strong>6. Design product labels:&nbsp;</strong><br />
Stamps labeled as very sensitive element, must be guaranteed aesthetic problems such as print beautiful, clear, high-viscosity, indelibly affixed or peeled off again. Labels must also be assured of product patents. With his expertise EPM&nbsp;will provide customers with the products label new technology, high safety.</p>

<p><strong>7. Clamp design documentation:&nbsp;</strong><br />
Binder document (File Folder) is used to store business documents, as well as effective means of business marketing. A beautiful design will leave an impression and satisfaction for customers every time you use it.</p>

<p><strong>8. Restaurant Menu Design:&nbsp;</strong><br />
A menu on the eye-catching presentation will elevate the value of PHC service dishes. If you are an owner and want sophistication to your customers feel that let us help you have an impressive menu on every table.</p>

<p><strong>9. Sample design newspaper ads:&nbsp;</strong><br />
If you advertise in a local newspaper or in magazines, print ads have a very professional impression. Use print impressive and eye-catching image to focus the reader on what product or service do you stand out from your competitors with.</p>

<p><strong>10. Design Calendar Festival:&nbsp;</strong><br />
calendar days giving customers and partners when spring became the beautiful culture of communication. Design a beautiful spring calendar convey just how good message to recipients, and significant advertising medium works throughout the year.</p>

<p><strong>11. The cover design, the magazine:&nbsp;</strong><br />
You need to create the attraction for a book or a magazine cover? It is true that a publication&#39;s success depends on the publication&#39;s cover design it. The artist designed the EPM will gladly help you present a book cover, the most impressive magazine.</p>

<p><strong>12. Packaging Design, Product labels:&nbsp;</strong><br />
product packaging design is a combination of materials, structure, layout, images, colors and other ingredients to create a visual attraction for communication purposes and strategic objectives marketing of a brand or product.</p>

<p><strong>13. Design paper bags:&nbsp;</strong><br />
Medium will be used to replace the normal bags just work noted corporate brand image, paper bags designed clear impression could increase the value of the items that you plan Awarded.</p>

<p><strong>14. Design Annual Report:&nbsp;</strong><br />
Not only expose the numbers, there is the annual report of the ultimate weapon of the business relationship with investors. Therefore this type of material design need a different mindset than designing a brochure, catalog, packaging or advertising pages in the newspaper.</p>

<p><strong>15. Photographing ad:&nbsp;</strong><br />
A picture is worth a thousand words by. For your advertising messages directly to your subconscious mind customer needs advertising images is impressive. Photographic Services ads EPM provides diverse photographic form suitable for various types of advertising.</p>

<p bablic-captured="true"><strong>For more information about the package design and advertising materials on demand customers can contact us at the email address:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.com&nbsp;</a>or Hotline: 093 8283 846, team of experts will free advice to customers.</strong></p>
', NULL, N'advertising-publications', NULL, NULL, NULL, NULL, NULL, NULL, N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'Ấn phẩm Quảng cáo', N'ADVERTISING PUBLICATIONS', N'ADVERTISING PUBLICATIONS', N'ADVERTISING PUBLICATIONS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3283, 3143, 1, N'Thiết kế logo', N'Thiết kế logo theo phong thủy', N'<p><img alt="" src="/Admin/Images/log-phong-thuy.png" style="float: right; width: 598px; height: 578px;" /></p>

<p><strong>1. V&igrave; sao phải thiết kế Logo theo Phong Thuỷ</strong></p>

<p>Trong c&aacute;c yếu tố thể hiện thương hiệu của doanh nghiệp, th&igrave; Logo (hay biểu trưng, biểu tượng) l&agrave; yếu tố chủ đạo, g&oacute;p phần định h&igrave;nh thương hiệu doanh nghiệp nhiều nhất trong ấn tượng của kh&aacute;ch h&agrave;ng. N&oacute; thể hiện văn ho&aacute; doanh nghiệp, thế mạnh, cũng như triết l&yacute; kinh doanh của doanh nghiệp đ&oacute;. Ch&iacute;nh v&igrave; vậy, Logo được c&aacute;c doanh nghiệp rất ch&uacute; trọng đầu tư, sao cho vừa đẹp, ấn tượng, thanh tho&aacute;t, vừa h&agrave;m chứa nhiều &yacute; nghĩa tinh tế v&agrave; s&acirc;u xa trong đ&oacute;.</p>

<p>Nhưng nội dung hay, h&igrave;nh thức đẹp vẫn l&agrave; chưa đủ, một Logo tốt c&ograve;n phải được thiết kế hợp Phong Thuỷ, gi&uacute;p bổ trợ cho chủ doanh nghiệp. Logo hợp Phong Thuỷ gi&uacute;p th&uacute;c đẩy vận kh&iacute;, thu h&uacute;t t&agrave;i lộc, ho&aacute; giải những vận xấu trong kinh doanh, gi&uacute;p cho c&ocirc;ng việc l&agrave;m ăn đạt thuận lợi, kinh doanh ph&aacute;t triển.</p>

<p><strong>2. Thế n&agrave;o l&agrave; một Logo hợp Phong Thuỷ</strong></p>

<p>Cũng như một căn nh&agrave;, một Logo hợp Phong Thuỷ trước ti&ecirc;n phải tạo cho người xem cảm gi&aacute;c thoải m&aacute;i, dễ chịu, g&acirc;y thiện cảm đối với doanh nghiệp, tổ chức. Tiếp đ&oacute; Logo phải bổ trợ cho bản mệnh của chủ doanh nghiệp (bao gồm Ni&ecirc;n Mệnh, Tứ Trụ Mệnh v&agrave; &Acirc;m Dương h&igrave;nh th&aacute;i), v&igrave; chủ doanh nghiệp sẽ l&agrave; đầu tầu th&uacute;c đẩy cả doanh nghiệp ph&aacute;t triển. Để đạt được điều đ&oacute;, Logo cần phải c&oacute;:</p>

<p>+ Một thiết kế r&otilde; r&agrave;ng, mạch lạc, ph&ocirc;ng chữ dễ nh&igrave;n, khoảng c&aacute;ch giữa c&aacute;c chữ, c&aacute;c đường n&eacute;t kh&ocirc;ng qu&aacute; thưa cũng kh&ocirc;ng qu&aacute; mau, gi&uacute;p cho trường năng lượng lưu chuyển tốt.<br />
+ C&aacute;c đường n&eacute;t tr&ecirc;n Logo cần c&oacute; sự tiếp nối, h&agrave;i ho&agrave;, tr&aacute;nh c&aacute;c g&oacute;c nhọn tạo cảm gi&aacute;c bất an cho người xem, n&ecirc;n sử dụng c&aacute;c đường vuốt cong tr&ograve;n mềm mại tạo cảm gi&aacute;c h&agrave;i ho&agrave;<br />
+ M&agrave;u sắc của Logo ngo&agrave;i việc phản ảnh Ngũ H&agrave;nh ph&ugrave; hợp th&igrave; cũng kh&ocirc;ng qu&aacute; tương phản g&acirc;y kh&oacute; chịu v&agrave; kh&ocirc;ng qu&aacute; mờ nhạt g&acirc;y kh&oacute; nh&igrave;n v&agrave; k&eacute;m ấn tượng<br />
+ Ngũ H&agrave;nh của Logo cần được lựa chọn ph&ugrave; hợp để vừa bổ trợ cho Ni&ecirc;n Mệnh lại vừa c&acirc;n bằng Tứ Trụ Mệnh của chủ doanh nghiệp. Tr&aacute;nh sử dụng c&aacute;c h&agrave;nh khắc chế với ni&ecirc;n mệnh của chủ doanh nghiệp hoặc c&aacute;c h&agrave;nh đ&atilde; qu&aacute; dư thừa trong Tứ Trụ Mệnh. Ngũ h&agrave;nh của Logo thể hiện qua m&agrave;u chữ, m&agrave;u nền, đường n&eacute;t hoạ tiết tr&ecirc;n Logo, kiểu chữ&hellip;<br />
&nbsp;+ Đặc t&iacute;nh &Acirc;m Dương của Logo cũng cần gi&uacute;p c&acirc;n bằng lại &Acirc;m Dương h&igrave;nh th&aacute;i của chủ doanh nghiệp. Nếu như th&acirc;n chủ thuộc Dương mệnh th&igrave; Logo n&ecirc;n thuộc &Acirc;m để gi&uacute;p c&acirc;n bằng v&agrave; ngược lại. Để biết một Logo thuộc &Acirc;m hay Dương căn cứ v&agrave;o nhiều yếu tố như m&agrave;u sắc, trạng th&aacute;i tĩnh hay động, c&aacute;ch tr&igrave;nh b&agrave;y bố cục&hellip;</p>

<p><strong>3. Quy tr&igrave;nh thiết kế Logo theo Phong Thuỷ</strong></p>

<p><strong>Bước 1:</strong><br />
- Khảo s&aacute;t y&ecirc;u cầu doanh nghiệp<br />
- T&igrave;m hiểu về ng&agrave;nh nghề kinh doanh<br />
- Đặc trưng sản phẩm<br />
- Quy m&ocirc; v&agrave; đặc th&ugrave; doanh nghiệp<br />
- Đối tượng kh&aacute;ch h&agrave;ng của doanh nghiệp<br />
- Th&ocirc;ng tin về Tứ trụ mệnh (giờ ng&agrave;y th&aacute;ng năm sinh) của chủ doanh nghiệp<br />
<strong>Bước 2:</strong><br />
- Th&ocirc;ng qua c&aacute;c th&ocirc;ng tin thu thập được, ch&uacute;ng t&ocirc;i sẽ đưa ra c&aacute;c bản thuyết minh v&agrave; y&ecirc;u cầu về mặt Phong Thuỷ, v&iacute; dụ như: c&aacute;c t&ocirc;ng m&agrave;u ch&iacute;nh, t&ocirc;ng m&agrave;u phụ, c&aacute;c đường n&eacute;t chủ đạo, kiểu ph&ocirc;ng chữ v&agrave; k&iacute;ch cỡ chữ, c&aacute;c h&igrave;nh ảnh n&ecirc;n c&oacute;,&hellip;<br />
<strong>Bước 3:</strong><br />
- Thiết kế Logo tr&ecirc;n c&aacute;c phần mềm đồ hoạ, dựa tr&ecirc;n c&aacute;c chỉ định về Phong Thuỷ đ&atilde; c&oacute; ở bước 2.<br />
Chỉnh sửa theo &yacute; kh&aacute;ch h&agrave;ng.</p>

<p><strong>4. Những nội dung cần cung cấp</strong></p>

<p>- Họ t&ecirc;n, giới t&iacute;nh, giờ ng&agrave;y th&aacute;ng năm sinh (ghi r&otilde; DL hay &Acirc;L) của chủ doanh nghiệp<br />
&nbsp;&nbsp;&nbsp; Lưu &yacute;: Chủ doanh nghiệp ở đ&acirc;y l&agrave; người trực tiếp điều h&agrave;nh, quyết định sự th&agrave;nh bại của doanh nghiệp, kh&ocirc;ng phải l&agrave; chủ tịch hội đồng quản trị hay người đứng t&ecirc;n tr&ecirc;n giấy tờ<br />
- T&ecirc;n doanh nghiệp (cả Anh v&agrave; Việt)<br />
- Website của doanh nghiệp (nếu c&oacute;)<br />
- Ng&agrave;nh nghề kinh doanh của doanh nghiệp (nếu c&oacute; nhiều ng&agrave;nh nghề th&igrave; ghi r&otilde; ng&agrave;nh ch&iacute;nh nhất)<br />
- Phương ch&acirc;m hoạt động, định hướng ph&aacute;t triển, gi&aacute; trị cốt l&otilde;i của doanh nghiệp<br />
- Tầm hoạt động của doanh nghiệp (trong một tỉnh th&agrave;nh, to&agrave;n quốc, khu vực Asia hay to&agrave;n cầu)<br />
- L&yacute; do muốn l&agrave;m logo (thiết kế mới, l&agrave;m lại từ logo cũ, l&yacute; do muốn l&agrave;m lại&hellip;)<br />
- Cung cấp c&aacute;c mẫu logo cũ, hoặc mẫu logo đang thu&ecirc; b&ecirc;n kh&aacute;c l&agrave;m m&agrave; chưa ưng &yacute; (nếu c&oacute;), n&ecirc;u r&otilde; điểm chưa ưng &yacute;<br />
- N&ecirc;u &yacute; tưởng mong muốn với mẫu logo (h&igrave;nh thức, m&agrave;u sắc, đường n&eacute;t&hellip;), c&aacute;c nội dung n&agrave;y chỉ để tham khảo<br />
- C&oacute; muốn đưa v&agrave;o logo một h&igrave;nh ảnh đặc biệt n&agrave;o đ&oacute; kh&ocirc;ng (sản phẩm của doanh nghiệp, h&igrave;nh ảnh ưa th&iacute;ch&hellip;)<br />
- Muốn l&agrave;m Logo dạng chỉ l&agrave; h&igrave;nh ảnh biểu trưng hay muốn c&aacute;ch điệu biến thể từ t&ecirc;n c&ocirc;ng ty<br />
- Nếu l&agrave;m logo ở dạng h&igrave;nh ảnh biểu trưng th&igrave; c&oacute; gh&eacute;p phần t&ecirc;n logo v&agrave;o b&ecirc;n cạnh kh&ocirc;ng<br />
- T&ecirc;n c&ocirc;ng ty sử dụng trong Logo muốn l&agrave; chữ tiếng Việt hay tiếng Anh<br />
- Ngo&agrave;i t&ecirc;n logo c&oacute; cần c&oacute; c&aacute;c c&acirc;u slogan (biểu ngữ) kh&ocirc;ng, cung cấp slogan (nếu c&oacute;)</p>

<p><strong>5. Chi ph&iacute; thực hiện</strong></p>

<p>C&ocirc;ng việc &ldquo;Thiết kế Logo theo Phong Thuỷ&rdquo; bao gồm 02 phần c&ocirc;ng việc:<br />
Phần Phong Thủy:<br />
- Khảo s&aacute;t, tư vấn, thiết kế phần Phong Thuỷ cho Logo<br />
- Bao gồm c&aacute;c c&ocirc;ng việc ở Bước 1 v&agrave; Bước 2 trong mục 3 ở tr&ecirc;n.<br />
<strong>&nbsp; Chi ph&iacute; trọn g&oacute;i 2.500.000đ</strong></p>

<p><strong>Phần Đồ Họa</strong></p>

<p>Thiết kế Logo dựa theo chỉ định của phần Phong Thuỷ<br />
Bao gồm c&aacute;c c&ocirc;ng việc ở Bước 3 trong mục 3 ở tr&ecirc;n.<br />
Phần n&agrave;y qu&yacute; kh&aacute;ch c&oacute; thể thu&ecirc; trực tiếp của ch&uacute;ng t&ocirc;i hoặc thu&ecirc; một đơn vị thiết kế Logo kh&aacute;c để hợp t&aacute;c với ch&uacute;ng t&ocirc;i.<br />
Chi ph&iacute; gồm 03 mức:<br />
<strong>+ 3.000.000đ: cho 02 phương &aacute;n logo<br />
+ 6.000.000đ: cho 06 phương &aacute;n logo<br />
+ 15.000.000đ: kh&ocirc;ng giới hạn số phương &aacute;n</strong></p>

<p>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i thiết kế logo chuy&ecirc;n nghiệp theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.com</a>&nbsp;hoặc Hotline: 0938.283846, đội ngũ Chuy&ecirc;n vi&ecirc;n ch&uacute;ng t&ocirc;i sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</p>
', NULL, N'thiet-ke-logo', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế logo', N'Thiết kế logo', N'Thiết kế logo', N'Thiết kế logo', N'Thiết kế logo', N'Thiết kế logo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3284, 3143, 2, N'Logo design, namecard', N'Logo design according to Feng Shui', N'<p><strong>1. Why should design according to Feng Shui Logo</strong></p>

<p>In the show brand elements of the business, the logo (or logo, symbol) is a key factor contributing to shaping the corporate brand&#39;s most important customers. It embodies the corporate culture and strengths, as well as the business philosophy of the business. Therefore, businesses Logo are very focused on investment, so just beautiful, impressive, elegant, and containing many subtle meanings and deeper in it.</p>

<p bablic-captured="true">But the content and form of the beautiful is not enough, a good logo should also be designed with Feng Shui, help subsidize business owners. Logo of Feng Shui helps to promote air transport, attracting fortune, the bad fortunes of the business, your work to reach a favorable business and business development.</p>

<p><br />
<strong>2. What is a logo of Fengshui</strong></p>

<p>Like a house, one of Fengshui Logo must first create the viewer feel comfortable, pleasant, cozy, for enterprises and organizations. Next Logo guardian must complement of business owners (including Year Par, Par and yin yang four pillars form), because business owners will be the first ship to promote both business development. To achieve that, the logo should have:</p>

<p>+ A design clear, coherent, visible fonts, spacing between letters, lines not too little nor too quickly, allowing the flow of good energy.&nbsp;<br />
+ The lines on Logo required continuity, harmony, avoid sharp corners create insecurity for the viewer, should use the circular curved claws feels soft harmonization&nbsp;<br />
+ Color of Logo besides reflecting the Five suitable operating the contrast is not too offensive and not too faint offensive look less impressive and&nbsp;<br />
+ Marble&#39;s logo should be suitable choice to complement both the medium balance Annual Par Four Head of business owners Par. Avoid using the older operating with destiny allelopathic business owner or the operator has a surplus of four pillars Par. The five elements of the logo shown through text color, background color, lines Logo textures, typography ...&nbsp;<br />
+ Yin-Yang Properties of Logos should also help rebalance the yin yang of business owners form. If the client under par Ocean Acoustics Logo should belong to help balance and vice versa. For a logo of Yin and Yang based on many factors such as color, static or dynamic state, the presentation layout ...</p>

<p><strong>3. Logo Design Process according to Fengshui</strong></p>

<p><strong>Step 1:&nbsp;</strong><br />
- requires business survey&nbsp;<br />
- Learn about business&nbsp;<br />
- Product Features&nbsp;<br />
- The size and characteristics now&nbsp;<br />
- For customers of Business Industry&nbsp;<br />
- Update on the Four pillars par (date of birth hours) of business owners&nbsp;<br />
<strong>Step 2:&nbsp;</strong><br />
- Through the information gathered, we will give explanations and requirements in terms of Feng Shui, eg primary colors, secondary colors, the dominant line, type font and text size, the picture should be, ...&nbsp;<br />
<strong>Step 3:&nbsp;</strong><br />
- Logo Design on the graphics software, based on the indications of Fengshui has 2 step.&nbsp;<br />
Edit the customization.</p>

<p><strong>4. The content should provide</strong></p>

<p>- Full name, gender, date of birth hours (specify DL or lunar) of business owners&nbsp;<br />
Note: Business owners who live here is operating, decide the success or failure of the business, not the board chairman or the person named on papers&nbsp;<br />
- the name of the enterprise (both English and Vietnamese)&nbsp;<br />
- Website of the enterprise (if any)&nbsp;<br />
- Industry business now (if more trades are clearly the most major industries)&nbsp;<br />
- motto, orientation, core values ​​of the business&nbsp;<br />
- Range of business (in a province success, national, regional or global Asia)&nbsp;<br />
- the reason want to make logo (the new design, a remake of the old logo, why want to do it again ...)&nbsp;<br />
- Provide old logo templates, logo templates are renting or other parties that have not satisfied (if any), points out not like the&nbsp;<br />
- if desired idea logo form (form, color, lines ...), the content this reference only&nbsp;<br />
- Would like to put on the logo a particular image does not (the product of the business, favorite photos ...)&nbsp;<br />
- want to logo image format is only symbolic or want stylized variations from company name&nbsp;<br />
- If the logo in the form of symbolic images then grafted into the next part of the name logo is not&nbsp;<br />
- name of company logo used in the letter want Vietnamese or English<br />
- In addition there is need to have the logo name slogan (banner) do not provide slogan (if any)</p>

<p><strong>5. Implementation costs</strong></p>

<p>The work &quot;according to Fengshui Logo Design&quot; includes 02 piece of work:&nbsp;<br />
The Feng Shui:&nbsp;<br />
- Surveying, consulting, design for part Fengshui Logo&nbsp;<br />
- Include work in Step 1 and 2 Step 3 items above.&nbsp;<br />
<strong>Cost 2 package. 500.000 e</strong></p>

<p><strong>Part Graphic</strong></p>

<p>Logo design is based on the designation of part Fengshui&nbsp;<br />
Including work in Step 3 of 3 section above.&nbsp;<br />
This section you can rent directly from us, or hire a logo design other units to cooperate with us.&nbsp;<br />
the cost includes 03 level:&nbsp;<br />
<strong>+ 3.000.000 e: 02 plans for logo&nbsp;<br />
+ 6.000.000 e: 06 plans for logo&nbsp;<br />
+ 15.000.000 e: unlimited number of plans</strong></p>

<p>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i thiết kế logo chuy&ecirc;n nghiệp theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.vn</a>&nbsp;hoặc Hotline: 0938283846, đội ngũ Chuy&ecirc;n vi&ecirc;n ch&uacute;ng t&ocirc;i sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</p>

<p bablic-captured="true">&nbsp;</p>
', NULL, N'logo-design-namecard', NULL, NULL, NULL, NULL, NULL, NULL, N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard', N'Logo design, namecard')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3285, 3144, 1, N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'<p><img alt="" src="/Admin/Images/facebook.png" style="float: right; width: 607px; height: 300px;" /></p>

<p>Với kinh nghiệm nhiều năm thực hiện truyền th&ocirc;ng v&agrave; quảng c&aacute;o, C&aacute;c chuy&ecirc;n gia ch&uacute;ng t&ocirc;i đang thực hiện rất nhiều chiến dịch quảng c&aacute;o Facebook th&agrave;nh c&ocirc;ng cho c&aacute;c doanh nghiệp, ch&uacute;ng t&ocirc;i tự tin sẽ gi&uacute;p Bạn th&agrave;nh c&ocirc;ng khi triển khai quảng c&aacute;o tr&ecirc;n Facebook.</p>

<p>B&ecirc;n cạnh quảng c&aacute;o Google th&igrave; quảng c&aacute;o Facebook ng&agrave;y c&agrave;ng được c&aacute;c doanh nghiệp Việt Nam ch&uacute; &yacute; v&agrave; sử dụng rộng r&atilde;i. Với hơn 32 triệu người d&ugrave;ng (th&aacute;ng 3/2015,số liệu thống k&ecirc; từ Facebook) Facebook đang cho thấy m&igrave;nh đang l&agrave; một k&ecirc;nh tiếp thị kh&ocirc;ng thể bỏ qua đối với tất cả c&aacute;c doanh nghiệp, trong tất cả c&aacute;c lĩnh vực.</p>

<p><strong>Lợi thế quảng c&aacute;o Facebook:</strong></p>

<p>Doanh nghiệp nhắm đ&uacute;ng đối tượng kh&aacute;ch h&agrave;ng:</p>

<ul>
	<li>Về giới t&iacute;nh, sở th&iacute;ch, độ tuổi,h&agrave;nh vi..</li>
	<li>Thị trường quảng c&aacute;o (H&agrave; Nội, Hồ Ch&iacute; Minh hoặc một địa danh cụ thể)</li>
	<li>Tr&ecirc;n thiết bị di động hoặc m&aacute;y t&iacute;nh...</li>
</ul>

<p>Quảng c&aacute;o Facebook&nbsp;c&oacute; độ tương t&aacute;c với kh&aacute;ch h&agrave;ng rất cao th&ocirc;ng qua&nbsp;Website, Fanpage... dễ d&agrave;ng phản hồi v&agrave; chăm s&oacute;c kh&aacute;ch h&agrave;ng tốt hơn.</p>

<p>Chiến dịch quảng c&aacute;o thay đổi linh hoạt, sống động, tạo cảm gi&aacute;c th&acirc;n thiện với kh&aacute;ch h&agrave;ng.</p>

<p>Ng&acirc;n s&aacute;ch quảng c&aacute;o linh hoạt, thay đổi dễ d&agrave;ng.</p>

<p>Chi ph&iacute; quảng c&aacute;o Facebook:</p>

<ul>
	<li>Kh&ocirc;ng c&oacute; chi ti&ecirc;u tối thiểu v&agrave; tối đa, t&ugrave;y theo ng&acirc;n s&aacute;ch của m&igrave;nh m&agrave; doanh nghiệp giới hạn khả năng tiếp cận kh&aacute;ch h&agrave;ng nhiều hay &iacute;t.</li>
	<li>Doanh nghiệp c&oacute; thể chọn h&igrave;nh thức t&iacute;nh tiền theo CPC hoặc CPM.</li>
</ul>

<p><strong>C&aacute;c h&igrave;nh thức quảng c&aacute;o Facebook Bin thực hiện:</strong></p>

<p><strong>&nbsp;1. Quảng c&aacute;o tăng Like (Fanpage): tăng like từ hệ thống Facebook, like thật 100%.</strong></p>

<p>&nbsp;</p>

<p><img alt="" height="337" src="http://bachnghegroup.com/images/allpic/quang-cao-facebook-1.jpg" width="600" /></p>

<p><strong>2. Quảng c&aacute;o b&agrave;i biết trong Fanpage (bao gồm Like,b&igrave;nh luận,chia sẻ...)</strong></p>

<p><img alt="" height="337" src="http://bachnghegroup.com/images/allpic/quang-cao-facebook-2.jpg" width="600" /></p>

<p>&nbsp;<strong>3. Quảng c&aacute;o c&agrave;i đặt Ứng dụng.</strong></p>

<p><img alt="" height="337" src="http://bachnghegroup.com/images/allpic/quang-cao-facebook-3.jpg" width="600" /></p>

<p><strong>&nbsp;4. Quảng c&aacute;o Website.</strong></p>

<p>&nbsp;<img alt="" height="337" src="http://bachnghegroup.com/images/allpic/quang-cao-facebook-4.jpg" width="600" /></p>

<p><strong>5. Quảng c&aacute;o Lượt xem Video</strong></p>

<p>&nbsp;<img alt="" height="337" src="http://bachnghegroup.com/images/allpic/quang-cao-facebook-5.jpg" width="600" /></p>

<p>Hiện nay, Quảng c&aacute;o Facebook rất dễ d&agrave;ng, nhưng để Quảng c&aacute;o Facebook hiệu quả th&igrave; rất &iacute;t người thực hiện được,nhiều doanh nghiệp, chủ cửa h&agrave;ng mất tiền tr&ecirc;n Facebook nhưng hiệu quả mang lại chưa được như mong đợi.</p>

<p><strong>Ch&uacute;ng t&ocirc;i sẽ hỗ trợ kh&aacute;ch h&agrave;ng thực hiện:</strong></p>

<p>1. Thiết kế v&agrave; chỉnh sửa Fanpage<br />
2. &Uacute;p b&agrave;i viết đ&uacute;ng chuẩn v&agrave; tối ưu tr&ecirc;n Fanpage.<br />
3. Hỗ trợ thiết kế banner.<br />
4. Nhắm đ&uacute;ng đối tượng mục ti&ecirc;u quảng c&aacute;o.Đ&acirc;y l&agrave; yếu tố quyết định sự th&agrave;nh c&ocirc;ng.<br />
5. B&aacute;o c&aacute;o trực tiếp từ t&agrave;i khoản Facebook.</p>

<p>B&aacute;ch Nghệ với kinh nghiệm thực tiễn khi thực hiện h&agrave;ng trăm chiến dịch tr&ecirc;n Facebook, với đủ mọi ng&agrave;nh nghề,Ch&uacute;ng t&ocirc;i sẽ tư vấn v&agrave; thiết lập chiến dịch QUẢNG C&Aacute;O FACEBOOK ph&ugrave; hợp với từng ng&agrave;nh nghề,đối tượng kh&aacute;ch h&agrave;ng để mang lại&nbsp;hiệu quả nhất cho kh&aacute;ch h&agrave;ng.</p>

<p><strong>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i quảng c&aacute;o Facebook theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.com</a>&nbsp;hoặc Hotline: 0938.8283846, đội ngũ chuy&ecirc;n gia sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</strong></p>
', NULL, N'quang-cao-facebook-facebook-ads', NULL, NULL, NULL, NULL, NULL, NULL, N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3286, 3144, 2, N'Facebook Ads', N'Advertising Facebook (Facebook Ads)', N'<p>With many years experience in providing communication and advertising, our experts are making a lot of advertising campaign Facebook for business success, we are confident will help you succeed in implementing ads Facebook.</p>

<p>Google ads next to the ads Facebook increasingly Vietnam enterprises attention and widely used. With more than 32 million users (monthly 3 / 2015, the statistics from Facebook) Facebook is showing himself as a marketing channel is not to be missed for all enterprises, in all both fields.</p>

<p><strong>Facebook advertising advantages:</strong></p>

<p>Audience targeting enterprise customers:</p>

<ul>
	<li>Gender, interests, age, behavior ..</li>
	<li>Advertising market (Hanoi, Ho Chi Minh or a particular landmark)</li>
	<li>On a mobile device or PC ...</li>
</ul>

<p>Advertising Facebook engagement with customers through highly Website, Fanpage ... easy feedback and better customer care.</p>

<p>Advertising campaign changed flexible, lively, friendly feeling customers.</p>

<p>Advertising budget flexibility, easy change.</p>

<p>Facebook advertising costs:</p>

<ul>
	<li>There is no minimum spending and maximum, depending on your budget that now limits the ability to reach customers more or less.</li>
	<li>Enterprises can choose the mode of charging by the CPC or CPM.</li>
</ul>

<p><strong>Other forms of advertising Facebook Bin done:</strong></p>

<p><strong>&nbsp;1. Advertising increased Like (Fanpage): increase system like Facebook, like truth 10 0%.</strong></p>

<p>&nbsp;</p>

<p><img alt="" height="337" src="http://en_57dfabf6e60c06495c676101_pipe.bablic.com/images/allpic/quang-cao-facebook-1.jpg" width="600" /></p>

<p><strong>2. Ads all know in Fanpage (including Like, comment, share ...)</strong></p>

<p><img alt="" height="337" src="http://en_57dfabf6e60c06495c676101_pipe.bablic.com/images/allpic/quang-cao-facebook-2.jpg" width="600" /></p>

<p>&nbsp;<strong>3. The app install ads.</strong></p>

<p><img alt="" height="337" src="http://en_57dfabf6e60c06495c676101_pipe.bablic.com/images/allpic/quang-cao-facebook-3.jpg" width="600" /></p>

<p><strong>&nbsp;4. Advertise Website.</strong></p>

<p>&nbsp;<img alt="" height="337" src="http://en_57dfabf6e60c06495c676101_pipe.bablic.com/images/allpic/quang-cao-facebook-4.jpg" width="600" /></p>

<p><strong>5. Ads Viewed Videos</strong></p>

<p>&nbsp;<img alt="" height="337" src="http://en_57dfabf6e60c06495c676101_pipe.bablic.com/images/allpic/quang-cao-facebook-5.jpg" width="600" /></p>

<p>Currently, Facebook ads is easy, but to effective Facebook ads are very few people do so, many businesses, shop owners lose money on Facebook but have not been effectively brought to expectations.</p>

<p><strong>We will assist customers to make:</strong></p>

<p>1. Design and edit Fanpage&nbsp;<br />
2. Face-standard article and optimized on Fanpage.&nbsp;<br />
3. Support banner design.&nbsp;<br />
4. Properly targeted advertising target audience is cao.Day determinant of success.&nbsp;<br />
5. Report directly from your Facebook account.</p>

<p bablic-captured="true">Botanical Art with practical experience performing hundreds of campaigns on Facebook, with all professions, we will advise and set up campaigns FACEBOOK ADS suit each industry, of customers to bring the most effective for customers.</p>
', NULL, N'facebook-ads', NULL, NULL, NULL, NULL, NULL, NULL, N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Quảng cáo Facebook (Facebook Ads)', N'Facebook Ads', N'Facebook Ads', N'Facebook Ads')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3287, 3145, 1, N'Quảng Cáo Google', N'Quảng Cáo Google', NULL, NULL, N'quang-cao-google', NULL, NULL, NULL, NULL, NULL, NULL, N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3288, 3145, 2, N'Google Adword', N'Quảng Cáo Google', NULL, NULL, N'google-adword', NULL, NULL, NULL, NULL, NULL, NULL, N'Google Adword', N'Google Adword', N'Google Adword', N'Google Adword', N'Google Adword', N'Google Adword')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3289, 3146, 1, N'Quảng Cáo Google', N'Quảng cáo Google AdWords', N'<p><img alt="" src="/Admin/Images/google-adword.png" style="width: 607px; height: 300px; float: right;" /></p>

<p><strong>AdWords</strong>, chương tr&igrave;nh quảng c&aacute;o trực tuyến của Google, cho ph&eacute;p bạn tiếp cận c&aacute;c kh&aacute;ch h&agrave;ng mới v&agrave; ph&aacute;t triển doanh nghiệp của m&igrave;nh.<br />
Chọn nơi quảng c&aacute;o của bạn xuất hiện, đặt ng&acirc;n s&aacute;ch m&agrave; bạn thấy h&agrave;i l&ograve;ng v&agrave; đo lường t&aacute;c động của quảng c&aacute;o.<br />
Kh&ocirc;ng c&oacute; cam kết chi ti&ecirc;u tối thiểu. Bạn c&oacute; thể tạm dừng hoặc dừng bất kỳ l&uacute;c n&agrave;o.</p>

<p>&nbsp;<strong>Lợi &iacute;ch của quảng c&aacute;o Google AdWords</strong><br />
<br />
Một v&agrave;i điều quan trọng khiến AdWords kh&aacute;c biệt so với c&aacute;c loại quảng c&aacute;o kh&aacute;c. Sử dụng AdWords, bạn c&oacute; thể:<br />
<br />
<strong><strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong></strong>Tiếp cận mọi người v&agrave;o đ&uacute;ng thời điểm họ đang t&igrave;m kiếm những g&igrave; bạn cung cấp</strong><br />
<br />
1. Quảng c&aacute;o của bạn được hiển thị cho những người đang t&igrave;m kiếm c&aacute;c loại sản phẩm v&agrave; dịch vụ m&agrave; bạn cung cấp. Bởi vậy những người đ&oacute; c&oacute; nhiều khả năng thực hiện h&agrave;nh<br />
2. Bạn c&oacute; thể chọn vị tr&iacute; quảng c&aacute;o của m&igrave;nh xuất hiện &mdash; tr&ecirc;n trang web cụ thể n&agrave;o v&agrave; trong khu vực địa l&yacute; n&agrave;o (tiểu bang, thị trấn hoặc thậm ch&iacute; v&ugrave;ng l&acirc;n cận).<br />
3. Chỉ t&iacute;nh ri&ecirc;ng Mạng hiển thị của Google (GDN) tiếp cận 80% người d&ugrave;ng Internet ở Hoa Kỳ.<br />
<br />
<strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong>Kiểm so&aacute;t ng&acirc;n s&aacute;ch của bạn</strong><br />
<br />
1. Với đặt gi&aacute; thầu gi&aacute; mỗi nhấp chuột (CPC), bạn chỉ bị t&iacute;nh ph&iacute; khi ai đ&oacute; nhấp v&agrave;o quảng c&aacute;o của bạn, chứ kh&ocirc;ng phải khi quảng c&aacute;o của bạn xuất hiện. C&oacute; nhiều t&ugrave;y chọn đặt gi&aacute; thầu kh&aacute;c nhau m&agrave; bạn c&oacute; thể chọn.<br />
2. Bạn quyết định số tiền nhiều hay &iacute;t m&agrave; m&igrave;nh muốn chi ti&ecirc;u h&agrave;ng th&aacute;ng v&agrave; bạn sẽ kh&ocirc;ng bao giờ bị t&iacute;nh ph&iacute; nhiều hơn số tiền đ&oacute;.<br />
3. Kh&ocirc;ng c&oacute; cam kết chi ti&ecirc;u tối thiểu.<br />
<br />
<strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong>Thấy ch&iacute;nh x&aacute;c phần n&agrave;o c&oacute; hiệu quả trong quảng c&aacute;o của bạn v&agrave; x&acirc;y dựng dựa tr&ecirc;n phần đ&oacute;</strong><br />
<br />
1. Xem b&aacute;o c&aacute;o về mức độ hiệu quả m&agrave; quảng c&aacute;o của bạn đang hoạt động &mdash; xem số lượng kh&aacute;ch h&agrave;ng mới kết nối với doanh nghiệp của bạn từ quảng c&aacute;o, họ đến từ đ&acirc;u, v.v&hellip;<br />
2. Sử dụng c&ocirc;ng cụ của AdWords để chỉnh sửa v&agrave; cải thiện quảng c&aacute;o của bạn v&agrave; tăng số lượng kh&aacute;ch h&agrave;ng tiềm năng li&ecirc;n hệ với doanh nghiệp của bạn.</p>

<p><strong>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i quảng c&aacute;o Google theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.</a>vn&nbsp;hoặc Hotline: 0938.8283846, đội ngũ chuy&ecirc;n gia sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</strong></p>
', NULL, N'quang-cao-google', NULL, NULL, NULL, NULL, NULL, NULL, N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google', N'Quảng Cáo Google')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3290, 3146, 2, N'Google Adwords Ads', N'Google Adwords Ads', N'<p><strong>AdWords&nbsp;</strong>, Online advertising program by Google, allows you to reach new customers and grow your business.&nbsp;<br />
Choose where your ads appear, set a budget that you&#39;re comfortable and measurement impact of advertising.&nbsp;<br />
there is no minimum spending commitment. You can pause or stop at any time.</p>

<p bablic-captured="true">&nbsp;<strong>&nbsp;Benefits of Google AdWords ads&nbsp;</strong><br />
<br />
A few important things AdWords apart compared to other types of ads. Using AdWords, you can:&nbsp;<br />
<br />
<strong><strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong></strong>Reach people at the right time they are looking for what you offer&nbsp;</strong><br />
<br />
1. Your ads are displayed to people who are looking for the types of products and services you offer. So those people are more likely to commit&nbsp;<br />
2. You can choose where your ads appear - on a particular site and geographic area (state, town or even neighborhood).&nbsp;<br />
3. Only Google Display Network (GDN) 80% reach of Internet users in the United States.&nbsp;<br />
<br />
<strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong>Control your budget&nbsp;</strong><br />
<br />
1. With cost-per-click (CPC), you are only charged when someone clicks on your ad, not when your ad appears. There are many options of different bidding which you can choose.&nbsp;<br />
2. You decide how much or little you want to spend each month and you will never be charged more than that amount.&nbsp;<br />
3. There is no minimum spending commitment.&nbsp;<br />
<br />
<strong><strong><strong><strong>&bull;&nbsp;</strong></strong></strong>See exactly what&#39;s working in your ad, and build on that section&nbsp;</strong><br />
<br />
1. See report on how effective your ads are performing - see how many new customers to connect to your business from advertising, where they come from, etc. ...&nbsp;<br />
2. Use AdWords tools to edit and improve your ads and increase the number of potential customers to contact your business.</p>
', NULL, N'google-adwords-ads', NULL, NULL, NULL, NULL, NULL, NULL, N'Google Adwords Ads', N'Google Adwords Ads', N'Google Adwords Ads', N'Google Adwords Ads', N'Google Adwords Ads', N'Google Adwords Ads')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3291, 3147, 1, N'Ấn phẩm văn phòng', N'Thiết kế in ấn phẩm văn phòng', N'<p><img alt="" src="/Admin/Images/an-pham-van-hong.png" style="float: right; width: 607px; height: 300px;" /></p>

<p>In ấn phẩm văn ph&ograve;ng l&agrave; dịch vụ được EPM cung cấp phục vụ cho nhu cầu in ấn của c&aacute;c doanh nghiệp như:&nbsp;<strong>in name card (in danh thiếp), in folder, in poster, in tờ rơi, in phong b&igrave; thư, in b&igrave;a file, in t&uacute;i,</strong>&hellip; Dịch vụ ch&uacute;ng t&ocirc;i bao gồm từ kh&acirc;u thiết kế, chế bản, in ấn phẩm văn ph&ograve;ng đến th&agrave;nh phẩm&hellip;</p>

<p>Đến với EPM qu&yacute; kh&aacute;ch sẽ c&oacute; một bộ ấn phẩm văn ph&ograve;ng ấn tượng, chuy&ecirc;n nghiệp v&agrave; g&oacute;p phần gi&uacute;p qu&yacute; kh&aacute;ch gi&agrave;nh chiến thắng khi giao tiếp v&agrave; c&oacute; th&ecirc;m tự tin khi đứng trước đối t&aacute;c.</p>

<p>Với đội ngũ thiết kế in ấn chuy&ecirc;n nghiệp c&oacute; nhiều kinh nghiệm trong lĩnh vực in ấn phẩm văn ph&ograve;ng, ch&uacute;ng t&ocirc;i kh&ocirc;ng ngừng n&acirc;ng cao chất lượng dịch vụ để gi&uacute;p kh&aacute;ch h&agrave;ng c&oacute; được những sản phẩm tốt nhất.</p>

<p>Bằng kinh nghiệm thực tế v&agrave; năng lực chuy&ecirc;n m&ocirc;n trong lĩnh vực thiết kế in ấn ch&uacute;ng t&ocirc;i lu&ocirc;n kết hợp t&iacute;nh độc đ&aacute;o, sự s&aacute;ng tạo, lu&ocirc;n &aacute;p dụng c&ocirc;ng nghệ v&agrave; sự tận t&acirc;m trong c&ocirc;ng việc nhằm đảm bảo tạo ra sản phẩm chất lượng ho&agrave;n hảo nhất, đ&aacute;p ứng mọi nhu cầu của kh&aacute;ch h&agrave;ng với chế độ hậu m&atilde;i tốt nhất. Với phong c&aacute;ch l&agrave;m việc chuy&ecirc;n nghiệp v&agrave; đội ngũ chuy&ecirc;n m&ocirc;n cao, n&ecirc;n ch&uacute;ng t&ocirc;i đ&atilde; thiết lập được mối quan hệ l&acirc;u năm với c&aacute;c kh&aacute;ch h&agrave;ng.</p>
', NULL, N'an-pham-van-phong', NULL, NULL, NULL, NULL, NULL, NULL, N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng', N'Ấn phẩm văn phòng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3292, 3147, 2, N'Publications Office', N'Print design office products', N'<h2 itemprop="name">Print design office products</h2>

<p>Printing office products is services provided EPM serving the printing needs of businesses such as&nbsp;<strong>in name card (cards printed), folder printing, poster printing, printing flyers, print style envelopes, file cover printing, print bag,&nbsp;</strong>... Our services range from design, prepress, printing office products to finished products ...</p>

<p>EPM Coming to you will have an impressive publications office, professional and helped you win when communicating and have more confidence in front of a partner.</p>

<p>With a team of professional print design has extensive experience in the field of office printing products, we constantly improve the quality of services to help customers get the best product.</p>

<p bablic-captured="true">By practical experience and professional competence in the field of print design, we always incorporate originality, creativity, always apply the technology and the dedication of the work to ensure quality product creation perfect quality, to meet the needs of customers with the best after sales service. With professional working style and professional team, we have established a long-time relationship with the customer.</p>
', NULL, N'publications-office', NULL, NULL, NULL, NULL, NULL, NULL, N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office', N'Publications Office')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3293, 3148, 1, N'Nhận diện thương hiệu', N'Bộ nhận diện thương hiệu', N'<p><strong>Nhận diện thương hiệu l&agrave; g&igrave; ?</strong></p>

<p>Việc quan trọng để c&oacute; một bộ nhận diện thương hiệu tốt kh&ocirc;ng chỉ l&agrave; đẹp kh&ocirc;ng, m&agrave; c&ograve;n yếu tố thương hiệu ẩn chứa trong mỗi mẫu thiết kế. Cần c&oacute; am hiểu s&acirc;u, rộng trong từng lĩnh vực cụ thể mới c&oacute; thể c&oacute; được một bộ nhận diện thương hiệu như &yacute; muốn.</p>

<p><strong>Thiết kế bộ nhận diện thương hiệu, c&oacute; n&ecirc;n l&agrave;m ?</strong></p>

<p>Đa phần c&aacute;c doanh nghiệp vừa v&agrave; nhỏ tại Việt Nam đều tự thiết kế logo, tự in v&agrave; điều chỉnh c&aacute;c thiết kế của m&igrave;nh theo &yacute; đồ của ri&ecirc;ng m&igrave;nh. Việc l&agrave;m n&agrave;y về l&acirc;u d&agrave;i sẽ l&agrave;m ảnh hưởng rất lớn tới việc ph&aacute;t triển sản phẩm, uy t&iacute;n thương hiệu.</p>

<p>+ X&acirc;y dựng niềm tin doanh nghiệp trong t&acirc;m tr&iacute; v&agrave; tr&aacute;i tim kh&aacute;ch h&agrave;ng<br />
+ Truyền tải th&ocirc;ng điệp doanh nghiệp đ&atilde; thiết lập.<br />
+ Để thu h&uacute;t nhiều kh&aacute;ch h&agrave;ng hơn.<br />
+ Để tạo dựng sự chuy&ecirc;n nghiệp.<br />
+ Để tăng độ tin cậy.<br />
+ Để nổi bật trong lĩnh vực của bạn.</p>

<p><strong>Bộ nhận diện thương hiệu bao gồm những g&igrave;?</strong></p>

<p>Hệ thống nhận diện thương hiệu l&agrave; hệ thống chuẩn mực bằng h&igrave;nh ảnh, k&iacute;ch thước, nguy&ecirc;n tắc sử dụng Logo, Slogan, c&aacute;c hạng mục văn ph&ograve;ng, quan hệ c&ocirc;ng ch&uacute;ng, thương mại điện tử, đồ họa ngo&agrave;i trời, &hellip; tr&ecirc;n tất cả c&aacute;c c&ocirc;ng cụ li&ecirc;n quan b&ecirc;n trong v&agrave; ngo&agrave;i doanh nghiệp. Hệ thống nhận diện thương hiệu phải đảm bảo t&iacute;nh thống nhất dựa tr&ecirc;n &yacute; tưởng được sử dụng xuy&ecirc;n suốt to&agrave;n bộ hệ thống.</p>

<p>+ Hệ thống t&agrave;i liệu văn ph&ograve;ng<br />
+ Hệ thống bảng hiệu<br />
+ Hệ thống x&uacute;c tiến thương mại<br />
+ Hệ thống đối ngoại<br />
+ Hệ thống sản phẩm dịch vụ.</p>

<p><strong>Quy tr&igrave;nh x&acirc;y dựng bộ nhận diện thương hiệu</strong></p>

<p>Tại EPM, ch&uacute;ng t&ocirc;i cung cấp một quy tr&igrave;nh x&acirc;y dựng bộ nhận diện thương hiệu chuẩn mực với quy tr&igrave;nh quản l&yacute; thiết kế chặt chẽ kết hợp với kh&aacute;ch h&agrave;ng để cho ra một bộ nhận diện thương hiệu ưng &yacute; nhất, để thực hiện một bộ nhận diện thương hiệu ch&uacute;ng t&ocirc;i th&ocirc;ng qua quy tr&igrave;nh thực hiện như b&ecirc;n dưới v&agrave; thực hiện quản l&yacute; dự &aacute;n theo phần mềm quản l&yacute; chuy&ecirc;n nghiệp gi&uacute;p đạt hiệu quả cao nhất trong c&ocirc;ng việc:</p>

<p>+ Tư vấn chọn g&oacute;i sản phẩm<br />
+ K&yacute; kết hợp đồng<br />
+ Ph&aacute;t triển &yacute; tưởng<br />
+ Chỉnh sửa thiết kế<br />
+ B&agrave;n giao thiết kế.</p>

<p><strong>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i thiết kế bộ nhận diện thương hiệu theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.</a>vn&nbsp;hoặc Hotline: 0938283846, đội ngũ chuy&ecirc;n vi&ecirc;n sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</strong></p>

<p><img alt="" src="/Admin/Images/giai-phap-tron-goi.jpg" style="width: 1171px; height: 301px;" /></p>
', NULL, N'nhan-dien-thuong-hieu', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhận diện thương hiệu', N'Nhận diện thương hiệu', N'Nhận diện thương hiệu', N'Nhận diện thương hiệu', N'Nhận diện thương hiệu', N'Nhận diện thương hiệu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3294, 3148, 2, N'Design of brand identity', N'Design of brand identity', N'<p><strong>What is the brand identity ?</strong></p>

<p>It is important to have a good brand identity not only is beautiful, but also brand elements hidden in each design. There should be knowledgeable, broad in each specific field can get a brand identity system as desired.</p>

<p><strong>Design of brand identity, which should do?</strong></p>

<p>A majority of small and medium enterprises in Vietnam are designed logo, and adjust themselves in their designs under his own intentions. Doing this in the long term will make a huge impact to the development of the product, brand reputation.</p>

<p>+ Develop business confidence in the minds and hearts clients&nbsp;<br />
+ Transmit messages have established businesses.&nbsp;<br />
+ To attract more customers.&nbsp;<br />
+ To build expertise now.&nbsp;<br />
+ To increase reliability.&nbsp;<br />
+ To stand out in your field.</p>

<p><strong>Brand identity system includes what?</strong></p>

<p>Brand identity system is the standard system image, the size, the principle of using Logo, Slogan, stationery items, public relations, e-commerce, outdoor graphics, ... on every all relevant tools inside and outside the enterprise. Brand identity system to ensure uniformity based on ideas used throughout the entire system.</p>

<p>+ System Office documents&nbsp;<br />
+ Systems signs&nbsp;<br />
+ trade promotion system&nbsp;<br />
+ external system&nbsp;<br />
+ Systems products and services.</p>

<p><strong>Process of building the brand identity</strong></p>

<p>At BACH Technology, we provide a process to develop the brand identity standards with design management processes closely associated with the customer to produce a brand identity like the best, to perform one of our brand identity through the implementation process as shown below and execute project management under a professional management software helps achieve maximum efficiency in their work:</p>

<p>+ Consulting select packages&nbsp;<br />
+ Sign contracts&nbsp;<br />
+ Develop ideas&nbsp;<br />
+ Edit design&nbsp;<br />
+ Handing design.</p>

<p><strong>Để biết th&ecirc;m th&ocirc;ng tin chi tiết về g&oacute;i thiết kế bộ nhận diện thương hiệu theo y&ecirc;u cầu Qu&yacute; kh&aacute;ch h&agrave;ng c&oacute; thể li&ecirc;n hệ với ch&uacute;ng t&ocirc;i theo địa chỉ email:&nbsp;<a href="mailto:info@bacnghegroup.com">info@epm.</a>vn&nbsp;hoặc Hotline: 0938.283846, đội ngũ chuy&ecirc;n vi&ecirc;n sẽ tư vấn miễn ph&iacute; cho qu&yacute; kh&aacute;ch h&agrave;ng.</strong></p>
', NULL, N'design-of-brand-identity', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhận diện thương hiệu', N'Nhận diện thương hiệu', N'Design of brand identity', N'Design of brand identity', N'Design of brand identity', N'Design of brand identity')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3295, 3149, 1, N'Shop thời trang', N'Shop thời trang', NULL, NULL, N'shop-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3296, 3149, 2, N'Shop thời trang', N'Shop thời trang', NULL, NULL, N'shop-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3297, 3150, 1, N'Shop thời trang', N'Shop thời trang', NULL, NULL, N'shop-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3298, 3150, 2, N'Shop thời trang', N'Shop thời trang', NULL, NULL, N'shop-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang', N'Shop thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3299, 3151, 1, N'Khác sạn Gateway', N'Khác sạn Gateway', NULL, NULL, N'khac-san-gateway', NULL, NULL, NULL, NULL, NULL, NULL, N'Khác sạn Gateway', N'Khác sạn Gateway', N'Khác sạn Gateway', N'Khác sạn Gateway', N'Khác sạn Gateway', N'Khác sạn Gateway')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3300, 3151, 2, N'Khá', N'Khách sạn', NULL, NULL, N'kha', NULL, NULL, NULL, NULL, NULL, NULL, N'Khác sạn Gateway', N'Khác sạn Gateway', N'Khá', N'Khá', N'Khá', N'Khá')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3301, 3152, 1, N'Shop thời trang quần áo', N'Shop thời trang quần áo', NULL, NULL, N'shop-thoi-trang-quan-ao', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3302, 3152, 2, N'Shop thời trang quần áo', N'Shop thời trang quần áo', NULL, NULL, N'shop-thoi-trang-quan-ao', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo', N'Shop thời trang quần áo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3303, 3153, 1, N'shop quần áo', N'shop quần áo', NULL, NULL, N'shop-quan-ao', NULL, NULL, NULL, NULL, NULL, NULL, N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3304, 3153, 2, N'shop quần áo', N'shop quần áo', NULL, NULL, N'shop-quan-ao', NULL, NULL, NULL, NULL, NULL, NULL, N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo', N'shop quần áo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3305, 3154, 1, N'Nông sản cafe', N'Nông sản cafe', NULL, NULL, N'nong-san-cafe', NULL, NULL, NULL, NULL, NULL, NULL, N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3306, 3154, 2, N'Nông sản cafe', N'Nông sản cafe', NULL, NULL, N'nong-san-cafe', NULL, NULL, NULL, NULL, NULL, NULL, N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3307, 3155, 1, N'Thực phẩm sạch', N'Thực phẩm sạch', NULL, NULL, N'thuc-pham-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3308, 3155, 2, N'Thực phẩm sạch', N'Thực phẩm sạch', NULL, NULL, N'thuc-pham-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch', N'Thực phẩm sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3309, 3156, 1, N'Nông sản cafe', N'Nông sản cafe', NULL, NULL, N'nong-san-cafe', NULL, NULL, NULL, NULL, NULL, NULL, N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3310, 3156, 2, N'Nông sản cafe', N'Nông sản cafe', NULL, NULL, N'nong-san-cafe', NULL, NULL, NULL, NULL, NULL, NULL, N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe', N'Nông sản cafe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3311, 3157, 1, N'Nhà hàng Milasia', N'Nhà hàng Milasia', NULL, NULL, N'nha-hang-milasia', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3312, 3157, 2, N'Nhà hàng Milasia', N'Nhà hàng Milasia', NULL, NULL, N'nha-hang-milasia', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia', N'Nhà hàng Milasia')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3313, 3158, 1, N'Cửa hàng nội thất', N'Cửa hàng nội thất', NULL, NULL, N'cua-hang-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3314, 3158, 2, N'Cửa hàng nội thất', N'Cửa hàng nội thất', NULL, NULL, N'cua-hang-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất', N'Cửa hàng nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3315, 3159, 1, N'Nhà hàng Food', N'Nhà hàng Food', NULL, NULL, N'nha-hang-food', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3316, 3159, 2, N'Nhà hàng Food', N'Nhà hàng Food', NULL, NULL, N'nha-hang-food', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food', N'Nhà hàng Food')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3317, 3160, 1, N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', NULL, NULL, N'thiet-ke-canh-quan', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3318, 3160, 2, N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', NULL, NULL, N'thiet-ke-canh-quan', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan', N'Thiết kế cảnh quan')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3319, 3161, 1, N'Shop nội thất', N'Shop nội thất', NULL, NULL, N'shop-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất')
GO
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3320, 3161, 2, N'Shop nội thất', N'Shop nội thất', NULL, NULL, N'shop-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất', N'Shop nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3321, 3162, 1, N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', NULL, NULL, N'shop-noi-that-ban-ghe', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3322, 3162, 2, N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', NULL, NULL, N'shop-noi-that-ban-ghe', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế', N'Shop nội thất bàn ghế')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3323, 3163, 1, N'siêu thị nội thất', N'siêu thị nội thất', NULL, NULL, N'sieu-thi-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3324, 3163, 2, N'siêu thị nội thất', N'siêu thị nội thất', NULL, NULL, N'sieu-thi-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất', N'siêu thị nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3325, 3164, 1, N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', NULL, NULL, N'thiet-ke-kien-truc', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3326, 3164, 2, N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', NULL, NULL, N'thiet-ke-kien-truc', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc', N'Thiết kế kiến trúc')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3327, 3165, 1, N'Thiết kế nội thất', N'Thiết kế nội thất', NULL, NULL, N'thiet-ke-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3328, 3165, 2, N'Thiết kế nội thất', N'Thiết kế nội thất', NULL, NULL, N'thiet-ke-noi-that', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất', N'Thiết kế nội thất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3329, 3166, 1, N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan', NULL, NULL, N'thiet-ke-canh-quan-vuon', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3330, 3166, 2, N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan', NULL, NULL, N'thiet-ke-canh-quan-vuon', NULL, NULL, NULL, NULL, NULL, NULL, N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn', N'Thiết kế cảnh quan vườn')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3331, 3167, 1, N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', NULL, NULL, N'tra-xanh-huu-co', NULL, NULL, NULL, NULL, NULL, NULL, N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3332, 3167, 2, N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', NULL, NULL, N'tra-xanh-huu-co', NULL, NULL, NULL, NULL, NULL, NULL, N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ', N'Trà xanh hữu cơ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3333, 3168, 1, N'Rau củ quả sạch', N'Rau củ quả sạch', NULL, NULL, N'rau-cu-qua-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3334, 3168, 2, N'Rau củ quả sạch', N'Rau củ quả sạch', NULL, NULL, N'rau-cu-qua-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch', N'Rau củ quả sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3335, 3169, 1, N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', NULL, NULL, N'chuoi-rau-qua-thuc-pham-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3336, 3169, 2, N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', NULL, NULL, N'chuoi-rau-qua-thuc-pham-sach', NULL, NULL, NULL, NULL, NULL, NULL, N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch', N'Chuỗi rau quả thực phẩm sạch')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3337, 3170, 1, N'Web môi giới nhà đất', N'Web môi giới nhà đất', NULL, NULL, N'web-moi-gioi-nha-dat', NULL, NULL, NULL, NULL, NULL, NULL, N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3338, 3170, 2, N'Web môi giới nhà đất', N'Web môi giới nhà đất', NULL, NULL, N'web-moi-gioi-nha-dat', NULL, NULL, NULL, NULL, NULL, NULL, N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3339, 3171, 1, N'Dự án Bất động sản', N'Dự án Bất động sản', NULL, NULL, N'du-an-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3340, 3171, 2, N'Dự án Bất động sản', N'Dự án Bất động sản', NULL, NULL, N'du-an-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3341, 3172, 1, N'Web môi giới nhà đất', N'Web môi giới nhà đất', NULL, NULL, N'web-moi-gioi-nha-dat', NULL, NULL, NULL, NULL, NULL, NULL, N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3342, 3172, 2, N'Web môi giới nhà đất', N'Web môi giới nhà đất', NULL, NULL, N'web-moi-gioi-nha-dat', NULL, NULL, NULL, NULL, NULL, NULL, N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất', N'Web môi giới nhà đất')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3343, 3173, 1, N'Dự án Bất động sản', N'Dự án Bất động sản', NULL, NULL, N'du-an-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3344, 3173, 2, N'Dự án Bất động sản', N'Dự án Bất động sản', NULL, NULL, N'du-an-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản', N'Dự án Bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3345, 3174, 1, N'Căn hộ cao cấp', N'Căn hộ cao cấp', NULL, NULL, N'can-ho-cao-cap', NULL, NULL, NULL, NULL, NULL, NULL, N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3346, 3174, 2, N'Căn hộ cao cấp', N'Căn hộ cao cấp', NULL, NULL, N'can-ho-cao-cap', NULL, NULL, NULL, NULL, NULL, NULL, N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp', N'Căn hộ cao cấp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3347, 3175, 1, N'Hotel EGA', N'Hotel EGA', NULL, NULL, N'hotel-ega', NULL, NULL, NULL, NULL, NULL, NULL, N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3348, 3175, 2, N'Hotel EGA', N'Hotel EGA', NULL, NULL, N'hotel-ega', NULL, NULL, NULL, NULL, NULL, NULL, N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA', N'Hotel EGA')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3349, 3176, 1, N'Nhà hàng', N'Nhà hàng', NULL, NULL, N'nha-hang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3350, 3176, 2, N'Nhà hàng', N'Nhà hàng', NULL, NULL, N'nha-hang', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng', N'Nhà hàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3351, 3177, 1, N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', NULL, NULL, N'sieu-thi-dien-may-dien-tu', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3352, 3177, 2, N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', NULL, NULL, N'sieu-thi-dien-may-dien-tu', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử', N'Siêu thị điện máy điện tử')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3353, 3178, 1, N'Siêu thị thời trang', N'Siêu thị thời trang', NULL, NULL, N'sieu-thi-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3354, 3178, 2, N'Siêu thị thời trang', N'Siêu thị thời trang', NULL, NULL, N'sieu-thi-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang', N'Siêu thị thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3355, 3179, 1, N'Siêu thị giày dép', N'Siêu thị giày dép', NULL, NULL, N'sieu-thi-giay-dep', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3356, 3179, 2, N'Siêu thị giày dép', N'Siêu thị giày dép', NULL, NULL, N'sieu-thi-giay-dep', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép', N'Siêu thị giày dép')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3357, 3180, 1, N'Shop mẹ và bé', N'Shop mẹ và bé', NULL, NULL, N'shop-me-va-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3358, 3180, 2, N'Shop mẹ và bé', N'Shop mẹ và bé', NULL, NULL, N'shop-me-va-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé', N'Shop mẹ và bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3359, 3181, 1, N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', NULL, NULL, N'sieu-thi-me-va-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3360, 3181, 2, N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', NULL, NULL, N'sieu-thi-me-va-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé', N'Siêu thị mẹ và bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3361, 3182, 1, N'Chụp hình cưới studio', N'Chụp hình cưới studio', NULL, NULL, N'chup-hinh-cuoi-studio', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3362, 3182, 2, N'Chụp hình cưới studio', N'Chụp hình cưới studio', NULL, NULL, N'chup-hinh-cuoi-studio', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio', N'Chụp hình cưới studio')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3363, 3183, 1, N'Shop hoa tươi 365', N'Shop hoa tươi 365', NULL, NULL, N'shop-hoa-tuoi-365', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3364, 3183, 2, N'Shop hoa tươi 365', N'Shop hoa tươi 365', NULL, NULL, N'shop-hoa-tuoi-365', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365', N'Shop hoa tươi 365')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3365, 3184, 1, N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', NULL, NULL, N'hoa-tuoi-su-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3366, 3184, 2, N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', NULL, NULL, N'hoa-tuoi-su-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện', N'Hoa tươi sự kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3367, 3185, 1, N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', NULL, NULL, N'chup-hinh-cuoi-studio1', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3368, 3185, 2, N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', NULL, NULL, N'chup-hinh-cuoi-studio1', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1', N'Chụp hình cưới studio1')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3369, 3186, 1, N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', NULL, NULL, N'chup-hinh-cuoi-studio2', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3370, 3186, 2, N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', NULL, NULL, N'chup-hinh-cuoi-studio2', NULL, NULL, NULL, NULL, NULL, NULL, N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2', N'Chụp hình cưới studio2')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3371, 3187, 1, N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', NULL, NULL, N'nha-hang-tiec-cuoi', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3372, 3187, 2, N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', NULL, NULL, N'nha-hang-tiec-cuoi', NULL, NULL, NULL, NULL, NULL, NULL, N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới', N'Nhà hàng tiệc cưới')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3373, 3188, 1, N'Trường mầm non', N'Trường mầm non', NULL, NULL, N'truong-mam-non', NULL, NULL, NULL, NULL, NULL, NULL, N'Trường mầm non', N'Trường mầm non', N'Trường mầm non', N'Trường mầm non', N'Trường mầm non', N'Trường mầm non')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3374, 3188, 2, N'Trườn mầm non', N'Trườn mầm non', NULL, NULL, N'truon-mam-non', NULL, NULL, NULL, NULL, NULL, NULL, N'Trường mầm non', N'Trường mầm non', N'Trườn mầm non', N'Trườn mầm non', N'Trườn mầm non', N'Trườn mầm non')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3375, 3189, 1, N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', NULL, NULL, N'trung-tam-tu-van-du-hoc', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3376, 3189, 2, N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', NULL, NULL, N'trung-tam-tu-van-du-hoc', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học', N'Trung tâm tư vấn du học')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3377, 3190, 1, N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', NULL, NULL, N'cham-soc-suc-khoe', NULL, NULL, NULL, NULL, NULL, NULL, N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3378, 3190, 2, N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', NULL, NULL, N'cham-soc-suc-khoe', NULL, NULL, NULL, NULL, NULL, NULL, N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe', N'Chăm sóc sức khỏe')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3379, 3191, 1, N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', NULL, NULL, N'cua-hang-do-choi', NULL, NULL, NULL, NULL, NULL, NULL, N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3380, 3191, 2, N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', NULL, NULL, N'cua-hang-do-choi', NULL, NULL, NULL, NULL, NULL, NULL, N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi', N'Cửa hàng đồ chơi')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3381, 3192, 1, N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', NULL, NULL, N'truong-mam-non-quoc-te', NULL, NULL, NULL, NULL, NULL, NULL, N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3382, 3192, 2, N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', NULL, NULL, N'truong-mam-non-quoc-te', NULL, NULL, NULL, NULL, NULL, NULL, N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế', N'Trường mầm non quốc tế')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3383, 3193, 1, N'Trung tâm đào tạo', N'Trung tâm đào tạo', NULL, NULL, N'trung-tam-dao-tao', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3384, 3193, 2, N'Trung tâm đào tạo', N'Trung tâm đào tạo', NULL, NULL, N'trung-tam-dao-tao', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo', N'Trung tâm đào tạo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3385, 3194, 1, N'Quà tặng cho bé', N'Quà tặng cho bé', NULL, NULL, N'qua-tang-cho-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3386, 3194, 2, N'Quà tặng cho bé', N'Quà tặng cho bé', NULL, NULL, N'qua-tang-cho-be', NULL, NULL, NULL, NULL, NULL, NULL, N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé', N'Quà tặng cho bé')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3387, 3195, 1, N'DESERT', N'DESERT', NULL, NULL, N'desert', NULL, NULL, NULL, NULL, NULL, NULL, N'DESERT', N'DESERT', N'DESERT', N'DESERT', N'DESERT', N'DESERT')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3388, 3195, 2, N'Sách quà tặng', N'Sách quà tặng', NULL, NULL, N'sach-qua-tang', NULL, NULL, NULL, NULL, NULL, NULL, N'DESERT', N'DESERT', N'Sách quà tặng', N'Sách quà tặng', N'Sách quà tặng', N'Sách quà tặng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3389, 3196, 1, N'LUNCH', N'LUNCH', NULL, NULL, N'lunch', NULL, NULL, NULL, NULL, NULL, NULL, N'LUNCH', N'LUNCH', N'LUNCH', N'LUNCH', N'LUNCH', N'LUNCH')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3390, 3196, 2, N'đồ chơi công nghệ', N'đồ chơi công nghệ', NULL, NULL, N'do-choi-cong-nghe', NULL, NULL, NULL, NULL, NULL, NULL, N'LUNCH', N'LUNCH', N'đồ chơi công nghệ', N'đồ chơi công nghệ', N'đồ chơi công nghệ', N'đồ chơi công nghệ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3391, 3197, 1, N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'Làm giàu chưa bao giờ là một chặng đường bằng phẳng trải đầy hoa hồng, làm giàu nhờ kinh doanh Online thì lại càng khó khăn hơn gấp nhiều lần. Việc bùng nổ của các trang mạng xã hội, kéo theo sự quản lý có phần '''' lỏng lẽo '''' và chính sách không tính phí ( trừ trường hợp chạy quảng cáo ) đã khiến cho số lượng các shop Online đang tăng lên theo từng ngày với một tốc độ chóng mặt. ', N'<p>T&iacute;nh cạnh tranh trong kinh doanh trực tuyến chưa hề c&oacute; dấu hiệu sụt giảm, vậy th&igrave; &#39;&#39; l&iacute;nh mới &#39;&#39; cần l&agrave;m g&igrave; để c&oacute; được một nền tảng vững v&agrave;ng trước khi bước v&agrave;o cuộc chiến khốc liệt n&agrave;y.</p>

<p><strong>1/ Ch&uacute; Trọng Tiếp Thị Bằng H&igrave;nh Ảnh Tr&ecirc;n Instagram</strong>: Instagram l&agrave; một trang mạng x&atilde; hội được ưa chuộng bởi những người y&ecirc;u th&iacute;ch nghệ thuật v&agrave; &#39;&#39; nghiện &#39;&#39; share h&igrave;nh. Nếu bạn c&oacute; một kho h&igrave;nh ảnh sản phẩm th&igrave;<a data-mce-href="https://www.instagram.com/diemvietonline/" href="https://www.instagram.com/diemvietonline/" target="_blank">&nbsp;Instagram</a>&nbsp;l&agrave; nơi l&yacute; tưởng để bạn c&oacute; thể quảng c&aacute;o về sản phẩm cũng như tăng sức thuyết phục khiến kh&aacute;ch h&agrave;ng phải chi tiền ng&agrave;y một nhiều hơn.</p>

<p>&nbsp;</p>

<p><img data-mce-src="//sw001.hstatic.net/6/04879b5f971fbc/14215532_1772536912958033_1706073956_o.png_grande.jpg" data-mce-style="display: block; margin-left: auto; margin-right: auto;" height="395" src="https://sw001.hstatic.net/6/04879b5f971fbc/14215532_1772536912958033_1706073956_o.png_grande.jpg" width="584" /></p>

<p>&nbsp;</p>

<p><strong>2/ Đầu Tư Mạnh Tay Để Thực Hiện Video Clip Quảng C&aacute;o</strong>: Youtube lu&ocirc;n l&agrave; k&ecirc;nh kết nối với kh&aacute;ch h&agrave;ng một c&aacute;ch th&acirc;n thiện v&agrave; hiệu quả nhất, đặc biệt l&agrave; những&nbsp;<a data-mce-href="http://www.diemvn.com/blogs/videos-clip/gioi-thieu-dich-vu-san-xuat-video-clip-diem-viet-online" href="http://www.diemvn.com/blogs/videos-clip/gioi-thieu-dich-vu-san-xuat-video-clip-diem-viet-online" target="_blank">Video Clip hướng dẫn sử dụng</a>. Giả sử bạn kinh doanh c&aacute;c thiết bị chăm s&oacute;c s&acirc;n vườn, kh&aacute;ch h&agrave;ng đa phần kh&ocirc;ng nắm r&otilde; c&aacute;ch sử dụng những sản phẩm như vậy, khi đ&oacute;, clip hướng dẫn sử dụng sản phẩm sẽ khiến kh&aacute;ch h&agrave;ng an t&acirc;m hơn khi bước v&agrave;o cửa h&agrave;ng của bạn, v&igrave; họ cảm thấy m&igrave;nh đ&atilde; đ&uacute;ng khi chọn mua h&agrave;ng ở đ&acirc;y.</p>

<p>&nbsp;</p>

<p><img data-mce-src="//sw001.hstatic.net/6/04872e0c8d1121/diem1_grande.jpg" data-mce-style="display: block; margin-left: auto; margin-right: auto;" height="307" src="http://sw001.hstatic.net/6/04872e0c8d1121/diem1_grande.jpg" width="590" /></p>

<p>&nbsp;</p>

<p><strong>3/ Chăm S&oacute;c Kh&aacute;ch H&agrave;ng</strong>: Đ&atilde; bao giờ bạn gửi Mail ch&uacute;c mừng kh&aacute;ch h&agrave;ng nh&acirc;n dịp sinh nhật hoặc một dịp kỷ niệm đặc biệt n&agrave;o đ&oacute; ? Bạn c&oacute; thường gửi Mail cảm ơn kh&aacute;ch h&agrave;ng v&igrave; họ đ&atilde; k&yacute; hợp đồng mua dịch vụ hoặc mua sản phẩm của bạn ? Nếu chưa, đừng l&atilde;ng ph&iacute; quỹ thời gian rảnh rỗi của m&igrave;nh nữa, h&atilde;y cho kh&aacute;ch h&agrave;ng một l&yacute; do khiến họ phải quay lại t&igrave;m bạn trong những lần sau.</p>

<p>&nbsp;</p>

<p><img data-mce-src="//sw001.hstatic.net/6/04873b220b1c88/diem5_grande.jpg" data-mce-style="display: block; margin-left: auto; margin-right: auto;" height="303" src="http://sw001.hstatic.net/6/04873b220b1c88/diem5_grande.jpg" width="583" /></p>

<p>&nbsp;</p>

<p><strong>4/ Tiếng N&oacute;i Của Người Chịu Tr&aacute;ch Nhiệm Phần Nội Dung</strong>: bộ mặt v&agrave; h&igrave;nh ảnh của 1 doanh nghiệp l&agrave; rất quan trọng, tuy vậy, đa phần kh&aacute;ch h&agrave;ng lại muốn được lắng nghe v&agrave; tham khảo từ ch&iacute;nh những người hiểu r&otilde; về dịch vụ hoặc sản phẩm nhất. Tập hợp được một đội ngũ&nbsp;<a data-mce-href="http://www.diemvn.com/blogs/ho-tro-webstie/dich-vu-quan-ly-noi-dung-fanpage" href="http://www.diemvn.com/blogs/ho-tro-webstie/dich-vu-quan-ly-noi-dung-fanpage" target="_blank">quản l&yacute; nội dung ( Content )</a>&nbsp;- những người c&oacute; tiếng n&oacute;i một c&aacute;ch thống nhất l&agrave; điều n&ecirc;n l&agrave;m.</p>

<p>&nbsp;</p>

<p><img data-mce-src="//sw001.hstatic.net/6/0487321a7739f8/diem3_grande.jpg" data-mce-style="display: block; margin-left: auto; margin-right: auto;" height="331" src="http://sw001.hstatic.net/6/0487321a7739f8/diem3_grande.jpg" width="589" /></p>

<p>&nbsp;</p>

<p><strong>5/ Ch&uacute; Trọng Quảng C&aacute;o Tr&ecirc;n Điện Thoại</strong>: kh&aacute;ch h&agrave;ng của bạn kh&ocirc;ng phải l&uacute;c n&agrave;o cũng ngồi y&ecirc;n một chỗ, lướt Web hoặc lu&ocirc;n c&oacute; thời gian rảnh để đến cửa h&agrave;ng. C&oacute; thể s&aacute;ng nay họ c&ograve;n ngồi tr&ecirc;n t&agrave;u lửa, trưa nay đ&atilde; ngồi trong một tiệm ăn c&ograve;n chiều tối lại c&oacute; một cuộc hẹn với nha sĩ, h&atilde;y đẩy mạnh quảng c&aacute;o tr&ecirc;n điện thoại để bất cứ l&uacute;c n&agrave;o v&agrave; ở bất cứ đ&acirc;u, kh&aacute;ch h&agrave;ng cũng c&oacute; thể t&igrave;m hiểu th&ecirc;m về bạn.</p>
', NULL, N'5-bi-quyet-can-nho-truoc-khi-bat-dau-kinh-doanh-online', NULL, NULL, NULL, NULL, NULL, NULL, N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3392, 3197, 2, N'5 BÍ QUYẾT CẦN NHỚ TRƯỚC KHI BẮT ĐẦU KINH DOANH ONLINE', N'Làm giàu chưa bao giờ là một chặng đường bằng phẳng trải đầy hoa hồng, làm giàu nhờ kinh doanh Online thì lại càng khó khăn hơn gấp nhiều lần. Việc bùng nổ của các trang mạng xã hội, kéo theo sự quản lý có phần '''' lỏng lẽo '''' và chính sách không tính phí ( trừ trường hợp chạy quảng cáo ) đã khiến cho số lượng các shop Online đang tăng lên theo từng ngày với một tốc độ chóng mặt. Tính cạnh tranh trong kinh doanh trực tuyến chưa hề có dấu hiệu sụt giảm, vậy thì '''' lính mới '''' cần làm gì để có được một nền tảng vững vàng trước khi bước vào cuộc chiến khốc liệt này.', NULL, NULL, N'5-bi-quyet-can-nho-truoc-khi-bat-dau-kinh-doanh-online', NULL, NULL, NULL, NULL, NULL, NULL, N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 Bí quyết cần nhớ trước khi bắt đầu kinh doanh online', N'5 BÍ QUYẾT CẦN NHỚ TRƯỚC KHI BẮT ĐẦU KINH DOANH ONLINE', N'5 BÍ QUYẾT CẦN NHỚ TRƯỚC KHI BẮT ĐẦU KINH DOANH ONLINE', N'5 BÍ QUYẾT CẦN NHỚ TRƯỚC KHI BẮT ĐẦU KINH DOANH ONLINE')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3393, 3198, 1, N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'Với lượng người sử dụng khổng lồ và không ngừng gia tăng, Facebook là một kênh truyền thông xã hội đầy tiềm năng để bạn kinh doanh trực tuyến. Và để có thể thành công trên “mảnh đất” màu mỡ này, bạn cần bỏ túi các bí kíp sau đây.', N'<h2><strong>1. Lu&ocirc;n tập trung v&agrave;o chủ đề ch&iacute;nh</strong></h2>

<p>Mọi người &ldquo;like&rdquo; trang Facebook của bạn v&igrave; họ quan t&acirc;m đến sản phẩm, dịch vụ m&agrave; bạn cung cấp. Do đ&oacute;, mọi nội dung m&agrave; bạn đăng tải tốt nhất n&ecirc;n gắn liền với sản phẩm hoặc dịch vụ m&agrave; bạn đang kinh doanh n&agrave;y. C&oacute; thể bạn sẽ cho răng việc tập trung viết m&atilde;i một chủ đề sẽ kh&aacute; t&ugrave; t&uacute;ng. Tuy nhi&ecirc;n, đ&acirc;y lại ch&iacute;nh l&agrave; cơ hội để bạn ph&aacute;t huy sức s&aacute;ng tạo. Để khiến người truy cập th&iacute;ch th&uacute; trước những nội dung bạn đăng tr&ecirc;n facebook, bạn n&ecirc;n t&igrave;m hiểu một số c&aacute;ch khai th&aacute;c chủ đề như:</p>

<ul>
	<li>Th&ocirc;ng tin c&aacute;c sự kiện do c&ocirc;ng ty tổ chức, c&aacute;c sự kiện kh&aacute;c c&oacute; li&ecirc;n quan đến sản phẩm, dịch vụ của c&ocirc;ng ty.</li>
	<li>Chia sẻ c&aacute;c clip h&agrave;i hước từ Youtube c&oacute; li&ecirc;n quan đến sản phẩm, ng&agrave;nh nghề m&agrave; c&ocirc;ng ty bạn đang kinh doanh.</li>
	<li>Khuyến kh&iacute;ch mọi người đăng tải c&aacute;c c&acirc;u hỏi, h&igrave;nh ảnh v&agrave; c&aacute;c c&acirc;u chuyện c&oacute; li&ecirc;n quan đến sản phẩm dịch vụ của bạn l&ecirc;n &ldquo;tường&rdquo;.</li>
	<li>Chia sẻ th&ocirc;ng tin hữu &iacute;ch trong đời sống để người d&ugrave;ng tham khảo.</li>
	<li>Thỉnh thoảng đăng lại c&aacute;c nội dung từng thu h&uacute;t mọi người.</li>
</ul>

<h2><strong>2. Lu&ocirc;n cập nhật th&ocirc;ng tin đi k&egrave;m với h&igrave;nh ảnh</strong></h2>

<p>&ldquo;Nhất nội dung, nh&igrave; h&igrave;nh ảnh&rdquo;. Ng&agrave;y c&agrave;ng c&oacute; nhiều bạn đọc th&iacute;ch xem phần h&igrave;nh ảnh trước khi đọc nội dung b&agrave;i đăng tr&ecirc;n facebook. Nếu đ&oacute; l&agrave; một tấm h&igrave;nh hấp dẫn hoặc truyền tải đầy đủ những g&igrave; họ cần, họ sẽ xem tiếp nội dung đi k&egrave;m h&igrave;nh ảnh đ&oacute; l&agrave; g&igrave;. Do đ&oacute;, bạn cần phải trau chuốt những tấm h&igrave;nh m&agrave; m&igrave;nh muốn đăng l&ecirc;n facebook. Những h&igrave;nh ảnh thiếu chỉnh chu, nhếch nh&aacute;c sẽ dễ g&acirc;y ấn tượng phản cảm v&agrave; l&acirc;u d&agrave;i sẽ ảnh hưởng đến lượng người theo d&otilde;i cũng như lượng người tương t&aacute;c. Ngo&agrave;i ra, tag mọi người v&agrave;o ảnh cũng l&agrave; một c&aacute;ch phổ biến để mọi người v&agrave;o xem ảnh m&agrave; bạn post l&ecirc;n. Tuy nhi&ecirc;n, kh&ocirc;ng phải ai cũng thấy thoải m&aacute;i với việc n&agrave;y v&agrave; c&oacute; nhiều người sẽ cảm thấy bị l&agrave;m phiền. C&aacute;ch tốt nhất l&agrave; h&atilde;y tổ chức một minigame, treo thưởng để mọi người tự tag m&igrave;nh v&agrave; bạn b&egrave; v&agrave;o.</p>

<p><br />
<img alt="4 Chieu Thuc Marketing Hieu Qua Tren Facebook" src="https://camhungkinhdoanh.chili.vn/getattachment/49fb93e7-5f6f-4114-9726-2ef9df2dc685/ban-hang-hieu-qua-01-(1).jpg.aspx" title="4 Chiêu Thức Marketing Hiệu Quả Trên Facebook" /><br />
<em>Những h&igrave;nh ảnh bắt mắt như thế n&agrave;y sẽ thu h&uacute;t được nhiều người truy cập</em></p>

<h2><strong>3. Tổ chức c&aacute;c cuộc thi</strong></h2>

<p>Để l&agrave;m cho fanpage đỡ nh&agrave;m ch&aacute;n v&agrave; thu h&uacute;t th&ecirc;m fan mới cũng như tăng lượt tương t&aacute;c, đ&ocirc;i l&uacute;c bạn cũng n&ecirc;n tổ chức những cuộc thi nho nhỏ như thi ảnh đẹp, thi video hay đơn giản l&agrave; gửi email để tham gia r&uacute;t thăm may mắn. C&oacute; rất nhiều c&aacute;ch tổ chức thi thố nhưng bạn nhớ xem qua c&aacute;c hướng dẫn của Facebook để nắm r&otilde; c&aacute;c chức năng v&agrave; giới hạn của trang trong qu&aacute; tr&igrave;nh tổ chức cuộc thi. C&aacute;c c&ocirc;ng ty phần mềm cũng l&agrave; c&aacute;nh tay đắc lực gi&uacute;p bạn s&aacute;ng tạo c&aacute;c c&ocirc;ng cụ hỗ trợ cho cuộc thi. Nếu bạn kh&ocirc;ng r&agrave;nh về c&ocirc;ng nghệ, bạn c&oacute; thể tạo ra c&aacute;c minigame đơn giản như đo&aacute;n &ocirc; chữ nhận qu&agrave;, share b&agrave;i post ở chế độ c&ocirc;ng khai v&agrave; comment hai chữ số may mắn&hellip; để k&iacute;ch th&iacute;ch người tham gia. Bạn cũng n&ecirc;n c&ocirc;ng bố phần qu&agrave; gồm c&oacute; những g&igrave;, gi&aacute; trị l&agrave; bao nhi&ecirc;u v&agrave; ng&agrave;y giờ c&ocirc;ng bố kết quả thật minh bạch để tất cả người chơi đều nắm r&otilde;.</p>

<p><br />
<img alt="4 Chieu Thuc Marketing Hieu Qua Tren Facebook" src="https://camhungkinhdoanh.chili.vn/getattachment/70409489-1133-417e-b043-ac80728b00f2/ban-hang-hieu-qua-02.png.aspx" title="4 Chiêu Thức Marketing Hiệu Quả Trên Facebook" /><br />
<em>Minigame sẽ gi&uacute;p bạn tăng tương t&aacute;c cho fanpage</em></p>

<h2><strong>4. Đo lường hiệu quả của hoạt động marketing tr&ecirc;n Facebook</strong></h2>

<p>Cuối c&ugrave;ng, bạn n&ecirc;n kiểm tra tất cả nội dung m&agrave; m&igrave;nh đăng tr&ecirc;n facebook c&oacute; ph&ugrave; hợp với thị hiếu người d&ugrave;ng hay kh&ocirc;ng bằng c&aacute;ch sử dụng một c&ocirc;ng cụ đo lường th&iacute;ch hợp. Những số liệu m&agrave; bạn cần phải quan t&acirc;m khi đo lường ch&iacute;nh l&agrave; lượng fans, số liệu chuyển đổi, c&aacute;c hoạt động, sự trung th&agrave;nh&hellip;Thực hiện đều đặn việc đo lường gi&uacute;p bạn hiểu r&otilde; fans của m&igrave;nh hơn v&agrave; c&oacute; chiến lược tốt hơn cho những hoạt động tiếp theo.<br />
<br />
Kinh doanh trực tuyến l&agrave; một thị trường nhộn nhịp m&agrave; nếu kh&ocirc;ng c&oacute; sự s&aacute;ng tạo v&agrave; học hỏi kh&ocirc;ng ngừng, bạn sẽ bị đ&agrave;o thải kh&ocirc;ng thương tiếc. Facebook cũng vậy. N&oacute; c&oacute; thể l&agrave; một k&ecirc;nh b&aacute;n h&agrave;ng đầy hấp dẫn với chi ph&iacute; thấp nhưng n&oacute; cũng sẽ l&agrave; một vấn đề v&ocirc; c&ugrave;ng nan giải nếu bạn kh&ocirc;ng đầu tư t&igrave;m hiểu một c&aacute;ch nghi&ecirc;m t&uacute;c. H&atilde;y nhớ c&aacute;c b&iacute; k&iacute;p tr&ecirc;n đ&acirc;y v&agrave; vận dụng v&agrave;o ch&iacute;nh c&ocirc;ng việc bạn đang kinh doanh, bạn sẽ ngạc nhi&ecirc;n v&igrave; kết quả m&agrave; n&oacute; đem lại đấy!</p>
', NULL, N'4-chieu-thuc-marketing-hieu-qua-tren-facebook', NULL, NULL, NULL, NULL, NULL, NULL, N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3394, 3198, 2, N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'Với lượng người sử dụng khổng lồ và không ngừng gia tăng, Facebook là một kênh truyền thông xã hội đầy tiềm năng để bạn kinh doanh trực tuyến. Và để có thể thành công trên “mảnh đất” màu mỡ này, bạn cần bỏ túi các bí kíp sau đây.', NULL, NULL, N'4-chieu-thuc-marketing-hieu-qua-tren-facebook', NULL, NULL, NULL, NULL, NULL, NULL, N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook', N'4 Chiêu Thức Marketing Hiệu Quả Trên Facebook')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3395, 3199, 1, N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Khi bước vào Thế giới kinh doanh, bạn phải bắt đầu “tập làm quen” với vấn đề hàng tồn kho. Tuy nhiên, “tập làm quen” với hàng tồn kho không có nghĩa là bạn sẽ không quan tâm đến vấn đề thanh lý chúng để xoay vòng vốn. Vậy với mặt hàng của xu hướng như thời trang thì làm thế nào để “giải phóng” hàng tồn kho gia tăng hiệu quả sử dụng vốn nhanh chóng? 3 phương pháp sau đây sẽ phần nào gợi ý hướng đi cho những người kinh doanh thời trang mới chập chững vào nghề.', N'<p><br />
<em>Lối tho&aacute;t n&agrave;o cho h&agrave;ng thời trang tồn kho?</em></p>

<h2><strong>K&iacute; gửi</strong></h2>

<p>K&iacute; gửi l&agrave; một c&aacute;ch cực k&igrave; hiệu quả gi&uacute;p bạn &ldquo;giải ph&oacute;ng&rdquo; h&agrave;ng tồn kho của m&igrave;nh nhanh nhất. Bạn c&oacute; thể k&iacute; gửi c&aacute;c mặt h&agrave;ng thời trang tồn kho của m&igrave;nh với c&aacute;c đại l&yacute; b&aacute;n h&agrave;ng tại c&aacute;c chợ đầu mối hoặc trung t&acirc;m thương mại lớn để họ gi&uacute;p bạn đẩy h&agrave;ng đi. Tất nhi&ecirc;n, bạn đừng qu&ecirc;n cung cấp một lợi &iacute;ch thỏa đ&aacute;ng cho họ để tăng cường mối quan hệ hợp t&aacute;c giữa đ&ocirc;i b&ecirc;n.</p>

<h2><strong>Giảm gi&aacute;</strong></h2>

<p>Giảm gi&aacute; l&agrave; phương ph&aacute;p phổ biến nhất được những người kinh doanh &aacute;p dụng, kh&ocirc;ng ri&ecirc;ng g&igrave; thời trang. Nếu sản phẩm trong kho đ&atilde; kh&ocirc;ng c&ograve;n l&agrave; xu hướng thời thượng của giới mộ điệu thời trang, hay n&oacute;i kh&aacute;c hơn ch&uacute;ng đ&atilde; lỗi thời th&igrave; c&aacute;ch giải quyết n&agrave;y được xem l&agrave; hiệu quả. Bạn c&oacute; thể &aacute;p dụng giảm gi&aacute; bằng nhiều phương ph&aacute;p kh&aacute;c nhau như: giảm trực tiếp tr&ecirc;n gi&aacute; b&aacute;n, mua một tặng một hay h&agrave;ng đồng gi&aacute; để thu h&uacute;t những kh&aacute;ch h&agrave;ng b&igrave;nh d&acirc;n. Ngo&agrave;i ra, bạn c&ograve;n c&oacute; thể &aacute;p dụng khung giờ v&agrave;ng giảm gi&aacute; để tạo động lực mua h&agrave;ng với kh&aacute;ch h&agrave;ng.</p>

<h2><strong>Tặng phẩm</strong></h2>

<p>Nếu k&iacute; gửi hay giảm gi&aacute; mang lại lợi &iacute;ch tức thời về mặt t&agrave;i sản th&igrave; tặng phẩm lại mang đến lợi &iacute;ch l&acirc;u d&agrave;i hơn. Tuy nhi&ecirc;n, tặng phẩm phải đặt đ&uacute;ng đối tượng, đ&uacute;ng thời điểm th&igrave; hiệu quả mới ph&aacute;t huy hết mức, nhất l&agrave; về mặt h&igrave;nh ảnh thương hiệu. Nh&acirc;n vi&ecirc;n, đối t&aacute;c, kh&aacute;ch h&agrave;ng hay c&aacute;c tổ chức từ thiện sẽ l&agrave; đối tượng tặng phẩm của bạn? V&agrave;, sản phẩm bạn định sử dụng l&agrave;m tặng phẩm sẽ thuộc dạng n&agrave;o? Đ&oacute; l&agrave; cả vấn đề về mặt tư duy chiến lược của người kinh doanh. H&atilde;y cẩn thận khi &aacute;p dụng phương ph&aacute;p n&agrave;y v&igrave; n&oacute; l&agrave; con dao hai lưỡi với thương hiệu của bạn.<br />
&nbsp;</p>

<p><br />
Kinh doanh lu&ocirc;n tồn tại rủi ro nằm ngo&agrave;i dự đo&aacute;n của bạn. Bạn kh&ocirc;ng cần phải t&igrave;m mọi c&aacute;ch để lẩn tr&aacute;nh rủi ro v&igrave; d&ugrave; trốn tr&aacute;nh thế n&agrave;o th&igrave; rủi ro cũng sẽ xuất hiện chỉ l&agrave; vấn đề thời gian. Điều quan trọng l&agrave; bạn phải t&igrave;m c&aacute;ch đối ph&oacute; để giảm thiểu tối đa t&aacute;c động xấu đến doanh nghiệp của m&igrave;nh. H&agrave;ng tồn kho trong kinh doanh thời trang l&agrave; một rủi ro, nhưng tại sao c&oacute; người giải quyết tốt v&agrave; đi l&ecirc;n, c&ograve;n c&oacute; người lại kh&ocirc;ng thể giải quyết v&agrave; đi đến thua lỗ. Điểm kh&aacute;c biệt ch&iacute;nh l&agrave; c&aacute;ch đối mặt của họ với rủi ro. Hi vọng rằng với những phương ph&aacute;p tr&ecirc;n đ&acirc;y, bạn sẽ t&igrave;m ra được c&aacute;ch đối ph&oacute; hiệu quả với rủi ro h&agrave;ng tồn kho trong cửa h&agrave;ng thời trang của m&igrave;nh.&nbsp;</p>
', NULL, N'lam-sao-de-thanh-ly-hang-ton-kho-thoi-trang-hieu-qua', NULL, NULL, NULL, NULL, NULL, NULL, N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3396, 3199, 2, N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Khi bước vào Thế giới kinh doanh, bạn phải bắt đầu “tập làm quen” với vấn đề hàng tồn kho. Tuy nhiên, “tập làm quen” với hàng tồn kho không có nghĩa là bạn sẽ không quan tâm đến vấn đề thanh lý chúng để xoay vòng vốn. Vậy với mặt hàng của xu hướng như thời trang thì làm thế nào để “giải phóng” hàng tồn kho gia tăng hiệu quả sử dụng vốn nhanh chóng? 3 phương pháp sau đây sẽ phần nào gợi ý hướng đi cho những người kinh doanh thời trang mới chập chững vào nghề.', NULL, NULL, N'lam-sao-de-thanh-ly-hang-ton-kho-thoi-trang-hieu-qua', NULL, NULL, NULL, NULL, NULL, NULL, N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?', N'Làm Sao Để Thanh Lý Hàng Tồn Kho Thời Trang Hiệu Quả?')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3397, 3200, 1, N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Một cô nàng với khuôn mặt khả ái, tốt nghiệp ngành marketing Đại học RMIT, Nguyễn Hiền dễ dàng có một công việc như ý trong một tập đoàn truyền thông lớn. Và, con đường tương lai trải thảm hoa hồng mở ra trước mắt khi gia đình đã sẵn sàng cho cô con gái nhỏ đi du học', N'<p>Thế nhưng, c&ocirc; g&aacute;i 9X nhỏ b&eacute; đ&atilde; c&oacute; quyết định v&ocirc; c&ugrave;ng t&aacute;o bạo, ở lại Việt Nam v&agrave; ph&aacute;t triển &ldquo;Khu vườn tr&ecirc;n s&acirc;n thượng&rdquo; của m&igrave;nh. Quyết định của c&ocirc; g&aacute;i n&agrave;y c&oacute; thực sự đ&uacute;ng đắn? V&agrave;, &ldquo;Khu vườn tr&ecirc;n s&acirc;n thượng&rdquo; của c&ocirc; ấy c&oacute; thể sống s&oacute;t đến bao giờ? Ch&uacute;ng ta h&atilde;y đi t&igrave;m c&acirc;u trả lời ngay sau đ&acirc;y.</p>

<p><br />
<em>Con đường từ bỏ truyền th&ocirc;ng dấn th&acirc;n v&agrave;o n&ocirc;ng nghiệp của c&ocirc; g&aacute;i trẻ</em></p>

<h2><strong>Bỏ truyền th&ocirc;ng đổi nghề l&agrave;m n&ocirc;ng d&acirc;n từ t&igrave;nh y&ecirc;u hoa cỏ</strong></h2>

<p>T&igrave;nh y&ecirc;u hoa cỏ đ&atilde; c&oacute; sẵn trong t&acirc;m hồn c&ocirc; g&aacute;i n&agrave;y ngay từ những ng&agrave;y c&ocirc; vẫn c&ograve;n l&agrave; một học sinh ở v&ugrave;ng đất Long Kh&aacute;nh (Đồng Nai). Nhưng tại thời điểm đ&oacute;, t&igrave;nh y&ecirc;u hoa cỏ chỉ đơn giản l&agrave; một sở th&iacute;ch của Nguyễn Hiền chứ chưa thực sự l&agrave; đam m&ecirc; m&atilde;nh liệt trong c&ocirc;. V&agrave;, như bao bạn b&egrave; đồng trang lứa, c&ocirc; n&agrave;ng v&agrave;o Đại học v&agrave; học một chuy&ecirc;n ng&agrave;nh kh&aacute; hot hiện nay &ndash; marketing. Cuộc đời của Hiền kh&aacute; bằng phẳng cho đến khi c&aacute;i m&oacute;n thơm bạc h&agrave; giải nhiệt v&agrave;o m&ugrave;a h&egrave; năm 3 Đại học l&agrave;m Hiền phải một phen lặn lội khắp nơi để t&igrave;m cho được nguy&ecirc;n liệu l&aacute; bạc h&agrave; cho thức uống y&ecirc;u th&iacute;ch. Ch&iacute;nh v&igrave; &ldquo;biến cố&rdquo; n&agrave;y cộng với đầu &oacute;c của một người kinh doanh, Hiền bắt đầu những bước đi đầu tr&ecirc;n con đường trở th&agrave;nh người n&ocirc;ng d&acirc;n đ&iacute;ch thực.&nbsp;</p>

<h2><strong>Từ &ldquo;l&agrave;m chơi&rdquo; sang &ldquo;ăn thiệt&rdquo; bằng tư duy của người l&agrave;m kinh doanh</strong></h2>

<p>Tại thời điểm đ&oacute;, Hiền chỉ nhập một số giống c&acirc;y như: bạc h&agrave;, hương thảo, h&uacute;ng t&acirc;y về cung cấp cho một lượng kh&aacute;ch h&agrave;ng hạn chế. Tận dụng những mối quan hệ của m&igrave;nh, c&ocirc; g&aacute;i trẻ đ&atilde; li&ecirc;n hệ người th&acirc;n mua giống ở c&aacute;c si&ecirc;u thị nước ngo&agrave;i để đ&aacute;p ứng việc kinh doanh thuở ban đầu. Với Hiền, kinh doanh tại thời điểm n&agrave;y chỉ đơn giản l&agrave; một th&uacute; vui khi vừa thỏa l&ograve;ng y&ecirc;u thương hoa cỏ lại c&oacute; thể kiếm được đồng ra đồng v&agrave;o. Hiền tốt nghiệp RMIT, c&oacute; một c&ocirc;ng việc ổn định trong một tập đo&agrave;n truyền th&ocirc;ng ở S&agrave;i G&ograve;n v&agrave; chuẩn bị cho con đường du học mở cửa tương lai. Nhưng mọi thứ ho&agrave;n to&agrave;n thay đổi khi Hiền nhận ra rằng, nhu cầu thị trường đối với sản phẩm của m&igrave;nh đang rất lớn. V&agrave;, c&ocirc; g&aacute;i trẻ đ&atilde; c&oacute; quyết định của ri&ecirc;ng m&igrave;nh &ndash; tiếp tục ph&aacute;t triển c&ocirc;ng việc kinh doanh v&agrave; kh&ocirc;ng l&ecirc;n đường đi du học trước sự ngạc nhi&ecirc;n của mọi người. L&agrave; một người trẻ th&ocirc;ng minh v&agrave; nhanh nhạy, Hiền kh&ocirc;ng kinh doanh bằng vận may m&agrave; bằng kiến thức, kĩ năng v&agrave; tư duy của người kinh doanh. C&ocirc; g&aacute;i trẻ chăm ch&uacute;t chuyện khảo s&aacute;t v&agrave; nghi&ecirc;n cứu thị trường để t&igrave;m ra nhu cầu kh&aacute;ch h&agrave;ng. Đặc biệt, Hiền li&ecirc;n tục cập nhật c&aacute;c giống mới để giữ lợi thế cạnh tranh trước c&aacute;c đối thủ chứ kh&ocirc;ng ngủ qu&ecirc;n trong chiến thắng. V&agrave;, trang fanpage &ldquo;Khu vườn tr&ecirc;n s&acirc;n thượng&rdquo; ch&iacute;nh thức ra mắt như một cột mốc đ&aacute;nh dấu th&agrave;nh c&ocirc;ng ban đầu của c&ocirc; g&aacute;i 9X d&aacute;m nghĩ d&aacute;m l&agrave;m.<br />
&nbsp;</p>

<p><img alt="" khu="" san="" thuong="" tren="" vuon="" /><br />
<em>&ldquo;Khu vườn tr&ecirc;n s&acirc;n thượng&rdquo; của Hiền đ&atilde; bắt đầu cho quả ngọt</em></p>

<p><br />
Mọi người đều c&oacute; những giấc mơ của ri&ecirc;ng m&igrave;nh nhưng can đảm để theo đuổi đến c&ugrave;ng giấc mơ th&igrave; kh&ocirc;ng phải ai cũng l&agrave;m được. V&agrave;, Nguyễn Hiền &ndash; c&ocirc; g&aacute;i sở hữu những thuận lợi m&agrave; kh&oacute; ai c&oacute; được lại sẵn s&agrave;ng từ bỏ tất cả để dấn th&acirc;n v&agrave;o con đường của ri&ecirc;ng c&ocirc;. Th&agrave;nh c&ocirc;ng c&oacute; thể đến hoặc kh&ocirc;ng nhưng sự can đảm v&agrave; quyết liệt của Hiền trong quyết định của m&igrave;nh l&agrave; b&agrave;i học qu&iacute; b&aacute;u cho những bạn trẻ tr&ecirc;n con đường lập th&acirc;n lập nghiệp học tập. C&ograve;n hiện tại, &ldquo;Khu vườn tr&ecirc;n s&acirc;n thượng&rdquo; của Nguyễn Hiền đ&atilde; thu h&uacute;t hơn 100.000 lượt th&iacute;ch v&agrave; kế hoạch vươn m&igrave;nh ra Bắc của c&ocirc; g&aacute;i trẻ cũng đ&atilde; sẵn s&agrave;ng.</p>
', NULL, N'khu-vuon-tren-san-thuong-va-cau-chuyen-thanh-cong-cua-co-chu-9x-tot-nghiep-rmit', NULL, NULL, NULL, NULL, NULL, NULL, N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3398, 3200, 2, N'“Khu Vườn Trên Sân Thượng” Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Một cô nàng với khuôn mặt khả ái, tốt nghiệp ngành marketing Đại học RMIT, Nguyễn Hiền dễ dàng có một công việc như ý trong một tập đoàn truyền thông lớn. Và, con đường tương lai trải thảm hoa hồng mở ra trước mắt khi gia đình đã sẵn sàng cho cô con gái nhỏ đi du học', NULL, NULL, N'“khu-vuon-tren-san-thuong”-va-cau-chuyen-thanh-cong-cua-co-chu-9x-tot-nghiep-rmit', NULL, NULL, NULL, NULL, NULL, NULL, N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'Khu Vườn Trên Sân Thượng Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'“Khu Vườn Trên Sân Thượng” Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'“Khu Vườn Trên Sân Thượng” Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT', N'“Khu Vườn Trên Sân Thượng” Và Câu Chuyện Thành Công Của Cô Chủ 9x Tốt Nghiệp RMIT')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3399, 3201, 1, N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'Trong một lần tình cờ về quê thăm gia đình chồng ở Phan Rang (Ninh Thuận) và thấy được những đặc sản quê hấp dẫn, Huỳnh Thị Mỹ Oanh -  sinh năm 1992 và hiện đang là nhân viên xuất nhập khẩu ở TP HCM đã nảy ra ý tưởng kinh doanh để kiếm thêm thu nhập.', N'<p><em>Ch&acirc;n dung c&ocirc; chủ đa t&agrave;i 9x</em></p>

<h2><strong>&Yacute; tưởng kinh doanh</strong></h2>

<p>&ldquo;Ở Phan Rang c&oacute; rất nhiều đặc sản nhưng trước giờ người d&acirc;n kh&ocirc;ng biết quảng b&aacute; n&ecirc;n t&ocirc;i thấy đ&acirc;y l&agrave; cơ hội để 2 vợ chồng thực hiện đam m&ecirc; kinh doanh. B&ecirc;n cạnh đ&oacute;, chung t&ocirc;i cũng mong muốn đưa đặc sản qu&ecirc; hương tới nhiều tỉnh th&agrave;nh tr&ecirc;n cả nước. Năm 2014, ch&uacute;ng t&ocirc;i ch&iacute;nh thức mở cửa h&agrave;ng ở quận 10&rdquo;, Oanh t&acirc;m sự.</p>

<p><br />
<img alt="9x Phat Len Nho Kinh Doanh Dac San Que" src="https://camhungkinhdoanh.chili.vn/getattachment/e2fec8b1-bd88-4f2d-952d-10d464926326/kinh-nghiem-vang-tu-nguoi-thanh-cong-02.jpg.aspx" title="9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê" /><br />
<em>Ch&iacute;nh Oanh l&agrave; một trong những người ti&ecirc;n phong trong việc đưa đặc sản Phan Rang ra c&aacute;c tỉnh th&agrave;nh kh&aacute;c tr&ecirc;n cả nước</em></p>

<h2><strong>Qu&aacute; tr&igrave;nh thực hiện</strong></h2>

<p>V&igrave; cẩn trọng, vốn ban đầu của 2 vợ chồng bỏ ra chỉ 50 triệu đồng bao gồm chi ph&iacute; thu&ecirc; mặt bằng, dụng cụ bu&ocirc;n b&aacute;n v&agrave; tiền trả cho nh&acirc;n vi&ecirc;n giao h&agrave;ng trong 2 th&aacute;ng đầu ti&ecirc;n. Ri&ecirc;ng chi ph&iacute; x&acirc;y dựng website để quảng b&aacute;n sản phẩm v&agrave; b&aacute;n h&agrave;ng online, Oanh cho biết c&ocirc; kh&ocirc;ng mất đồng n&agrave;o v&igrave; chồng m&igrave;nh l&agrave; d&acirc;n c&ocirc;ng nghệ th&ocirc;ng tin.<br />
<br />
Điều khiến 2 vợ chồng lu&ocirc;n đau đầu ch&iacute;nh l&agrave; kh&acirc;u nguy&ecirc;n liệu v&agrave; giao h&agrave;ng. Oanh cho biết vợ chồng c&ocirc; đ&atilde; phải bỏ ra cả th&aacute;ng để t&igrave;m nguồn cung ứng sản phẩm chất lượng v&agrave; ổn định. Ngo&agrave;i ra, để khảo s&aacute;t nhu cầu kh&aacute;ch h&agrave;ng, Oanh chỉ nhập một số đặc sản nhất định như mủ tr&ocirc;m, mật ong rừng, hạt &eacute;, tỏi&hellip; với số lượng chỉ v&agrave;i kg. Oanh ki&ecirc;n tr&igrave; b&ugrave; lỗ v&agrave; b&aacute;n với gi&aacute; phải chăng nhất trong thời gian đầu với mong muốn gầy dựng được l&ograve;ng tin cho kh&aacute;ch h&agrave;ng. B&ecirc;n cạnh đ&oacute;, Oanh c&ograve;n x&acirc;y dựng một đội ngũ giao h&agrave;ng chuy&ecirc;n nghiệp v&agrave; chọn đối t&aacute;c cung cấp h&agrave;ng uy t&iacute;n để đảm bảo nguy&ecirc;n liệu đầu v&agrave;o. Để giữ cho sản phẩm lu&ocirc;n tươi ngon, Oanh chỉ lấy theo đ&uacute;ng vụ m&ugrave;a v&igrave; đ&oacute; mới l&agrave; những sản phẩm chất lượng nhất. Ngo&agrave;i ra, c&ocirc; cũng t&igrave;m hiểu th&ecirc;m c&aacute;c c&aacute;ch bảo quản sản phẩm hợp l&yacute; v&agrave; an to&agrave;n</p>

<h2><strong>Gặt h&aacute;i th&agrave;nh c&ocirc;ng</strong></h2>

<p>&ldquo;Nửa năm đầu ti&ecirc;n 2 vợ chồng kh&ocirc;ng những l&agrave;m kh&ocirc;ng c&ocirc;ng m&agrave; c&ograve;n li&ecirc;n tục phải b&ugrave; lỗ. Tuy nhi&ecirc;n, đến th&aacute;ng thứ 7 th&igrave; lượng kh&aacute;ch bắt đầu tăng l&ecirc;n v&agrave; doanh thu b&ugrave; đắp được c&aacute;c chi ph&iacute; bỏ ra. L&uacute;c đ&oacute;, ch&uacute;ng t&ocirc;i nghĩ m&igrave;nh thật may mắn v&igrave; chỉ trong nửa năm đ&atilde; tho&aacute;t lỗ, sớm hơn rất nhiều so với kế hoạch đặt ra ban đầu&rdquo;, Oanh cho biết. Bắt đầu từ đ&oacute;, vợ chồng Oanh tiếp tục đẩy mạnh marketing bằng những b&agrave;i viết về địa điểm du lịch k&egrave;m theo nội dung giới thiệu c&aacute;c đặc sản hấp dẫn tr&ecirc;n website gi&uacute;p kh&aacute;ch h&agrave;ng biết v&agrave; hiểu nhiều hơn về c&ocirc;ng dụng cũng như điểm đặc biệt của sản phẩm.<br />
<br />
Chỉ sau 2 năm kinh doanh, giờ đ&acirc;y cửa h&agrave;ng của vợ chồng Oanh đ&atilde; c&oacute; h&agrave;ng trăm kh&aacute;ch h&agrave;ng th&acirc;n thiết v&agrave; con số n&agrave;y dự kiến sẽ c&ograve;n tăng l&ecirc;n rất nhiều. Số lượng sản phẩm 100% c&oacute; nguồn gốc từ Phan Rang đ&atilde; đạt mốc 30 loại. Hiện tại, sau khi trừ tất cả chi ph&iacute; th&igrave; vợ chồng Oanh thu l&atilde;i khoảng 35-50 triệu đồng &ndash; một con số kh&ocirc;ng hề nhỏ đối với c&aacute;c &ldquo;&ocirc;ng chủ, b&agrave; chủ&rdquo; vẫn c&ograve;n trong lứa tuổi 9x.</p>
', NULL, N'9x-phat-len-nho-kinh-doanh-dac-san-que', NULL, NULL, NULL, NULL, NULL, NULL, N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3400, 3201, 2, N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'Trong một lần tình cờ về quê thăm gia đình chồng ở Phan Rang (Ninh Thuận) và thấy được những đặc sản quê hấp dẫn, Huỳnh Thị Mỹ Oanh -  sinh năm 1992 và hiện đang là nhân viên xuất nhập khẩu ở TP HCM đã nảy ra ý tưởng kinh doanh để kiếm thêm thu nhập.', NULL, NULL, N'9x-phat-len-nho-kinh-doanh-dac-san-que', NULL, NULL, NULL, NULL, NULL, NULL, N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê', N'9x Phất Lên Nhờ Kinh Doanh Đặc Sản Quê')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3401, 3202, 1, N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Internet bao trùm toàn bộ địa cầu và len lỏi vào tất cả hoạt động có liên quan đến con người. Lẽ dĩ nhiên, kinh doanh không thể nằm ngoài phạm vi đó. Trước sự xâm lấm vũ bão ấy của Internet, người làm kinh doanh chỉ có hai lựa chọn: hoặc thích nghi hoặc chết?', N'<p>&nbsp;Số doanh nghiệp đứng tr&ecirc;n bờ vực ph&aacute; sản do kh&ocirc;ng chịu th&iacute;ch nghi hoặc thay đổi chậm so với thời cuộc kh&ocirc;ng phải nhỏ. Số doanh nghiệp c&ograve;n lại phải t&igrave;m mọi c&aacute;ch để th&iacute;ch nghi, để sống v&agrave; để ph&aacute;t triển. V&agrave;, những c&ocirc;ng cụ marketing hiệu quả nhất tr&ecirc;n Internet ch&iacute;nh l&agrave; vũ kh&iacute; để tồn tại giữa thương trường số. Vậy bộ c&ocirc;ng cụ marketing n&agrave;y gồm những g&igrave;?<br />
<img alt="Nhung Cong Cu Marketing Hieu Qua Nhat Tren Interner" src="https://camhungkinhdoanh.chili.vn/getattachment/ae2ed7b4-43f4-4509-814a-48e35989b758/quang-cao-online-anh-01.png.aspx" title="Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet" /><br />
<em>Website &ndash; c&ocirc;ng cụ marketing quan trọng trong thời đại số</em></p>

<h2><strong>Website</strong></h2>

<p>Website ch&iacute;nh l&agrave; một trong những c&ocirc;ng cụ marketing căn bản nhất nhưng chiếm giữ vị tr&iacute; quan trọng đặc biệt để doanh nghiệp tiếp cận kh&aacute;ch h&agrave;ng trong m&ocirc;i trường Internet. Tất cả những th&ocirc;ng tin li&ecirc;n quan đến doanh nghiệp từ lịch sử h&igrave;nh th&agrave;nh, giới thiệu hay gi&aacute; cả sản phẩm, th&ocirc;ng b&aacute;o quan trọng đều sẽ được c&ocirc;ng bố tr&ecirc;n website. V&igrave; thế, x&acirc;y dựng website l&agrave; c&ocirc;ng việc quan trọng bậc nhất khi doanh nghiệp muốn tồn tại trong thời buổi ng&agrave;y nay.</p>

<h2><strong>Mạng x&atilde; hội</strong></h2>

<p>Mạng x&atilde; hội đ&aacute;nh dấu một cuộc c&aacute;ch mạng mới trong c&aacute;ch tiếp cận kh&aacute;ch h&agrave;ng thời đại c&ocirc;ng nghệ số. V&igrave; kh&ocirc;ng c&oacute; khoảng c&aacute;ch địa l&yacute; n&agrave;o ngăn cản tr&ecirc;n mạng x&atilde; hội n&ecirc;n việc tiếp thị sản phẩm sẽ mở rộng vượt trội so với trước đ&acirc;y. Tuy nhi&ecirc;n, đối với c&ocirc;ng cụ marketing n&agrave;y, người d&ugrave;ng c&oacute; nhiều quyền chủ động hơn trong việc lựa chọn cũng như b&agrave;y tỏ cảm x&uacute;c v&agrave; tương t&aacute;c trực tiếp với doanh nghiệp cung cấp sản phẩm hay dịch vụ họ quan t&acirc;m. V&igrave; thế, muốn tận dụng hiệu quả c&ocirc;ng cụ n&agrave;y, bạn cần tạo ra những nội dung thật sự độc đ&aacute;o, hấp dẫn thậm ch&iacute; cần tạo ra tr&agrave;o lưu nhưng phải tương ứng với chất lượng sản phẩm v&agrave; dịch vụ, th&igrave; mới c&oacute; thể gi&agrave;nh thắng lợi cao nhất.</p>

<h2><strong>Email</strong></h2>

<p>Email marketing l&agrave; h&igrave;nh thức marketing trực tiếp trong thời đại số. Để c&oacute; được danh s&aacute;ch kh&aacute;ch h&agrave;ng, bạn c&oacute; thể thu thập v&agrave; cũng c&oacute; thể mua từ những đơn vị cung cấp. Email marketing l&agrave; một c&ocirc;ng cụ hữu hiệu gi&uacute;p bạn duy tr&igrave; mối quan hệ với kh&aacute;ch h&agrave;ng hiện tại v&agrave; tạo mối quan hệ với những kh&aacute;ch h&agrave;ng tiềm năng th&ocirc;ng qua việc thường xuy&ecirc;n gửi thư giới thiệu doanh nghiệp đến họ. Ưu điểm của c&ocirc;ng cụ n&agrave;y ch&iacute;nh l&agrave; t&iacute;nh kinh tế về chi ph&iacute;, dễ d&agrave;ng sử dụng cũng như việc đo lường kh&aacute; đơn giản. H&atilde;y thử nghiệm c&ocirc;ng cụ n&agrave;y cho doanh nghiệp của bạn ngay từ h&ocirc;m nay!</p>

<h2><strong>SEO</strong></h2>

<p>SEO (Search Engine Optimization) l&agrave; qu&aacute; tr&igrave;nh tối ưu h&oacute;a website của bạn tr&ecirc;n c&ocirc;ng cụ t&igrave;m kiếm. Đ&acirc;y l&agrave; một trong những c&ocirc;ng cụ marketing cực k&igrave; hiệu quả v&agrave; hiện đang l&agrave; sự lựa chọn h&agrave;ng đầu của những người l&agrave; marketing hiện đại. C&ocirc;ng cụ n&agrave;y mang lại hiệu quả l&acirc;u d&agrave;i d&ugrave; cho chiến dịch marketing của bạn đ&atilde; chấm dứt. Một thế mạnh nữa của SEO ch&iacute;nh l&agrave; khả năng n&acirc;ng cao h&igrave;nh ảnh thương hiệu website của bạn trong t&acirc;m tr&iacute; kh&aacute;ch h&agrave;ng. Để sử dụng tốt SEO, bạn cần 5 yếu tố ch&iacute;nh: từ kh&oacute;a, nội dung, link, lượng người truy cập v&agrave; t&ecirc;n miền. Nếu hội tụ được 5 yếu tố n&agrave;y, khả năng SEO th&agrave;nh c&ocirc;ng l&agrave; cực k&igrave; cao.</p>

<p><br />
<a href="https://www.google.com.vn/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwjVrfTM8KbPAhUEE5QKHfSqDGEQjRwIBw&url=http%3A%2F%2Fvietcom.vn%2Fdich-vu-seo&psig=AFQjCNGm4PQFT1pGFuvdJfpSKCQdoQmq2w&ust=1474767863962464" target="_blank"><img alt="Kết quả hình ảnh cho seo" src="http://vietcom.vn/wp-content/uploads/2015/09/Slide-20160219231727-0.jpg" /></a><br />
<em>SEO &ndash; sự lựa chọn h&agrave;ng đầu của những người marketing hiện đại</em></p>

<p><br />
Tr&ecirc;n đ&acirc;y l&agrave; một số trong nhiều c&ocirc;ng cụ marketing hiệu quả của thời đại Internet gi&uacute;p bạn c&oacute; thể tồn tại v&agrave; ph&aacute;t triển ổn định trước s&oacute;ng gi&oacute; thương trường. Bạn kh&ocirc;ng thể chỉ h&agrave;i l&ograve;ng với những g&igrave; đang c&oacute; m&agrave; phải lu&ocirc;n vận động, học hỏi kh&ocirc;ng ngừng nếu muốn l&agrave;m kinh doanh trong thời đại kh&ocirc;ng phải cạnh tranh m&agrave; ch&iacute;nh sự lười biếng th&iacute;ch nghi mới ch&iacute;nh l&agrave; kẻ hủy diệt doanh nghiệp. H&atilde;y lu&ocirc;n trong tư thế sẵn s&agrave;ng th&iacute;ch nghi, thay đổi v&agrave; ph&aacute;t triển trước thời cuộc nếu bạn chọn kinh doanh l&agrave;m đường đi cho m&igrave;nh.</p>
', NULL, N'nhung-cong-cu-marketing-hieu-qua-nhat-tren-internet', NULL, NULL, NULL, NULL, NULL, NULL, N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3402, 3202, 2, N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Internet bao trùm toàn bộ địa cầu và len lỏi vào tất cả hoạt động có liên quan đến con người. Lẽ dĩ nhiên, kinh doanh không thể nằm ngoài phạm vi đó. Trước sự xâm lấm vũ bão ấy của Internet, người làm kinh doanh chỉ có hai lựa chọn: hoặc thích nghi hoặc chết? Số doanh nghiệp đứng trên bờ vực phá sản do không chịu thích nghi hoặc thay đổi chậm so với thời cuộc không phải nhỏ. Số doanh nghiệp còn lại phải tìm mọi cách để thích nghi, để sống và để phát triển. Và, những công cụ marketing hiệu quả nhất trên Internet chính là vũ khí để tồn tại giữa thương trường số. Vậy bộ công cụ marketing này gồm những gì?', NULL, NULL, N'nhung-cong-cu-marketing-hieu-qua-nhat-tren-internet', NULL, NULL, NULL, NULL, NULL, NULL, N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet', N'Những Công Cụ Marketing Hiệu Quả Nhất Trên Internet')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3403, 3203, 1, N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'Blog cũng là một trong những kênh truyền thông giúp bạn quảng bá sản phẩm hoặc dịch vụ. Blog thường có thiết kế đơn giản nên nếu nếu bạn là một người đang có nhu cầu làm blog để kiếm tiền, tăng traffic và thu hút người quan tâm đến thương hiệu, hãy đừng quên rằng cần có CTA để kêu gọi khách hàng hành động. Hãy cùng Chili điểm qua các yếu tố để bạn có một bài blog hiệu quả nhé!', N'<h2><strong>Đăng k&egrave;m biểu đồ hoặc h&igrave;nh ảnh hấp dẫn</strong></h2>

<p>Viết blog quan trong nhất ch&iacute;nh l&agrave; nội dung. Nội dung hấp dẫn, độc đ&aacute;o v&agrave; hữu &iacute;ch với người d&ugrave;ng sẽ gi&uacute;p c&aacute;c b&agrave;i đăng của bạn tiếp cận với nhiều người hơn. Tuy nhi&ecirc;n, với mức độ phổ biến hiện nay của blog, để c&oacute; thể cạnh tranh được với c&aacute;c trang blog được tạo ra mỗi ng&agrave;y, c&aacute;c b&agrave;i viết của bạn cần c&oacute; nhiều h&igrave;nh ảnh th&uacute; vị hơn nữa. Một b&agrave;i blog c&oacute; h&igrave;nh ảnh hấp dẫn sẽ thu h&uacute;t lượng view hơn đến 94%. Cụ thể hơn, c&oacute; đến 60% kh&aacute;ch h&agrave;ng thường ưu ti&ecirc;n chọn c&aacute;c c&ocirc;ng ty c&oacute; h&igrave;nh ảnh xuất hiện tr&ecirc;n kết quả t&igrave;m kiếm. Ngo&agrave;i chức năng thu h&uacute;t người đọc, h&igrave;nh ảnh trong c&aacute;c b&agrave;i blog c&ograve;n gi&uacute;p ngắt qu&atilde;ng văn bản v&agrave; cho người đọc thời gian suy ngẫm về những th&ocirc;ng tin vừa đọc.</p>

<p><br />
<img alt="4 Yeu To Giup Bai Blog Dat Hieu Qua Cao" src="https://camhungkinhdoanh.chili.vn/getattachment/04e8a963-7a39-4685-9f21-54d6a7bc0e11/quang-cao-online-01-(1).jpg.aspx" title="4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao" /><br />
<em>H&igrave;nh ảnh hấp dẫn sẽ thu h&uacute;t được nhiều lượt quan t&acirc;m từ người xem</em></p>

<h2><strong>Sử dụng thiết kế v&agrave; d&agrave;n trang dễ đọc</strong></h2>

<p>Kh&ocirc;ng như những c&aacute;c trang mạng x&atilde; hội kh&aacute;c c&oacute; sẵn giao diện cụ thể, với blog bạn c&oacute; thể t&ugrave;y &yacute; chỉnh sửa giao diện của m&igrave;nh. Do đ&oacute;, h&atilde;y chọn những kiểu sắp xếp c&aacute;c đề mục v&agrave; m&agrave;u sắc thật h&agrave;i h&ograve;a, vừa c&oacute; thể gi&uacute;p người xem thấy ngay được những đề mục quan trọng vừa khiến họ kh&ocirc;ng bị &ldquo;hoa mắt&rdquo;. Ngo&agrave;i ra, c&aacute;ch thiết kế d&agrave;n trang blog sẽ gi&uacute;p cho người xem nắm được tổng qu&aacute;t trang blog của bạn hiện đang c&oacute; những g&igrave; v&agrave; gi&uacute;p họ c&oacute; thể nắm được kh&aacute;i qu&aacute;t nội dung b&agrave;i đăng cụ thể. T&oacute;m lại th&igrave;, nội dung chất lượng v&agrave; thiết kế độc đ&aacute;o sẽ l&agrave; hai yếu tố h&agrave;ng đầu gi&uacute;p tăng uy t&iacute;n cho blog của bạn.</p>

<h2><strong>Li&ecirc;n kết với mạng x&atilde; hội</strong></h2>

<p>Đừng tự c&ocirc; lập m&igrave;nh với thế giới internet ng&agrave;y c&agrave;ng ph&aacute;t triển. H&atilde;y kết nối blog của bạn với nhiều trang mạng x&atilde; hội như Facebook hay Instagram để c&oacute; thể k&eacute;o về lượng truy cập lớn. Ngo&agrave;i ra, bạn cũng đừng qu&ecirc;n cập nhật những xu hướng mới nhất từ c&aacute;c trang mạng x&atilde; hội n&agrave;y để tạo một nội dung, một chủ đề hoặc một cuộc thảo luận ph&ugrave; hợp để thu h&uacute;t sự quan t&acirc;m của người xem. H&atilde;y tổ chức nhiều cuộc đối thoại, tạo điều kiện cho người đọc tham gia v&agrave;o thảo luận b&agrave;i viết để họ cảm thấy rằng bạn coi trọng &yacute; kiến của họ.</p>

<h2><strong>Call to action</strong></h2>

<p>Cuối mỗi b&agrave;i chia sẻ, đừng qu&ecirc;n tạo tương t&aacute;c v&agrave; &ldquo;k&eacute;o&rdquo; th&ecirc;m cho m&igrave;nh những người d&ugrave;ng mới bằng c&aacute;c n&uacute;t như: Đăng k&yacute; nhận Newsletter, Ưu đ&atilde;i đặc biệt, Xem th&ecirc;m b&agrave;i tại đ&acirc;y&hellip;. Để gi&uacute;p người đọc dễ d&agrave;ng nhận ra c&aacute;c n&uacute;t CTA n&agrave;y, bạn cần thiết kế c&aacute;c n&uacute;t tr&ecirc;n nằm ở g&oacute;c dễ nh&igrave;n v&agrave; c&oacute; m&agrave;u bắt mắt. Ngo&agrave;i ra, bạn cũng n&ecirc;n đơn giản h&oacute;a c&aacute;c n&uacute;t CTA để kh&ocirc;ng khiến người d&ugrave;ng cảm thấy kh&oacute; chịu khi nhấn v&agrave;o. Những mục đăng k&yacute; d&agrave;i l&ecirc; th&ecirc; với c&aacute;c đề mục kh&ocirc;ng cần thiết như địa chỉ, sở th&iacute;ch&hellip; sẽ khiến bạn bị giảm lượt tương t&aacute;c.</p>

<p><br />
<img alt="4 Yeu To Giup Bai Blog Dat Hieu Qua Cao" src="https://camhungkinhdoanh.chili.vn/getattachment/d4612086-6ba0-4c40-8cff-ffff09d597bc/quang-cao-online-02.png.aspx" title="4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao" /><br />
<em>Chọn m&agrave;u sắc bắt mắt cho c&aacute;c n&uacute;t CTA sẽ gi&uacute;p người xem dễ ch&uacute; &yacute;</em></p>

<p><br />
Khi việc viết blog đ&atilde; trở th&agrave;nh c&ocirc;ng việc kh&ocirc;ng chỉ mang t&iacute;nh chia sẻ c&aacute; nh&acirc;n nữa m&agrave; dẫn trở th&agrave;nh phương tiện để học tập, trao đổi chuy&ecirc;n m&ocirc;n v&agrave; l&agrave; một phần thiết yếu của kinh doanh, bạn sẽ cần phải cực kỳ lưu t&acirc;m đến những g&igrave; m&igrave;nh thực hiện tr&ecirc;n trang nội dung của m&igrave;nh. Việc n&agrave;y dĩ nhi&ecirc;n sẽ kh&ocirc;ng đơn giản nhưng nếu bạn ch&uacute; &yacute; bốn yếu tố quan trọng tr&ecirc;n đ&acirc;y, chắc chắn trang blog của bạn c&oacute; thể đủ sức k&iacute;ch th&iacute;ch người đọc phản hồi lại, v&agrave; quan trọng nhất l&agrave; bạn c&oacute; thể sẽ kiếm được tiền từ n&oacute;.</p>
', NULL, N'4-yeu-to-giup-bai-blog-dat-hieu-qua-cao', NULL, NULL, NULL, NULL, NULL, NULL, N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3404, 3203, 2, N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'logo
CHILI FREE
CHILI COMP
CHILI SHOP
CHILI PAGE
CHILI APPS
TƯ VẤN CHỌN MẪU
Cảm hứng kinh doanhBí quyết kinh doanhQuảng cáo Online4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao
Quảng cáo Online
4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao
14-09-2016
Blog cũng là một trong những kênh truyền thông giúp bạn quảng bá sản phẩm hoặc dịch vụ. Blog thường có thiết kế đơn giản nên nếu nếu bạn là một người đang có nhu cầu làm blog để kiếm tiền, tăng traffic và thu hút người quan tâm đến thương hiệu, hãy đừng quên rằng cần có CTA để kêu gọi khách hàng hành động. Hãy cùng Chili điểm qua các yếu tố để bạn có một bài blog hiệu quả nhé!', NULL, NULL, N'4-yeu-to-giup-bai-blog-dat-hieu-qua-cao', NULL, NULL, NULL, NULL, NULL, NULL, N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao', N'4 Yếu Tố Giúp Bài Blog Đạt Hiệu Quả Cao')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3405, 3204, 1, N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'Nếu nghĩ rằng chỉ khi nào có một số vốn thật lớn mới có thể bắt đầu kinh doanh thì bạn đã nhầm rồi đấy. Để có thể tự khởi nghiệp, đôi khi tất cả những gì bạn cần chính là sự khéo léo trong cách chọn địa điểm, chọn sản phẩm kinh doanh phù hợp và lên kế hoạch đầu tư hợp lý', N'<p>Một khi đ&atilde; nắm vững được c&aacute;c yếu tố tr&ecirc;n th&igrave; d&ugrave; với số vốn chỉ vỏn vẹn 15 triệu đồng, bạn vẫn c&oacute; thể c&oacute; tạo được m&ocirc; h&igrave;nh kinh doanh hiệu quả.</p>

<h2><strong>1. B&aacute;n quần &aacute;o online</strong></h2>

<p>Hoa (Q.T&acirc;n B&igrave;nh) từng b&aacute;n quần &aacute;o thu&ecirc; tại chợ Bến Th&agrave;nh (TPHCM) với mức lương chỉ c&oacute; 3 triệu đồng/th&aacute;ng (bao ăn uống). Với số tiền &iacute;t ỏi giữa đất S&agrave;i th&agrave;nh n&agrave;y, tiền gửi về cho gia đ&igrave;nh v&agrave; d&agrave;nh dụm chẳng được l&agrave; bao. Điều n&agrave;y khiến Hoa trăn trở v&agrave; quyết định mở cửa h&agrave;ng quần &aacute;o tr&ecirc;n mạng.<br />
<br />
Do chỉ nắm trong tay số vốn &iacute;t ỏi n&ecirc;n để tr&aacute;nh rủi ro, c&ocirc; đăng k&yacute; mở shop miễn ph&iacute; tr&ecirc;n website thương mại điện tử. Song song với đ&oacute;, Hoa cũng quảng b&aacute; sản phẩm tr&ecirc;n Facebook c&aacute; nh&acirc;n của m&igrave;nh. Với c&aacute;ch thức n&agrave;y, Hoa kh&ocirc;ng mất tiền mở cửa h&agrave;ng hay thu&ecirc; kios m&agrave; vẫn c&oacute; được lượng kh&aacute;ch h&agrave;ng ổn định.</p>

<p><br />
<img alt="4 Mo Hinh Kinh Doanh Co So Von Chi Tu 15 Trieu Dong" src="https://camhungkinhdoanh.chili.vn/getattachment/791ab294-d06d-4b8d-901a-1ecf29804773/xu-huong-kinh-doanh-01.jpg.aspx" title="4 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng" /><br />
<em>B&aacute;n h&agrave;ng online tr&ecirc;n mạng l&agrave; sự lựa chọn ho&agrave;n hảo với những bạn c&oacute; vốn kinh doanh thấp</em></p>

<p><br />
Với kinh nghiệm c&oacute; sẵn n&ecirc;n thay v&igrave; chọn với số lượng nhiều, mỗi sản phẩm Hoa chỉ lấy 1-2 c&aacute;i v&agrave; chỉ chọn những mẫu độc đ&aacute;o nhất. Nếu nhận thấy mẫu m&atilde; n&agrave;y được nhiều người quan t&acirc;m, Hoa mới tiếp tục lấy th&ecirc;m để tr&aacute;nh h&agrave;ng tồn kho. Thời gian đầu, do kh&aacute;ch h&agrave;ng chưa biết đến sản phẩm th&igrave; lợi nhuận kh&ocirc;ng cao. Thế nhưng sau v&agrave;i th&aacute;ng, do sản phẩm kinh doanh c&oacute; kiểu d&aacute;ng đặc sắc n&ecirc;n h&agrave;ng h&oacute;a của Hoa được cộng đồng mạng chia sẻ với tốc độ ng&agrave;y c&agrave;ng cao. Dần d&agrave;, lượng kh&aacute;ch tại shop online của c&ocirc; n&agrave;ng n&agrave;y gia tăng mạnh.<br />
<br />
Hoa chia sẻ: &ldquo;Sau khi trừ c&aacute;c khoản chi ph&iacute; th&ocirc;ng thường, trung b&igrave;nh một th&aacute;ng t&ocirc;i c&oacute; thể kiếm được tr&ecirc;n chục triệu đồng từ b&aacute;n quần &aacute;o. T&iacute;ch lũy dần dần, mỗi th&aacute;ng t&ocirc;i đều c&oacute; tiền dư giả v&agrave; tr&iacute;ch ra khoảng 5 -10% để mua quảng c&aacute;o tr&ecirc;n website thương mại điện với mong muốn c&oacute; th&ecirc;m kh&aacute;ch h&agrave;ng&rdquo;. Cho tới nay, nhờ b&aacute;n h&agrave;ng qua mạng cũng như kh&ocirc;ng ngừng t&igrave;m những nguồn h&agrave;ng mới lạ m&agrave; Hoa lu&ocirc;n c&oacute; 300 kh&aacute;ch h&agrave;ng quen thuộc. Đ&acirc;y cũng l&agrave; t&iacute;n hiệu vui cho những ai muốn kinh doanh quần &aacute;o nhưng c&oacute; số vốn c&ograve;n hạn chế.</p>

<h2><strong>2. Cửa h&agrave;ng đồ ăn vặt mang đi</strong></h2>

<p>Đồ ăn vặt lu&ocirc;n l&agrave; m&oacute;n ăn ưa th&iacute;ch của giới trẻ. B&aacute;n đồ ăn vặt mang đi cũng l&agrave; c&aacute;ch tiết kiệm mặt bằng, giảm bớt chi ph&iacute; đầu tư b&agrave;n ghế m&agrave; lại thu hồi vốn nhanh.<br />
<br />
Ch&uacute; Vi&ecirc;n, chủ cửa h&agrave;ng b&aacute;nh tr&aacute;ng trộn ở quận 3 (TP HCM) cho biết m&ocirc; h&igrave;nh b&aacute;n đồ ăn vặt chỉ cần 5-7 triệu l&agrave; c&oacute; thể l&agrave;m được. Hơn thế nữa, với thức ăn vặt, bạn kh&ocirc;ng nhất thiết phải thu&ecirc; mặt bằng lớn m&agrave; điều cốt yếu l&agrave; sản phẩm phải ngon, gi&aacute; phải chăng v&agrave; điều quan trọng l&agrave; phải được b&aacute;n ở khu đ&ocirc;ng học sinh sinh vi&ecirc;n. Nếu nh&agrave; bạn ở ngay mặt tiền th&igrave; đ&acirc;y ch&iacute;nh l&agrave; ưu thế lớn khi bạn c&oacute; thể tận dụng một khoảng nhỏ trước s&acirc;n để mở cửa h&agrave;ng ăn vặt. Với loại h&igrave;nh kinh doanh n&agrave;y, chi ph&iacute; để l&agrave;m ra sản phẩm kh&ocirc;ng cao nhưng số lợi nhuận bạn c&oacute; thể kiểm được do ch&uacute;ng mang lại c&oacute; thể l&ecirc;n tới 50% tr&ecirc;n tổng doanh thu.<br />
<br />
&ldquo;Cửa h&agrave;ng của t&ocirc;i chỉ rộng v&agrave;i m2 nhưng từ 15h chiều trở đi l&agrave; kh&aacute;ch nối đu&ocirc;i nhau lấy số mua h&agrave;ng. Ban đầu chỉ c&oacute; 2 vợ chồng b&aacute;n nhưng giờ phải thu&ecirc; th&ecirc;m người l&agrave;m mới c&oacute; thể đ&aacute;p ứng nhu cầu cửa kh&aacute;ch. Do đ&oacute;, sau khi trừ c&aacute;c khoản mua sắm nguy&ecirc;n vật liệu v&agrave; tiền c&ocirc;ng của người l&agrave;m thu&ecirc;, mỗi ng&agrave;y cửa h&agrave;ng của t&ocirc;i l&atilde;i thu được hơn một triệu đồng&rdquo;, ch&uacute; Vi&ecirc;n chia sẻ.</p>

<h2><strong>3. Qu&aacute;n nướng vỉa h&egrave;</strong></h2>

<p>V&agrave;o buổi tối, vỉa h&egrave; l&agrave; nơi được kh&aacute; nhiều giới trẻ ưa th&iacute;ch để tụ tập ăn uống. Nhận thấy đ&acirc;y l&agrave; thời gian v&agrave;ng để kinh doanh n&ecirc;n Lu&acirc;n, một chủ qu&aacute;n nướng ở vỉa h&egrave; đường Trần N&atilde;o (quận 2) đ&atilde; thu&ecirc; một mặt bằng nhỏ ở đ&acirc;y v&agrave; bắt đầu kinh doanh đồ nuống. Với số vốn 15 triệu đồng, Lu&acirc;n tr&iacute;ch 3 triệu để trả tiền mặt bằng, sau đ&oacute; anh ch&agrave;ng t&igrave;m nguồn h&agrave;ng thanh l&yacute; b&agrave;n ghế nhựa gi&aacute; rẻ khoảng 3 triệu đồng 10 bộ, 9 triệu c&ograve;n lại để mua thực phẩm v&agrave; trả tiền nh&acirc;n vi&ecirc;n thu&ecirc; theo giờ.<br />
<br />
&ldquo;Qu&aacute;n nướng xi&ecirc;n que của t&ocirc;i v&igrave; c&oacute; chi ph&iacute; đầu tư thấp n&ecirc;n gi&aacute; mỗi xi&ecirc;n b&aacute;n ra thấp hơn 20-30% so với c&aacute;c qu&aacute;n kh&aacute;c. Đ&acirc;y v&ocirc; t&igrave;nh lại l&agrave; một lợi thế cạnh tranh kh&aacute; lớn v&agrave; gi&uacute;p t&ocirc;i c&oacute; h&agrave;ng trăm kh&aacute;ch ra v&agrave;o mỗi tối&rdquo;, Lu&acirc;n n&oacute;i.<br />
Lu&acirc;n cũng cho biết, sau một năm hoạt động, từ số tiền nhỏ ch&agrave;ng trai đ&atilde; t&iacute;ch lũy được khoản lớn hơn v&agrave; c&oacute; thể mở rộng m&ocirc; h&igrave;nh theo &yacute; muốn. Tuy nhi&ecirc;n Lu&acirc;n cũng nhấn mạnh rằng để qu&aacute;n nướng hấp dẫn thực kh&aacute;ch, ngo&agrave;i vị tr&iacute; th&igrave; c&aacute;c m&oacute;n ăn cũng cần phải cập nhật li&ecirc;n tục cũng như đảm bảo vệ sinh v&agrave; kh&ocirc;ng gian phải tho&aacute;ng đ&atilde;ng.</p>

<p><br />
<img alt="4 Mo Hinh Kinh Doanh Co So Von Chi Tu 15 Trieu Dong" src="https://camhungkinhdoanh.chili.vn/getattachment/54482b69-3c92-4173-b9c6-85bd0504d470/xu-huong-kinh-doanh-02.jpg.aspx" title="4 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng" /><br />
<em>Th&uacute; vui tụ tập ăn uống v&agrave;o mỗi tối ch&iacute;nh l&agrave; cơ hội tốt để bạn kinh doanh những qu&aacute;n nướng mini</em></p>

<p><br />
C&oacute; thể thấy, kinh doanh với số vốn chỉ khoảng từ 15 triệu đồng kh&ocirc;ng kh&oacute; như ch&uacute;ng ta tưởng. Nếu bạn đang ấp ủ kế hoạch kinh doanh độc đ&aacute;o nhưng lại c&oacute; số vốn qu&aacute; nhỏ, đừng nản l&ograve;ng. Trước hết, bạn cần vạch ra kế hoạch thật tỉ mỉ, x&aacute;c định được loại h&igrave;nh kinh doanh v&agrave; kh&aacute;ch h&agrave;ng mục ti&ecirc;u. Sau đ&oacute;, t&ugrave;y v&agrave;o sản phẩm kinh doanh l&agrave; g&igrave; m&agrave; bạn sẽ phải quan t&acirc;m tiếp về vấn đề mặt bằng. Chỉ cần l&agrave;m tuần tự c&aacute;c bước tr&ecirc;n, bạn đ&atilde; c&oacute; thể tự tin khởi nghiệp rồi đấy. Chili ch&uacute;c bạn th&agrave;nh c&ocirc;ng!</p>
', NULL, N'3-mo-hinh-kinh-doanh-co-so-von-chi-tu-15-trieu-dong', NULL, NULL, NULL, NULL, NULL, NULL, N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3406, 3204, 2, N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'Nếu nghĩ rằng chỉ khi nào có một số vốn thật lớn mới có thể bắt đầu kinh doanh thì bạn đã nhầm rồi đấy. Để có thể tự khởi nghiệp, đôi khi tất cả những gì bạn cần chính là sự khéo léo trong cách chọn địa điểm, chọn sản phẩm kinh doanh phù hợp và lên kế hoạch đầu tư hợp lý', NULL, NULL, N'3-mo-hinh-kinh-doanh-co-so-von-chi-tu-15-trieu-dong', NULL, NULL, NULL, NULL, NULL, NULL, N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng', N'3 Mô Hình Kinh Doanh Có Số Vốn Chỉ Từ 15 Triệu Đồng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3407, 3205, 1, N'Sales Manager', N'www.nongduochai.com', N'<p>T&ocirc;i rất h&agrave;i l&ograve;ng với sản phẩm v&agrave;&nbsp;dịch vụ của EPM Design, dễ quản trị, cập nhật!</p>
', NULL, N'sales-manager', NULL, NULL, NULL, NULL, NULL, NULL, N'Sales Manager', N'Sales Manager', N'Sales Manager', N'Sales Manager', N'Sales Manager', N'Sales Manager')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3408, 3205, 2, N'IT Manager', N'Nông Dược Hai; www.nongduochai.com', NULL, NULL, N'it-manager', NULL, NULL, NULL, NULL, NULL, NULL, N'Sales Manager', N'Sales Manager', N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3409, 3206, 1, N'Giám đốc Marketing', N'Công ty Saigontrans.com.vn', N'<p>T&ocirc;i rất h&agrave;i l&ograve;ng với sản phẩm v&agrave;&nbsp;dịch vụ của EPM Design, dễ quản trị, cập nhật!</p>
', NULL, N'giam-doc-marketing', NULL, NULL, NULL, NULL, NULL, NULL, N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3410, 3206, 2, N'Giám đốc Marketing', N'Công ty Saigontrans.com.vn', NULL, NULL, N'giam-doc-marketing', NULL, NULL, NULL, NULL, NULL, NULL, N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing', N'Giám đốc Marketing')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3411, 3207, 1, N'IT Manager', N'www.haiminh.com.vn', N'<p>T&ocirc;i rất h&agrave;i l&ograve;ng với sản phẩm v&agrave;&nbsp;dịch vụ của EPM Design, dễ quản trị, cập nhật!</p>
', NULL, N'it-manager', N'http://www.haiminh.com.vn/', NULL, NULL, NULL, NULL, NULL, N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3412, 3207, 2, N'IT Manager', N'www.haiminh.com.vn', NULL, NULL, N'it-manager', N'http://www.haiminh.com.vn/', NULL, NULL, NULL, NULL, NULL, N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager', N'IT Manager')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3413, 3208, 1, N'Tự Tạo SEO Cho Website Của Mình', N'Đứng trước cơ hội vàng trong thời kỳ phát triển hưng thịnh của Internet, lại có máu kinh doanh trong người, nhiều nhà khởi nghiệp có tuổi đời còn rất trẻ đã bắt đầu gia nhập ngành. Những website bán hàng ồ ạt xuất hiện nhưng trong số chúng, bao nhiêu còn, bao nhiêu mất và bao nhiêu đang chờ chết? ', N'<p>Một khi đ&atilde; quyết định dấn th&acirc;n v&agrave;o thị trường online, bạn c&oacute; thể đi ch&acirc;n đất khởi đầu nhưng muốn ph&aacute;t triển ở tầm cao mới th&igrave; việc trang bị một &ldquo;đ&ocirc;i gi&agrave;y&rdquo; kiến thức v&agrave; kĩ năng l&agrave; điều chắc chắn. Vậy bạn đ&atilde; biết tự tạo SEO cho website của m&igrave;nh chưa? H&atilde;y c&ugrave;ng Chili qua từng bước của qu&aacute; tr&igrave;nh l&agrave;m SEO website để bạn c&oacute; sự h&igrave;nh dung đầu ti&ecirc;n về lĩnh vực n&agrave;y.</p>

<p><br />
<img alt="Tu Tao SEO Cho Website Cua Minh" src="https://camhungkinhdoanh.chili.vn/getattachment/a127ff09-9cff-43d1-82f3-ddda71ad2f20/19-Quan_ly_van_hanh_anh_01.jpg.aspx" title="Tự Tạo SEO Cho Website Của Mình" /><br />
<em>Tự tạo SEO cho website &ndash; Bạn đ&atilde; sẵn s&agrave;ng?</em></p>

<h2><strong>Từ kh&oacute;a</strong></h2>

<p>Kh&ocirc;ng c&oacute; từ kh&oacute;a th&igrave; chẳng thể n&agrave;o SEO website được. V&igrave; thế, việc l&agrave;m đầu ti&ecirc;n của bạn ch&iacute;nh l&agrave; t&igrave;m từ kh&oacute;a cho website của m&igrave;nh. Một c&aacute;ch đơn giản để c&oacute; được danh s&aacute;ch từ kh&oacute;a li&ecirc;n quan đến website của bạn l&agrave; sử dụng Google Keyword Planner. Sau khi c&oacute; một số gợi &yacute; từ kh&oacute;a hiện tại, bạn đi v&agrave;o ph&acirc;n t&iacute;ch hiệu quả sử dụng của ch&uacute;ng. H&atilde;y c&oacute; kế hoạch kh&ocirc;n ngoan giữa từ kh&oacute;a rộng v&agrave; từ kh&oacute;a đu&ocirc;i d&agrave;i (V&iacute; dụ: chả c&aacute; ngon l&agrave; từ kh&oacute;a rộng trong khi chả c&aacute; ngon B&igrave;nh Định lại l&agrave; từ kh&oacute;a đu&ocirc;i d&agrave;i) dựa tr&ecirc;n những ti&ecirc;u chuẩn: lượng t&igrave;m kiếm, sự ph&ugrave; hợp, thứ hạng v&agrave; ước t&iacute;nh độ kh&oacute; để đạt được thứ hạng cao của từ kh&oacute;a. Từ những ti&ecirc;u chuẩn n&agrave;y, bạn c&oacute; thể chọn ra từ kh&oacute;a tốt cho m&igrave;nh.</p>

<h2><strong>Tối ưu h&oacute;a tr&ecirc;n trang</strong></h2>

<p>Trước khi quyết định &ldquo;xuất khẩu&rdquo; website ra ngo&agrave;i, bạn cần phải đảm bảo rằng mọi thứ đ&atilde; thực sự ho&agrave;n hảo. H&atilde;y d&agrave;nh thời gian đầu để kiểm tra xem từ đề mục đến h&igrave;nh ảnh đ&atilde; đ&aacute;p ứng chuẩn SEO chưa. C&aacute;c thẻ ti&ecirc;u đề, c&aacute;c thẻ meta description, c&aacute;c thẻ meta keyword, nội dung th&acirc;n trang, c&aacute;c thẻ H, URL, lading page, cấu tr&uacute;c website đều c&oacute; những quy tắc nhất định. V&agrave;, bạn cần t&igrave;m hiểu tất cả những điều n&agrave;y để website của m&igrave;nh đảm bảo đ&uacute;ng ti&ecirc;u chuẩn để &ldquo;xuất khẩu&rdquo;&nbsp; v&agrave; đạt thứ hạng cao.</p>

<h2><strong>Nội dung</strong></h2>

<p>Nội dung cần c&oacute; từ kh&oacute;a l&agrave; điều tất nhi&ecirc;n từ từ kh&oacute;a ch&iacute;nh đến từ kh&oacute;a phụ nhưng bố tr&iacute; ch&uacute;ng như thế n&agrave;o, mật độ ra sao th&igrave; bạn cần phải suy x&eacute;t cẩn trọng. Đừng cố nhồi nhết từ kh&oacute;a một c&aacute;ch v&ocirc; nghĩa. Thay v&agrave;o đ&oacute;, bạn h&atilde;y tập trung x&acirc;y dựng nội dung thật sự độc đ&aacute;o, hấp dẫn, mới lạ v&agrave; thể hiện được sự kh&aacute;c biệt của bạn so với những đối thủ kh&aacute;c.<br />
Ngo&agrave;i ra, bạn cần chăm chỉ cập nhật nội dung của m&igrave;nh li&ecirc;n tục mỗi ng&agrave;y nếu muốn Google ch&uacute; &yacute; để n&acirc;ng cao thứ hạng website của bạn. Nếu kh&ocirc;ng c&oacute; thời gian cập nhật nội dung thường xuy&ecirc;n, bạn c&oacute; thể sử dụng tiện &iacute;ch Tin tức từ Chili để hỗ trợ c&ocirc;ng việc của m&igrave;nh.</p>

<h2><strong>Li&ecirc;n kết</strong></h2>

<p>Khi tất cả đ&atilde; sẵn s&agrave;ng, bạn đ&atilde; c&oacute; thể bắt đầu &ldquo;xuất khẩu&rdquo; &nbsp;website. Đầu ti&ecirc;n, bạn c&oacute; thể chia sẻ nội dung website l&ecirc;n c&aacute;c trang mạng x&atilde; hội để thu h&uacute;t sự ch&uacute; &yacute;.<br />
Thứ hai, bạn h&atilde;y tạo dựng mối li&ecirc;n hệ với c&aacute;c website c&oacute; li&ecirc;n quan đến lĩnh vực m&igrave;nh kinh doanh v&agrave; trao đổi li&ecirc;n kết với nhau. Ngo&agrave;i ra, bạn cũng c&oacute; thể mua li&ecirc;n kết từ c&aacute;c website &nbsp;đ&aacute;ng tin cậy để gia tặng độ uy t&iacute;n của m&igrave;nh hơn. Để kiểm tra độ uy t&iacute;n cao hay thấp, bạn c&oacute; thể sử dụng c&ocirc;ng cụ SEOMoz Toolbar để kiểm tra chỉ số DA (Domain Authority) của trang bạn nhắm đến. Bạn c&agrave;ng tạo nhiều mối li&ecirc;n kết c&agrave;ng tốt nhưng quan trọng l&agrave;, c&aacute;c trang n&agrave;y phải thật sự li&ecirc;n quan đến sản phẩm v&agrave; dịch vụ của bạn.</p>

<h2><strong>Đường dẫn th&acirc;n thiện</strong></h2>

<p>Đường dẫn th&acirc;n thiện gi&uacute;p mọi người c&oacute; thể dễ d&agrave;ng nắm bắt hay đo&aacute;n được đại &yacute; chủ đề trước khi họ ch&iacute;nh thức nhấp chuột v&agrave;o URL. Vậy l&agrave;m thế n&agrave;o để tạo được đường dẫn th&acirc;n thiện? Đường dẫn th&acirc;n thiện sẽ đi k&egrave;m từ kh&oacute;a hoặc ti&ecirc;u đề của trang nội dung gi&uacute;p người xem nhận diện được vấn đề ngay từ đầu. Chẳng hạn như, đường dẫn như thế n&agrave;y:&nbsp;<a href="https://camhungkinhdoanh.chili.vn/Thu-Suc-Voi-Nhung-Y-Tuong-Kinh-Doanh-Khong-Can-Von.aspx">https://epm.vn/Thu-Suc-Voi-Nhung-Y-Tuong-Kinh-Doanh-Khong-Can-Von.aspx</a>&nbsp;được xem l&agrave; một URL th&acirc;n thiện truyền tải được nội dung th&ocirc;ng điệp đến người xem ngay từ đầu thay v&igrave; cả mớ b&ograve;ng bong lằng nhằng số, chữ hay k&iacute; tự đặc biệt kh&oacute; hiểu. H&atilde;y ch&uacute; &yacute; đến điều n&agrave;y nếu muốn SEO hiệu quả website của bạn!</p>

<h2><strong>C&ocirc;ng cụ ph&acirc;n t&iacute;ch</strong></h2>

<p>Sau khi đ&atilde; thưc hiện SEO cho website, bạn cần phải c&oacute; c&ocirc;ng cụ đ&aacute;nh gi&aacute; hiệu quả t&aacute;c động của những việc m&igrave;nh l&agrave;m để hoạch định bước tiếp theo ch&iacute;nh x&aacute;c hơn. V&agrave;, Google Analytics l&agrave; c&ocirc;ng cụ hữu hiệu để gi&uacute;p bạn thực hiện điều n&agrave;y. Để k&iacute;ch hoạt hoạt động của Google Analytics, bạn cần c&agrave;i m&atilde; theo d&otilde;i v&agrave;o website của bạn. Dữ liệu ph&acirc;n t&iacute;ch từ Google Analytics cực k&igrave; chi tiết sẽ gi&uacute;p bạn c&oacute; c&aacute;i nh&igrave;n to&agrave;n diện hơn về kết quả của m&igrave;nh.</p>

<p><br />
<img alt="Tu Tao SEO Cho Website Cua Minh" src="https://camhungkinhdoanh.chili.vn/getattachment/Bi-quyet-kinh-doanh/quan-ly-va-van-hanh/Tu-Tao-SEO-Cho-Website-Cua-Minh-(1)/19-Quan_ly_van_hanh_anh-02.png.aspx" title="Tự Tạo SEO Cho Website Của Mình" /></p>

<p><em>Sử dụng c&aacute;c c&ocirc;ng cụ đo lường để kiểm tra chất lượng nội dung của m&igrave;nh</em></p>

<p>Bạn chẳng thể n&agrave;o SEO website hiệu quả nếu thiếu kiến thức về lĩnh vực n&agrave;y. V&agrave; th&agrave;nh c&ocirc;ng chẳng bao giờ đến đối với người ngừng học hỏi. H&atilde;y trang bị c&agrave;ng sớm c&agrave;ng tốt kiến thức về SEO v&agrave; bắt đầu trải nghiệm tiện &iacute;ch quảng c&aacute;o của epm tại link:&nbsp;<a href="https://www.chili.vn/ung-dung/marketing-seo/seo-68">https://www.e</a>pm.vn. Từ cấu h&igrave;nh đường dẫn chuẩn SEO, hỗ trợ SEO đa ng&ocirc;n ngữ, b&aacute;o c&aacute;o lỗi SEO đến t&ugrave;y chỉnh cấu h&igrave;nh thẻ title v&agrave; meta, bạn sẽ nhận những trải nghiệm hữu &iacute;ch trong việc SEO website. Tuy nhi&ecirc;n, để tận dụng tối đa những chức năng từ tiện &iacute;ch n&agrave;y, bạn h&atilde;y bắt đầu t&igrave;m hiểu về SEO ngay b&acirc;y giờ!&nbsp;</p>
', NULL, N'tu-tao-seo-cho-website-cua-minh', NULL, NULL, NULL, NULL, NULL, NULL, N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3414, 3208, 2, N'Tự Tạo SEO Cho Website Của Mình', N'Đứng trước cơ hội vàng trong thời kỳ phát triển hưng thịnh của Internet, lại có máu kinh doanh trong người, nhiều nhà khởi nghiệp có tuổi đời còn rất trẻ đã bắt đầu gia nhập ngành. Những website bán hàng ồ ạt xuất hiện nhưng trong số chúng, bao nhiêu còn, bao nhiêu mất và bao nhiêu đang chờ chết? ', NULL, NULL, N'tu-tao-seo-cho-website-cua-minh', NULL, NULL, NULL, NULL, NULL, NULL, N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình', N'Tự Tạo SEO Cho Website Của Mình')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3415, 3209, 1, N'Sản xuất rượu', N'Sản xuất rượu', NULL, NULL, N'san-xuat-ruou', NULL, NULL, NULL, NULL, NULL, NULL, N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3416, 3209, 2, N'Sản xuất rượu', N'Sản xuất rượu', NULL, NULL, N'san-xuat-ruou', NULL, NULL, NULL, NULL, NULL, NULL, N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu', N'Sản xuất rượu')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3417, 3210, 1, N'siêu thị máy tính', N'siêu thị máy tính', NULL, NULL, N'sieu-thi-may-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3418, 3210, 2, N'siêu thị máy tính', N'siêu thị máy tính', NULL, NULL, N'sieu-thi-may-tinh', NULL, NULL, NULL, NULL, NULL, NULL, N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính', N'siêu thị máy tính')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3419, 3211, 1, N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', NULL, NULL, N'shop-my-pham-hot', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot')
GO
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3420, 3211, 2, N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', NULL, NULL, N'shop-my-pham-hot', NULL, NULL, NULL, NULL, NULL, NULL, N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot', N'Shop mỹ phẩm hot')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3421, 3212, 1, N'BREAKFAST', N'BREAKFAST', N'<p>Shop mỹ phẩm v&agrave; phụ liệu t&oacute;c</p>
', NULL, N'breakfast', NULL, NULL, NULL, NULL, NULL, NULL, N'BREAKFAST', N'BREAKFAST', N'BREAKFAST', N'BREAKFAST', N'BREAKFAST', N'BREAKFAST')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3422, 3212, 2, N'Shop mỹ phẩm và phụ liệu tóc', N'Shop mỹ phẩm và phụ liệu tóc', NULL, NULL, N'shop-my-pham-va-phu-lieu-toc', NULL, NULL, NULL, NULL, NULL, NULL, N'BREAKFAST', N'BREAKFAST', N'Shop mỹ phẩm và phụ liệu tóc', N'Shop mỹ phẩm và phụ liệu tóc', N'Shop mỹ phẩm và phụ liệu tóc', N'Shop mỹ phẩm và phụ liệu tóc')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3423, 3213, 1, N'shop đồng hồ', N'shop đồng hồ', NULL, NULL, N'shop-dong-ho', NULL, NULL, NULL, NULL, NULL, NULL, N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3424, 3213, 2, N'shop đồng hồ', N'shop đồng hồ', NULL, NULL, N'shop-dong-ho', NULL, NULL, NULL, NULL, NULL, NULL, N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ', N'shop đồng hồ')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3425, 3214, 1, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', NULL, NULL, N'shop-my-pham-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3426, 3214, 2, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', NULL, NULL, N'shop-my-pham-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3427, 3215, 1, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', NULL, NULL, N'shop-my-pham-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3428, 3215, 2, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', NULL, NULL, N'shop-my-pham-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện', N'shop mỹ phẩm phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3429, 3216, 1, N'quần áo thời trang', N'quần áo thời trang', NULL, NULL, N'quan-ao-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3430, 3216, 2, N'quần áo thời trang', N'quần áo thời trang', NULL, NULL, N'quan-ao-thoi-trang', NULL, NULL, NULL, NULL, NULL, NULL, N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang', N'quần áo thời trang')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3431, 3217, 1, N'thời trang phụ kiện', N'thời trang phụ kiện', NULL, NULL, N'thoi-trang-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3432, 3217, 2, N'thời trang phụ kiện', N'thời trang phụ kiện', NULL, NULL, N'thoi-trang-phu-kien', NULL, NULL, NULL, NULL, NULL, NULL, N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện', N'thời trang phụ kiện')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3433, 3218, 1, N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', NULL, NULL, N'trung-tam-tu-van-dao-tao', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3434, 3218, 2, N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', NULL, NULL, N'trung-tam-tu-van-dao-tao', NULL, NULL, NULL, NULL, NULL, NULL, N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo', N'Trung tâm tư vấn đào tạo')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3435, 3219, 1, N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', NULL, NULL, N'my-pham-lam-dep', NULL, NULL, NULL, NULL, NULL, NULL, N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3436, 3219, 2, N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', NULL, NULL, N'my-pham-lam-dep', NULL, NULL, NULL, NULL, NULL, NULL, N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp', N'Mỹ phẩm làm đẹp')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3437, 3220, 1, N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', NULL, NULL, N'trang-diem-nganh-toc', NULL, NULL, NULL, NULL, NULL, NULL, N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3438, 3220, 2, N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', NULL, NULL, N'trang-diem-nganh-toc', NULL, NULL, NULL, NULL, NULL, NULL, N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc', N'Trang điểm ngành tóc')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3439, 3221, 1, N'chủ đầu tư dự án', N'chủ đầu tư dự án', NULL, NULL, N'chu-dau-tu-du-an', NULL, NULL, NULL, NULL, NULL, NULL, N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3440, 3221, 2, N'chủ đầu tư dự án', N'chủ đầu tư dự án', NULL, NULL, N'chu-dau-tu-du-an', NULL, NULL, NULL, NULL, NULL, NULL, N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3441, 3222, 1, N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', NULL, NULL, N'chu-dau-tu-du-an-1', NULL, NULL, NULL, NULL, NULL, NULL, N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3442, 3222, 2, N'chủ đầu tư dự án', N'chủ đầu tư dự án', NULL, NULL, N'chu-dau-tu-du-an', NULL, NULL, NULL, NULL, NULL, NULL, N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án 1', N'chủ đầu tư dự án', N'chủ đầu tư dự án', N'chủ đầu tư dự án')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3443, 3223, 1, N'Thông tin bất động sản', N'Thông tin bất động sản', NULL, NULL, N'thong-tin-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3444, 3223, 2, N'Thông tin bất động sản', N'Thông tin bất động sản', NULL, NULL, N'thong-tin-bat-dong-san', NULL, NULL, NULL, NULL, NULL, NULL, N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản', N'Thông tin bất động sản')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3445, 3224, 1, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', NULL, NULL, N'phan-mem-quan-ly-ban-hang-pos', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3446, 3224, 2, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', NULL, NULL, N'phan-mem-quan-ly-ban-hang-pos', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3447, 3225, 1, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'<p align="center"><strong>TH&Ocirc;NG TIN VỀ C&Ocirc;NG TY</strong></p>

<ul>
	<li>C&ocirc;ng ty <strong>CP C&ocirc;ng Nghệ EPM</strong> l&agrave; một trong những c&ocirc;ng ty c&oacute; bề d&agrave;y kinh nghiệm về tư vấn, thiết kế c&aacute;c giải ph&aacute;p quản l&yacute; b&aacute;n h&agrave;ng như: c&aacute;c nh&agrave; h&agrave;ng, cafe, fastfood, qu&aacute;n ăn, bar, karaoke, bida, c&aacute;c shop thời trang, giầy d&eacute;p, si&ecirc;u thị mini, nh&agrave; s&aacute;ch, Spa&hellip;, c&aacute;c resort, kh&aacute;ch sạn v&agrave; nhiều lọai h&igrave;nh kinh doanh b&aacute;n h&agrave;ng.</li>
</ul>

<p style="margin-left:31.5pt;">&nbsp;</p>

<ul>
	<li>C&aacute;c nh&acirc;n sự c&oacute; tr&ecirc;n 10 năm kinh nghiệm tư vấn, thiết kế giải ph&aacute;p cũng như c&aacute;c lập tr&igrave;nh vi&ecirc;n hệ thống. Hiện c&ocirc;ng ty ch&uacute;ng t&ocirc;i đang ph&aacute;t triển, h&ograve;an thiện t&iacute;ch hợp ph&acirc;n hệ quản l&yacute; b&aacute;n h&agrave;ng với ph&acirc;n hệ kế t&oacute;an th&agrave;nh một quy tr&igrave;nh kh&eacute;p k&iacute;n. Đơn giản h&oacute;a c&aacute;c số liệu cũng như c&aacute;c quy tr&igrave;nh qu&aacute; phức tạp xưa cũ. R&uacute;t ngắn c&aacute;c c&ocirc;ng đọan nhập liệu, chuyển h&oacute;a số liệu của c&aacute;c bộ phận c&oacute; li&ecirc;n quan.</li>
</ul>

<p style="margin-left:31.5pt;">&nbsp;</p>

<ul>
	<li>Chiến lược mục ti&ecirc;u: Lu&ocirc;n lu&ocirc;n ch&uacute; trọng chăm s&oacute;c, phục vụ kh&aacute;ch h&agrave;ng chu đ&aacute;o. Đầu tư nguồn nh&acirc;n lực cốt l&otilde;i, ổn định, lu&ocirc;n lu&ocirc;n sử dụng c&aacute;c c&ocirc;ng nghệ mới nhằm ph&aacute;t triển c&aacute;c t&iacute;nh năng phần mềm vượt trội. Kết hợp nhiều giải ph&aacute;p quản l&yacute; để đưa ra giải ph&aacute;p tổng thể ho&agrave;n chỉnh, tiết giảm, r&uacute;t ngắn c&aacute;c c&ocirc;ng đoạn quản l&yacute;, tiết kiệm ph&iacute; quản l&yacute; hệ thống đến mức tối đa, đảm bảo hệ thống quản l&yacute; tốt, hiệu quả theo y&ecirc;u cầu của kh&aacute;ch h&agrave;ng.</li>
</ul>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p align="center"><strong>C&Aacute;C ĐIỂM NỔI BẬT CỦA PHẦN MỀM ReliPos</strong></p>

<p>&nbsp;</p>

<ul>
	<li>Sử dụng c&ocirc;ng nghệ mới nhất hiện nay.</li>
	<li><strong>Order bằng Ipad, thiết bị di động.</strong></li>
	<li>Thao t&aacute;c b&aacute;n h&agrave;ng đơn giản, ngắn gọn, nhanh ch&oacute;ng.</li>
	<li>Giao diện đa ng&ocirc;n ngữ, th&acirc;n thiện, dể sử dụng tr&ecirc;n c&aacute;c thiết bị cảm ứng.</li>
	<li>Dể d&agrave;ng tương th&iacute;ch với c&aacute;c thiết bị phần cứng kh&aacute;c như <strong>Laptop, Ipad...</strong></li>
	<li>Bảo mật, tối ưu ho&aacute; dữ liệu.</li>
	<li>Cơ chế back-up (sao lưu) tự động theo lịch tr&igrave;nh chặt chẽ.</li>
	<li>Hệ thống b&aacute;o c&aacute;o quản trị, b&aacute;o c&aacute;o thuế cập nhật li&ecirc;n tục.</li>
	<li>Kết nối cơ sở dữ liệu qua mạng internet dể d&agrave;ng, kh&ocirc;ng phụ thuộc v&agrave;o phần mềm c&agrave;i đặt.</li>
	<li>Ph&acirc;n quyền chi tiết từng ph&iacute;m chức năng.</li>
	<li>Khả năng mở rộng, n&acirc;ng cấp hệ thống dể d&agrave;ng.</li>
	<li>ReliPos l&agrave; giải ph&aacute;p tổng thể t&iacute;ch hợp nhiều ph&acirc;n hệ quản l&yacute; k&eacute;p k&iacute;n.</li>
	<li>Dễ d&agrave;ng kết nối với c&aacute;c Phần Mềm Kế To&aacute;n kh&aacute;c.</li>
</ul>

<p align="center"><strong>T&iacute;nh Năng Phần Mềm Quản L&yacute; Chuỗi Nh&agrave; H&agrave;ng, Cafe, Kem, Bar </strong><strong>ReliPos</strong></p>

<p><strong>C&aacute;c Ph&acirc;n Hệ Ch&iacute;nh:</strong></p>

<ol>
	<li><strong>Xử l&yacute; số liệu mạng internet.</strong></li>
</ol>

<p align="center" style="margin-left:9.0pt;"><strong><img height="489" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image003.jpg" width="618" /></strong></p>

<ul>
	<li>Tất cả dữ liệu được tự động cập nhật v&agrave; lưu trữ tại m&aacute;y chủ th&ocirc;ng qua mạng internet.</li>
	<li>C&oacute; thể xem số liễu qua mạng bằng: Ipad, laptop, PC,&hellip;m&agrave; kh&ocirc;ng phụ thuộc v&agrave;o chương tr&igrave;nh c&agrave;i đặt.</li>
	<li>Khi c&oacute; sự cố về đường truyền mạng th&igrave; dữ liệu tạm thời được lưu trữ tại m&aacute;y chi nh&aacute;nh. C&aacute;c hoạt động b&aacute;n h&agrave;ng tại c&aacute;c chi nh&aacute;nh dẫn hoạt động b&igrave;nh thường. Khi sự cố mạng được khắc phục xong th&igrave; m&aacute;y chủ tự động cập nhật lại tất cả c&aacute;c th&ocirc;ng tin chưa cập nhật.</li>
</ul>

<ol>
	<li value="2"><strong>Sơ đồ hệ thống hoạt động.</strong></li>
</ol>

<p align="center" style="margin-left:9.0pt;"><strong><img height="483" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image005.jpg" width="605" /></strong></p>

<p align="center" style="margin-left:9.0pt;">&nbsp;</p>

<ol>
	<li value="3"><strong>Quản l&yacute; danh mục </strong></li>
</ol>

<ul>
	<li>Danh mục h&agrave;ng b&aacute;n, c&aacute;c mặt h&agrave;ng khuyến m&atilde;i, nh&oacute;m h&agrave;ng (02 cấp).</li>
	<li>Danh mục nguy&ecirc;n vật liệu.</li>
	<li>Danh mục c&aacute;c mặt h&agrave;ng quản l&yacute; tồn kho.</li>
	<li>Danh mục nh&oacute;m h&agrave;ng (02 cấp).</li>
	<li>Danh mục b&agrave;n, ph&ograve;ng, khu vực.</li>
	<li>Danh mục nh&acirc;n vi&ecirc;n thu ng&acirc;n, nh&acirc;n vi&ecirc;n phục vụ.</li>
	<li>Danh mục quầy, ca b&aacute;n.</li>
	<li>Danh mục kh&aacute;ch h&agrave;ng th&acirc;n thiết.</li>
	<li>Danh mục tiền tệ.</li>
	<li>Danh mục ghi ch&uacute; order.</li>
</ul>

<ol>
	<li value="4"><strong>C&aacute;c t&iacute;nh năng quản l&yacute; b&aacute;n h&agrave;ng( Menu ch&iacute;nh)</strong></li>
</ol>

<p align="center" style="margin-left:.5in;"><strong><img height="315" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image007.jpg" width="641" /></strong></p>

<ol style="list-style-type:lower-alpha;">
	<li><strong>T&iacute;nh năng thao t&aacute;c b&aacute;n h&agrave;ng</strong></li>
</ol>

<ul>
	<li>Thiết kế chức năng b&aacute;n h&agrave;ng theo giao diện cảm ứng t&iacute;ch hợp với việc sử dụng thiết bị đọc m&atilde; vạch gi&uacute;p nh&acirc;n vi&ecirc;n thu ng&acirc;n thực hiện thao t&aacute;c t&iacute;nh tiền nhanh ch&oacute;ng, đơn giản, dễ sử dụng.</li>
	<li>Chức năng giao diện đa ng&ocirc;n ngữ.</li>
	<li>Chức năng b&aacute;n h&agrave;ng theo nh&agrave; h&agrave;ng, caf&eacute;, qu&aacute;n ăn, Karaoke, b&aacute;n lẻ theo m&atilde; vạch, v&agrave; nhiều m&ocirc; h&igrave;nh kinh doanh tr&ecirc;n c&ugrave;ng ph&acirc;n hệ.</li>
	<li>Chức năng quản l&yacute; khu vực b&agrave;n, ph&ograve;ng (kh&ocirc;ng giới hạn).</li>
	<li>Chức năng mở b&agrave;n, gh&eacute;p b&agrave;n, t&aacute;ch b&agrave;n, chuyển b&agrave;n, tạm t&iacute;nh.</li>
	<li>Chức năng them m&oacute;n, x&oacute;a m&oacute;n, ghi ch&uacute; bếp.</li>
	<li>Chức năng trả lại trước khi thanh to&aacute;n, sau khi thanh to&aacute;n c&oacute; ph&acirc;n quyền/cấp bậc.</li>
	<li>Chức năng giảm gi&aacute; theo phần trăm, theo số tiền tr&ecirc;n từng m&oacute;n h&agrave;ng, nh&oacute;m h&agrave;ng v&agrave; tr&ecirc;n tổng bill.</li>
	<li>Chức năng giảm gi&aacute; tự động hay bằng tay t&ugrave;y chọn.</li>
	<li>Chức năng phụ thu, t&iacute;nh VAT tự động theo nhiều mức định trước.</li>
	<li>Chức năng quản l&yacute; h&agrave;ng b&aacute;n, nh&oacute;m h&agrave;ng, h&agrave;ng khuyến m&atilde;i, h&agrave;ng tặng k&egrave;m (kh&ocirc;ng giới hạn).</li>
	<li>Chức năng hủy phiếu, kh&oacute;a m&agrave;n h&igrave;nh, in lại phiếu xuống bếp, xuất h&oacute;a đơn, in phiếu c&uacute;p điện, điều chỉnh b&agrave;n.</li>
	<li>Quản l&yacute; nhiều mức gi&aacute; b&aacute;n theo ng&agrave;y/giờ, tự động chuyển gi&aacute; theo ng&agrave;y/giờ định trước (kh&ocirc;ng giới hạn).</li>
	<li>Chức năng quản l&yacute; số lượng thực kh&aacute;ch, kh&aacute;ch h&agrave;ng, nh&oacute;m kh&aacute;ch h&agrave;ng, t&ecirc;n c&ocirc;ng ty, địa chỉ, m&atilde; số thuế, t&ecirc;nnh&acirc;n vi&ecirc;n phục vụ theo order.</li>
	<li>Chức năng quản l&yacute; số lần in tr&ecirc;n từng phiếu, quy định số lần in phiếu tối đa.</li>
</ul>

<ul>
	<li>Chức năng hiển thi chi tiết m&oacute;n order theo c&aacute;c trạng th&aacute;i: chưa l&agrave;m, đang l&agrave;m, l&agrave;m xong, trả h&agrave;ng, hết h&agrave;ng, kh&ocirc;ng sử l&yacute;.</li>
	<li>Quản l&yacute; Thu/Chi.</li>
	<li>Chức năng quản l&yacute; lịch sử b&aacute;n h&agrave;ng.</li>
	<li>Chức năng quản l&yacute; tiền đặt cọc.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="2"><strong>Chức năng order m&oacute;n, kiểm tra m&oacute;n bằng Ipad, Tablet, thiết bị di động: </strong></li>
</ol>

<p align="center" style="margin-left:45.0pt;"><strong><img height="520" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image009.gif" width="352" /></strong></p>

<ul>
	<li>Quản l&yacute; order m&oacute;n: d&agrave;nh cho phục vụ</li>
</ul>

<ul>
	<li>Chức năng mở b&agrave;n, chọn khu vực, chọn b&agrave;n, chọn m&oacute;n, gh&eacute;p b&agrave;n, t&aacute;ch b&agrave;n, chuyển b&agrave;n, tạm t&iacute;nh, th&ecirc;m m&oacute;n, x&oacute;a m&oacute;n, ghi ch&uacute; bếp.</li>
	<li>Quản l&yacute; kh&ocirc;ng giới hạn b&agrave;n, kh&ocirc;ng giới hạn m&oacute;n nhờ v&agrave;o thanh trượt tr&ecirc;n Ipad, tablet.</li>
	<li>In Docket summary: in tổng m&oacute;n t&ecirc;n b&agrave;n.</li>
	<li>In Table summary: in phiếu để kh&aacute;ch h&agrave;ng kiểm tra m&oacute;n đ&atilde; ăn, điền c&aacute;c th&ocirc;ng tin xuất h&oacute;a đơn v&agrave; sử dụng c&aacute;c dịch vụ kh&aacute;c.</li>
	<li>Kiểm tra m&oacute;n l&ecirc;n rồi hay chưa l&ecirc;n, thời gian bao l&acirc;u sẽ l&ecirc;n m&oacute;n kế tiếp.</li>
	<li>Check trạng th&aacute;i kh&aacute;ch đang ngồi hay đ&atilde; về.</li>
</ul>

<ul>
	<li>Chức năng Hotess: d&agrave;nh cho tiếp t&acirc;n</li>
</ul>

<ul>
	<li>Tiếp t&acirc;n c&oacute; thể kiểm tra b&agrave;n xem m&oacute;n order cuối c&ugrave;ng l&uacute;c mấy giờ ?</li>
	<li>B&agrave;n trống m&agrave;u xanh lơ.</li>
	<li>B&agrave;n c&oacute; kh&aacute;ch m&agrave;u cam.</li>
	<li>B&agrave;n đ&atilde; dung hết m&oacute;n m&agrave;u xanh l&aacute;.</li>
	<li>B&agrave;n đ&atilde; thanh to&aacute;n tiền nhưng kh&aacute;ch chưa về m&agrave;u xanh dương.</li>
	<li>Tất cả c&aacute;c trạng th&aacute;i tr&ecirc;n gi&uacute;p cho tiếp t&acirc;n đ&oacute;n kh&aacute;ch v&agrave; hướng dẫn kh&aacute;ch một c&aacute;ch dể d&agrave;ng.</li>
</ul>

<ul>
	<li>Quản l&yacute; bếp: d&agrave;nh cho chế biến (c&oacute; thể ph&acirc;n chia nhiều bếp, bar)</li>
</ul>

<ul>
	<li>Định lượng được thời gian ho&agrave;n tất m&oacute;n (hổ trợ tiếp t&acirc;n v&agrave; phục vụ th&ocirc;ng b&aacute;o kh&aacute;ch h&agrave;ng khi cần.</li>
	<li>Cho ph&eacute;p quầy chế biến check m&oacute;n đang l&agrave;m, l&agrave;m xong, hết h&agrave;ng, th&ecirc;m thời gian ho&agrave;n tất m&oacute;n 5 ph&uacute;t, 10 ph&uacute;t, 15 ph&uacute;t,&hellip;</li>
	<li>Thể hiện trạng th&aacute;i đổi m&agrave;u đối với c&aacute;c m&oacute;n bị l&agrave;m trể.</li>
	<li>Khi m&oacute;n được check đ&atilde; l&agrave;m xong th&igrave; m&oacute;n đ&oacute; tự ẩn đi.</li>
	<li>C&oacute; thể xem chi tiết lịch sử to&agrave;n bộ qu&aacute; tr&igrave;nh chế biến c&aacute;c m&oacute;n ăn.</li>
</ul>

<ul>
	<li>Chức năng cảnh b&aacute;o hết h&agrave;ng:</li>
</ul>

<ul>
	<li>Bộ phận kho c&oacute; thể check m&oacute;n đ&atilde; hết h&agrave;ng hoặc số lượng c&ograve;n lại l&agrave; bao nhi&ecirc;u ? Điều n&agrave;y gi&uacute;p phục vụ dể d&agrave;ng tư vấn kh&aacute;ch h&agrave;ng khi c&oacute; y&ecirc;u cầu.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="3"><strong>&nbsp;&nbsp;&nbsp;C&aacute;c h&igrave;nh thức thanh to&aacute;n</strong></li>
</ol>

<ul>
	<li>C&aacute;c h&igrave;nh thức thanh to&aacute;n đa dạng, kh&ocirc;ng giới hạn h&igrave;nh thức thanh to&aacute;n trong c&ugrave;ng 1 phiếu.</li>
	<li>Thanh to&aacute;n bằng tiền mặt: VNĐ, USD, ERO, YEN, BATH,&hellip;</li>
	<li>Thanh to&aacute;n bằng thẻ (Visa, Master,Amex,&hellip;).</li>
	<li>Voucher, Coupon theo d&otilde;i số seri từng phiếu đ&atilde; ph&aacute;t h&agrave;nh.</li>
	<li>Thanh to&aacute;n bằng thẻ VIP.</li>
	<li>Chức năng cho kh&aacute;ch nợ.</li>
	<li>Quản l&yacute; tiền TIP, phiếu tiếp kh&aacute;ch.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="4"><strong>C&aacute;c ph&acirc;n quyền b&aacute;n h&agrave;ng</strong></li>
</ol>

<ul>
	<li>C&aacute;c chức năng ph&acirc;n quyền chi tiết tr&ecirc;n từng n&uacute;t chức năng cho Thu Ng&acirc;n, Quản L&yacute; v&agrave; bộ phận kế to&aacute;n.</li>
	<li>Ph&acirc;n quyền r&otilde; c&aacute;c chức năng: hủy phiếu, trả lại, giảm gi&aacute; sau khi thanh to&aacute;n.</li>
	<li>Ph&acirc;n quyền chức năng tiếp kh&aacute;ch, xem c&aacute;c b&aacute;o c&aacute;o.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="5"><strong>Quản l&yacute; order bếp tr&ecirc;n Tablet, LCD TV khổ lớn</strong></li>
</ol>

<p align="center" style="margin-left:4.5pt;"><strong><img height="253" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image011.jpg" width="496" /></strong></p>

<ul>
	<li>Thể hiện trạng th&aacute;i từng m&oacute;n chưa l&agrave;m,đang l&agrave;m, trả lại, kh&ocirc;ng xử l&yacute;, hết h&agrave;ng.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="6"><strong>Ph&acirc;n Hệ Times Service: d&ugrave;ng cho Karaoke, Bida, S&acirc;n Gold, Kh&aacute;ch Sạn,&hellip;</strong></li>
</ol>

<ul>
	<li>Tự đ&ocirc;ng t&iacute;nh tiền giờ theo c&aacute;c mức gi&aacute; v&agrave; muối giờ được định trước.</li>
	<li>Chức năng book ph&ograve;ng, book b&agrave;n: theo d&otilde;i thời gian c&aacute;c ph&ograve;ng, b&agrave;n do kh&aacute;ch h&agrave;ng đặt trước.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="7"><strong>Chức Năng Quản L&yacute; Quy Tr&igrave;nh Giao H&agrave;ng Tận Nơi:</strong></li>
</ol>

<ul>
	<li>Nh&acirc;n vi&ecirc;n trực tổng đ&agrave;i sẽ ghi nhận th&ocirc;ng tin kh&aacute;ch như: t&ecirc;n, địa chỉ, số điện thoại kh&aacute;ch h&agrave;ng, thời gian giao h&agrave;ng, c&aacute;c m&oacute;n h&agrave;ng m&agrave; kh&aacute;ch đặt.</li>
	<li>Sau khi nhận đơn sẽ được chuyển sang bộ phận chuẩn bị, chế biến h&agrave;ng.</li>
	<li>Bộ phận xuất phiếu giao nhận sẽ theo d&otilde;i t&ecirc;n nh&acirc;n vi&ecirc;n giao h&agrave;ng, thời gian nhận h&agrave;ng, h&igrave;nh tứhc thanh to&aacute;n đơn h&agrave;ng.</li>
	<li>Bộ phận thu ng&acirc;n sẽ theo d&otilde;i h&agrave;ng được đi giao hay chưa ? Ph&acirc;n loại phiếu đ&atilde; thanh t&oacute;a hay chưa thanh to&aacute;n.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="8"><strong>Chương Tr&igrave;nh Quản L&yacute; Chăm S&oacute;c Kh&aacute;ch H&agrave;ng</strong></li>
</ol>

<ol style="list-style-type:lower-roman;">
	<li value="5"><strong>Ch&iacute;nh s&aacute;ch giảm gi&aacute;</strong></li>
</ol>

<ul>
	<li>Ch&iacute;nh s&aacute;ch giảm gi&aacute; c&oacute; thể lập tr&igrave;nh được nhờ form lập tr&igrave;nh thiết kế đơn giản, th&ecirc;m, x&oacute;a, sửa c&aacute;c điều kiện giảm gi&aacute; rất dễ d&agrave;ng v&agrave; chi tiết.</li>
	<li>Giảm gi&aacute; theo th&aacute;ng, tuần, ng&agrave;y.</li>
	<li>Giảm gi&aacute; theo thứ trong tuần.</li>
	<li>Giảm gi&aacute; theo giờ.</li>
	<li>Giảm gi&aacute; theo tổng tiền tr&ecirc;n Bill.</li>
	<li>Giảm gi&aacute; theo số lượng mặt hang.</li>
	<li>Giảm gi&aacute; theo m&oacute;n h&agrave;ng quy định trước.</li>
	<li>Tất cả c&aacute;c loại giảm gi&aacute; c&oacute; thể giảm theo % hay theo số tiền tuyệt đối.</li>
	<li>Giảm gi&aacute; theo thẻ VIP, thẻ V&agrave;ng, Bạc, Kim Cương.</li>
	<li>Tự động n&acirc;ng cấp thẻ theo chương tr&igrave;nh thẻ.</li>
</ul>

<ol style="list-style-type:lower-roman;">
	<li value="5"><strong>Quản l&yacute; thẻ VIP</strong></li>
</ol>

<ul>
	<li>Quản l&yacute; danh mục VIP: lưu trữ th&ocirc;ng tin kh&aacute;ch h&agrave;ng, t&ecirc;n, địa chỉ, số điện thoại, email, chức vụ, ng&agrave;nh nghề, sở th&iacute;ch.</li>
	<li>&Aacute;p dụng thẻ VIP, thẻ kh&aacute;ch h&agrave;ng.</li>
	<li>B&aacute;o c&aacute;o doanh thu từng kh&aacute;ch h&agrave;ng.</li>
	<li>T&iacute;ch điểm, tăng hạng cho thẻ VIP kh&aacute;ch h&agrave;ng theo c&aacute;c ch&iacute;nh s&aacute;ch c&oacute; thể tự định nghĩa trước t&ugrave;y &yacute;.</li>
	<li>Mỗi tăng hạng được &aacute;p dụng cho 1ch&iacute;nh s&aacute;ch giảm gi&aacute; tự định nghĩa trước.</li>
	<li>Hệ thống dữ liệu thẻ VIP được cập nhật tr&ecirc;n to&agrave;n hệ thống, &aacute;p dụng cho tất cả c&aacute;c chi nh&aacute;nh m&agrave; kh&aacute;ch h&agrave;ng đến.</li>
</ul>

<ol style="list-style-type:lower-roman;">
	<li value="5"><strong>Chương tr&igrave;nh marketing Online: </strong></li>
</ol>

<ul>
	<li>Chiến dịch email marketing: Tự động gửi th&ocirc;ng tin th&ocirc;ng b&aacute;o ch&uacute;c mừng sinh nhật, thư cảm ơn kh&aacute;ch h&agrave;ng đ&atilde; sử dụng dịch vụ, th&ocirc;ng b&aacute;o n&acirc;ng hạng thẻ VIP, tự động chọn Voucher cho kh&aacute;ch h&agrave;ng, thống k&ecirc; chi tiết lịch sử email qua email.</li>
	<li>Chiến dịch email marketing: Tự động gửi th&ocirc;ng tin th&ocirc;ng b&aacute;o ch&uacute;c mừng sinh nhật, thư cảm ơn kh&aacute;ch h&agrave;ng đ&atilde; sử dụng dịch vụ, th&ocirc;ng b&aacute;o n&acirc;ng hạng thẻ VIP, tự động chọn Voucher cho kh&aacute;ch h&agrave;ng qua SMS.</li>
</ul>

<ol style="list-style-type:lower-roman;">
	<li><strong>Quản l&yacute; Re-coin</strong></li>
</ol>

<ul>
	<li>Khi kh&aacute;ch h&agrave;ng sử dụng dịch vụ sẽ được quy đổi th&agrave;nh tiền theo tỉ lệ v&agrave; được t&iacute;ch lũy v&agrave;o t&agrave;i khoản của kh&aacute;ch h&agrave;ng tr&ecirc;n hệ thống.</li>
	<li>Khi kh&aacute;ch h&agrave;ng đến sử dụng dịch vụ lần sau, kh&aacute;ch h&agrave;ng sẽ được giảm trừ trực tiếp b&agrave;o bill thanh to&aacute;n đ&oacute;. Nếu kh&ocirc;ng th&igrave; sẽ tiếp tục t&iacute;ch lũy v&agrave;o t&agrave;i khoản đ&oacute;.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="10"><strong>Quản l&yacute; thẻ trả trước</strong></li>
</ol>

<ul>
	<li>D&ugrave;ng danh mục thẻ VIP để tạo th&agrave;nh danh mục thẻ trả trước.</li>
	<li>Kh&aacute;ch h&agrave;ng sẽ được nạp v&agrave;o t&agrave;i khoản với mức mệnh gi&aacute; m&agrave; kh&aacute;ch h&agrave;ng mua.</li>
	<li>Mỗi kh&aacute;ch h&agrave;ng được cung cấp m&atilde; PIN, khi thanh to&aacute;n kh&aacute;ch h&agrave;ng sẽ nhập m&atilde; PIN v&agrave;o để đảm bảo t&iacute;nh an to&agrave;n v&agrave; bảo mật.</li>
	<li>Khi kh&aacute;ch h&agrave;ng sử dụng dịch vụ số tiền được trừ dần cho đến mức tối thỉu.</li>
	<li>Khi c&oacute; nhu cầu nạp tiền th&ecirc;m, kh&aacute;ch h&agrave;ng c&oacute; thể đến bất kỳ chi nh&aacute;nh n&agrave;o để nạp tiền v&agrave;o t&agrave;i khoản. Số tiền nạp th&ecirc;m sẽ được cấp nhật l&ecirc;n to&agrave;n hệ thống.</li>
	<li>Kh&aacute;ch h&agrave;ng c&oacute; thể kiễm tra t&agrave;i khoản của m&igrave;nh tại c&aacute;c m&aacute;y trạm của hệ thống.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="11"><strong>Quản l&yacute; quầy xuất h&oacute;a đơn VAT</strong></li>
</ol>

<ul>
	<li>Tại quầy xuất h&oacute;a đơn nh&acirc;n vi&ecirc;n kế to&aacute;n sẽ cập nhật th&ocirc;ng tin kh&aacute;ch h&agrave;ng: t&ecirc;n c&ocirc;ng ty, địa chỉ, MST v&agrave; chọn c&aacute;c số phiếu m&agrave; kh&aacute;ch h&agrave;ng đ&atilde; sử dụng.</li>
	<li>Sau khi kiễm tra xong sẽ cho in h&oacute;a đơn GTGT theo mẫu đ&atilde; đăng k&yacute;.</li>
	<li>H&oacute;a đơn GTGT sẽ in theo chi tiết c&aacute;c mặt h&agrave;ng kh&aacute;ch đ&atilde; chọn hoặc in theo tổng số tiền kh&aacute;ch đ&atilde; sử dụng.</li>
</ul>

<ul>
	<li><strong>Ph&acirc;n hệ gửi rượu d&ugrave;ng cho c&aacute;c qu&aacute;n Bar</strong></li>
</ul>

<ul>
	<li>Quản l&yacute; thẻ gửi rượu, ng&agrave;y gửi.</li>
	<li>Quản l&yacute; t&ecirc;n, th&ocirc;ng tin chủ thẻ.</li>
	<li>Ghi nhận dung t&iacute;ch c&ograve;n lại, nh&acirc;n vi&ecirc;n lập thẻ gửi rượu v&agrave; vị tr&iacute; lưu giữ chai rượu.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="13"><strong>C&aacute;c b&aacute;o c&aacute;o b&aacute;n h&agrave;ng t&ugrave;y chọn theo ca, ng&agrave;y, giờ, theo nh&acirc;n vi&ecirc;n phục vụ</strong></li>
</ol>

<p align="center"><img height="328" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image013.jpg" width="672" /></p>

<ul>
	<li>B&aacute;o c&aacute;o doanh thu tổng thể: tổng doanh thu tiền mặt, tổng tiền h&agrave;ng b&aacute;n, giảm gi&aacute;, ph&iacute; phục vụ, VAT, thu/chi, đặt cọc, VIP, Voucher, Coupon, Thẻ, VNĐ, USD, ERO, Kh&aacute;ch Nợ, Tiếp Kh&aacute;ch.</li>
</ul>

<ul>
	<li>Ph&acirc;n t&iacute;ch doanh thu theo ng&agrave;y, giờ.</li>
	<li>B&aacute;o c&aacute;o doanh thu th&aacute;ng theo biểu đồ điểm.</li>
	<li>B&aacute;o c&aacute;o ca b&aacute;n, tổng hợp b&aacute;o c&aacute;o ca b&aacute;n sau 12 giờ đ&ecirc;m.</li>
	<li>B&aacute;o c&aacute;o chi tiết b&agrave;n, theo d&otilde;i tất cả c&aacute;c giao dịch trong b&agrave;n.</li>
	<li>B&aacute;o c&aacute;o chi tiết m&oacute;n: doanh số m&oacute;n,giảm gi&aacute;, trừ tiền, ph&iacute; phục vụ, VAT, hủy, trả lại, h&agrave;ng b&aacute;n chậm b&aacute;n &iacute;t.</li>
	<li>B&aacute;o c&aacute;o giảm gi&aacute; theo ch&iacute;nh s&aacute;ch.</li>
	<li>B&aacute;o c&aacute;o chi tiết h&oacute;a đơn VAT.</li>
	<li>B&aacute;o c&aacute;o tổng hợp c&aacute;c phiếu hủy, trả lại, kh&aacute;ch nợ.</li>
	<li>B&aacute;o c&aacute;o giao ca.</li>
	<li>B&aacute;o c&aacute;o lịch sử: v&agrave;o/ra ca, thao t&aacute;c phiếu, chuyển b&agrave;n, lịch sử đăng nhập, lịch sử lỗi.</li>
	<li>B&aacute;o c&aacute;o trạng th&aacute;i phiếu để theo d&otilde;i v&agrave; kiễm chứng.</li>
	<li>B&aacute;o c&aacute;o danh s&aacute;ch order theo nh&acirc;n vi&ecirc;n phục vụ.</li>
	<li>B&aacute;o c&aacute;o th&ocirc;ng tin giao h&agrave;ng, danh s&aacute;ch Voucher.</li>
	<li>B&aacute;o c&aacute;o nộp tiền.</li>
	<li>Hỗ trợ xuất dữ liệu sang Excel, PDF,&hellip;</li>
</ul>

<p align="center"><img height="340" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image015.jpg" width="605" /></p>

<ul style="list-style-type:square;">
	<li><strong>Chương Tr&igrave;nh Quản L&yacute; Menu Add-On theo gi&aacute; ưu đ&atilde;i</strong></li>
</ul>

<p style="margin-left:40.5pt;"><strong>V&iacute; dụ: </strong>Trong menu Add-On c&oacute; 8 m&oacute;n k&egrave;m theo gi&aacute; ưu đ&atilde;i l&agrave; 20.000đ/m&oacute;n, c&ograve;n gi&aacute; b&igrave;nh thường l&agrave; 40.000đ/m&oacute;n.</p>

<ul>
	<li>Nếu kh&aacute;ch h&agrave;ng chọn 1 trong c&aacute;c m&oacute;n trong menu Add-On th&igrave; sẽ được hưởng theo gi&aacute; ưu đ&atilde;i đ&iacute;nh k&egrave;m l&agrave; 20.000đ/m&oacute;n.</li>
	<li>Nếu kh&aacute;ch h&agrave;ng chọn c&aacute;c m&oacute;n ngo&agrave;i Menu Add-On th&igrave; c&aacute;c m&oacute;n k&egrave;m theo sẽ được t&iacute;nh gi&aacute; b&igrave;nh thường l&agrave; 40.000đ/m&oacute;n.</li>
	<li>Chức năng nhằm tr&aacute;nh sự nhầm lẩn của NV thu ng&acirc;n khi thao t&aacute;c m&aacute;y, tạo sự c&ocirc;ng bằng cho kh&aacute;ch h&agrave;ng khi sử dụng dịch vụ, thắt chặt quản l&yacute; tr&aacute;nh thất tho&aacute;t h&agrave;ng h&oacute;a li&ecirc;n quan đến Add-On.</li>
</ul>

<ul style="list-style-type:circle;">
	<li><strong>Chương tr&igrave;nh quản l&yacute; quy tr&igrave;nh chế biến m&oacute;n </strong></li>
</ul>

<ul>
	<li>Tại VP trung t&acirc;m c&aacute;c quy tr&igrave;nh chế biến m&oacute;n ăn được cập nhật v&agrave;o hệ thống.</li>
	<li>Ở tại c&aacute;c điểm chi nh&aacute;nh nếu chưa r&otilde; c&aacute;ch chế biến cũng như định lượng của 1 m&oacute;n bất kỳ n&agrave;o đ&oacute; th&igrave; nh&acirc;n vi&ecirc;n bếp c&oacute; thể v&agrave;o hệ thống n&agrave;y để lấy th&ocirc;ng tin c&aacute;ch chế biến v&agrave; định lượng của m&oacute;n đ&oacute;.</li>
	<li>Điều n&agrave;y gi&uacute;p chuẩn h&oacute;a c&aacute;c m&oacute;n ăn về khẩu vị, chất lượng v&agrave; kể cả về h&igrave;nh thức tr&igrave;nh b&agrave;y m&oacute;n đ&oacute;. Tạo n&ecirc;n chuy&ecirc;n nghiệp hơn trong hệ thống kinh doanh của m&igrave;nh.</li>
</ul>

<ol>
	<li value="5"><strong>C&aacute;c t&iacute;nh năng quản l&yacute; kho</strong></li>
</ol>

<ol style="list-style-type:lower-alpha;">
	<li><strong>M&ocirc; h&igrave;nh quản l&yacute; kho tổng thể</strong></li>
</ol>

<ul>
	<li>Tại văn ph&ograve;ng trung t&acirc;m được thiết lập 1 m&aacute;y Server. Tại m&aacute;y n&agrave;y sẽ chứa to&agrave;n bộ c&aacute;c dữ liệu của c&aacute;c chi nh&aacute;nh.</li>
	<li>Tất c&aacute;c số liệu được truyền nhận hai chiều từ m&aacute;y trung t&acirc;m đến m&aacute;y m&aacute;y nh&aacute;nh v&agrave; ngược lại.</li>
	<li>C&aacute;c số liệu về kho c&oacute; thể truyền nhận qua lại giữa c&aacute;c chi nh&aacute;nh như: xuất kho nội bộ, đổi trả h&agrave;ng, lu&acirc;n chuyển h&agrave;ng h&oacute;a giữa c&aacute;c kho.</li>
</ul>

<p align="center" style="margin-left:63.0pt;"><img height="431" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image017.jpg" width="509" /></p>

<ol style="list-style-type:lower-alpha;">
	<li value="2"><strong>M&ocirc; h&igrave;nh quản l&yacute; kho nội bộ đa cấp</strong></li>
</ol>

<ul>
	<li>Tại chi nh&aacute;nh sẽ thiết lập hệ thống quản l&yacute; kho bao gồm: 1 kho tổng v&agrave; c&aacute;c kho cấp 2 như kho bếp, kho Bar 1, khoo Bar 2, kho bia nước giải kh&aacute;t.</li>
	<li>Kho tổng sẽ điều phối tất cả c&aacute;c số liệu xuống kho cấp 2.</li>
</ul>

<ul>
	<li>Ngo&agrave;i ra trong một số trường hợp c&oacute; sự lu&acirc;n chuyển h&agrave;ng h&oacute;a giữa c&aacute;c kho cấp 2 cho nhau th&igrave; c&aacute;c kho cấp 2 trực tiếp lu&acirc;n chuyển m&agrave; kh&ocirc;ng cần th&ocirc;ng qua kho tổng.</li>
</ul>

<p align="center" style="margin-left:63.0pt;"><img height="372" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image019.jpg" width="634" /></p>

<ol style="list-style-type:lower-alpha;">
	<li value="3"><strong>Thiết lập nguy&ecirc;n liệu, định mức c&ocirc;ng thức chế biến</strong></li>
</ol>

<ul>
	<li>C&agrave;i c&ocirc;ng thức chế biến cho từng m&oacute;n h&agrave;ng b&aacute;n.</li>
	<li>T&iacute;nh ti&ecirc;u hao nguy&ecirc;n vật liệu theo ng&agrave;y, th&aacute;ng.</li>
	<li>Quản l&yacute; gi&aacute; vốn nguy&ecirc;n vật liệu, h&agrave;ng b&aacute;n.</li>
	<li>Quản l&yacute; ch&ecirc;nh lệch giữa thực tế v&agrave; số liệu.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="4"><strong>Quản l&yacute; tồn kho nguy&ecirc;n vật liệu</strong></li>
</ol>

<ul>
	<li>Cho ph&eacute;p, cảnh b&aacute;o c&agrave;i tồn tối đa, tối thỉu, tồn kho &acirc;m.</li>
	<li>T&iacute;nh gi&aacute; vốn h&agrave;ng b&aacute;n.</li>
</ul>

<ul>
	<li>T&iacute;nh gi&aacute; trị tồn hiện tại.</li>
	<li>Cho ph&eacute;p xem số lượng tồn kho trong từng t&agrave;i khoản.</li>
	<li>Theo d&otilde;i kho theo 2 đơn vị t&iacute;nh.</li>
	<li>C&acirc;n đối xuất nhập tồn.</li>
	<li>Nhập-xuất h&agrave;ng thanh to&aacute;n ngay, hoặc theo c&ocirc;ng nợ.</li>
	<li>Chuyển kho h&agrave;ng h&oacute;a vật tư nội bộ.</li>
	<li>C&acirc;n đối chi ph&iacute; đầu v&agrave;o.</li>
	<li>C&acirc;n đối số lượng kho tr&ecirc;n số liệu v&agrave; thực tế.</li>
	<li>Cập nhật l&yacute; do c&acirc;n đối.</li>
	<li>Xuất h&oacute;a đơn c&aacute;c phiếu nhập-xuất.</li>
	<li>Quản l&yacute; ho&aacute; đơn nhập h&agrave;ng.</li>
	<li>Quản l&yacute; thuế VAT đầu v&agrave;o.</li>
	<li>Quản l&yacute; gi&aacute; nhập mua.</li>
	<li>Quản l&yacute; chi tiết kho xuất chuyển v&agrave; kho nhập chuyển.</li>
	<li>Quản l&yacute; thồi gian xuất /nhập.</li>
	<li>Quản l&yacute; l&iacute; do chuyển kho.</li>
</ul>

<ol style="list-style-type:lower-alpha;">
	<li value="5"><strong>C&aacute;c b&aacute;o c&aacute;o tồn kho </strong></li>
</ol>

<ul>
	<li>B&aacute;o c&aacute;o tồn kho hiện tại.</li>
	<li>B&aacute;o c&aacute;o c&acirc;n đối kho.</li>
	<li>Sổ chi tiết vật tư h&agrave;ng h&oacute;a.</li>
	<li>B&aacute;o c&aacute;o tổng hợp số lượng xuất&hellip;</li>
	<li>B&aacute;o c&aacute;o h&agrave;ng tồn kho theo kho, theo ng&agrave;y, theo nh&oacute;m h&agrave;ng, loại h&agrave;ng.</li>
	<li>B&aacute;o c&aacute;o ch&ecirc;nh lệch tồn kho thực tế v&agrave; tồn kho trong m&aacute;y.</li>
	<li>Chi tiết mua h&agrave;ng theo nh&agrave; cung cấp, mặt h&agrave;ng.</li>
	<li>Xuất file dữ liệu kho ra Excel, PDF.</li>
</ul>

<ol>
	<li value="6"><strong>Quản l&yacute; thu chi, c&ocirc;ng nợ</strong></li>
</ol>

<p align="center"><img height="339" src="file:///C:\Users\User\AppData\Local\Temp\msohtmlclip1\01\clip_image021.jpg" width="602" /></p>

<ul>
	<li>Danh s&aacute;ch h&oacute;a đơn mua h&agrave;ng, b&aacute;n h&agrave;ng.</li>
	<li>Chỉnh sửa, x&oacute;a, xuất h&oacute;a đơn VAT.</li>
	<li>Phiếu thu tiền mặt, chi tiền mặt.</li>
</ul>

<ul>
	<li>Phiếu thu - chi c&ocirc;ng nợ tiền mặt, tiền ng&acirc;n h&agrave;ng.</li>
	<li>Phiếu thu &ndash; chi tạm ứng v&agrave; trả trước.</li>
	<li>Phiếu đặt cọc, thu kh&aacute;c, thu trả nợ.</li>
	<li>Quản l&yacute; th&ocirc;ng tin c&ocirc;ng nợ phải thu của kh&aacute;ch h&agrave;ng, nh&agrave; cung cấp.</li>
	<li>Quản l&yacute; th&ocirc;ng tin c&ocirc;ng nợ phải trả của kh&aacute;ch h&agrave;ng, nh&agrave; cung cấp.</li>
	<li>B&aacute;o c&aacute;o c&ocirc;ng nợ theo đối tượng.</li>
	<li>B&aacute;o c&aacute;o nợ qu&aacute; hạn, t&igrave;nh h&igrave;nh thanh to&aacute;n nợ của kh&aacute;ch h&agrave;ng.</li>
	<li>B&aacute;o c&aacute;o nhật k&yacute; thu, chi.</li>
	<li>B&aacute;o c&aacute;o c&ocirc;ng nợ tổng hợp.</li>
	<li>B&aacute;o c&aacute;o chi tiết c&ocirc;ng nợ.</li>
	<li>B&aacute;o c&aacute;o tuổi nợ dựa tr&ecirc;n chứng từ theo d&otilde;i.</li>
</ul>
', NULL, N'phan-mem-quan-ly-ban-hang-pos', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3448, 3225, 2, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', NULL, NULL, N'phan-mem-quan-ly-ban-hang-pos', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS', N'Phần mềm quản lý bán hàng POS')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3449, 3226, 1, N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'<p><strong>C&aacute;c chức năng ch&iacute;nh</strong></p>

<p><img alt="" src="/Admin/Images/POS.png" style="width: 860px; height: 647px; float: right;" /></p>

<p>1. Quản l&yacute; b&agrave;n theo khu vực &ndash; ph&acirc;n chia theo nhiều tab tr&ecirc;n dưới với số lượng khu vực v&agrave; b&agrave;n kh&ocirc;ng hạn chế</p>

<p>2. Xem trạng th&aacute;i b&agrave;n, ph&ograve;ng trực quan, chọn b&agrave;n để thao t&aacute;c trực tiếp</p>

<p>3. Thao t&aacute;c đơn giản dễ sử dụng</p>

<p>4. In bill 58mm, 76mm, 80mm hoặc in laser khổ nhỏ 7.5cm x 10cm</p>

<p>5. Quản l&yacute; doanh thu theo ng&agrave;y, theo ca, theo nh&acirc;n vi&ecirc;n, in b&aacute;o c&aacute;o doanh thu, b&aacute;o c&aacute;o kết ca</p>

<p>6. Hỗ trợ chuyển b&agrave;n, gộp b&agrave;n, chuyển khu vực</p>

<p>7. Quản l&yacute; kho h&agrave;ng</p>

<p>8. Bảo mật với ph&acirc;n quyền theo nh&oacute;m người d&ugrave;ng</p>

<p>9. Quản trị hệ thống với sao lưu/kh&ocirc;i phục dữ liệu, x&oacute;a dữ liệu cũ</p>

<p>10. In phiếu chế biến xuống bar/bếp</p>

<p>11 Định nghĩa c&ocirc;ng thức định lượng vật tư v&agrave; trừ h&agrave;ng kho theo định lượng vật tư</p>

<p>12. Quản l&yacute; quỹ (phiếu thu, phiếu chi, tổng hợp quỹ)</p>

<p>13. Hỗ trợ in phiếu in thử &nbsp;cho kh&aacute;ch với t&ugrave;y chọn c&oacute; sử dụng/ kh&ocirc;ng sử dụng</p>

<p>14. Ph&acirc;n ca v&agrave; t&iacute;nh lương cho nh&acirc;n vi&ecirc;n theo ca l&agrave;m việc</p>

<p>15. Cho ph&eacute;p đổi gi&aacute; b&aacute;n trực tiếp tr&ecirc;n h&oacute;a đơn</p>

<p>16. Quản l&yacute; th&agrave;nh vi&ecirc;n (VIP, V&agrave;ng, Bạc, Đồng&hellip;) v&agrave; tự động giảm gi&aacute; theo từng loại th&agrave;nh vi&ecirc;n</p>

<p>17. T&iacute;ch điểm thẻ tự động cảnh b&aacute;o n&acirc;ng loại th&agrave;nh vi&ecirc;n khi đạt ngưỡng doanh thu.</p>

<p>18. Nhiều b&aacute;o c&aacute;o mới phục vụ thống k&ecirc; v&agrave; quản l&yacute;: B&aacute;o c&aacute;o kho h&agrave;ng, thống k&ecirc; doanh thu theo nh&acirc;n vi&ecirc;n.</p>

<p>19. Quản l&yacute; linh động c&aacute;c mặt h&agrave;ng chưa c&oacute; trong hệ thống hoặc mặt h&agrave;ng theo y&ecirc;u cầu ri&ecirc;ng của kh&aacute;ch</p>

<p>20. Ghi ch&uacute; tr&ecirc;n từng mặt h&agrave;ng để ghi lại c&aacute;c y&ecirc;u cầu ri&ecirc;ng của từng kh&aacute;ch</p>

<p><strong>Thừa hưởng to&agrave;n bộ t&iacute;nh năng của c&aacute;c phi&ecirc;n bản trước, Thuần Việt POS 4.0 l&agrave; một bước đột ph&aacute; mới, với những thay đổi s&acirc;u rộng.</strong></p>

<p>1. Cho ph&eacute;p bạn tải về v&agrave; c&agrave;i đặt sử dụng thử nghiệm đồng thời c&aacute;c phần:</p>

<p>+ Chương tr&igrave;nh cho m&aacute;y t&iacute;nh b&igrave;nh thường (như bản 3.0 v&agrave; c&aacute;c phi&ecirc;n bản trước)</p>

<p>+ Chương tr&igrave;nh cho m&aacute;y cảm ứng</p>

<p>+ Chương tr&igrave;nh order bằng m&aacute;y t&iacute;nh bảng/điện thoại chạy hệ điều h&agrave;nh android</p>

<p>+ Chương tr&igrave;nh quản trị online từ xa qua điện thoại/c&aacute;c thiết bị cầm tay/m&aacute;y t&iacute;nh</p>

<p>+ Hệ thống trợ gi&uacute;p v&agrave; hướng dẫn sử dụng đầy đủ, chi tiết tới từng c&aacute;ch quản l&yacute;</p>

<p>2. Cho ph&eacute;p bạn quản l&yacute; nhiều kho h&agrave;ng, v&agrave; trừ kho theo nh&oacute;m h&agrave;ng hoặc theo khu vực</p>

<p>3. Khuyến mại tự động: tự động giảm gi&aacute; h&agrave;ng hoặc h&oacute;a đơn trong một giai đoạn định trước</p>

<p>4. Hỗ trợ giao diện b&agrave;n cảm ứng theo thiết kế hoặc tự động</p>

<p>5. Hỗ trợ tất cả c&aacute;c khổ giấy: 57mm, 76mm, 80mm, A4, A5</p>

<p>6. Hơn 100 t&ugrave;y chọn đủ cho bạn dễ d&agrave;ng thay đổi c&aacute;ch quản l&yacute; v&agrave; m&ocirc; h&igrave;nh kinh doanh m&agrave; kh&ocirc;ng phải chỉnh sửa lại phần mềm.</p>

<p>7. Hỗ trợ tối đa cho nh&agrave; quản l&yacute;: kiểm so&aacute;t order, lưu viết hoạt động, theo d&otilde;i từ xa&hellip;</p>

<p>8. Xử l&yacute; chi tiết thu chi, c&ocirc;ng nợ kh&aacute;ch h&agrave;ng, c&ocirc;ng nợ nh&agrave; cung cấp theo từng phần, từng giao dịch</p>

<p>9. Hỗ trợ t&iacute;ch hợp thẻ th&agrave;nh vi&ecirc;n (thẻ từ, m&atilde; vạch) cho kh&aacute;ch h&agrave;ng, tự động tăng hạng kh&aacute;ch h&agrave;ng khi đến doanh số quy định, tự động giảm gi&aacute; khi kh&aacute;ch h&agrave;ng đến sử dụng dịch vụ.</p>

<p>10. Quản l&yacute; kho h&agrave;ng chi tiết tỉ mỉ với định lượng vật tư, hỗ trợ 3 đơn vị t&iacute;nh c&oacute; quy đổi v&agrave; kh&ocirc;ng quy đổi.</p>

<p>11. Thiết kế giao diện b&agrave;n theo &yacute; muốn, chạy đồng thời tr&ecirc;n m&aacute;y cảm ứng v&agrave; điện thoại/m&aacute;y t&iacute;nh bảng để order</p>

<p>12. Nhiều t&iacute;nh năng tiện &iacute;ch dễ d&agrave;ng sử dụng: t&igrave;m kiếm ho&agrave;n to&agrave;n kh&ocirc;ng dấu, import, export excel</p>

<p>13. Quản l&yacute; chấm c&ocirc;ng nh&acirc;n sự với nhiều c&aacute;ch t&iacute;nh lương, tạm ứng v&agrave; chi lương trực tiếp từ phần mềm</p>

<p>14. Hệ thống b&aacute;o c&aacute;o trực quan, đầy đủ với c&aacute;c b&aacute;o c&aacute;o l&atilde;i lỗ, b&aacute;o c&aacute;o b&aacute;n h&agrave;ng, b&aacute;o c&aacute;o kho h&agrave;ng&hellip;</p>

<p>15. Quản l&yacute; ph&acirc;n quyền theo từng nh&oacute;m người d&ugrave;ng tới từng chức năng cụ thể.</p>

<p>V&agrave; c&ograve;n rất nhiều chức năng mới, h&atilde;y c&ugrave;ng kh&aacute;m ph&aacute;, vui l&ograve;ng&nbsp;</p>

<p>&nbsp;</p>
', NULL, N'phan-mem-quan-ly-nha-hang-cafe-bida-karaoke', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3450, 3226, 2, N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', NULL, NULL, N'phan-mem-quan-ly-nha-hang-cafe-bida-karaoke', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng cafe bida karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke', N'Phần mềm quản lý nhà hàng, cafe, bida, karaoke')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3451, 3227, 1, N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'<p><img alt="" src="/Admin/Images/manhinhchinh.png" style="width: 749px; height: 567px; float: right;" /></p>

<p>1. Quản l&yacute; b&aacute;n h&agrave;ng với 3 loại h&agrave;ng: h&agrave;ng mới, h&agrave;ng cũ v&agrave; phụ kiện</p>

<p>2. Quản l&yacute; sửa chữa</p>

<p>3. Quản l&yacute; kho h&agrave;ng</p>

<p>4. Quản l&yacute; c&ocirc;ng nợ</p>

<p>5. T&iacute;nh hoa hồng cho nh&acirc;n vi&ecirc;n kinh doanh v&agrave; nh&acirc;n vi&ecirc;n kỹ thuật</p>

<p>6. Quản l&yacute; thu chi, quản l&yacute; quỹ</p>

<p>7. Nhắc việc, cảnh b&aacute;o h&agrave;ng tồn kho, c&ocirc;ng nợ qu&aacute; hạn, h&agrave;ng tới hạn b&aacute;n</p>

<p>8. Quản l&yacute; đặt h&agrave;ng</p>

<p>9. Quản l&yacute; h&agrave;ng đổi trả với mức gi&aacute; thiết lập trước</p>

<p>10. Quản l&yacute; khuyến mại, cộng h&agrave;ng khuyến mại tự động</p>

<p>11. Quản l&yacute; nh&acirc;n sự, t&iacute;nh lương, chấm c&ocirc;ng</p>

<p>12. In h&oacute;a đơn theo nhiều khổ giấy kh&aacute;c nhau</p>

<p>13. Hệ thống b&aacute;o c&aacute;o đầy đủ</p>

<p>14. Ph&acirc;n quyền theo từng t&agrave;i khoản</p>

<p>15. Tự động sao lưu dữ liệu</p>

<p>V&agrave; nhiều chức năng kh&aacute;c.</p>
', NULL, N'phan-mem-quan-ly-cua-hang-dien-thoai', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3452, 3227, 2, N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', NULL, NULL, N'phan-mem-quan-ly-cua-hang-dien-thoai', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại', N'Phần mềm quản lý cửa hàng điện thoại')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3453, 3228, 1, N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'<p><span style="line-height:1;"><span style="font-size:20px;"><strong>C&aacute;c chức năng quản l&yacute; ch&iacute;nh</strong></span><img alt="" src="/Admin/Images/vangmoibanra.png" style="width: 800px; height: 508px; float: right;" /></span></p>

<p><span style="line-height:1;"><strong>1. Quản l&yacute; b&aacute;n h&agrave;ng</strong><img alt="" src="/Admin/Images/tich hop can dien tu.png" style="float: right; width: 520px; height: 402px;" /></span></p>

<p><span style="line-height:1;">+ Danh mục sản phẩm</span></p>

<p><span style="line-height:1;">+ In tem m&atilde; vạch đặc th&ugrave; cho ng&agrave;nh v&agrave;ng bạc, trang sức</span></p>

<p><span style="line-height:1;">+ Quản l&yacute; gi&aacute; v&agrave; lịch sử biến động gi&aacute;</span></p>

<p><span style="line-height:1;">+ Quản l&yacute; h&agrave;ng b&aacute;n sỉ</span></p>

<p><span style="line-height:1;">+ Quản l&yacute; h&agrave;ng b&aacute;n lẻ</span></p>

<p><span style="line-height:1;">+ Quản l&yacute; đặt h&agrave;ng</span></p>

<p><span style="line-height:1;">+ Quản l&yacute; gia c&ocirc;ng chế t&aacute;c l&agrave;m mới theo y&ecirc;u cầu</span></p>

<p><span style="line-height:1;"><strong>2. Quản l&yacute; kho h&agrave;ng</strong></span></p>

<p><span style="line-height:1;">+ Danh mục kho h&agrave;ng</span></p>

<p><span style="line-height:1;">+ Danh mục nh&agrave; cung cấp</span></p>

<p><span style="line-height:1;">+ Nhập mua h&agrave;ng từ nh&agrave; cung cấp</span></p>

<p><span style="line-height:1;">+ Nhập mua h&agrave;ng từ kh&aacute;ch lẻ</span></p>

<p><span style="line-height:1;">+ Nhập mua h&agrave;ng gửi chế t&aacute;c</span></p>

<p><span style="line-height:1;">+ Chuyển kho</span></p>

<p><span style="line-height:1;">+ Xuất h&agrave;ng gửi chế t&aacute;c</span></p>

<p><span style="line-height:1;">+ Xem tồn kho</span></p>

<p><span style="line-height:1;"><strong>3. Quản l&yacute; c&ocirc;ng nợ</strong></span></p>

<p><span style="line-height:1;">+ C&ocirc;ng nợ phải thu</span></p>

<p><span style="line-height:1;">+ C&ocirc;ng nợ phải trả</span></p>

<p><span style="line-height:1;"><strong>4. Quản l&yacute; cầm đồ</strong></span></p>

<p><span style="line-height:1;">+ Cho vay cầm đồ</span></p>

<p><span style="line-height:1;">+ Vay th&ecirc;m</span></p>

<p><span style="line-height:1;">+ Gia hạn trả l&atilde;i</span></p>

<p><span style="line-height:1;">+ Kh&aacute;ch chuộc đồ</span></p>

<p><span style="line-height:1;">+ Thanh l&yacute; hợp đồng qu&aacute; hạn</span></p>

<p><span style="line-height:1;"><strong>5. Quản l&yacute; thu chi</strong></span></p>

<p><span style="line-height:1;">+ Tạo phiếu thu<span style="line-height:1;"><span style="line-height:1;"><span style="line-height:1;"><span style="line-height:1;"><span style="line-height:1;"><img alt="" src="/Admin/Images/loai vang.png" style="float: right; width: 520px; height: 423px;" /></span></span></span></span></span></span></p>

<p><span style="line-height:1;">+ Tạo phiếu chi</span></p>

<p><span style="line-height:1;">+ Danh mục phiếu thu chi</span></p>

<p><span style="line-height:1;">+ Tồn quỹ</span></p>

<p><span style="line-height:1;"><strong>6. Quản l&yacute; nh&acirc;n sự</strong></span></p>

<p><span style="line-height:1;">+ Danh s&aacute;ch nh&acirc;n vi&ecirc;n</span></p>

<p><span style="line-height:1;">+ Tạm ứng lương</span></p>

<p><span style="line-height:1;">+ Chấm c&ocirc;ng</span></p>

<p><span style="line-height:1;">+ Thưởng phạt</span></p>

<p><span style="line-height:1;">+ T&iacute;nh lương v&agrave; chi lương</span></p>

<p><span style="line-height:1;"><strong>7. Quản trị hệ thống</strong></span></p>

<p><span style="line-height:1;">+ Người d&ugrave;ng v&agrave; ph&acirc;n quyền người d&ugrave;ng</span></p>

<p><span style="line-height:1;">+ Đổi mật khẩu</span></p>

<p><span style="line-height:1;">+ Thiết lập t&ugrave;y chọn to&agrave;n hệ thống<span style="line-height:1;"><span style="line-height:1;"><span style="line-height:1;"><span style="line-height:1;"><img alt="" src="/Admin/Images/kiemdinhvang.png" style="width: 500px; float: right; height: 582px;" /></span></span></span></span></span></p>

<p><span style="line-height:1;"><strong>8. B&aacute;o c&aacute;o</strong></span></p>

<p><span style="line-height:1;">C&aacute;c t&iacute;nh năng nổi bật</span></p>

<p><span style="line-height:1;">1. Hệ thống gọn nhẹ đơn giản, dễ sử dụng, nhiều tiện &iacute;ch</span></p>

<p><span style="line-height:1;">2. In m&atilde; vạch chuy&ecirc;n dụng trực tiếp từ phần mềm</span></p>

<p><span style="line-height:1;">3. Hỗ trợ nhiều loại m&aacute;y in h&oacute;a đơn, giấy bi&ecirc;n nhận, giấy đảm bảo: 57mm, 76mm, 80mm, A4, A5&hellip;</span></p>

<p><span style="line-height:1;">4. Hỗ trợ đầy đủ font unicode, giao diện ho&agrave;n to&agrave;n tiếng việt</span></p>

<p><span style="line-height:1;">5. B&aacute;o c&aacute;o đầy đủ r&otilde; r&agrave;ng, dễ đọc, dễ hiểu.</span></p>

<p><span style="line-height:1;">6. Ph&acirc;n quyền chi tiết tới từng chức năng</span></p>

<p><span style="line-height:1;">V&agrave; c&ograve;n rất nhiều t&iacute;nh năng th&uacute; vị kh&aacute;c</span></p>
', NULL, N'phan-mem-quan-ly-hieu-vang', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3454, 3228, 2, N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', NULL, NULL, N'phan-mem-quan-ly-hieu-vang', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng', N'Phần mềm quản lý hiệu vàng')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3455, 3229, 1, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'<p><strong>1. Chức năng hệ thống<img alt="" src="/Admin/Images/man hinh chinh SM V4.png" style="float: right; width: 593px; height: 428px;" /></strong></p>

<p>Tạo mới cơ sở dữ liệu</p>

<p>Sao lưu cơ sở dữ liệu</p>

<p>Phục hồi cơ sở dữ liệu</p>

<p>Đổi mật khẩu đăng nhập</p>

<p>Quản trị thư viện ảnh</p>

<p>Ph&acirc;n quyền v&agrave; quản trị người sử dụng</p>

<p>Cấu h&igrave;nh to&agrave;n bộ hệ thống</p>

<p>C&agrave;i th&ecirc;m</p>

<p><strong>2. B&aacute;n h&agrave;ng</strong></p>

<p>Quản l&yacute; hợp đồng</p>

<p>Quản l&yacute; b&aacute;o gi&aacute;</p>

<p>Quản l&yacute; th&ocirc;ng tin kh&aacute;ch h&agrave;ng</p>

<p>Quản l&yacute; b&aacute;n lẻ</p>

<p>Quản l&yacute; b&aacute;n bu&ocirc;n</p>

<p>Quản l&yacute; điểm b&aacute;n</p>

<p>Danh mục mặt h&agrave;ng</p>

<p><strong>3. Kho h&agrave;ng</strong></p>

<p>Danh mục kho h&agrave;ng</p>

<p>Danh mục nh&agrave; cung cấp</p>

<p>Nhập kho</p>

<p>Chuyển kho</p>

<p>Kiểm k&ecirc; kho</p>

<p>Trả lại nh&agrave; cung cấp</p>

<p>Tồn kho</p>

<p><strong>4. Sau b&aacute;n h&agrave;ng</strong></p>

<p>Danh mục kho h&agrave;ng</p>

<p>Danh mục nh&agrave; cung cấp</p>

<p>Nhập kho</p>

<p>Chuyển kho</p>

<p>Kiểm k&ecirc; kho</p>

<p>Trả lại nh&agrave; cung cấp</p>

<p>Tồn kho</p>

<p><strong>5. B&aacute;o c&aacute;o b&aacute;n h&agrave;ng</strong></p>

<p>Chi tiết b&aacute;n h&agrave;ng</p>

<p>Tổng hợp b&aacute;n h&agrave;ng</p>

<p>Chi tiết b&aacute;n h&agrave;ng theo nh&acirc;n vi&ecirc;n kinh doanh</p>

<p>Tổng hợp b&aacute;n h&agrave;ng theo NVKD</p>

<p>Danh s&aacute;ch h&oacute;a đơn hủy</p>

<p>Tổng hợp b&aacute;n h&agrave;ng theo h&agrave;ng h&oacute;a</p>

<p>Tổng hợp b&aacute;n h&agrave;ng theo kh&aacute;ch h&agrave;ng</p>

<p><strong>6. B&aacute;o c&aacute;o đặt h&agrave;ng</strong></p>

<p>Chi tiết đặt h&agrave;ng</p>

<p>Tổng hợp đặt h&agrave;ng</p>

<p>Danh s&aacute;ch phiếu đặt h&agrave;ng bị hủy</p>

<p>Danh s&aacute;ch phiếu đặt h&agrave;ng chưa xuất</p>

<p><strong>7. B&aacute;o c&aacute;o c&ocirc;ng nợ phải thu</strong></p>

<p>Chi tiết c&ocirc;ng nợ phải thu</p>

<p>Tổng hợp c&ocirc;ng nợ phải thu</p>

<p>B&aacute;o c&aacute;o tuổi nợ</p>

<p>Chi tiết c&ocirc;ng nợ theo NVKD</p>

<p>Tổng hợp c&ocirc;ng nợ theo NVKD</p>

<p>Chi tiết tiền thu c&ocirc;ng nợ theo NVKD</p>

<p><strong>8. B&aacute;o c&aacute;o quỹ</strong></p>

<p>B&aacute;o c&aacute;o quỹ tiền mặt</p>

<p>B&aacute;o c&aacute;o c&aacute;c khoản thu kh&aacute;c</p>

<p>B&aacute;o c&aacute;o c&aacute;c khoản chi kh&aacute;c</p>

<p>Danh s&aacute;ch phiếu thu c&ocirc;ng nợ</p>

<p>Danh s&aacute;ch phiếu chi c&ocirc;ng nợ</p>

<p><strong>9. B&aacute;o c&aacute;o biểu đồ</strong></p>

<p>Biểu đồ doanh số theo tỉnh th&agrave;nh</p>

<p>Biểu đồ doanh số theo nh&oacute;m h&agrave;ng h&oacute;a</p>

<p>Biểu đồ doanh số theo khoảng thời gian</p>

<p>Biểu đồ doanh số theo nh&oacute;m h&agrave;ng c&aacute;c th&aacute;ng trong năm</p>

<p>Danh s&aacute;ch hợp đồng</p>
', NULL, N'phan-mem-ban-hang-kho-hang-cong-no-sm', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3456, 3229, 2, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', NULL, NULL, N'phan-mem-ban-hang-kho-hang-cong-no-sm', NULL, NULL, NULL, NULL, NULL, NULL, N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM', N'Phần mềm bán hàng, kho hàng, công nợ SM')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3457, 3230, 1, N'www', NULL, NULL, NULL, N'www', NULL, NULL, NULL, NULL, NULL, NULL, N'www', N'www', N'www', N'www', N'www', N'www')
INSERT [dbo].[PNK_ProductDesc] ([Id], [MainId], [LangId], [Title], [Brief], [Detail], [Require], [TitleUrl], [Position], [Utility], [Design], [Pictures], [Payment], [Contact], [Metadescription], [MetaKeyword], [MetaTitle], [H1], [H2], [H3]) VALUES (3458, 3230, 2, N'www', NULL, NULL, NULL, N'www', NULL, NULL, NULL, NULL, NULL, NULL, N'www', N'www', N'www', N'www', N'www', N'www')
SET IDENTITY_INSERT [dbo].[PNK_ProductDesc] OFF
SET IDENTITY_INSERT [dbo].[PNK_UploadImage] ON 

INSERT [dbo].[PNK_UploadImage] ([Id], [Name], [Published], [ImagePath], [Ordering], [PostDate], [Updatedate], [ProductId], [Type], [LongiTude], [Latitude]) VALUES (1, N'Youtube', N'1', N'khgxvDN2X9E', 1, CAST(0x0000A7530098040F AS DateTime), CAST(0x0000A7530098040F AS DateTime), 3230, NULL, NULL, NULL)
INSERT [dbo].[PNK_UploadImage] ([Id], [Name], [Published], [ImagePath], [Ordering], [PostDate], [Updatedate], [ProductId], [Type], [LongiTude], [Latitude]) VALUES (2, N'Youtube', N'1', N'khgxvDN2X9E', 2, CAST(0x0000A75300980445 AS DateTime), CAST(0x0000A75300980445 AS DateTime), 3231, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PNK_UploadImage] OFF
SET IDENTITY_INSERT [dbo].[PNK_User] ON 

INSERT [dbo].[PNK_User] ([Id], [FullName], [Username], [Password], [Phone], [Address], [Email], [IsNewsletter], [Role], [Published], [PostDate], [UpdateDate], [Token], [Mobile], [LocationId], [Image]) VALUES (123, N'admin', N'admin', N'ac274ab120231fd34f533ef0667aee7b', NULL, NULL, N'admin@gmail.com', N'0', 1, N'1', CAST(0x0000A632001CB405 AS DateTime), CAST(0x0000A632001CB405 AS DateTime), NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PNK_User] OFF
INSERT [dbo].[sd_xml] ([id], [xmlcontent]) VALUES (1, N'<ConfigCatalog><Configs><Config value="Pages/home.ascx" name="home" /><Config value="Pages/BookingPrice/admin_bookingprice.ascx" name="bookingprice" att="Giá tour" /><Config value="Pages/ProgramTour/admin_programtour.ascx" name="programtour" att="Chương trình tour" /><Config value="Pages/ProgramTour/admin_editprogramtour.ascx" name="edit_programtour" att="Chỉnh sửa chương trình tour" /><Config value="Pages/User/admin_user.ascx" name="user" att="Tài khoản người dùng" /><Config value="Pages/User/admin_edituser.ascx" name="edit_user" att="Tài khoản người dùng" /><Config value="Pages/ContentStatic/admin_contentstatic.ascx" name="contentstatic" att="Nội dung tĩnh" /><Config value="Pages/ContentStatic/admin_editcontentstatic.ascx" name="edit_contentstatic" att="Chỉnh sửa nội dung tĩnh" /><Config value="Pages/Config/admin_page.ascx" name="page" att="Cấu hình chung" /><Config value="Pages/Config/admin_config.ascx" name="config" att="Cấu hình email" /><Config value="Pages/Config/admin_seo.ascx" name="seo" att="Tối ưu seo" /><Config value="Pages/ProductCategory/admin_editproductcategory.ascx" name="edit_productcategory" att="Nhóm bài viết" /><Config value="Pages/ProductCategory/admin_productcategory.ascx" name="productcategory" att="Nhóm bài viết" /><Config value="Pages/Product/admin_editproduct.ascx" name="edit_product" att="Bài viết" /><Config value="Pages/Product/admin_product.ascx" name="product" att="Bài viết" /><Config value="Pages/Slider/admin_slider.ascx" name="slider" att="Banner" /><Config value="Pages/Slider/admin_editslider.ascx" name="edit_slider" att="Banner" /><Config value="Pages/Booking/admin_booking.ascx" name="booking" att="Booking" /><Config value="Pages/Booking/admin_editbooking.ascx" name="edit_booking" att="Chỉnh sửa booking" /><Config value="Pages/BookingGroup/admin_bookinggroup.ascx" name="bookinggroup" att="Booking Nhóm" /><Config value="Pages/ExchangeRate/admin_exchangerate.ascx" name="exchangerate" att="Quy đổi ngoại tệ" /><Config value="Pages/ExchangeRate/admin_editexchangerate.ascx" name="edit_exchangerate" att="Chỉnh sửa quy đổi ngoại tệ" /></Configs></ConfigCatalog>')
INSERT [dbo].[sd_xml] ([id], [xmlcontent]) VALUES (2, N'<ConfigCatalog><Configs><Config value="Pages/CategoryManagement/Category.ascx" name="danh-muc" att="Trang danh mục" /><Config value="Pages/CategoryManagement/CategoryDetail.ascx" name="chi-tiet" att="Trang chi tiết" /><Config value="Pages/TemplateManagement/Template.ascx" name="danh-muc giao dien" att="Trang danh mục giao diện" /><Config value="Pages/TemplateManagement/TemplateDetail.ascx" name="giao-dien-chi-tiet" att="Trang giao diện chi tiết" /><Config value="Pages/BlogManagement/Blog.ascx" name="danh-muc-blogc" att="Trang danh mục blog" /><Config value="Pages/BlogManagement/BlogDetail.ascx" name="Blog-chi-tiet" att="Trang blog chi tiết" /><Config value="Pages/contact/contact.ascx" name="contact" att="Trang liên hệ" /><Config value="Pages/contact/request.ascx" name="request" att="Trang gửi yêu cầu" /><Config value="Pages/login.ascx" name="login" att="Trang đăng nhập" /><Config value="Pages/CompanyManagement/CompanyDetail.ascx" name="company" att="Trang thông tin công ty" /><Config value="Pages/SearchManagement/search.ascx" name="search" att="Trang tìm kiếm" /><Config value="Pages/ServiceManagement/Service.ascx" name="service" att="Trang dịch vụ" /><Config value="Pages/home.ascx" name="trang-chu" att="Trang chủ" /><Config value="Pages/GalleryManagement/Video.ascx" name="video" att="Video" /></Configs></ConfigCatalog>')
INSERT [dbo].[sd_xml] ([id], [xmlcontent]) VALUES (3, N'<ConfigCatalog><Configs><Config value="/Home" name="1" att="true" /><Config value="/GioiThieu" name="2" att="true" /><Config value="/LienHe" name="3" att="true" /></Configs></ConfigCatalog>')
INSERT [dbo].[sd_xml] ([id], [xmlcontent]) VALUES (4, N'<ConfigCatalog><Configs><Config value="Slider" name="1" att="false" /></Configs><Configs><Config value="Partner" name="2" att="false" /></Configs></ConfigCatalog>')
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Name]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Name] ON [dbo].[PNK_Banner]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_Position]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Position] ON [dbo].[PNK_Banner]
(
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Published]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Published] ON [dbo].[PNK_Banner]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_categoryid]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_categoryid] ON [dbo].[PNK_ContentStatic]
(
	[categoryid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_published]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_published] ON [dbo].[PNK_ContentStatic]
(
	[published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_langid]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_langid] ON [dbo].[PNK_ContentStaticdesc]
(
	[langid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_mainid]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_mainid] ON [dbo].[PNK_ContentStaticdesc]
(
	[mainid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_title]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_title] ON [dbo].[PNK_ContentStaticdesc]
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_titleurl]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_titleurl] ON [dbo].[PNK_ContentStaticdesc]
(
	[titleurl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_CategoryId]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_CategoryId] ON [dbo].[PNK_Product]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Hot]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Hot] ON [dbo].[PNK_Product]
(
	[Hot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Published]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Published] ON [dbo].[PNK_Product]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_langid]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_langid] ON [dbo].[PNK_ProductCategory]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_Ordering]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Ordering] ON [dbo].[PNK_ProductCategory]
(
	[Ordering] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_PathTree]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_PathTree] ON [dbo].[PNK_ProductCategory]
(
	[PathTree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Published]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Published] ON [dbo].[PNK_ProductCategory]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_LangId]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_LangId] ON [dbo].[PNK_ProductcategoryDesc]
(
	[LangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Name]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Name] ON [dbo].[PNK_ProductcategoryDesc]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_NameUrl]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_NameUrl] ON [dbo].[PNK_ProductcategoryDesc]
(
	[NameUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_LangId]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_LangId] ON [dbo].[PNK_ProductDesc]
(
	[LangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Title]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Title] ON [dbo].[PNK_ProductDesc]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_TitleUrl]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_TitleUrl] ON [dbo].[PNK_ProductDesc]
(
	[TitleUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Name]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Name] ON [dbo].[PNK_UploadImage]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_productid]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_productid] ON [dbo].[PNK_UploadImage]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_Published]    Script Date: 15/04/2017 10:28:44 AM ******/
CREATE NONCLUSTERED INDEX [idx_Published] ON [dbo].[PNK_UploadImage]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PNK_Banner] ADD  DEFAULT ((1)) FOR [Position]
GO
ALTER TABLE [dbo].[PNK_Banner] ADD  DEFAULT ((1)) FOR [ClickCount]
GO
ALTER TABLE [dbo].[PNK_Banner] ADD  DEFAULT ('0') FOR [Published]
GO
ALTER TABLE [dbo].[PNK_Booking] ADD  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[PNK_Booking] ADD  DEFAULT ('0') FOR [Published]
GO
ALTER TABLE [dbo].[PNK_Booking] ADD  DEFAULT ('1') FOR [PathTree]
GO
ALTER TABLE [dbo].[PNK_BookingPrice] ADD  DEFAULT ((1)) FOR [Min]
GO
ALTER TABLE [dbo].[PNK_BookingPrice] ADD  DEFAULT ((1)) FOR [Max]
GO
ALTER TABLE [dbo].[PNK_BookingPrice] ADD  DEFAULT ((1)) FOR [GroupType]
GO
ALTER TABLE [dbo].[PNK_BookingPrice] ADD  DEFAULT ('0') FOR [Published]
GO
ALTER TABLE [dbo].[PNK_ContentStaticdesc] ADD  DEFAULT ((1)) FOR [langid]
GO
ALTER TABLE [dbo].[PNK_CountryDesc] ADD  DEFAULT ((1)) FOR [LangId]
GO
ALTER TABLE [dbo].[PNK_ExchangeRateDesc] ADD  DEFAULT ((1)) FOR [LangId]
GO
ALTER TABLE [dbo].[PNK_Location] ADD  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[PNK_Location] ADD  DEFAULT ('0') FOR [Published]
GO
ALTER TABLE [dbo].[PNK_Location] ADD  DEFAULT ('1') FOR [PathTree]
GO
ALTER TABLE [dbo].[PNK_Product] ADD  DEFAULT ((0)) FOR [Code]
GO
ALTER TABLE [dbo].[PNK_Product] ADD  DEFAULT ('Pages/Products/productdetail.ascx') FOR [Page]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT ((1)) FOR [PathTree]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT (NULL) FOR [BaseImage]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT (NULL) FOR [SmallImage]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT (NULL) FOR [ThumbnailImage]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT (NULL) FOR [Page]
GO
ALTER TABLE [dbo].[PNK_ProductCategory] ADD  DEFAULT (NULL) FOR [PageDetail]
GO
ALTER TABLE [dbo].[PNK_ProductDesc] ADD  DEFAULT ((1)) FOR [LangId]
GO
ALTER TABLE [dbo].[PNK_States] ADD  DEFAULT ('1') FOR [CountryID]
GO
ALTER TABLE [dbo].[PNK_User] ADD  DEFAULT ((0)) FOR [IsNewsletter]
GO
ALTER TABLE [dbo].[PNK_User] ADD  DEFAULT ((1)) FOR [Role]
GO
ALTER TABLE [dbo].[PNK_User] ADD  DEFAULT ((0)) FOR [Published]
GO
ALTER TABLE [dbo].[PNK_User] ADD  DEFAULT (getdate()) FOR [PostDate]
GO
ALTER TABLE [dbo].[PNK_User] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO
USE [master]
GO
ALTER DATABASE [vitinhth_foody] SET  READ_WRITE 
GO
