library(lfe)
library(ggthemes)
beta = vector()
for(i in 1:10000){
df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
df.full$inter = df.full$sim_dummy*df.full$time_dummy

reghdfe = felm(chg_gfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                           l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | co_code+year, 
               data = df.full,  
               exactDOF = TRUE, 
               cmethod = "cgm2") 
beta[i] = reghdfe$beta[1]
}

beta1 = data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | co_code+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta2 = data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | state+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta3 = data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | state+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta4 = data.frame(beta)
warnings()

###########################
beta = vector()
for(i in 1:10000){
df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
df.full$inter = df.full$sim_dummy*df.full$time_dummy

reghdfe = felm(chg_gfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                 l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | co_code+year, 
               data = df.full,  
               exactDOF = TRUE, 
               cmethod = "cgm2") 
beta[i] = reghdfe$beta[1]
}

beta5= data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | co_code+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta6 = data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | state+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta7 = data.frame(beta)
warnings()

beta = vector()
for(i in 1:10000){
  df.full$sim_dummy = rbinom(dim(df.full)[1], 1, mean(df.full$TG_dummy))
  
  df.full$inter = df.full$sim_dummy*df.full$time_dummy
  
  reghdfe = felm(chg_nfa_w ~ inter+l4_log_assets_w + l4_leverage_w + l4_grw_sales_w +
                   l4_roa_w  + l4_cfo_w |co_code+ind2+year| 0 | state+year, 
                 data = df.full,  
                 exactDOF = TRUE, 
                 cmethod = "cgm2") 
  beta[i] = reghdfe$beta[1]
}

beta8 = data.frame(beta)
warnings()

myList <- list(beta1, beta2, beta3, beta4, beta5, beta6, beta7, beta8)

write.csv(myList, "myList.csv", row.names = FALSE)







ggplot(beta1, aes(beta)) +
  stat_ecdf(geom = "step", size = 1) +
  ylab("Cumulative Probability") +
  geom_hline(yintercept = 0.1, linewidth = 1) +
  ggtitle("gfa") +
  theme_classic(base_size = 20)

ggplot(beta2, aes(beta)) +
  stat_ecdf(geom = "step", size = 1) +
  ylab("Cumulative Probability") +
  geom_hline(yintercept = 0.1, linewidth = 1) +
  ggtitle("nfa") +
  theme_classic(base_size = 20)
