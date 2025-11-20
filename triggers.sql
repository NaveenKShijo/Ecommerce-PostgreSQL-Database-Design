
-- To adjust the stock whenever an order item is inserted/updated/deleted

CREATE OR REPLACE FUNCTION adj_stock_after_order()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE product
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE product
        SET stock_quantity = stock_quantity + OLD.quantity
        WHERE product_id = OLD.product_id;

    ELSIF TG_OP = 'UPDATE' THEN 
        UPDATE product 
        SET stock_quantity = stock_quantity - (NEW.quantity - OLD.quantity)         
        WHERE product_id = NEW.product_id;
    END IF;

    RETURN NULL;  -- After trigger, the return value is ignored

END;
$$;

CREATE TRIGGER stock_adjust
AFTER INSERT OR UPDATE OR DELETE on order_items
FOR EACH ROW
EXECUTE FUNCTION adj_stock_after_order();



-- Trigger to keep orders.total_amount updated from order_items table

CREATE OR REPLACE FUNCTION update_total_amount()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE 
    current_ord_id INT;
BEGIN
    current_ord_id := COALESCE(NEW.order_id, OLD.order_id);
    UPDATE orders o
    SET total_amount = (
        SELECT COALESCE(SUM(quantity*price_at_purchase), 0) 
        FROM order_items
        WHERE order_id = current_ord_id
    )
    WHERE o.order_id = current_ord_id;

    RETURN NULL; 
END;
$$;

CREATE TRIGGER update_total_amount_trggr
AFTER INSERT OR DELETE OR UPDATE ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_total_amount();