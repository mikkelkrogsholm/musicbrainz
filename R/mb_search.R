#' Search MusicBrainz
#'
#' @param type Selects the index to be searched, artist, release, release-group,
#'     recording, work, label (track is supported but maps to recording)
#' @param query Lucene search query, this is mandatory. The query field supports
#'     the full Lucene Search syntax; you can find a detailed guide at \href{https://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#package_description}{Lucene Search syntax}.
#'     For example, you can set conditions while searching for a name with the
#'     AND operator.
#' @param limit An integer value defining how many entries should be returned.
#'     Only values between 1 and 100 (both inclusive) are allowed. If not given,
#'     this defaults to 25.
#' @param offset Return search results starting at a given offset. Used for paging
#'     through more than one page of results.
#'
#' @return a list
#' @export
#'
#' @source \href{https://musicbrainz.org/doc/Development/XML_Web_Service/Version_2/Search}{MusicBrainz Search}
#'
#' @examples
#'
#' \dontrun{
#'
#' # Annotation
#' annotation_data <- mb_search("annotation", "entity:bdb24cb5-404b-4f60-bba4-7b730325ae47")
#'
#' # Area
#' area_data <- mb_search("area", 'query="Île-de-France"')
#'
#' # Artist
#' artist_data <- mb_search("artist", "artist:fred AND type:group AND country:US")
#'
#' # CDStub
#' cdstub_data <- mb_search("cdstub", "title:Doo")
#'
#' # Label
#' label_data <- mb_search("label", "Devil's Records")
#'
#' # Place
#' place_data <- mb_search("place", "chipping")
#'
#' # Recording
#' recording_data <- mb_search("recording", "isrc:GBAHT1600302")
#'
#' # Release Group
#' release_group_data <- mb_search("release-group", "release:Tenance")
#'
#' # Release
#' release_data <- mb_search("release", "release:Schneider AND Shake")
#'
#' # Work
#' work_data <- mb_search("work", "work:Frozen AND arid:4c006444-ccbf-425e-b3e7-03a98bab5997")
#'
#' }

mb_search <- function(type, query, limit = NULL, offset = NULL){

  # url creation
  base_url <- "http://musicbrainz.org/ws/2"
  url <- base::paste(c(base_url, type), collapse = "/")

  parsed_url <- httr::parse_url(url)
  parsed_url$query <- base::list(query = query, limit = limit,  offset = offset)

  url <- httr::build_url(parsed_url)

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
