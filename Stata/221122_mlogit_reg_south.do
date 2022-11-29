** multinomial logit regression 
** Created by: Bingcai Liu
** 2022-11-22


** 22-11-22 test regression
mlogit presence_cat ppt_sp_10y ppt_su_10y ppt_f_10y ppt_w_10y tmean_sp_10y tmean_su_10y tmean_f_10y tmean_w_10y /* 
					*/ppt_sp_10y_sq ppt_su_10y_sq ppt_f_10y_sq ppt_w_10y_sq /*
                  */tmean_sp_10y_sq tmean_su_10y_sq tmean_f_10y_sq tmean_w_10y_sq /*
				  */SLOPE i.south_face i.Xeric i.Hydric pop_density i.private /*
				  */tms_price_SW tms_HW_price corn_GrossReturn Soybean_GrossReturn
				  
mlogit presence_cat_2 ppt_sp_10y ppt_su_10y ppt_f_10y ppt_w_10y tmean_sp_10y tmean_su_10y tmean_f_10y tmean_w_10y /* 
					*/ppt_sp_10y_sq ppt_su_10y_sq ppt_f_10y_sq ppt_w_10y_sq /*
                  */tmean_sp_10y_sq tmean_su_10y_sq tmean_f_10y_sq tmean_w_10y_sq /*
				  */SLOPE i.south_face i.Xeric i.Hydric pop_density i.private /*
				  */tms_price_SW tms_HW_price corn_GrossReturn Soybean_GrossReturn
				  

				  
				
				  
**** mixed logit learn ****
use https://www.stata-press.com/data/r17/inschoice
cmset id insurance

cmmixlogit choice income 
cmmixlogit choice, casevars(income)	
cmmixlogit choice premium income, random(deductible)		  



** 22-11-28 
** mixed logit test after generating rent variable
cmset ID cover_name

cmmixlogit choice rent_est, casevars(ppt_sp_10y ppt_su_10y ppt_f_10y ppt_w_10y tmean_sp_10y tmean_su_10y tmean_f_10y tmean_w_10y /* 
					*/ppt_sp_10y_sq ppt_su_10y_sq ppt_f_10y_sq ppt_w_10y_sq /*
                  */tmean_sp_10y_sq tmean_su_10y_sq tmean_f_10y_sq tmean_w_10y_sq /*
				  */SLOPE i.south_face i.Xeric i.Hydric pop_density i.private /*
				  */tms_price_SW tms_HW_price corn_GrossReturn Soybean_GrossReturn)


cmmixlogit choice rent_est 
