MODEL (
  name dw_gold.servicer_aum,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column date
  ),
  start '2024-03-16',
  cron '@daily',
  grain (servicer, date),
  audits (
    not_null(columns = (aum, date))
  )
);
 
SELECT
  servicer,
  data_date AS date,
  SUM(unpaid_principal_balance) AS aum,
  FORMAT_DATE('%j', data_date + 1) AS D_O_Y,
  EXTRACT(YEAR FROM data_date + 1) AS year
FROM dw_silver.active_loan
GROUP BY
  servicer,
  data_date