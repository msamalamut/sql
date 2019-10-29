/****** Object:  Function [dbo].[fn_TalonBrigadePRR]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		Kazak V.V
-- Create date: 2018-01-20
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_TalonBrigadePRR]
(	
	@sys_id nvarchar(255)
)
RETURNS TABLE 
AS
RETURN 
(
	select	row_number() over(order by b.ID)  as npp,
			к.Название as ОрганизацияТ,
			ka.Название AS Маршрут,
			convert(nvarchar(10), l.Дата, 104) as Дата , l.Номер,
			cast(cast(isnull(l.ЗЧ_ВыездФакт , l.ЗЧ_ВыездПлан) as time) as nvarchar(5)) as ВремяПрибытия,
			cast(cast(isnull(l.ЗЧ_ПриездФакт, l.ЗЧ_ПриездПлан) as time) as nvarchar(5)) as ВремяУбытия,
			u.Название as Заказчик,
			us.АвтотехникаВид, us.ГосНомер,
	--		l.Маршрут,
			s.Название ФИО, d.Название Должность, s.Удостоверение,
			b.ОтработаноЧ
	from	с_ПЛисты l
			left outer join Контрагенты к ON l.Организация = к.SYS_ID
			left outer join к_Адреса ka ON l.КудаМесто = ka.SYS_ID
			left outer join У_УС u ON l.Заказчик = u.SYS_ID
			left outer join У_УС_S	us ON l.Автотехника = us.SYS_ID 
			left outer join с_ПЛистыБригады b on l.SYS_ID = b.Операция
			left outer join Сотрудники s on b.Сотрудник = s.SYS_ID
			left outer join Должности d on s.Должность = d.SYS_ID
	where	l.SYS_ID = @sys_id

)
