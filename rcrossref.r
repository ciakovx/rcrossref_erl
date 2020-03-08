
# press Shift + Enter
print("You just ran the cell and selected the next cell")

# press Ctrl + Enter
print("You just ran this cell and the focus stayed here in this cell")

# press Alt (or option on Mac) + Enter
print("You just ran the cell and inserted a new cell below it")

install.packages('rcrossref')

# load packages
library(rcrossref)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)
library(readr)

# increase number of columns and rows displayed when we print a table
options(repr.matrix.max.cols=100, repr.matrix.max.rows=20)

2 + 2

# assign 5 to y
y <- 5

# evaluate y
y

print(y)

# assign 5 to y


# assign 10 to x


# assign the sum of x and y to myTotal. Print myTotal to the console.


# take the square root of the sum of 2 + 2
sum(2, 2)

# confirm that sum is a function
is.function(sum)

# sum takes an unlimited number (. . .) of numeric elements
sum(3, 4, 5, 6, 7)

# evaluating a sum with missing values will return NA
sum(3, 4, NA)

# look at the help file for sum
?sum

# but setting the argument na.rm to TRUE will remove the NA
sum(3, 4, na.rm = TRUE)

# assign the PLoS ISSN
plosone_issn <- '1932-6203'

# get information about the journal
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE)
plosone_details

plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")

plosone_details

#display information about the data frame
str(plosone_details)

# dimensions: 1 row, 53 columns
dim(plosone_details)

# number of rows
nrow(plosone_details)

# number of columns
ncol(plosone_details)

# column names
names(plosone_details)

plosone_details$publisher

plosone_details$total_dois

plosone_details$deposits_funders_current

# assign an ISSN to a value. Call the value what you want (e.g. plosone_issn)


# look up journal details using the cr_journals function and assign it to a new value (e.g. plosone_details)


# print the journal details to the console by typing in the value name


plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")

dim(plosone_publications)

names(plosone_publications)

plosone_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jama_issn <- '1538-3598'
jah_issn <- '0021-8723'
jah_jama_publications <- rcrossref::cr_journals(issn = c(jama_issn, jah_issn), works = T, limit = 10) %>%
  purrr::pluck("data")

names(jah_jama_publications)
jah_jama_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

plosone_issn <- '1932-6203'
nih_funder_doi <- '10.13039/100000002'
plosone_publications_orcids <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25,
                                                 filter = c(award.funder = nih_funder_doi,
                                                           from_pub_date = '2020-02-01')) %>%
  purrr::pluck("data")

plosone_publications_orcids %>%
    tidyr::unnest(funder)

plosone_issn <- '1932-6203'
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")

plosone_details$deposits_licenses_backfile

plosone_details$deposits_licenses_current

plosone_license <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25, filter = c(`has_license` = TRUE)) %>% 
  pluck("data")

plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license)

plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license) %>%
  tidyr::unnest(license)

jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")
jlsc_8_1 <- jlsc_publications_2019 %>%
  dplyr::filter(volume == "8",
         issue == "1") 
jlsc_8_1 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jah_jama_publications$issn[1]

jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(doi == "10.7710/2162-3309.2299") 
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(stringr::str_detect(title, "OER"))
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jlsc_issn <- "2162-3309"
jlsc_publications_oa <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.bibliographic` = 'open access')) %>%
  purrr::pluck("data")
jlsc_publications_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, issn, author)

jlsc_publications_auth <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.author` = 'salo')) %>%
  purrr::pluck("data")
jlsc_publications_auth %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign the C&RL ISSN 2150-6701


# use the query.author field query to search for articles written by Lisa Hinchliffe. 


plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")
plosone_publications_json <- jsonlite::toJSON(plosone_publications)

plosone_publications_json

jsonlite::write_json(plosone_publications_json, "plosone_publications.json")

jlsc_ku_oa <- cr_works(dois = '10.7710/2162-3309.1252') %>%
  purrr::pluck("data")
jlsc_ku_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")
my_dois_works <- rcrossref::cr_works(dois = my_dois) %>%
  pluck("data")
my_dois_works %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

purrr::map_chr(jlsc_ku_oa, typeof)

jlsc_ku_oa %>%
    tidyr::unnest(author)

suber_oa <- cr_works(query = 'open+access', flq = c(`query.author` = 'suber')) %>%
  pluck("data")
suber_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

suber_oa_books <- suber_oa %>%
  filter(type == "book")
suber_oa_books %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

suber_isbn <- cr_works(flq = c(`query.author` = 'suber',
                           `query.bibliographic` = '9780262301732')) %>%
  pluck("data")
suber_isbn %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

my_citations <- rcrossref::cr_cn(my_dois,
                                 format = "text",
                                 style = "chicago-note-bibliography") %>% 
  purrr::map_chr(., purrr::pluck, 1)
my_citations

writeLines(my_citations, "my_citations_text.txt")

rcrossref::get_styles()[1:15]

my_citations_bibtex <- rcrossref::cr_cn(my_dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)

writeLines(my_citations_bibtex, "my_citations_bibtex.bib")

my_references <- read.csv("references.txt", stringsAsFactors = FALSE, fileEncoding = "ISO 8859-1")
my_references

my_references_works_list <- purrr::map(
  my_references$reference,
  function(x) {
    print(x)
    my_works <- rcrossref::cr_works(query = x, limit = 5) %>%
      purrr::pluck("data")
  })

my_references_works_df <- my_references_works_list %>%
  purrr::map_dfr(., function(x) {
    x[1, ]
  })
my_references_works_df %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

my_references_works_df$title

plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 2) %>%
  pluck("data")

purrr::map_chr(plosone_publications, typeof)

plosone_publications_mutated <- plosone_publications %>%
  dplyr::mutate(author = as.character(author)) %>%
  dplyr::mutate(link = as.character(link)) %>%
  dplyr::mutate(license = as.character(license)) %>%
  dplyr::mutate(reference = as.character(reference)) %>%
  dplyr::mutate(funder = as.character(funder)) %>%
  dplyr::mutate("clinical-trial-number" = as.character("clinical-trial-number"))
write.csv(plosone_publications_mutated, "plosone_publications_mutated.csv")

install.packages("roadoi")

library(roadoi)

options(roadoi_email = "clarke.iakovakis@okstate.edu")

my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")
my_dois_oa <- roadoi::oadoi_fetch(dois = my_dois,
                                 email = "clarke.iakovakis@okstate.edu")

names(my_dois_oa)

my_dois_oa <- my_dois_oa %>%
  filter(is_oa == TRUE)

my_dois_oa %>%
    unnest(best_oa_location)
