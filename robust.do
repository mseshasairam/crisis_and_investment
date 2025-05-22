set more off
estimates clear
cd "D:\Krea_Google\Current Projects\Uncertainty and Investments\data_2023_apr"
use match.dta,clear
merge m:1 state year using election_data
drop _merge
replace election =0 if election==.
gen inter = time_dummy* TG_dummy
drop if year>=2015 | year<=2005
*generate dummy = 0
*replace dummy = 1 if year>=2010
*replace inter = dummy* TG_dummy

reghdfe chg_gfa_w inter, absorb(co_code year ind2) vce(cluster state year)
est store a1
reghdfe chg_gfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster state year)
est store a2
reghdfe chg_gfa_w inter, absorb(co_code year ind2) vce(cluster co_code year)
est store a3
reghdfe chg_gfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster co_code year)
est store a4
reghdfe chg_nfa_w inter, absorb(co_code year ind2) vce(cluster state year)
est store a5
reghdfe chg_nfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster state year)
est store a6
reghdfe chg_nfa_w inter, absorb(co_code year ind2) vce(cluster co_code year)
est store a7
reghdfe chg_nfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster co_code year)
est store a8
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using robust2a, dec(4) bracket excel replace

