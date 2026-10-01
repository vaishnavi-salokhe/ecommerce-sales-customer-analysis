USE ecommerce;

-- =====================================================
-- 7. LATE DELIVERY BY CUSTOMER STATE
-- Business Question:
-- Which customer regions experience higher delivery delays?
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders,

    SUM(
        o.order_delivered_customer_date >
        o.order_estimated_delivery_date
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            o.order_delivered_customer_date >
            o.order_estimated_delivery_date
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_rate

FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY c.customer_state

HAVING COUNT(DISTINCT o.order_id) >= 500

ORDER BY late_delivery_rate DESC;


-- =====================================================
-- 8. REPEAT CUSTOMER ANALYSIS
-- Business Question:
-- How many customers placed more than one order?
-- =====================================================

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,

    COUNT(*) AS customers

FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders

GROUP BY customer_type;


-- =====================================================
-- 9. TOP SELLERS VS TOTAL REVENUE
-- Business Question:
-- How concentrated is seller revenue?
-- =====================================================

WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
),

ranked_sellers AS (
    SELECT
        seller_id,
        revenue,
        RANK() OVER (ORDER BY revenue DESC) AS seller_rank
    FROM seller_revenue
)

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN seller_rank <= 10 THEN revenue
                ELSE 0
            END
        ) / SUM(revenue),
        2
    ) AS top_10_seller_revenue_share

FROM ranked_sellers;