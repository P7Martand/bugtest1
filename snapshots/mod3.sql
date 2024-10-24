{% snapshot mod3 %}
{{
  config({    
    "check_cols": ["c_smallint"],
    "strategy": 'check',
    "target_schema": "qa_db_warehouse",
    "unique_key": "c_float",
    "updated_at": 
  })
}}

WITH all_type_table_default AS (

  SELECT * 
  
  FROM {{ source('hive_metastore.qa_db_warehouse', 'all_type_table_default') }}

)

SELECT *

FROM all_type_table_default

{% endsnapshot %}
