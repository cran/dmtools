## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = FALSE------------------------------------------------------
#  library(dmtools)

## ----preg_table, echo = FALSE, result = 'asis', warning = FALSE, message = FALSE----
library(knitr)
library(dmtools)
library(dplyr)

preg <- system.file("preg.xlsx", package = "dmtools")
table <- readxl::read_xlsx(preg)
kable(table, caption = "LB")

## ----preg_dataset, echo = FALSE, result = 'asis'------------------------------

id <- c("01", "02", "03")
site <- c("site 01", "site 02", "site 03")
sex <- c("f", "m", "f")
preg_yn_e2 <- c("y", "y", "y")
preg_res_e2 <- c("neg", "neg", "neg")
preg_yn_e3 <- c("y", "y", "n")
preg_res_e3 <- c("neg", "pos", "unnes")

df <- data.frame( 
       id, site, sex,
       preg_yn_e2, preg_res_e2,
       preg_yn_e3, preg_res_e3,
       stringsAsFactors = FALSE)

kable(df, caption = "dataset")

## ----preg---------------------------------------------------------------------
preg <- system.file("preg.xlsx", package = "dmtools")
obj_short <- short(preg, id, "LBORRES", c("site", "sex"))

obj_short <- obj_short %>% check(df)
obj_short %>% get_result()

## ----drug_table, echo = FALSE, result = 'asis', warning = FALSE, message = FALSE----
drug <- system.file("drug.xlsx", package = "dmtools")
table <- readxl::read_xlsx(drug)
kable(table, caption = "CM")

## ----drug_dataset, echo = FALSE, result = 'asis'------------------------------

id <- c("01", "02", "03")
e2_drug_type <- c("type_one", "type_two", "type_one")
e2_drug_amount <- c(2, 1, 2)
e3_drug_type <- c("type_one", "type_two", "type_one")
e3_drug_amount <- c(2, 1, 1)

df <- data.frame( 
       id, e2_drug_type, e2_drug_amount,
       e3_drug_type, e3_drug_amount,
       stringsAsFactors = FALSE)

kable(df, caption = "dataset")

## ----drug---------------------------------------------------------------------
drug <- system.file("drug.xlsx", package = "dmtools")
# parameter is_post has value FALSE because a dataset has a prefix in the names of variables
obj_short <- short(drug, id, "CMTRT", is_post = F)

obj_short <- obj_short %>% check(df)
obj_short %>% get_result()

## ----vf_table, echo = FALSE, result = 'asis', warning = FALSE, message = FALSE----
vf <- system.file("vf.xlsx", package = "dmtools")
table <- readxl::read_xlsx(vf)
kable(table, caption = "VS")

## ----vf_dataset, echo = FALSE, result = 'asis'--------------------------------

id <- c("01", "02", "03")
e2_hr <- c(60, 70, 76)
e2_respr <- c(12, 15, 16)
e3_hr <- c(65, 71, 86)
e3_respr <- c(13, 14, 18)

df <- data.frame( 
       id, e2_hr, e2_respr,
       e3_hr, e3_respr, 
       stringsAsFactors = FALSE)

kable(df, caption = "dataset")

## ----vf-----------------------------------------------------------------------
vf <- system.file("vf.xlsx", package = "dmtools")
obj_short <- short(vf, id, "VSTEST_HR", is_post = F)

obj_short <- obj_short %>% check(df)
obj_short %>% get_result()

## ----ae_table, echo = FALSE, result = 'asis', warning = FALSE, message = FALSE----
ae <- system.file("ae.xlsx", package = "dmtools")
table <- readxl::read_xlsx(ae)
kable(table, caption = "AE")

## ----ae_dataset, echo = FALSE, result = 'asis'--------------------------------

id <- c("01", "02", "03")
ast_e2 <- c(32, 56, 60)
ast_norm_e2 <- c("norm", "no", "no")
ast_cl_e2 <- c(NA, "no", "yes")
ast_e3 <- c(36, 80, 32)
ast_norm_e3 <- c("norm", "no", "norm")
ast_cl_e3 <- c(NA, "yes", NA)
ae_yn_e5 <- c("no", "yes", "no")
ae_desc_e5 <- c(NA, "abnormal ast", NA)

df <- data.frame( 
       id, ast_e2, ast_norm_e2, ast_cl_e2,
       ast_e3, ast_norm_e3, ast_cl_e3,
       ae_yn_e5, ae_desc_e5,
       stringsAsFactors = FALSE)

kable(df, caption = "dataset")

## ----ae-----------------------------------------------------------------------
ae <- system.file("ae.xlsx", package = "dmtools")
obj_short <- short(ae, id, "LBNRIND", common_cols = c("ae_yn_e5", "ae_desc_e5"), extra = "LBTEST")

obj_short <- obj_short %>% check(df)
obj_short %>% get_result()

