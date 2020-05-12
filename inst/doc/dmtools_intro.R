## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
#  library(dmtools)

## ----refer, echo = FALSE, result = 'asis', warning = FALSE, message = FALSE----
library(knitr)
library(dmtools)
library(dplyr)

refs <- system.file("labs_refer.xlsx", package = "dmtools")
refers <- readxl::read_xlsx(refs)
kable(refers, caption = "lab reference ranges")

## ----dataset, echo = FALSE, result = 'asis'-----------------------------------

id <- c("01", "02", "03")
age <- c("19", "20", "22")
sex <- c("f", "m", "m")
gluc_post <- c("5.5", "4.1", "9.7")
gluc_res_post <- c("norm", NA, "norm")
ast_post <- c("30", "48", "31")
ast_res_post <- c("norm", "norm", "norm")

df <- data.frame(
  id, age, sex,
  gluc_post, gluc_res_post,
  ast_post, ast_res_post,
  stringsAsFactors = F
)

kable(df, caption = "dataset")

## ----lab----------------------------------------------------------------------
# "norm" and "no" it is an example, necessary variable for the estimate, get from the dataset
refs <- system.file("labs_refer.xlsx", package = "dmtools")
obj_lab <- lab(refs, id, age, sex, "norm", "no")
obj_lab <- obj_lab %>% check(df)

# ok - analysis, which has a correct estimate of the result
obj_lab %>% choose_test("ok")

# mis - analysis, which has an incorrect estimate of the result
obj_lab %>% choose_test("mis")

# skip - analysis, which has an empty value of the estimate
obj_lab %>% choose_test("skip")

# all analyzes 
obj_lab %>% get_result()

## ----timelines, echo = FALSE, result = 'asis', warning = F, message = FALSE----

dates <- system.file("dates.xlsx", package = "dmtools")
timeline <- readxl::read_xlsx(dates)
kable(timeline, caption = "timeline")

## ----dataset_dates, echo = FALSE, result = 'asis'-----------------------------

id <- c("01", "02", "03")
screen_date_E1 <- c("1991-03-13", "1991-03-07", "1991-03-08")
rand_date_E2 <- c("1991-03-15", "1991-03-11", "1991-03-10")
ph_date_E3 <- c("1991-03-21", "1991-03-16", "1991-03-16")
bio_date_E3 <- c("1991-03-23", "1991-03-16", "1991-03-16")

df <- data.frame(
  id, screen_date_E1, rand_date_E2, ph_date_E3, bio_date_E3,
  stringsAsFactors = F
)

kable(df, caption = "dataset")

## ----date---------------------------------------------------------------------
# use parameter str_date for search columns with dates, default:"DAT"
dates <- system.file("dates.xlsx", package = "dmtools")
obj_date <- date(dates, id, dplyr::contains, dplyr::matches)
obj_date <- obj_date %>% check(df)

# out - dates, which are out of the protocol's timeline
obj_date %>% choose_test("out")

# uneq - dates, which are unequal
obj_date %>% choose_test("uneq")

# ok - correct dates
obj_date %>% choose_test("ok")

# all dates
obj_date %>% get_result()

## ----wbcc, echo = FALSE, result = 'asis', warning = F, message = FALSE--------
wbcc_file <- system.file("wbcc.xlsx", package = "dmtools")
wbcc <- readxl::read_xlsx(wbcc_file)
kable(wbcc, caption = "wbcc")

## ----dataset_wbcc, echo = FALSE, result = 'asis'------------------------------
id <- c("01", "02", "03")
wbc_post <- c(5.6, 7.8, 8.1)
lym_rel_post <- c(21, 25, 30)
lym_abs_post <- c(1.18, 1.95, 2.13)

df <- data.frame(
  id, wbc_post, lym_rel_post, lym_abs_post,
  stringsAsFactors = F
)

kable(df, caption = "dataset")

## ----wbc----------------------------------------------------------------------
wbcc_file <- system.file("wbcc.xlsx", package = "dmtools")
wbcc <- wbc(wbcc_file, id)
wbcc <- wbcc %>% check(df)

# mis - wbc, which has an incorrect calculation
wbcc %>% choose_test("mis")

# ok - wbc, which has a correct calculation
wbcc %>% choose_test("ok")

# all WBCs count
wbcc %>% get_result()

## ----refer_sites, echo = FALSE, result = 'asis'-------------------------------
refs_s01 <- system.file("labs_refer_s01.xlsx", package = "dmtools")
refers_s01 <- readxl::read_xlsx(refs_s01)
kable(refers_s01, caption = "lab reference ranges s01")

refs_s02 <- system.file("labs_refer_s02.xlsx", package = "dmtools")
refers_s02 <- readxl::read_xlsx(refs_s02)
kable(refers_s02, caption = "lab reference ranges s02")

## ----dataset_sites, echo = FALSE, result = 'asis'-----------------------------
site <- c("site 01", "site 02")
id <- c("01", "02")
age <- c("19", "20")
sex <- c("f", "m")
gluc_post <- c("5.5", "4.1")
gluc_res_post <- c("norm", "no")
ast_post <- c("30", "48")
ast_res_post <- c(NA, "norm")

df <- data.frame(
  site, id, age, sex,
  gluc_post, gluc_res_post,
  ast_post, ast_res_post,
  stringsAsFactors = F
)

kable(df, caption = "dataset")

## ----sites--------------------------------------------------------------------
refs_s01 <- system.file("labs_refer_s01.xlsx", package = "dmtools")
refs_s02 <- system.file("labs_refer_s02.xlsx", package = "dmtools")

s01_lab <- lab(refs_s01, id, age, sex, "norm", "no", site = "site 01")
s02_lab <- lab(refs_s02, id, age, sex, "norm", "no", site = "site 02")

labs <- list(s01_lab, s02_lab)
labs <- labs %>% check_sites(df, site)

# mis - analysis, which has an incorrect estimate of the result
labs %>% test_sites(function (lab) choose_test(lab, "mis"))

# ok - analysis, which has a correct estimate of the result
labs %>% test_sites(function (lab) choose_test(lab, "ok")) 

# skip - analysis, which has an empty value of the estimate
labs %>% test_sites(function (lab) choose_test(lab, "skip"))

# all analyzes
labs %>% test_sites(function (lab) get_result(lab))

# you can combine sites, use |
comb_lab <- lab(refs_s01, id, age, sex, "norm", "no", site = "site 01|site 02")
comb_labs <- list(comb_lab)

comb_labs <- comb_labs %>% check_sites(df, site)
comb_labs %>% test_sites(function (lab) choose_test(lab, "mis"))

## ----rename, eval = FALSE-----------------------------------------------------
#  rename_dataset("./crfs", "old_name", "new_name", 2)

