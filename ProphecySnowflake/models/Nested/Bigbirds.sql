WITH Animals AS (

  SELECT * 
  
  FROM {{ ref('Animals')}}

),

Subgraph_1 AS (

  WITH FlattenSchema_1 AS (
  
    {#Simplifies the structure of bird data for easier analysis.#}
    SELECT * 
    
    FROM Animals AS in0
  
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
  
  )
  
  SELECT * 
  
  FROM SQLStatement_1

),

Join_1 AS (

  {#Combines data on animal records with their validity periods for comprehensive tracking.#}
  SELECT 
    in0.DBT_VALID_TO AS DBT_VALID_TO,
    in0.DBT_UPDATED_AT AS DBT_UPDATED_AT,
    in0.DBT_VALID_FROM AS DBT_VALID_FROM,
    in1.DBT_UPDATED_AT_1 AS DBT_UPDATED_AT_1,
    in1.DBT_VALID_FROM_1 AS DBT_VALID_FROM_1,
    in1.DBT_VALID_TO_1 AS DBT_VALID_TO_1
  
  FROM Subgraph_1 AS in0
  INNER JOIN Animals AS in1
     ON in1.DBT_UPDATED_AT_1 = in0.DBT_UPDATED_AT

)

SELECT *

FROM Join_1
