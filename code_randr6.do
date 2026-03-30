* yearly regressions
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


reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2006 ,robust
est store a1
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2007 ,robust
est store a2
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2008 ,robust
est store a3
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2009 ,robust
est store a4
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2010 ,robust
est store a5
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2011 ,robust
est store a6
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2012 ,robust
est store a7
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2013 ,robust
est store a8
reg chg_gfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2014 ,robust
est store a9
outreg2 [a1 a2 a3 a4 a5 a6 a7 a8 a9]  using year_reg, dec(4) bracket excel replace  adjr2

reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2006 ,robust
est store a1
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2007 ,robust
est store a2
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2008 ,robust
est store a3
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2009 ,robust
est store a4
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2010 ,robust
est store a5
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2011 ,robust
est store a6
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2012 ,robust
est store a7
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2013 ,robust
est store a8
reg chg_nfa_w TG_dummy l4_log_assets_w l4_leverage_w l4_grw_sales_w l4_roa_w l4_cfo_w     if year==2014 ,robust
est store a9


outreg2 [a1 a2 a3 a4 a5 a6 a7 a8 a9]  using year, dec(4) bracket excel replace  adjr2