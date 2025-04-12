```sql
select * 
from company
	join country on country.id_country = company.id_country; -- те что совпадают (середина)

select *
from company
	left join country on country.id_country = company.id_country; -- возвращает все строки из левой таблицы и соответствующие строки из правой таблицы.

select * 
from company
	right join country on country.id_country = company.id_country; -- возвращает все строки из правой таблицы и соответствующие строки из левой таблицы

```

