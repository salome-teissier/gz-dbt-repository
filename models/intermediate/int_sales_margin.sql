WITH sales_data AS (
    SELECT
        sales.orders_id,
        sales.products_id,
        CAST(sales.quantity AS FLOAT64) AS quantity,
        CAST(sales.revenue AS FLOAT64) AS revenue,
        CAST(product.purchase_price AS FLOAT64) AS purchase_price
    FROM {{ ref('stg_gz_raw_data__raw_gz_sales') }} AS sales
    JOIN {{ ref('stg_gz_raw_data__raw_gz_product') }} AS product
    ON sales.products_id = product.products_id
)

SELECT
    orders_id,
    products_id,
    quantity,
    revenue,
    purchase_price,
    quantity * purchase_price AS purchase_cost,  -- Calculate purchase cost
    revenue - (quantity * purchase_price) AS margin  -- Calculate margin
FROM sales_data

