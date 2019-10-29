/****** Object:  View [dbo].[Контрагенты_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Контрагенты_S]
as
--	select * from [Контрагенты_S] where НашаОрганизация= 'ДА' 
	SELECT SYS_ID
	, Название
	, isnull([Название],'')+isnull(' ('+[Примечания]+')','') AS Название2
	, SYS_U
--	, case when Название like '%беломортранс%' or Название like '%маламут%' then 'ДА' end НашаОрганизация
	, case	when SYS_ID='88219B0B6CCC424E9312026C8BFCC635' then 'ДА' 
			when SYS_ID='87982728CB9B40828DA94891A6F8FF3C' then 'ДА' 
			when SYS_ID='87BAE32D03D94215ADACF118F0AFA5F2' then 'ДА' 
	  end НашаОрганизация

	FROM Контрагенты


