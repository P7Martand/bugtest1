{% snapshot mod4 %}
{{
  config({    
    "strategy": "timestamp",
    "target_schema": "qa_db_warehouse",
    "unique_key": "c_int",
    "updated_at": "c_float"
  })
}}

WITH all_type_table_default AS (

  SELECT *
  
  FROM {{ source('hive_metastore.qa_db_warehouse', 'all_type_table_default') }}

)

SELECT *

FROM all_type_table_default

{% endsnapshot %}
