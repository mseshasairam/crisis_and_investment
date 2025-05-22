### Matching
library(haven)
m.out1 <- matchit(TG_dummy ~ l4_log_assets_w + l4_roa_w + l4_leverage_w + 
                             l4_grw_sales_w  + l4_cfo_w + ind,
                  data = df.agg,
                  method = "nearest",
                  link = "logit",
                  # ratio = 2,
                  # ratio = 4,
                  # ratio = 5,
                  ratio = 3,
                   distance = "glm",
                  # caliper = 0.1,
                  replace = TRUE) # FALSE

df.m <- m.out1$match.matrix

matched_pairs = list()

X1 <- df.agg[rownames(df.m), c("co_code")]

k = dim(m.out1$match.matrix)[2]

for (i in 1:k){
  matched_pairs[[i]] = df.agg[as.numeric(df.m[, i]), c("co_code")]
}

names(matched_pairs) = paste0("X", 2:(k+1))

df.m <- data.frame(X1, data.frame(matched_pairs))

df.m$match_group = row.names(df.m)

r1 <- left_join(df.full, df.m, by = c("co_code" = "X1"))
r1 <- na.omit(r1[, c("year", "co_code", names(matched_pairs))])

var_select <- dplyr::setdiff(names(r1), c("year"))

r2 <- r1 %>%
  gather(X, co_code, all_of(var_select)) %>% 
  select(-X) %>% 
  mutate(id="yes")

match <- as.data.frame(left_join(df.full, r2, by=c("year","co_code")))

match <- match %>% 
  filter(id=="yes") %>% 
  as.data.frame()

m.out2 <- matchit(TG_dummy ~ l4_log_assets_w + l4_roa_w + l4_leverage_w + 
                             l4_grw_sales_w  + l4_cfo_w + ind4,
                  data = match[match$time_dummy == 0,],
                  method = NULL, 
                  distance = "glm")
summary(m.out2)

m.out3 <- matchit(TG_dummy ~ l4_log_assets_w + l4_roa_w + l4_leverage_w + 
                             l4_grw_sales_w  + l4_cfo_w + ind4,
                  data = match[match$time_dummy == 1,],
                  method = NULL, 
                  distance = "glm")
summary(m.out3)

m.out4 <- matchit(TG_dummy ~ l4_log_assets_w + l4_roa_w + l4_leverage_w + 
                             l4_grw_sales_w  + l4_cfo_w + ind4,
                  data = df.full[df.full$time_dummy==0,],
                  method = NULL,
                  distance = "glm")
summary(m.out4)

m.out5 <- matchit(TG_dummy ~ l4_log_assets_w + l4_roa_w + l4_leverage_w + 
                             l4_grw_sales_w  + l4_cfo_w + ind3,
                  data = df.full[df.full$time_dummy==1,],
                  method = NULL,
                  distance = "glm")
summary(m.out5)

haven::write_dta(df.full, "df_full.dta")
haven::write_dta(match, "match.dta")

df.gr_full1 <- aggregate(df.full$chg_nfa_w, list(df.full$year, df.full$TG_dummy), mean)
df.gr_full2 <- aggregate(df.full$chg_gfa_w, list(df.full$year, df.full$TG_dummy), mean)

df.gr_match1 <- aggregate(match$chg_nfa_w, list(match$year, match$TG_dummy), mean)
df.gr_match2 <- aggregate(match$chg_gfa_w, list(match$year, match$TG_dummy), mean)

plot(df.gr_match1$Group.1, df.gr_match1$x,
     type = "b",
     pch = 19,
     col = factor(df.gr_match1$Group.2))

plot(df.gr_match2$Group.1, df.gr_match2$x,
     type = "b",
     pch = 19,
     col = factor(df.gr_match2$Group.2))


plot(df.gr_full1$Group.1, df.gr_full1$x,
     type = "b",
     pch = 19,
     col = factor(df.gr_full1$Group.2))

plot(df.gr_full2$Group.1, df.gr_full2$x,
     type = "b",
     pch = 19,
     col = factor(df.gr_full2$Group.2))