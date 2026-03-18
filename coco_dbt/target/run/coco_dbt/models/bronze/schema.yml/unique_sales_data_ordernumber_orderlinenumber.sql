select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    ordernumber || '-' || orderlinenumber as unique_field,
    count(*) as n_records

from COCO_DB.BRONZE.sales_data
where ordernumber || '-' || orderlinenumber is not null
group by ordernumber || '-' || orderlinenumber
having count(*) > 1



      
    ) dbt_internal_test