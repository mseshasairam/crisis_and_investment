* table 3 results for matched data
set more off
estimates clear
 cd "C:\Users\SESHA.LAPTOP-833NH1RT\Desktop\iimbrr"
use df_full.dta,clear
merge m:1 state year using election_data
drop _merge
replace election =0 if election==.
gen inter = time_dummy* TG_dummy
drop if year>=2015 | year<=2005
*generate dummy = 0
*replace dummy = 1 if year>=2010
*replace inter = dummy* TG_dummy

reghdfe chg_gfa_w inter  i.year , absorb(co_code) vce(cluster co_code)
est store a1
reghdfe chg_gfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election  i.year, absorb(co_code) vce(cluster co_code)
est store a2
reghdfe chg_gfa_w inter  i.year, absorb(co_code) vce(cluster co_code year)
est store a3
reghdfe chg_gfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election  i.year, absorb(co_code) vce(cluster co_code year)
est store a4
reghdfe chg_nfa_w inter  i.year, absorb(co_code) vce(cluster co_code)
est store a5
reghdfe chg_nfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election  i.year, absorb(co_code) vce(cluster co_code)
est store a6
reghdfe chg_nfa_w inter  i.year, absorb(co_code) vce(cluster co_code year)
est store a7
reghdfe chg_nfa_w inter l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w  election  i.year, absorb(co_code ) vce(cluster co_code year)
est store a8

outreg2 [a1 a2 a3 a4 a5 a6 a7 a8] using full_AP, dec(4) bracket excel replace  adjr2