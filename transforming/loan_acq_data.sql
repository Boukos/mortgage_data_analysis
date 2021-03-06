DROP TABLE loan_acq_data;
CREATE TABLE loan_acq_data AS
SELECT LOAN_ID, 
	ORIG_CHN, 
	cast(ORIG_RT as decimal(4,3)) AS ORIG_RT, 
	cast(ORIG_AMT as bigint) AS ORIG_AMT, 
	cast(ORIG_TRM as smallint) AS ORIG_TRM, 
	cast(substr(FRST_DTE, 1, 2) as smallint) AS FRST_DTE_MTH,
	cast(substr(FRST_DTE, 4) as smallint) AS FRST_DTE_YR,
	cast(OLTV as smallint) AS OLTV, 
	cast(OCLTV as smallint) AS OCLTV, 
	cast(NUM_BO as smallint) AS NUM_BO, 
	cast(DTI as smallint) AS DTI, 
	cast(CSCORE_B as smallint) AS CSCORE_B, 
	FTHB_FLG, 
	PURPOSE, 
	PROP_TYP, 
	cast(NUM_UNIT as smallint) AS NUM_UNIT,
	OCC_STAT, 
	STATE, 
	cast(ZIP_3 as smallint) AS ZIP_3, 
	cast(MI_PCT as smallint) AS MI_PCT, 
	PRODUCT_TYPE, 
	"FANNIE_MAE" as AGENCY
from fannie_mae_acq
UNION ALL
SELECT id_loan as LOAN_ID, 
	channel as ORIG_CHN, 
	cast(int_rt as decimal(4,3)) as ORIG_RT, 
	cast(orig_upb as bigint) as ORIG_AMT, 
	cast(orig_loan_term as smallint) as ORIG_TRM, 
	cast(substr(dt_first_pi,5) as smallint) as FRST_DTE_MTH,
	cast(substr(dt_first_pi,1,4) as smallint) as FRST_DTE_YR,
	cast(ltv as smallint) as OLTV, 
	cast(cltv as smallint) as OCLTV, 
	cast(cnt_borr as smallint) as NUM_BO, 
	cast(dti as smallint) as DTI, 
	cast(fico as smallint) as CSCORE_B, 
	CASE WHEN flag_fthb=" " THEN "U" ELSE flag_fthb END as FTHB_FLG, 
	CASE WHEN loan_purpose="N" THEN "R" ELSE loan_purpose END as PURPOSE, 
	prop_type as PROP_TYP, 
	cast(cnt_units as smallint) as NUM_UNIT,
	CASE WHEN occpy_sts="O" THEN "P" ELSE occpy_sts END as OCC_STAT, 
	st as STATE, 
	cast(zipcode as smallint) as ZIP_3, 
	CASE WHEN mi_pct = "000" THEN "" ELSE cast(mi_pct as smallint) END as MI_PCT, 
	prod_type as PRODUCT_TYPE,
	"FREDDIE_MAC" as AGENCY
from freddie_mac_acq
