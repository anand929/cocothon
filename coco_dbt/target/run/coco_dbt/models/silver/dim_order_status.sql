
  
    

        create or replace transient table COCO_DB.SILVER.dim_order_status
         as
        (

SELECT DISTINCT
    SHA2(status || dealsize, 256) AS order_status_sk,
    status,
    dealsize
FROM COCO_DB.BRONZE.sales_data
        );
      
  