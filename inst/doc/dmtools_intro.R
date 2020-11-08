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

ID <- c("01", "02", "03")
AGE <- c("19", "20", "22")
SEX <- c("f", "m", "m")
V1_GLUC <- c("5.5", "4.1", "9.7")
V1_GLUC_IND <- c("norm", NA, "norm")
V2_AST <- c("30", "48", "31")
V2_AST_IND <- c("norm", "norm", "norm")

df <- data.frame(
  ID, AGE, SEX,
  V1_GLUC, V1_GLUC_IND,
  V2_AST, V2_AST_IND,
  stringsAsFactors = F
)

kable(df, caption = "dataset")

## ----lab----------------------------------------------------------------------
# "norm" and "no" it is an example, necessary variable for the estimate, get from the dataset
# parameter is_post has value FALSE because a dataset has a prefix( V1_ ) in the names of variables
refs <- system.file("labs_refer.xlsx", package = "dmtools")
obj_lab <- lab(refs, ID, AGE, SEX, "norm", "no", is_post = FALSE)
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

## ----rename, eval = FALSE-----------------------------------------------------
#  rename_dataset("./crfs", "old_name", "new_name", 2)

