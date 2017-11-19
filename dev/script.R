
#### base functions ----
id <- "5b11f4ce-a62d-471e-81fc-a69a8278c7da"

resources <- c("area", "artist", "event", "instrument", "label", "place",
               "recording", "release", "release-group", "series", "work", "url")

resource <- "artist"

# function
mb_lookup <- function(resource, id){

  # url creation
  base_url <- "http://musicbrainz.org/ws/2"
  url <- base::paste(c(base_url, resource, id), collapse = "/")
  url <- utils::URLencode(url)

  # api call
  get_data <- httr::GET(url,
                        httr::add_headers(
                          Accept ="application/json",
                          "user-agent" = "R package"))

  # status check
  status <- httr::status_code(get_data)
  if(status != 200) stop(base::paste0("Status code: ", status))

  # extract content
  content_data <- httr::content(get_data, type = "application/json")

  # return data
  return(content_data)
}
mb_search <- function(resource, query){

  # url creation
  base_url <- "http://musicbrainz.org/ws/2"
  url <- base::paste(c(base_url, resource), collapse = "/")
  url <- base::paste0(url, "?query=", query)
  url <- utils::URLencode(url)

  # api call
  get_data <- httr::GET(url,
                        httr::add_headers(
                          Accept ="application/json",
                          "user-agent" = "R package"))

  # status check
  status <- httr::status_code(get_data)
  if(status != 200) stop(base::paste0("Status code: ", status))

  # extract content
  content_data <- httr::content(get_data, type = "application/json")

  # return data
  return(content_data)
}

x <- mb_lookup(resource, id)
y <- mb_search(resource, "aqua")

#### specialized functions----


