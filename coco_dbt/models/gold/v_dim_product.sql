{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

SELECT
    PRODUCT_SK AS PRODUCT_KEY,
    PRODUCTCODE AS PRODUCT_CODE,
    PRODUCTLINE AS PRODUCT_LINE,
    MSRP AS SUGGESTED_RETAIL_PRICE
FROM {{ ref('dim_product') }}
