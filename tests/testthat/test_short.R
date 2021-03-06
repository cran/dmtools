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
  stringsAsFactors = FALSE
)

not_full <- data.frame(
  id, site, sex,
  preg_yn_e2, preg_res_e2,
  preg_res_e3,
  stringsAsFactors = FALSE
)

test_that("check don't stop if error", {
  obj_short <- short("preg.xlsx", id, "res", c("site", "sex"))
  expect_warning(check(obj_short, not_full), "can't bind")
})


test_that("check add columns", {
  obj_short <- short("preg.xlsx", id, "res", c("site", "sex"), is_add_cols = TRUE)
  obj_short <- check(obj_short, not_full)
  preg <- get_result(obj_short)
  expect_equal(ncol(preg), 7)
})


test_that("check the number of columns with common variables", {
  obj_short <- short("preg.xlsx", id, "res", c("site", "sex"))
  obj_short <- check(obj_short, df)
  preg <- get_result(obj_short)
  expect_equal(ncol(preg), 7)
})

test_that("check the number of columns without common variables", {
  short_no_com <- short("preg.xlsx", id, "res")
  short_no_com <- check(short_no_com, df)
  preg_no_com <- get_result(short_no_com)
  expect_equal(ncol(preg_no_com), 5)
})

test_that("check the number of columns with extra variables", {
  short_extra <- short("preg_extra.xlsx", id, "res", extra = "human_name")
  short_extra <- check(short_extra, df)
  preg_extra <- get_result(short_extra)
  expect_equal(ncol(preg_extra), 6)
})


test_that("check if the name_to_find is wrong", {
  error_name_to_find <- short("preg_extra.xlsx", id, "ress", extra = "human_name")
  expect_error(check(error_name_to_find, df), "name_to_find is wrong")
})
