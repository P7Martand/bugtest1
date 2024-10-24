{% snapshot birds %}
{{
  config({    
    "strategy": "timestamp",
    "target_schema": "qa_schema",
    "unique_key": "LAST_LOGIN_TIME",
    "updated_at": "MY_STRUCT_VAR"
  })
}}

WITH VARIANT_ALL_TYPES AS (

  SELECT *
  
  FROM {{ source('ROHIT.VARIANT_SCHEMA', 'VARIANT_ALL_TYPES') }}

)

SELECT *

FROM VARIANT_ALL_TYPES

{% endsnapshot %}
