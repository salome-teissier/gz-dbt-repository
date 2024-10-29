WITH aggregated_orders AS (
    SELECT
        orders_id,
        date_date,         
        revenue,            
        quantity,
        (quantity * purchase_price) AS purchase_cost,               
    FROM {{ ref('int_sales_margin') }}       
    GROUP BY orders_id
),

SELECT
    orders_id,
    date_date,
    revenue,
    quantity,
    purchase_cost,
    (revenue - purchase_cost) AS margin    
FROM aggregated_orders;
