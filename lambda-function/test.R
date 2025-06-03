library(httr2)

baseId <- "app47BTSMOR7BEbwT"
tableName <- "Deployments"
viewName <- "Public"
fields <- c("Station ID", "ID", "Indoor/Outdoor", "URL")

httr2::request("https://api.airtable.com") |>
  httr2::req_url_path("v0", baseId, tableName) |>
  httr2::req_url_query(view = viewName,
                       `fields[]` = fields,
                       .multi = "explode") |>
  httr2::req_auth_bearer_token(keyring::key_get("cskt-airtable")) |>
  httr2::req_perform() |>
  httr2::resp_body_json() |>
  magrittr::extract2("records") |>
  purrr::map("fields") |>
  purrr::list_transpose() |>
  tibble::as_tibble()
