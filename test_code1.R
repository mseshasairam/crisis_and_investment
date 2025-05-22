rm(list=ls())
library(dplyr);
library(tidyr);
library(haven)
source("D:/Krea_Google/my_functions.R")
setwd("D:/Krea_Google/Current Projects/Uncertainty and Investments/data_2023_apr")

filename <- grep("\\_dat\\.txt", list.files(), value=TRUE)

df1 <- read.delim(filename[2], sep = "|")
df2 <- read.delim(filename[1], sep = "|")
df2 <- df2[, c("co_code","cin_code")]
df2 <- df2[!duplicated(df2[, c("co_code")]),] 

names(df1) <- substring(names(df1), 4)
df1[, "co_code"] <- as.numeric(df1[, "finance1_cocode"])
df1[, "year"] <- as.numeric(substr(df1[, "finance1_year"], 7, 10))

df1 <- left_join(df1, df2, by = c("co_code"))
df1 <- df1 %>% 
  mutate(
    year = as.numeric(substr(finance1_year, 7, 10)),
    age = year- as.numeric(substr(cin_code, 9, 12)),
    state = substr(cin_code,7,8),
    length_cin = str_length(cin_code),
    list_dummy = substr(cin_code, 1, 1),
    list = ifelse(list_dummy == "L", 1, 0),
    time_dummy = ifelse(year>2010, 1, 0),
    TG_dummy = ifelse(state == "TG", 1, 0),
    AP_dummy = ifelse(state == "AP", 1, 0),
    TG_AP_dummy = ifelse(state == "AP" | state == "TG", 1, 0),
    states_dummy = ifelse(  state == "AP" | 
                            state == "TG" |
                            state == "TN" |
                            state == "MH" |
                            state == "OR" |
                            state == "CH" |
                            state == "KA", 1, 0),
    pre = ifelse(year<=2010, 1, 0),
    dur = ifelse(year>=2011 & year<=2014, 1, 0),
    post = ifelse(year>2014, 1, 0),
    ind2 = as.numeric(substr(cin_code, 2, 3)),
    ind3 = as.numeric(substr(cin_code, 2, 4)),
    ind4 = as.numeric(substr(cin_code, 2, 5)),
    ind5 = as.numeric(substr(cin_code, 2, 6))) %>%
  arrange(co_code, year) %>% 
  as.data.frame()

df1 <- df1[!duplicated(df1[, c("co_code", "year")]),]  
tmp <- expand.grid(unique(df1[, "year"]), unique(df1[, "co_code"]))
names(tmp) <- c("year", "co_code")

df1 <- tmp %>%
  left_join(df1, by = c("co_code", "year")) %>%
  arrange(co_code, year) %>%
  select(co_code, year, everything())

df1 <- df1 %>%
  arrange(co_code, year) %>%
  group_by(co_code) %>%
  mutate(log_assets = log(1 + total_assets),
         lag_total_assets = lag(total_assets, order_by = year),
         lag_sales = lag(sales, 1, order_by = year),
         grw_sales = (sales - lag_sales)/lag_sales,
         grw_sales = ifelse(grw_sales > 1 , 1, grw_sales),
         grw_sales = ifelse(grw_sales < -1 , -1, grw_sales),
         leverage = borrowings/total_assets,
         fxd_dummy = gross_fixed_assets/total_assets,
         lag_cash  = lag(cash_bank_bal, 1, order_by = year),
         cash  = (cash_bank_bal-lag_cash)/lag_total_assets,
         cfo = cf_net_frm_op_activity/lag_total_assets,
         roa = pbt/lag_total_assets,
         lag_gross_fixed_assets = lag(gross_fixed_assets, 1, order_by = year),
         lag_net_fixed_assets = lag(net_fixed_assets, 1, order_by = year),
         chg_gfa = (gross_fixed_assets - lag_gross_fixed_assets)/lag_total_assets,
         chg_nfa = (net_fixed_assets - lag_net_fixed_assets)/lag_total_assets,
         l4_log_assets = lag(log_assets, 4, order_by = year),
         l4_grw_sales = lag(grw_sales, 4, order_by = year),
         l4_cfo = lag(cfo, 4,order_by = year),
         l4_roa = lag(roa, 4,order_by = year),
         l4_leverage = lag(leverage, 4, order_by = year)) %>% 
  as.data.frame()

df2 <- df1[!is.na(df1$company_name),]

vars = c("co_code", "year", "age", "state","length_cin",
         "list_dummy", "list", "time_dummy", 
         "TG_dummy", "AP_dummy", "TG_AP_dummy","states_dummy",
         "pre", "post", "dur", "ind2", "ind3", "ind4", "ind5", 
         "chg_gfa", "chg_nfa","l4_log_assets", "l4_leverage",
         "l4_grw_sales", "l4_roa", "l4_cfo", "age",
         "cash", "leverage","grw_sales", "roa", "cfo","fxd_dummy")

df2 <- df2 %>% 
  group_by(co_code) %>%
  mutate(l4_leverage = ifelse(is.na(l4_leverage),0,l4_leverage),
         leverage = ifelse(is.na(leverage),0,leverage)) %>% 
  select(all_of(vars)) %>% 
  filter(!is.na(chg_gfa),
         !is.na(l4_log_assets),
         !is.na(l4_roa),
         !is.na(l4_grw_sales), 
         !is.na(l4_cfo) ) %>% 
  ungroup() %>% 
  as.data.frame()

saveRDS(as.data.frame(df2), "out1")

