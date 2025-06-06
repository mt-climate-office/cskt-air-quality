library(tidyverse)
library(magrittr)

httr::GET("https://c36nxc3vd0.execute-api.us-west-2.amazonaws.com/prod/sensor-data") |>
  httr::content(type = "application/json") %$%
  data %>%
  purrr::transpose() %>%
  magrittr::set_names(c(
    "sensor_index",
    "last_seen",
    "name",
    "location_type",
    "model",
    "firmware_version",
    "latitude",
    "longitude",
    "altitude",
    "aqi"
  )) %>%
  purrr::map(unlist) %>%
  tibble::as_tibble() %>%
  dplyr::transmute(
    `Station ID` = dplyr::case_match(name,
                                     "DEQ018" ~ 'CSKT — Arlee High School (Outside, "DEQ018")',
                                     "Arlee HS" ~ 'CSKT — Arlee High School (Inside, "Arlee HS")',
                                     "Hot Springs School District" ~ 'CSKT — Hot Springs High School (Outside, "Hot Springs School District")',
                                     "CSKT-Polson Middle School" ~ 'CSKT — Polson Middle School (Outside, "CSKT-Polson Middle School")',
                                     "Ronan, MT" ~ 'CSKT — Ronan High School (Outside, "Ronan, MT")',
                                     # "St. Ignatius High School" ~ 'CSKT — St. Ignatius High School (Outside, "St. Ignatius High School")',
                                     .default = name
    )  ,
    `Registration ID` = sensor_index,
    URL = paste0("https://map.purpleair.com/1/b/lt/mAQI/a10/p0/cC0?select=", sensor_index,"#8.6/47.5061/-114.347")
  ) %>%
  dplyr::arrange(`Station ID`) %T>%
  readr::write_csv("sensor_urls.csv") 
