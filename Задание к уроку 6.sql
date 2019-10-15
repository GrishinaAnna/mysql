USE vk;

--  Пусть задан некоторый пользователь.(id=1)
--  Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.




SELECT count(*) AS total_messages, -- считаем кол-во сообщений от пользователей
	   from_user_id 
FROM messages
WHERE from_user_id = 1 -- отправитель (пользователь)
     OR to_user_id = 1 -- получатель (пользователь)
GROUP BY from_user_id
   HAVING from_user_id >=2 -- выбираем друзей пользователя
ORDER BY total_messages DESC
LIMIT 1 -- выбираем того, который больше всех общался с нашим пользователем
 ;
 ------------------------------------------------------------------------------------------------------------------------------------
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

SELECT media_id, COUNT(*) AS total_likes -- применим агрегирующую функцию count 
FROM likes
WHERE user_id IN (SELECT id FROM media WHERE user_id IN (
SELECT tbl1.id FROM (
SELECT user_id AS id FROM profiles ORDER BY birthday DESC LIMIT 10) AS tbl1   -- выбираем 10 самых молодых пользователей
)
) 
GROUP BY media_id; -- собираем все записи с каждым media_id в 1 запись и подсчитываем их количество


-- Есть другой вариант:

SELECT user_id, media_id, COUNT(*) AS total_likes -- применим агрегирующую функцию count 
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) -- выбираем 10 самых молодых пользователей
GROUP BY media_id; -- собираем все записи с каждым media_id в 1 запись и подсчитываем их количество

/*  Но этот запрос у меня не работает: "SQL Error [1235] [42000]:
 This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery" */


---------------------------------------------------------------------------------------------------------------------------------------

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
CASE (gender)
         WHEN 'm' THEN 'male' -- выведем в таком виде
         WHEN 'f' THEN 'female'
    END AS gender, count(*) FROM profiles
WHERE user_id IN (
SELECT user_id FROM likes
)
GROUP BY gender;


