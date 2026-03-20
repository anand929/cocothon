{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

{%- set create_semantic_view_sql -%}
CREATE OR REPLACE SEMANTIC VIEW COCO_DB.GOLD.SV_DIM_ORDER_STATUS
    TABLES (
        dim_order_status AS COCO_DB.SILVER.DIM_ORDER_STATUS
            PRIMARY KEY (order_status_sk)
            COMMENT = 'Order status dimension table'
    )
    DIMENSIONS (
        dim_order_status.order_status_sk AS order_status_sk
            COMMENT = 'Order status surrogate key',
        dim_order_status.status AS status
            COMMENT = 'Order status',
        dim_order_status.dealsize AS dealsize
            COMMENT = 'Deal size category'
    )
    METRICS (
        dim_order_status.status_count AS COUNT(DISTINCT status)
            COMMENT = 'Count of distinct order statuses'
    )
    COMMENT = 'Semantic view for order status dimension'
{%- endset -%}

SELECT '{{ create_semantic_view_sql | replace("'", "''") }}' AS semantic_view_ddl
