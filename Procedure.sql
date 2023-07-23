DELIMITER |
DROP PROCEDURE IF EXISTS show_client_orders;
CREATE PROCEDURE show_client_orders(IN client_name VARCHAR(255))
BEGIN
DECLARE total_due DOUBLE;
DECLARE order_id, client_id, stock_id, or_qty, model_id, brand_id INT;
DECLARE model_name, brand_name VARCHAR(255);
DECLARE done INT DEFAULT FALSE;
DECLARE order_cursor CURSOR FOR
SELECT o.id, o.client_id, o.stock_id, o.or_qty, m.id, b.id
FROM orders o
INNER JOIN stock s ON o.stock_id = s.id
INNER JOIN models m ON s.model_id = m.id
INNER JOIN brands b ON m.brand_id = b.id
INNER JOIN clients c ON o.client_id = c.id
WHERE c.name = client_name;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

OPEN order_cursor;

SET total_due = 0;

SELECT concat('Orders for client: ', client_name) as result;

FETCH order_cursor INTO order_id, client_id, stock_id, or_qty, model_id, brand_id;
WHILE NOT done DO
SELECT m.name INTO model_name FROM models m WHERE m.id = model_id;
SELECT b.name INTO brand_name FROM brands b WHERE b.id = brand_id;
SELECT (s.price * o.or_qty) INTO total_due FROM orders o INNER JOIN stock s ON o.stock_id = s.id WHERE o.id = order_id;
SELECT concat('Order: ', order_id, ', Brand: ', brand_name, ', Model: ', model_name, ', Quantity: ', or_qty, ', Total: ', total_due) as result
GROUP BY order_id;
SET total_due = 0;
FETCH order_cursor INTO order_id, client_id, stock_id, or_qty, model_id, brand_id;
END WHILE;

CLOSE order_cursor;

END |
DELIMITER ;

CALL show_client_orders('Technopolis');