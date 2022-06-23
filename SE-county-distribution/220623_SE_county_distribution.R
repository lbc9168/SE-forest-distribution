#################################
# Get distribution by county
#
# 06-23-22
#################################

library(tidyverse)
library(plyr)
library(dplyr)

## Select county level presence data from county clustered data frame

SE_ct_presence_77to87 <- South_cluster_summed %>% 
  select(year, STATECD, COUNTYCD, S_1, S_2, H_2527, H_2628, H_31, H_32, H_34, H_35, count) %>%
  filter(year >= 1977 & year <= 1987 & STATECD != 51)


SE_ct_presence_07to17 <- South_cluster_summed %>% 
  select(year, STATECD, COUNTYCD, S_1, S_2, H_2527, H_2628, H_31, H_32, H_34, H_35, count) %>%
  filter(year >= 2007 & year <= 2017 & STATECD != 51)


## calculate the count of presence for each county
SE_ct_presence_77to87 <- ddply(SE_ct_presence_77to87, .(STATECD, COUNTYCD), summarize, 
                               S_1.sum=sum(S_1), S_2.sum=sum(S_2), H_2527.sum=sum(H_2527), H_2628.sum=sum(H_2628), 
                               H_31.sum=sum(H_31), H_32.sum=sum(H_32), H_34.sum=sum(H_34), H_35.sum=sum(H_35), 
                               count.sum=sum(count))

SE_ct_presence_07to17 <- ddply(SE_ct_presence_07to17, .(STATECD, COUNTYCD), summarize, 
                               S_1.sum=sum(S_1), S_2.sum=sum(S_2), H_2527.sum=sum(H_2527), H_2628.sum=sum(H_2628), 
                               H_31.sum=sum(H_31), H_32.sum=sum(H_32), H_34.sum=sum(H_34), H_35.sum=sum(H_35), 
                               count.sum=sum(count))

## calculate the presence probability for each county
sum_var_list <- c("S_1.sum","S_2.sum","H_2527.sum","H_2628.sum","H_31.sum","H_32.sum",
                  "H_34.sum","H_35.sum")

sum_var_list2 <- c("S_1_pct","S_2_pct","H_2527_pct","H_2628_pct","H_31_pct","H_32_pct",    
                   "H_34_pct","H_35_pct")

SE_ct_presence_77to87[, sum_var_list2] <- mapply(
  FUN = "/",
  SE_ct_presence_77to87[sum_var_list],
  SE_ct_presence_77to87["count.sum"]
)

SE_ct_presence_07to17[, sum_var_list2] <- mapply(
  FUN = "/",
  SE_ct_presence_07to17[sum_var_list],
  SE_ct_presence_07to17["count.sum"]
)

## Select STATECD, COUNTYCD, and their presence percentage
SE_ct_presence_77to87 <- SE_ct_presence_77to87 %>% 
  select(STATECD, COUNTYCD, S_1_pct, S_2_pct, H_2527_pct, H_2628_pct, H_31_pct, H_32_pct, H_34_pct, H_35_pct)
  

SE_ct_presence_07to17 <- SE_ct_presence_07to17 %>% 
  select(STATECD, COUNTYCD, S_1_pct, S_2_pct, H_2527_pct, H_2628_pct, H_31_pct, H_32_pct, H_34_pct, H_35_pct)

SE_ct_presence_07to17$FIPS = 1000*SE_ct_presence_07to17$STATECD + SE_ct_presence_07to17$COUNTYCD
SE_ct_presence_77to87$FIPS = 1000*SE_ct_presence_77to87$STATECD + SE_ct_presence_77to87$COUNTYCD

## Export distribution data
library(foreign)
write.csv(SE_ct_presence_77to87, "SE_ct_presence_77to87.csv")
write.csv(SE_ct_presence_07to17, "SE_ct_presence_07to17.csv")
