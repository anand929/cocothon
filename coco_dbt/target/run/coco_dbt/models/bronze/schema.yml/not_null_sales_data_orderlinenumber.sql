select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select orderlinenumber
from COCO_DB.BRONZE.sales_data
where orderlinenumber is null



      
    ) dbt_internal_test