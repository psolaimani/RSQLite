library(magrittr)

html <- xml2::read_html("https://www.sqlite.org/download.html")

latest_name <- html %>%
  rvest::html_nodes("a") %>%
  xml2::xml_find_all('//*[(@id = "a1")] | //*[(@id = "a2")]') %>%
  rvest::html_text() %>%
  grep("amalgamation", ., value = TRUE) %>%
  .[1]

latest <- paste0("http://www.sqlite.org/", Sys.Date() %>% strftime("%Y"), "/", latest_name)
tmp <- tempfile()
download.file(latest, tmp)
unzip(tmp, exdir = "src/sqlite3", junkpaths = TRUE)
unlink("src/shell.c")
