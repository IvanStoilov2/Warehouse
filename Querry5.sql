SELECT p.client_id, AVG(p.total) AS average_payment
FROM
  (SELECT client_id, SUM(total) AS total
   FROM payments
   GROUP BY client_id) AS p
GROUP BY p.client_id;

#Тази заявка ще изведе клиентски ID и средна стойност на плащанията за всеки клиент.
# Задача 6