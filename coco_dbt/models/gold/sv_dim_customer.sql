{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

{%- set create_semantic_view_sql -%}
CREATE OR REPLACE SEMANTIC VIEW COCO_DB.GOLD.SV_DIM_CUSTOMER
    TABLES (
        dim_customer AS COCO_DB.SILVER.DIM_CUSTOMER
            PRIMARY KEY (customer_sk)
            COMMENT = 'Customer dimension table'
    )
    DIMENSIONS (
        dim_customer.customer_sk AS customer_sk
            COMMENT = 'Customer surrogate key',
        dim_customer.customername AS customername
            COMMENT = 'Customer name',
        dim_customer.phone AS phone
            COMMENT = 'Customer phone number',
        dim_customer.addressline1 AS addressline1
            COMMENT = 'Address line 1',
        dim_customer.addressline2 AS addressline2
            COMMENT = 'Address line 2',
        dim_customer.city AS city
            COMMENT = 'City',
        dim_customer.state AS state
            COMMENT = 'State',
        dim_customer.postalcode AS postalcode
            COMMENT = 'Postal code',
        dim_customer.country AS country
            COMMENT = 'Country',
        dim_customer.territory AS territory
            COMMENT = 'Sales territory',
        dim_customer.contactlastname AS contactlastname
            COMMENT = 'Contact last name',
        dim_customer.contactfirstname AS contactfirstname
            COMMENT = 'Contact first name'
    )
    METRICS (
        dim_customer.customer_count AS COUNT(DISTINCT customername)
            COMMENT = 'Count of distinct customers'
    )
    COMMENT = 'Semantic view for customer dimension'
{%- endset -%}

SELECT '{{ create_semantic_view_sql | replace("'", "''") }}' AS semantic_view_ddl
