{{
    config(
        materialized='table',
        database='COCO_DB',
        schema='SILVER'
    )
}}

SELECT DISTINCT
    SHA2(productcode, 256) AS product_sk,
    productcode,
    productline,
    msrp
FROM {{ ref('v_sales_data') }}
