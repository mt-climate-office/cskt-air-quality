library(httr2)
library(DT)
library(magrittr)
library(tidyverse)


query_fields <-
  c("name",
    "location_type",
    "latitude",
    "longitude",
    "altitude",
    "model",
    "firmware_version",
    "last_seen",
    "pm2.5")

sensors <-
  c(
    # 190201,
    # 176205,
    # 176249,
    # 176161,
    190203,
    190189,
    176181,
    176173,
    176203,
    176155,
    190325,
    190197,
    212487,
    176179,
    176197,
    176157,
    190195,
    212833,
    212849,
    176231,
    176149,
    212459,
    176175,
    176185,
    190185,
    190217,
    212455,
    190199,
    176253,
    176251,
    176177,
    176207,
    190211,
    212855,
    176183,
    212697,
    240607)

httr2::request("https://api.purpleair.com") |>
  httr2::req_url_path("v1","sensors") |>
  httr2::req_url_query(fields = query_fields,
                       show_only = sensors,
                       .multi = "comma") |>
  httr2::req_headers(`X-API-Key` = keyring::key_get("cskt-purpleair")) |>
  httr2::req_perform() |>
  resp_body_json() %$%
  {
    data |>
      purrr::transpose() |>
      magrittr::set_names(fields) |>
      purrr::map(unlist) |>
      tibble::as_tibble() |>
      dplyr::mutate(last_seen = lubridate::as_datetime(last_seen) |>
                      lubridate::with_tz("America/Denver"),
                    location_type = factor(location_type, 
                                           levels = 0:1,
                                           labels = c("outside", "inside"),
                                           ordered = TRUE)
      )
  } |>
  dplyr::select(dplyr::matches(c("sensor_index", query_fields))) |>
  dplyr::arrange(name, location_type) |>
  print(n = 36)
  