par(mfrow = c(2, 2))
tg_1 = df.full$chg_nfa_w [df.full$TG_dummy ==1 & df.full$time_dummy==1]
tg_0 = df.full$chg_nfa_w [df.full$TG_dummy ==1 & df.full$time_dummy==0]
nh_1 = df.full$chg_nfa_w [df.full$TG_dummy ==0 & df.full$time_dummy==1]
nh_0 = df.full$chg_nfa_w [df.full$TG_dummy ==0 & df.full$time_dummy==0]

tg_1 = density(tg_1)
tg_0 = density(tg_0)
nh_1 = density(nh_1)
nh_0 = density(nh_0)

plot(tg_1, 
     lwd = 2, 
     lty = 3,
     col = "black",
     ylim=c(0, 25), 
     xlab = "Fig 5a: nfa",
     main = "Telangana region", cex.lab=1.5, cex.axis=1.5)
lines(tg_0, col = "black", lwd = 2)

plot(nh_1, 
     lwd = 2, 
     lty = 3,
     col = "black",
     ylim=c(0, 25), 
     xlab = "Fig 5b: nfa",
     main = "Bordering states", cex.lab=1.5, cex.axis=1.5)
lines(nh_0, col = "black", lwd = 2)

tg_1 = df.full$chg_gfa_w [df.full$TG_dummy ==1 & df.full$time_dummy==1]
tg_0 = df.full$chg_gfa_w [df.full$TG_dummy ==1 & df.full$time_dummy==0]
nh_1 = df.full$chg_gfa_w [df.full$TG_dummy ==0 & df.full$time_dummy==1]
nh_0 = df.full$chg_gfa_w [df.full$TG_dummy ==0 & df.full$time_dummy==0]

tg_1 = density(tg_1)
tg_0 = density(tg_0)
nh_1 = density(nh_1)
nh_0 = density(nh_0)


plot(tg_1, 
     lwd = 2, 
     lty = 3,
     col = "black",
     ylim=c(0, 25), 
     xlab = "Fig 5c: gfa",
     main = "Telangana region", cex.lab=1.5, cex.axis=1.5)
lines(tg_0, col = "black", lwd = 2)

plot(nh_1, 
     lwd = 2, 
     lty = 3,
     col = "black",
     ylim=c(0, 25), 
     xlab = "Fig 5d: gfa",
     main = "Bordering states",cex.lab=1.5, cex.axis=1.5)
lines(nh_0, col = "black", lwd = 2)





###################NFA###########
