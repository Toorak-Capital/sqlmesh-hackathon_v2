{% macro StandardiseLoanStatus(status, delinquent_days) %}
  CASE 
    -- Standardize BSI statuses
    WHEN UPPER({{ status }}) IN ('0-29') AND CAST({{delinquent_days}} AS INT) == 0  THEN 'Active'
    WHEN UPPER({{ status }}) IN ('0-29', '30-59', '60-89', '90+') AND CAST({{delinquent_days}} AS INT) > 0 THEN 'DLQ'
    WHEN UPPER({{ status }}) = 'BKY' THEN 'BKY'
    WHEN UPPER({{ status }}) = 'FCL' THEN 'FCL'
    WHEN UPPER({{ status }}) = 'PIF' THEN 'PIF'
    WHEN UPPER({{ status }}) = 'REO' THEN 'REO'
    ELSE {{ status }}
  END
{% endmacro %}