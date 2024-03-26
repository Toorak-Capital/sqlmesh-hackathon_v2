MODEL (
  name dw_silver.bsi_loan,
  kind VIEW
);

SELECT
  LOAN_NUMBER AS servicer_loan_number,
  INV_ACCT_NBR AS originator_loan_number,
  BOARDED_TO_LOANSERV_DATE AS servicer_onboarded_date,
  INTEREST_RT AS servicer_interest_rate,
  TI_PMT AS ti_amount,
  CURRENT_LOAN_STATUS,
  DELQ_DAYS_INCLUDING_GRACE_DAYS AS status,
  PRINCIPAL_BAL AS unpaid_principal_balance,
  PI_PMT AS pi_amount,
  MATURITY_DATE AS original_maturity_date,
  CHARGE_OFF_DATE AS charge_off_date,
  DATA_DATE AS data_date,
  NEXT_PAYMENT_DUE_DATE AS next_payment_due_date,
  CURR_INDX_RATE AS current_index_rate,
  LAST_PMT_DATE AS last_payment_date,
  DLQ_STATUS AS deliquency_status,
  PREPAYMENT_PENALTY_CD AS prepayment_penalty_flag,
  LATE_CHARGE_GRACE_DAYS AS late_charge_grace_period,
  INTEREST_PAID_TO_DATE AS interest_paid_to_date,
  LATE_CHARGES_DUE AS unpaid_late_charges,
  NSF_CK_COUNT AS nsf_check_count,
  NSF_LAST_DATE AS nsf_last_date,
  UNAP_BAL_TOTAL AS suspense_balance,
  'BSI' AS servicer
FROM dw_bronze.bsi_loan