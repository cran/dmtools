## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----auth, eval = FALSE-------------------------------------------------------
#  library(jsonlite)
#  library(dmtools)
#  
#  # read MedDRA id and API key from a CSV file
#  auth <- read.csv("api_auth.csv", sep = ";")
#  url_auth <- "https://midt.meddra.org/connect/token"
#  # get token
#  token <- meddra_auth(url_auth, auth$id, auth$api_key)

## ----search_api, eval = FALSE-------------------------------------------------
#  
#  url_search <- "https://mapit.meddra.org/api/search"
#  # read a file with a json
#  json_search <- read_json("search.txt") %>% toJSON(auto_unbox = T)
#  # get a response
#  list_search <- meddra_post(url_search, json_search, token)
#  # response to a tibble
#  tibble_search <- list_parse(list_search)

## ----hierarchy_api, eval = FALSE----------------------------------------------
#  
#  url_hier <- "https://mapit.meddra.org/api/hier"
#  # read a file with a json
#  json_hier <- read_json("hier.txt") %>% toJSON(auto_unbox = T)
#  # get a response
#  list_hier <- meddra_post(url_hier, json_hier, token)
#  # response to a tibble
#  tibble_hier <- list_parse(list_hier$rows)

## ----type_api, eval = FALSE---------------------------------------------------
#  
#  url_type <- "https://mapit.meddra.org/api/type"
#  # read a file with a json
#  json_type <- read_json("type.txt") %>% toJSON(auto_unbox = T)
#  # get a response
#  list_type <- meddra_post(url_type, json_type, token)
#  # response to a tibble
#  tibble_type <- list_parse(list_type)

