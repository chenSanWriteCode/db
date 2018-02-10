ALTER PROCEDURE [dbo].[searchMainDir]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
declare @DirHead nvarchar(50),
@DirEnd nvarchar(50)
	SET NOCOUNT ON;
--set @DirHead = (select f.beforContent+''  from FirstLevel f  where f.id=0 for xml path('') )
--set @DirEnd = (select f.afterContent+''  from FirstLevel  f where f.id=0 for xml path(''))
	select mainDir =--@DirHead+
	(select f.beforContent+''+ f.midContent+f.afterContent+''  from FirstLevel f  where f.id>0 and f.activityFlag=1 order by f.orderId,f.createdDate for xml path(''))
	--+@DirEnd
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter TRIGGER updateBeforContentHref
   ON  [firstLevel]
   AFTER INSERT
AS 
BEGIN
	declare @id int
	
	SET NOCOUNT ON;
select @id=i.id from inserted i
update [firstLevel]  set [beforContent] = replace([beforContent],'#','#'+convert(nvarchar(10),@id)) where id = @id
    -- Insert statements for trigger here

END
GO
