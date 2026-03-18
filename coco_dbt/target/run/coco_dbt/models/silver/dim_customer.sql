
  
    

        create or replace transient table COCO_DB.SILVER.dim_customer
         as
        (

SELECT DISTINCT
    SHA2(customername || COALESCE(phone, '') || COALESCE(city, '') || COALESCE(country, ''), 256) AS customer_sk,
    customername,
    phone,
    addressline1,
    addressline2,
    city,
    state,
    postalcode,
    country,
    territory,
    contactlastname,
    contactfirstname
FROM COCO_DB.BRONZE.sales_data
        );
      
  