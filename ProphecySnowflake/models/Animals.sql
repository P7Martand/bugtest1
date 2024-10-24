WITH birds AS (

  SELECT * 
  
  FROM {{ ref('birds')}}

),

FlattenSchema_1 AS (

  {#Simplifies the structure of bird data for easier analysis.#}
  SELECT * 
  
  FROM birds AS in0

),

Deduplicate_1 AS (

  {#Removes duplicate records to ensure data accuracy and integrity.#}
  SELECT 
    DISTINCT DBT_UPDATED_AT AS DBT_UPDATED_AT,
    DBT_VALID_FROM AS DBT_VALID_FROM,
    DBT_VALID_TO AS DBT_VALID_TO
  
  FROM FlattenSchema_1 AS in0

),

Reformat_1 AS (

  {#Streamlines data by selecting key validity timestamps for further analysis.#}
  SELECT 
    DBT_VALID_TO AS DBT_VALID_TO,
    DBT_UPDATED_AT AS DBT_UPDATED_AT,
    DBT_VALID_FROM AS DBT_VALID_FROM
  
  FROM Deduplicate_1 AS in0

),

SQLStatement_1 AS (

  SELECT *
  
  FROM Reformat_1

),

Join_1 AS (

  {#Combines data from two sources to analyze validity and update timestamps for records.#}
  SELECT 
    in0.DBT_VALID_TO AS DBT_VALID_TO,
    in0.DBT_UPDATED_AT AS DBT_UPDATED_AT,
    in0.DBT_VALID_FROM AS DBT_VALID_FROM,
    in1.DBT_UPDATED_AT AS DBT_UPDATED_AT_1,
    in1.DBT_VALID_FROM AS DBT_VALID_FROM_1,
    in1.DBT_VALID_TO AS DBT_VALID_TO_1
  
  FROM SQLStatement_1 AS in0
  INNER JOIN birds AS in1
     ON 1 = 1

)

SELECT *

FROM Join_1
