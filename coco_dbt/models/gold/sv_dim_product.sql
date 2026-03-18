{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

{%- set create_semantic_view_sql -%}
CREATE OR REPLACE SEMANTIC VIEW COCO_DB.GOLD.SV_DIM_PRODUCT
    TABLES (
        dim_product AS COCO_DB.SILVER.DIM_PRODUCT
            PRIMARY KEY (product_sk)
            COMMENT = 'Product dimension table'
    )
    DIMENSIONS (
        dim_product.product_sk AS product_sk
            COMMENT = 'Product surrogate key',
        dim_product.productcode AS productcode
            COMMENT = 'Product code identifier',
        dim_product.productline AS productline
            COMMENT = 'Product line category',
        dim_product.msrp AS msrp
            COMMENT = 'Manufacturer suggested retail price'
    )
    METRICS (
        dim_product.product_count AS COUNT(DISTINCT productcode)
            COMMENT = 'Count of distinct products'
    )
    COMMENT = 'Semantic view for product dimension'
{%- endset -%}

SELECT '{{ create_semantic_view_sql | replace("'", "''") }}' AS semantic_view_ddl
