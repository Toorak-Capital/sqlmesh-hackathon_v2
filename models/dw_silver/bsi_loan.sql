MODEL (
  name dw_silver.bsi_loan,
  kind VIEW
);
 
@DEF(bsi_date_format, '%m/%d/%Y');
 
JINJA_QUERY_BEGIN;
SELECT
  LOAN_NUMBER AS servicer_loan_number,
  INV_ACCT_NBR AS originator_loan_number,
  PARSE_DATE(@bsi_date_format, BOARDED_TO_LOANSERV_DATE) AS servicer_onboarded_date,
  INTEREST_RT::FLOAT64 AS servicer_interest_rate,
  TI_PMT::NUMERIC AS ti_amount,
  {{StandardiseLoanStatus('CURRENT_LOAN_STATUS', 'DELQ_DAYS_INCLUDING_GRACE_DAYS')}}AS status,
  PRINCIPAL_BAL::NUMERIC AS unpaid_principal_balance,
  PI_PMT::NUMERIC AS pi_amount,
  PARSE_DATE(@bsi_date_format, MATURITY_DATE) AS original_maturity_date,
  PARSE_DATE(@bsi_date_format, CHARGE_OFF_DATE) AS charge_off_date,
  PARSE_DATE(@bsi_date_format, DATA_DATE) AS data_date,
  PARSE_DATE(@bsi_date_format, NEXT_PAYMENT_DUE_DATE) AS next_payment_due_date,
  CURR_INDX_RATE::NUMERIC AS current_index_rate,
  PARSE_DATE(@bsi_date_format, LAST_PMT_DATE) AS last_payment_date,
  DLQ_STATUS AS deliquency_status,
  PREPAYMENT_PENALTY_CD AS prepayment_penalty_flag,
  LATE_CHARGE_GRACE_DAYS::INT64 AS late_charge_grace_period,
  PARSE_DATE(@bsi_date_format, INTEREST_PAID_TO_DATE) AS interest_paid_to_date,
  LATE_CHARGES_DUE::NUMERIC AS unpaid_late_charges,
  NSF_CK_COUNT::INT64 AS nsf_check_count,
  PARSE_DATE(@bsi_date_format, NSF_LAST_DATE) AS nsf_last_date,
  UNAP_BAL_TOTAL::NUMERIC AS suspense_balance,
  'BSI' AS servicer
FROM dw_bronze.bsi_loan
JINJA_END;