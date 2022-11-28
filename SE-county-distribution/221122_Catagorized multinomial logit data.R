##########################################
## Build data for multinomial logistic regression
## 3 categories: longleaf, loblolly, hardwood
## 6 combinations: no plantation, longleaf only, loblolly only,
##              hardwood only, longleaf & loblolly, softwood & hardwood
## Then export data
##
## Created by: Bingcai Liu
## 11/22/2022
############################################

## Data: load("~/GitHub/SE-forest-distribution/SE-county-distribution/SE_county_clustered.RData")


## Create categorized data
## 6 combinations: 0: no plantation, 1: longleaf only, 2: loblolly only,
##              3: hardwood only, 4: longleaf & loblolly, 5: softwood & hardwood

SE_reg$H_status = SE_reg$H_2527 + SE_reg$H_2628 + SE_reg$H_31 + SE_reg$H_32 + SE_reg$H_34 + SE_reg$H_35

SE_reg$presence_cat = 0
SE_reg$presence_cat[SE_reg$S_1 == 1 & SE_reg$S_2 == 0 & SE_reg$H_status == 0] = 1
SE_reg$presence_cat[SE_reg$S_1 == 0 & SE_reg$S_2 == 1 & SE_reg$H_status == 0] = 2
SE_reg$presence_cat[SE_reg$S_1 == 0 & SE_reg$S_2 == 0 & SE_reg$H_status > 0] = 3
SE_reg$presence_cat[SE_reg$S_1 == 1 & SE_reg$S_2 == 1 & SE_reg$H_status == 0] = 4
SE_reg$presence_cat[(SE_reg$S_1 == 1 | SE_reg$S_2 == 1) & SE_reg$H_status > 0] = 5

SE_reg %>% count(presence_cat)

library(foreign)
write.dta(SE_reg, "SE_reg_221122.dta")

## 8 combinations: 0: no plantation, 1: longleaf only, 2: loblolly only,
##              3: hardwood only, 4: longleaf & loblolly, 5: longleaf & hardwood
##              6: loblolly & hardwood, 7: all softwood & hardwood

library(tidyverse)

SE_reg$presence_cat_2 = 0
SE_reg$presence_cat_2[SE_reg$S_1 == 1 & SE_reg$S_2 == 0 & SE_reg$H_status == 0] = 1
SE_reg$presence_cat_2[SE_reg$S_1 == 0 & SE_reg$S_2 == 1 & SE_reg$H_status == 0] = 2
SE_reg$presence_cat_2[SE_reg$S_1 == 0 & SE_reg$S_2 == 0 & SE_reg$H_status > 0] = 3
SE_reg$presence_cat_2[SE_reg$S_1 == 1 & SE_reg$S_2 == 1 & SE_reg$H_status == 0] = 4
SE_reg$presence_cat_2[SE_reg$S_1 == 1 & SE_reg$S_2 == 0 & SE_reg$H_status > 0] = 5
SE_reg$presence_cat_2[SE_reg$S_1 == 0 & SE_reg$S_2 == 1 & SE_reg$H_status > 0] = 6
SE_reg$presence_cat_2[SE_reg$S_1 == 1 & SE_reg$S_2 == 1 & SE_reg$H_status > 0] = 7

SE_reg %>% count(presence_cat_2)

library(foreign)
write.dta(SE_reg, "SE_reg_221122.dta")


## Combinations for softwood: 0: others, 1: longleaf planted, 2: shortleaf planted
##                            3: natural longleaf 4: natural shortleaf 5:

library(tidyverse)
SE_reg$presence_cat_3 = 0
SE_reg$presence_cat_3[SE_reg$S_1 == 1 & SE_reg$S_2 == 0 & SE_reg$STDORGCD == 1] = 1
SE_reg$presence_cat_3[SE_reg$S_1 == 0 & SE_reg$S_2 == 1 & SE_reg$STDORGCD == 1] = 2
SE_reg$presence_cat_3[SE_reg$S_1 == 1 & SE_reg$S_2 == 0 & SE_reg$STDORGCD == 0] = 3
SE_reg$presence_cat_3[SE_reg$S_1 == 0 & SE_reg$S_2 == 1 & SE_reg$STDORGCD == 0] = 4
SE_reg$presence_cat_3[SE_reg$S_1 == 1 & SE_reg$S_2 == 1 & SE_reg$STDORGCD == 0] = 5

SE_reg %>% count(presence_cat_3)

library(foreign)
write.dta(SE_reg, "SE_reg_221122.dta")
