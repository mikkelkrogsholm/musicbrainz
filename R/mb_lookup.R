#' Lookup requests on MusicBrainz
#'
#' @param resource the part of the api you want to call
#'     \itemize{
#'       \item artist
#'       \item label
#'       \item recording
#'       \item release
#'       \item release group
#'       \item work
#'     }
#' @param id the musicbrainz id
#'
#' @return a list
#'
#' @source \href{https://musicbrainz.org/doc/Development/JSON_Web_Service}{MusicBrainz JSON Web Service}
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#'
#' # Artist lookup
#' artist_data <- mb_lookup("artist", "5b11f4ce-a62d-471e-81fc-a69a8278c7da")
#'
#' # Label lookup
#' label_data <- mb_lookup("label", "46f0f4cd-8aab-4b33-b698-f459faf64190")
#'
#' # Recording lookup
#' recording_data <- mb_lookup("recording", "fcbcdc39-8851-4efc-a02a-ab0e13be224f")
#'
#' # Release lookup
#' release_data <- mb_lookup("release", "59211ea4-ffd2-4ad9-9a4e-941d3148024a")
#'
#' # Release lookup
#' release_group_data <- mb_lookup("release-group", "c9fdb94c-4975-4ed6-a96f-ef6d80bb7738")
#'
#' # Release lookup
#' work_data <- mb_lookup("work", "b1df2cf3-69a9-3bc0-be44-f71e79b27a22")
#'
#' }
#'
mb_lookup <- function(resource, id){

  # url creation
  base_url <- "http://musicbrainz.org/ws/2"
  url <- base::paste(c(base_url, resource, id), collapse = "/")
  url <- utils::URLencode(url)

  # api call
  get_data <- httr::GET(url,
                        httr::add_headers(
                          Accept ="application/json",
                          "user-agent" = "musicbrainz R package"))

  # status check
  status <- httr::status_code(get_data)
  if(status != 200) stop(base::paste0("Status code: ", status))

  # extract content
  content_data <- httr::content(get_data, type = "application/json")

  # return data
  return(content_data)
}

