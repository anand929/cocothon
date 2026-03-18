

SELECT DISTINCT
    SHA2(productcode, 256) AS product_sk,
    productcode,
    productline,
    msrp
FROM COCO_DB.BRONZE.sales_data