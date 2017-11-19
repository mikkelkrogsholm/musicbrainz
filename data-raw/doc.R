pacman::p_load(rvest, stringr)

url <- "https://musicbrainz.org/doc/Development/XML_Web_Service/Version_2/Search"

html_data <- read_html(url)

headers <-  html_data %>%
  html_nodes("h3") %>%
  html_text()

headers %>%
  tolower() %>%
  str_replace_all(" ", "-") %>%
  paste("item", .) %>%
  paste(., collapse = "\n") %>%
  cat()

tables <-
html_data %>%
  html_nodes("table") %>%
  html_table(fill = TRUE)


###

tabular <- function(df, ...) {
  stopifnot(is.data.frame(df))

  align <- function(x) if (is.numeric(x)) "r" else "l"
  col_align <- vapply(df, align, character(1))

  cols <- lapply(df, format, ...)
  contents <- do.call("paste",
                      c(cols, list(sep = " \\tab ", collapse = "\\cr\n  ")))

  paste("\\tabular{", paste(col_align, collapse = ""), "}{\n  ",
        contents, "\n}\n", sep = "")
}

###

tabular(tables[[2]]) %>% cat()
