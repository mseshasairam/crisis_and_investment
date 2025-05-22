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
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using matched, dec(4) bracket excel replace


set more off
estimates clear
cd "G:\My Drive\Current Projects\Uncertainty and Investments\data_2023_apr"
use df_full.dta,clear
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
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using full, dec(4) bracket excel replace



set more off
estimates clear
cd "D:\Krea_Google\Current Projects\Uncertainty and Investments\data_2023_apr"
use match.dta,clear
merge m:1 state year using election_data
drop _merge
replace election =0 if election==.
egen median_fxd = median(fxd_dummy), by(year)
generate fx_dummy = 0
replace fx_dummy = 1 if fxd_dummy > median_fxd & !missing(fxd_dummy)
gen inter1 = time_dummy * TG_dummy
gen inter2 = fx_dummy * TG_dummy
gen inter3 = time_dummy* fx_dummy
gen inter = time_dummy * TG_dummy *fx_dummy
drop if year>=2015 | year<=2005
reghdfe chg_nfa_w inter* election , absorb(state year ind2) vce(cluster state year)
est store a1
reghdfe chg_gfa_w inter* election , absorb(state year ind2) vce(cluster state year)
est store a2
reghdfe chg_nfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(state year ind2) vce(cluster state year)
est store a3
reghdfe chg_gfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(state year ind2) vce(cluster state year)
est store a4
reghdfe chg_nfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster state year)
est store a5
reghdfe chg_gfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster state year)
est store a6
reghdfe chg_nfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster co_code year)
est store a7
reghdfe chg_gfa_w inter* l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election, absorb(co_code year ind2) vce(cluster co_code year)
est store a8
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using sources, dec(4) bracket excel replace



