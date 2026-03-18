
  
    

        create or replace transient table COCO_DB.SILVER.dim_date
         as
        (

SELECT DISTINCT
    SHA2(CAST(orderdate AS VARCHAR), 256) AS date_sk,
    orderdate,
    qtr_id,
    month_id,
    year_id
FROM COCO_DB.BRONZE.sales_data
WHERE orderdate IS NOT NULL
        );
      
  