rm(list=ls())
library(dplyr)
library(stringr)
library(MatchIt)
library(psych)
source("D:/Krea_Google/my_functions.R")
setwd("D:/Krea_Google/Current Projects/Uncertainty and Investments/data_2023_apr")

df <- readRDS("out1")
 # results for Andhra firms
#  df_renamed <- df %>%
#                select(-TG_dummy) %>% 
#                rename(TG_dummy = AP_dummy) %>% 
#                filter(state !="TG") %>% 
#                mutate(state = ifelse(state =="AP", "TG", state))
#  
# df <- df_renamed

df <- df %>% 
  filter(state !="AP", 
         !is.na(ind4),
         !is.na(TG_dummy),
         year>=2001 & year<=2014, #year= 2006 2001
         states_dummy==1)

trim = 0.01
df[, "chg_gfa_w"] <- psych::winsor(df[, "chg_gfa"], trim = trim, na.rm = TRUE)
df[, "chg_nfa_w"] <- psych::winsor(df[, "chg_nfa"], trim = trim, na.rm = TRUE)
df[, "l4_log_assets_w"] <- psych::winsor(df[, "l4_log_assets"], trim = trim, na.rm = TRUE)
df[, "l4_leverage_w"] <- psych::winsor(df[, "l4_leverage"], trim = trim, na.rm = TRUE)
df[, "l4_grw_sales_w"] <- psych::winsor(df[, "l4_grw_sales"], trim = trim, na.rm = TRUE)
df[, "l4_roa_w"] <- psych::winsor(df[, "l4_roa"], trim = trim, na.rm = TRUE)
df[, "l4_cfo_w"] <- psych::winsor(df[, "l4_cfo"], trim = trim, na.rm = TRUE)
df[, "grw_sales_w"] <- psych::winsor(df[, "grw_sales"], trim = trim, na.rm = TRUE)
df[, "roa_w"] <- psych::winsor(df[, "roa"], trim = trim, na.rm = TRUE)
df[, "cfo_w"] <- psych::winsor(df[, "cfo"], trim = trim, na.rm = TRUE)
df[, "cash_w"] <- psych::winsor(df[, "cash"], trim = trim, na.rm = TRUE)
df[, "leverage_w"] <- psych::winsor(df[, "leverage"], trim = trim, na.rm = TRUE)
df[, "fxd_dummy_w"] <- psych::winsor(df[, "fxd_dummy"], trim = trim, na.rm = TRUE)
length(table(df$year))

df1  <- df %>% 
  group_by(co_code) %>% 
  mutate(periods = n(),
         keep_controls = ifelse(periods >=1 & TG_dummy == 0, 1, 0)) %>%
  filter(keep_controls == 1 | TG_dummy == 1, periods >= 1) %>% 
  as.data.frame()

table(df1$TG_dummy)

df <- df1

df.full <- df

df <- df %>% 
  group_by(co_code) %>% 
  mutate(ind = ind4) %>% # ind = ind3
  filter(year<2010 & year>=2006) %>%
  select(co_code, periods, ind, TG_dummy, l4_log_assets_w,  l4_roa_w, l4_leverage_w, 
         l4_grw_sales_w, l4_cfo_w) %>% 
  as.data.frame()

df.agg = aggregate(. ~ co_code, data = df, mean)

