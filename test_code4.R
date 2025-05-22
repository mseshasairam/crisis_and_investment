vars1 = c("chg_gfa_w", "chg_nfa_w", "l4_log_assets_w",
          "l4_leverage_w", "l4_roa_w", "l4_grw_sales_w", "l4_cfo_w", 
          "cash_w", "leverage_w", "fxd_dummy_w")

vars2 = c("l4_log_assets_w","l4_roa_w", "l4_leverage_w","l4_grw_sales_w","l4_cfo_w", "ind4")

tmp1 = df.full[df.full$TG_dummy ==1 & df.full$time_dummy == 0,vars2]
tmp2 = df.full[df.full$TG_dummy ==0 & df.full$time_dummy == 0,vars2]
tmp3 = df.full[df.full$TG_dummy ==1 & df.full$time_dummy == 1,vars2]
tmp4 = df.full[df.full$TG_dummy ==0 & df.full$time_dummy == 1,vars2]

tmp5 = match[match$TG_dummy ==1 & match$time_dummy == 0,vars2]
tmp6 = match[match$TG_dummy ==0 & match$time_dummy == 0,vars2]
tmp7 = match[match$TG_dummy ==1 & match$time_dummy == 1,vars2]
tmp8 = match[match$TG_dummy ==0 & match$time_dummy == 1,vars2]

df.m1 = diff.dfs(tmp1,tmp2,0,"w")
df.m2 = diff.dfs(tmp3,tmp4,0,"w")
df.m3 = diff.dfs(tmp5,tmp6,0,"w")
df.m4 = diff.dfs(tmp7,tmp8,0,"w")

df.1 = m.sign.clean(df.m1, "estimate","p.value")
df.2 = m.sign.clean(df.m2, "estimate","p.value")
df.3 = m.sign.clean(df.m3, "estimate","p.value")
df.4 = m.sign.clean(df.m4, "estimate","p.value")

df.1[,c("var.name","n","mean","se", "n.1","mean.1","se.1","vr")]
df.2[,c("var.name","n","mean","se", "n.1","mean.1","se.1","vr")]
df.3[,c("var.name","n","mean","se", "n.1","mean.1","se.1","vr")]
df.4[,c("var.name","n","mean","se", "n.1","mean.1","se.1","vr")]

xl_file1 =rbind.data.frame(df.1, df.2, df.3, df.4)
# viewxl(xl_file1)


tmp1 = df.full[df.full$TG_dummy ==1 & df.full$time_dummy == 0,vars1]
tmp2 = df.full[df.full$TG_dummy ==0 & df.full$time_dummy == 0,vars1]
tmp3 = df.full[df.full$TG_dummy ==1 & df.full$time_dummy == 1,vars1]
tmp4 = df.full[df.full$TG_dummy ==0 & df.full$time_dummy == 1,vars1]

tmp5 = match[match$TG_dummy ==1 & match$time_dummy == 0,vars1]
tmp6 = match[match$TG_dummy ==0 & match$time_dummy == 0,vars1]
tmp7 = match[match$TG_dummy ==1 & match$time_dummy == 1,vars1]
tmp8 = match[match$TG_dummy ==0 & match$time_dummy == 1,vars1]

df.des1 = m.sign.clean(diff.dfs(tmp7,tmp5,0,"w"), "estimate","p.value")
df.des2 = m.sign.clean(diff.dfs(tmp8,tmp6,0,"w"), "estimate","p.value")
xl_file2 = rbind.data.frame(df.des1, df.des2)
# viewxl(xl_file2)

df.des3 = m.sign.clean(diff.dfs(tmp3,tmp1,0,"w"), "estimate","p.value")
df.des4 = m.sign.clean(diff.dfs(tmp4,tmp2,0,"w"), "estimate","p.value")
xl_file3 =rbind.data.frame(df.des3, df.des4)
# viewxl(xl_file3)
