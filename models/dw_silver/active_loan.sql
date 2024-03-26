MODEL (
  name dw_silver.active_loan,
  kind VIEW
);
 
SELECT
  *
FROM dw_silver.purchased_loan
WHERE
  NOT status IN ('PIF', 'LIQUIDATED') AND unpaid_principal_balance <> 0


