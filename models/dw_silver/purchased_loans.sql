MODEL (
  name dw_silver.purchased_loan,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column data_date
  ),
  cron '@daily',
  start '2024-03-16',
  grain (originator_loan_number, servicer_loan_number, data_date),
  audits (not_null(columns = (originator_loan_number, servicer_loan_number, status)), accepted_values(
    column = status,
    is_in = ('Active', 'DLQ', 'BKY', 'FCL', 'REO', 'PIF', 'Closed', 'Transfer')
  ))
);
 
SELECT
  *
FROM dw_silver.bsi_loan
/* UNION ALL */ /* SELECT * FROM dw_silver.fci_loan */ /* UNION ALL */ /* SELECT * FROM dw_silver.shellpoint_loan */
WHERE
  data_date BETWEEN @start_date AND @end_date