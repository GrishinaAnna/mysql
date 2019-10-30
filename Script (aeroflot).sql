/*
Требования к курсовому проекту

1. общее текстовое описание БД и решаемых ею задач
2. минимальное количество таблиц - 10
3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами)
4. скрипты наполнения БД данными
5. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)
6. представления (минимум 2)
7. хранимые процедуры / триггеры
8. ...*/

USE aeroflot;

-- находим бронирования для пассажира id=1

SELECT * FROM booking AS b
WHERE passenger_id = 1


 -- можем узнать информацию об этом пассажире
SELECT * FROM passengers AS p
WHERE p.id = (SELECT b.passenger_id FROM booking AS b
WHERE passenger_id = 1)

/* В настоящее время проект находится в стадии доработки по пунктам 5,6,7*/