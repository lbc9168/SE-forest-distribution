####################################
## Volume calculation for loblolly and longleaf,
## Create rent estimator for each point according to species and age
## Created by: Bingcai Liu
## Date: 2022-11-28
####################################


#### 22-11-28: testing mixed logit ####

## Create an estimator of volume
## the estimator is just test numbers
## need to be replace with models from papers in the future

## Non-artificial: loblolly: exp(3-4/age), longleaf: exp(2-4/age)
## Artificial: loblolly: exp(3.1-4/age), longleaf: exp(2.1-4/age)
## mixed non-artificial: exp(2.5-4/age)

library(tidyverse)
SE_reg$yield_est = 0
SE_reg$yield_est[SE_reg$presence_cat_3 == 1] = exp(2.1-4/SE_reg$STDAGE)
SE_reg$yield_est[SE_reg$presence_cat_3 == 2] = exp(3.1-4/SE_reg$STDAGE)
SE_reg$yield_est[SE_reg$presence_cat_3 == 3] = exp(2-4/SE_reg$STDAGE)
SE_reg$yield_est[SE_reg$presence_cat_3 == 4] = exp(3-4/SE_reg$STDAGE)
SE_reg$yield_est[SE_reg$presence_cat_3 == 5] = exp(2.5-4/SE_reg$STDAGE)

## create an estimator of rent
## Rent = r*[PV*exp(-r*age) - $1000]/(1-exp(-r*age))

SE_reg$rent_est = 0.03*(SE_reg$tms_price_SW*SE_reg$yield_est*exp(-0.03*SE_reg$STDAGE))/(1-exp(-0.03*(SE_reg$STDAGE+1)))



#### Create a new dataframe for mixed logit
## for every point, list all 6 options, then calculate the yield and rent


SE_reg_mixlogit <- subset(SE_reg, select = c(presence_cat_3, ppt.sp.10y, ppt.su.10y, ppt.f.10y, ppt.w.10y, tmean.sp.10y,
                                             tmean.su.10y, tmean.f.10y, tmean.w.10y,  
                                             ppt.sp.10y_sq, ppt.su.10y_sq, ppt.f.10y_sq, ppt.w.10y_sq, 
                                             tmean.sp.10y_sq, tmean.su.10y_sq, tmean.f.10y_sq, tmean.w.10y_sq,
                                             SLOPE, south_face, Xeric, Hydric, pop_density, private, 
                                             tms_price_SW, tms_HW_price, corn_GrossReturn, Soybean_GrossReturn, STDAGE
))

## add choice vairable
SE_reg_mixlogit$choice = 1

SE_reg_mixlogit$ID <- 1:nrow(SE_reg_mixlogit)

library(dplyr)
library(tidyr)

SE_reg_mixlogit <- SE_reg_mixlogit %>% 
  group_by(ID) %>% 
  complete(presence_cat_3 = full_seq(0:5, 1)) %>%
  fill(ppt.sp.10y, ppt.su.10y, ppt.f.10y, ppt.w.10y, tmean.sp.10y,
       tmean.su.10y, tmean.f.10y, tmean.w.10y,  
       ppt.sp.10y_sq, ppt.su.10y_sq, ppt.f.10y_sq, ppt.w.10y_sq, 
       tmean.sp.10y_sq, tmean.su.10y_sq, tmean.f.10y_sq, tmean.w.10y_sq,
       SLOPE, south_face, Xeric, Hydric, pop_density, private, 
       tms_price_SW, tms_HW_price, corn_GrossReturn, Soybean_GrossReturn, STDAGE)


SE_reg_mixlogit_2 <- SE_reg_mixlogit %>% 
  fill(ppt.sp.10y, ppt.su.10y, ppt.f.10y, ppt.w.10y, tmean.sp.10y,
       tmean.su.10y, tmean.f.10y, tmean.w.10y,  
       ppt.sp.10y_sq, ppt.su.10y_sq, ppt.f.10y_sq, ppt.w.10y_sq, 
       tmean.sp.10y_sq, tmean.su.10y_sq, tmean.f.10y_sq, tmean.w.10y_sq,
       SLOPE, south_face, Xeric, Hydric, pop_density, private, 
       tms_price_SW, tms_HW_price, corn_GrossReturn, Soybean_GrossReturn, STDAGE, .direction = "up")

## fill other choices as 0

SE_reg_mixlogit_2$choice[is.na(SE_reg_mixlogit_2$choice)] = 0
  

## Add category names

SE_reg_mixlogit_2$cover_name <- "others"
SE_reg_mixlogit_2$cover_name[SE_reg_mixlogit_2$presence_cat_3 == 1] <- "longleaf_planted"
SE_reg_mixlogit_2$cover_name[SE_reg_mixlogit_2$presence_cat_3 == 2] <- "shortleaf_planted"
SE_reg_mixlogit_2$cover_name[SE_reg_mixlogit_2$presence_cat_3 == 3] <- "longleaf_natural"
SE_reg_mixlogit_2$cover_name[SE_reg_mixlogit_2$presence_cat_3 == 4] <- "shortleaf_natural"
SE_reg_mixlogit_2$cover_name[SE_reg_mixlogit_2$presence_cat_3 == 5] <- "mixed_natural"

## Create an estimator of volume
## the estimator is just test numbers
## need to be replace with models from papers in the future

## Non-artificial: loblolly: exp(3-4/age), longleaf: exp(2-4/age)
## Artificial: loblolly: exp(3.1-4/age), longleaf: exp(2.1-4/age)
## mixed non-artificial: exp(2.5-4/age)

library(tidyverse)
SE_reg_mixlogit_2$yield_est = 0
SE_reg_mixlogit_2$yield_est[SE_reg_mixlogit_2$presence_cat_3 == 1] = exp(2.1-4/SE_reg_mixlogit_2$STDAGE)
SE_reg_mixlogit_2$yield_est[SE_reg_mixlogit_2$presence_cat_3 == 2] = exp(3.1-4/SE_reg_mixlogit_2$STDAGE)
SE_reg_mixlogit_2$yield_est[SE_reg_mixlogit_2$presence_cat_3 == 3] = exp(2-4/SE_reg_mixlogit_2$STDAGE)
SE_reg_mixlogit_2$yield_est[SE_reg_mixlogit_2$presence_cat_3 == 4] = exp(3-4/SE_reg_mixlogit_2$STDAGE)
SE_reg_mixlogit_2$yield_est[SE_reg_mixlogit_2$presence_cat_3 == 5] = exp(2.5-4/SE_reg_mixlogit_2$STDAGE)

## create an estimator of rent
## Rent = r*[PV*exp(-r*age) - $1000]/(1-exp(-r*age))

SE_reg_mixlogit_2$rent_est = 0.03*(SE_reg_mixlogit_2$tms_price_SW * SE_reg_mixlogit_2$yield_est
                                   *exp(-0.03*SE_reg_mixlogit_2$STDAGE))/(1-exp(-0.03*(SE_reg_mixlogit_2$STDAGE+1)))

SE_reg_mixlogit_small <- subset(SE_reg_mixlogit_2, ID < 5000)


library(foreign)
write.dta(SE_reg_mixlogit_2, "SE_reg_221129.dta")
write.dta(SE_reg_mixlogit_small, "SE_mixedreg_small_221129.dta")

