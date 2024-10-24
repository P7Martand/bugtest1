{{
  config({    
    "materialized": "view",
    "strategy": "timestamp",
    "target_schema": "qa_db_warehouse",
    "updated_at": "newdbt_value"
  })
}}

WITH mod6 AS (

  SELECT * 
  
  FROM {{ ref('mod6')}}

),

Filter_1 AS (

  {#Filters records to exclude specific values and ensure validity based on a threshold.#}
  SELECT * 
  
  FROM mod6 AS in0
  
  WHERE true AND dbt_scd_id != 'randomValue' AND dbt_valid_from >= 2.0

),

OrderBy_1 AS (

  {#Sorts filtered records by validity date and ID for better organization.#}
  SELECT * 
  
  FROM Filter_1 AS in0
  
  ORDER BY dbt_valid_from ASC NULLS LAST, dbt_scd_id ASC NULLS LAST

),

Reformat_1 AS (

  {#Transforms data to include updated timestamps and a new calculated value for further analysis.#}
  SELECT 
    dbt_updated_at AS dbt_updated_at,
    dbt_valid_from % 2 AS newdbt_value,
    dbt_valid_to AS dbt_valid_to,
    dbt_scd_id AS dbt_scd_id
  
  FROM OrderBy_1 AS in0

),

SQLStatement_1 AS (

  SELECT *
  
  FROM Reformat_1

),

Join_1 AS (

  {#Combines updated records with relevant historical data for comparison.#}
  SELECT 
    in0.dbt_updated_at AS dbt_updated_at,
    in1.dbt_scd_id AS dbt_scd_id,
    in1.dbt_valid_from AS dbt_valid_from,
    in1.dbt_valid_to AS dbt_valid_to,
    in0.newdbt_value AS newdbt_value
  
  FROM SQLStatement_1 AS in0
  INNER JOIN mod6 AS in1
     ON in1.dbt_updated_at >= in0.newdbt_value

)

SELECT *

FROM Join_1
