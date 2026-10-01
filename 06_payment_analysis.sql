SELECT
    seller_state,
    COUNT(*) AS sellers
FROM sellers
GROUP BY seller_state
ORDER BY sellers DESC;

SELECT
    order_status,
    COUNT(*) AS orders,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders),
        2
    ) AS order_percentage
FROM orders
GROUP BY order_status
ORDER BY orders DESC;


SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;