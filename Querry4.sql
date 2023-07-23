SELECT clients.name, stock.id, stock.quantity
FROM clients
LEFT OUTER JOIN orders ON clients.id = orders.client_id
LEFT OUTER JOIN stock ON orders.stock_id = stock.id;

/*
Задача 5
Тази заявка ще ни даде списък на всички клиенти в базата данни "warehouse", които имат поръчки, 
включително тези, които не са направили никакви поръчки, както и наличностите на заявената стока. Ако няма поръчки за дадения клиент,
ще бъде изведена стойност null за колоната "quantity". 
*/