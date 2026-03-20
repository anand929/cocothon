{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

SELECT
    ORDER_STATUS_SK AS ORDER_STATUS_KEY,
    STATUS AS ORDER_STATUS,
    DEALSIZE AS DEAL_SIZE_CATEGORY
FROM {{ ref('dim_order_status') }}
