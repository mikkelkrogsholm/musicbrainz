

mb_search_annotation <- function(query, limit = NULL, offset = NULL){

  my_data <- mb_search(type = "annotation", query = query, limit = limit, offset = offset)

  return(my_data)
}


mb_search_annotation("entity:bdb24cb5-404b-4f60-bba4-7b730325ae47")
