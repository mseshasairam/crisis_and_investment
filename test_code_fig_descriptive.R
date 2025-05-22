library(ggthemes)
library(ggplot2)

df_gr_full1 <- aggregate(df.full$chg_nfa_w, list(df.full$year, df.full$TG_dummy), mean)
df_gr_full2 <- aggregate(df.full$chg_gfa_w, list(df.full$year, df.full$TG_dummy), mean)

df_g1 = df.gr_full1
df_g2 = df.gr_full2

names(df_g1) = c("year","state", "investment")
df_g1$state = ifelse(df_g1$state ==0 ,"Bordering State","Telangana")
df_g1$names = "NFA"

names(df_g2) = c("year","state", "investment")
df_g2$state = ifelse(df_g2$state ==0 ,"Bordering State","Telangana")
df_g2$names = "GFA"

df.g = rbind.data.frame(df_g1,df_g2)

ggplot(data = df_g1, mapping = aes(x = year, y = investment, shape = factor(state))) +
  geom_path(linewidth = 2, colour = "black", linetype = "dashed" ) +
  geom_point(size = 4, colour = "black") +
  geom_vline(xintercept = 2010, linewidth = 1, linetype = 2) +
  scale_x_continuous(breaks = seq(2000, 2019, by = 1)) +
  labs(title = "NFA") +
  theme_classic(base_size = 20) +
  theme(legend.position = "bottom", legend.title = element_blank())

ggplot(data = df_g2, mapping = aes(x = year, y = investment, shape = factor(state))) +
  geom_path(linewidth = 2, colour = "black", linetype = "dashed") +
  geom_point(size = 4, colour = "black") +
  geom_vline(xintercept = 2010, linewidth = 1, linetype = 2) +
  scale_x_continuous(breaks = seq(2000, 2019, by = 1)) +
  labs(title = "GFA") +
  theme_classic(base_size = 20) +
  theme(legend.position = "bottom", legend.title = element_blank())
