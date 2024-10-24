{% snapshot mod1 %}
{{
  config({    
    "check_cols": ["c_boolean"],
    "strategy": 'check',
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

{% if is_incremental() %}
  
  WHERE true > (
          SELECT MAX(true)
          
          FROM {{this}}
         )
{% endif %}

{% endsnapshot %}
