create database ecommerce_db;
use ecommerce_db;


select
(select count(distinct order_id) from orders) as total_orders,
(select count(distinct customer_id) from customers) as total_customers,
(select avg(review_score) from reviews) as avg_rating,
(select sum(order_status='delivered') from orders) as delivered_orders,
(select sum(order_status='returned') from orders) as returned_orders,
(select sum(order_status='cancelled') from orders) as cancelled_orders,
(select sum(order_status='shipped') from orders) as shipped_orders;
 
 
 ALTER TABLE order_items CHANGE COLUMN `discount(%)` discount DOUBLE;

SELECT 
    o.order_id,
    p.product_id,
    p.Category_final AS product_name,
    o.delivery_status
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;




-- Trigger
DELIMITER $$

CREATE TRIGGER check_quantity
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'quantity must be greater than 0';
    END IF;
END$$

DELIMITER ;


















