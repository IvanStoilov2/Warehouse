/*
	Задача 3
	Заявката има за цел да покаже името на клиента, заявил дадена стока и сумата, която има да заплати той
*/

SELECT clients.name, CONCAT(SUM(payments.total), " BGN") AS total_payments
FROM clients
JOIN payments ON payments.client_id = clients.id
GROUP BY clients.name;
