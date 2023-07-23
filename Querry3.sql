SELECT orders.id, clients.name, brands.name, models.name, orders.dateOfOrder
FROM clients
INNER JOIN orders ON clients.id = orders.client_id
INNER JOIN stock ON orders.stock_id = stock.id
INNER JOIN models ON stock.model_id = models.id
INNER JOIN brands ON stock.brand_id = brands.id;

#връща информация за датата на поръчката, артикула, който е поръчан, и магазина, който я е поръчал
# Задача 4