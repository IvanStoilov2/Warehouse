/*
	Заявката демонстрира използването на JOIN и агрегатна функция едновременно, както и SELECT с огр. условие (задачи 2 и 7).
	Заявката има за цел да покаже всички заявени от клиенти продукти през м.Януари 2022г. с тяхната марка и модел, както и количество
	на продукта, дата на заявката, дължима сума и информация за клиента. 
*/

SELECT orders.id as order_ID, clients.name as client_name, clients.address as clientAddress, clients.phone as clientPhone,
stockgroups.name as StockGroup, CONCAT(brands.name, " ", models.name) as ProductName, orders.or_qty as Qty,
orders.dateOfOrder, CONCAT(payments.total, " BGN") as total
FROM stock
JOIN orders ON stock.id=orders.stock_id
JOIN clients ON orders.client_id=clients.id
JOIN brands ON stock.brand_id=brands.id
JOIN models ON stock.model_id=models.id
JOIN stockgroups ON stock.groups_id=stockgroups.id
JOIN payments ON orders.id=payments.order_id
WHERE dateOfOrder BETWEEN '2022-01-01' AND '2022-01-31'