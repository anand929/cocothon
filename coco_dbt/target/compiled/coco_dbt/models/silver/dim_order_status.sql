

SELECT DISTINCT
    SHA2(status || dealsize, 256) AS order_status_sk,
    status,
    dealsize
FROM COCO_DB.BRONZE.v_sales_data