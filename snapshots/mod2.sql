{% snapshot mod2 %}
{{
  config({    
    "check_cols": [],
    "strategy": 'timestamp',
    "target_schema": "qa_db_warehouse",
    "unique_key": "c_array",
    "updated_at": "c_double"
  })
}}

WITH all_type_table_default AS (

  SELECT *
  
  FROM {{ source('hive_metastore.qa_db_warehouse', 'all_type_table_default') }}

)

SELECT *

FROM all_type_table_default

{% endsnapshot %}
