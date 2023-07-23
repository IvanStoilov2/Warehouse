DELIMITER |
CREATE TRIGGER update_stock_on_order AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE stock
    SET quantity = quantity - NEW.or_qty
    WHERE id = NEW.stock_id;
END;
| DELIMITER ;