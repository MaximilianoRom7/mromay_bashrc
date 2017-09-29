-- select * from information_schema.tables

select table_name from information_schema.tables where table_name ilike '%account%'