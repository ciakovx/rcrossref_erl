
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

# increase number of columns and rows displayed when we print a table
options(repr.matrix.max.cols=100, repr.matrix.max.rows=20)

# Press Ctrl + Enter or click the Run button to evaluate 2 + 2
2 + 2

# assign 5 to y
y <- 5

# evaluate y
y

# using print() will do the same thing as just typing the variable in, it just makes it explicit
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

# get information about the journal and pluck the data
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

# print the publisher variable
plosone_details$publisher

# print the total number of DOIs
plosone_details$total_dois

# is funder data current on deposits?
plosone_details$deposits_funders_current

# assign an ISSN to a value. Call the value what you want (e.g. plosone_issn)


# look up journal details using the cr_journals function and assign it to a new value (e.g. plosone_details). 
# Remember to include a %>% pipe and call purrr::pluck("data")


# print the journal details to the console by typing in the value name


# get metadata on articles by setting works = TRUE
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")

# print dimensions of this data frame
dim(plosone_publications)

# print column names
names(plosone_publications)

# print select columns from the data frame
plosone_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign the JAMA and JAH ISSNs
jama_issn <- '1538-3598'
jah_issn <- '0021-8723'

# get the last 10 publications on deposit from each journal. For multiple ISSNs, use c() to combine them
jah_jama_publications <- rcrossref::cr_journals(issn = c(jama_issn, jah_issn), works = T, limit = 10) %>%
  purrr::pluck("data")

# print column names
names(jah_jama_publications)

# print data frame with select columns
jah_jama_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign the JLSC ISSN
jlsc_issn <- "2162-3309"

# get articles published since January 1, 2019
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, 
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")

# print the dataframe with select column
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign the PLoS ONE ISSN and the NIH Funder DOI
plosone_issn <- '1932-6203'
nih_funder_doi <- '10.13039/100000002'

# get articles published in PLoS since 3/1 funded by NIH
plosone_publications_nih <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25,
                                                 filter = c(award.funder = nih_funder_doi,
                                                           from_pub_date = '2020-03-01')) %>%
  purrr::pluck("data")

# print the dataframe, first unnesting the funder column
plosone_publications_nih %>%
    tidyr::unnest(funder)

# assign the PLoS ONE ISSN and get journal details by setting works = FALSE
plosone_issn <- '1932-6203'
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")

# is article licensing data on file current?
plosone_details$deposits_licenses_current

# get last 25 articles on file where has_license is TRUE
plosone_license <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25, filter = c(`has_license` = TRUE)) %>% 
  pluck("data")

# print the data with select columns
plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license)

# print the data frame with license unnested. The .drop argument will drop all other list columns.
plosone_license %>%
  tidyr::unnest(license, .drop = TRUE)

# assign the JLSC ISSN and get all publications after January 1, 2019
jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# use filter from dplyr to get only volume 8, issue 1
jlsc_8_1 <- jlsc_publications_2019 %>%
  dplyr::filter(volume == "8",
         issue == "1") 

# print the data frame with select columns
jlsc_8_1 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

jah_jama_publications$issn[1]

# filter to get "The Five Laws of OER" article by DOI
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(doi == "10.7710/2162-3309.2299") 

# print data frame with select columns
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# use str_detect to search the title column for articles that include the term OER
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(stringr::str_detect(title, "OER"))

# print the data frame with select column
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign JLSC ISSN and query the bibliographic field for terms mentioning open access. 
jlsc_issn <- "2162-3309"
jlsc_publications_oa <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.bibliographic` = 'open access')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, issn, author)

# Use the query.author field query to find JLSC articles with author name Salo
jlsc_publications_auth <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.author` = 'salo')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_auth %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# assign the C&RL ISSN 2150-6701


# use the query.author field query to search for articles written by Lisa Hinchliffe. 


# assign the PLOS ISSN and get the last 25 articles on deposit
plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")

# use the toJSON function to convert the output to JSON
plosone_publications_json <- jsonlite::toJSON(plosone_publications)

# print the JSON
plosone_publications_json

# write a JSON file
jsonlite::write_json(plosone_publications_json, "plosone_publications.json")

# Get metadata for a single article by DOI
jlsc_ku_oa <- cr_works(dois = '10.7710/2162-3309.1252') %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_ku_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# Use c() to create a vector of DOIs
my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")

# pass the my_dois vector to cr_works()
my_dois_works <- rcrossref::cr_works(dois = my_dois) %>%
  pluck("data")

# print the data frame with select columns
my_dois_works %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# print the type of each column (e.g. character, numeric, logical, list)
purrr::map_chr(jlsc_ku_oa, typeof)

# unnest the author column
jlsc_ku_oa %>%
    tidyr::unnest(author)

# do a general query for the term open access and a field query to return results where the author name includes Suber
suber_oa <- cr_works(query = 'open+access', flq = c(`query.author` = 'suber')) %>%
  pluck("data")

# print the data frame with select columns
suber_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# use filter() from dplyr to filter that result to include only books
suber_oa_books <- suber_oa %>%
  filter(type == "book")

# print the data frame with select columns
suber_oa_books %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# run a different cr_works() query with author set to Suber and his book's ISBN passed to query.bibliographic
suber_isbn <- cr_works(flq = c(`query.author` = 'suber',
                           `query.bibliographic` = '9780262301732')) %>%
  pluck("data")

# print the data frame with select columns
suber_isbn %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# Use c() to create a vector of DOIs
my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")

# Use cr_cn to get back citations formatted in Chicago for those DOIs
my_citations <- rcrossref::cr_cn(my_dois,
                                 format = "text",
                                 style = "chicago-note-bibliography") %>% 
  purrr::map_chr(., purrr::pluck, 1)

# print the formatted citations
my_citations

# write the formatted citations to a text file
writeLines(my_citations, "my_citations_text.txt")

# look at the first 15 styles Crossref offers
rcrossref::get_styles()[1:15]

# Use cr_cn() to get BibTeX files for my DOIs
my_citations_bibtex <- rcrossref::cr_cn(my_dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)

# write to bibtex file
writeLines(my_citations_bibtex, "my_citations_bibtex.bib")

# read in a CSV file of citations
my_references <- read.csv("references.txt", stringsAsFactors = FALSE, fileEncoding = "ISO 8859-1")

# print the file
my_references

# loop through the references column, using cr_works() to look the item up and return the top 5 hits
my_references_works_list <- purrr::map(
  my_references$reference,
  function(x) {
    print(x)
    my_works <- rcrossref::cr_works(query = x, limit = 5) %>%
      purrr::pluck("data")
  })

# for each reference looked up, get back the first result
my_references_works_df <- my_references_works_list %>%
  purrr::map_dfr(., function(x) {
    x[1, ]
  })

# print the data frame with select columns
my_references_works_df %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)

# print the title column
my_references_works_df$title

# assign the PLOS ONE ISSN and get the last two articles on file
plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 2) %>%
  pluck("data")

# use map_chr to print the column types
purrr::map_chr(plosone_publications, typeof)

# use mutate() to coerce list columns to character vectors
plosone_publications_mutated <- plosone_publications %>%
  dplyr::mutate(author = as.character(author)) %>%
  dplyr::mutate(link = as.character(link)) %>%
  dplyr::mutate(license = as.character(license)) %>%
  dplyr::mutate(reference = as.character(reference)) %>%
  dplyr::mutate(funder = as.character(funder)) %>%
  dplyr::mutate("clinical-trial-number" = as.character("clinical-trial-number"))
write.csv(plosone_publications_mutated, "plosone_publications_mutated.csv")

# install the roadoi package
install.packages("roadoi")

# load the roadoi package
library(roadoi)

# Use c() to create a vector of DOIs
my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")

# use oadoi_fetch() to get Unpaywall data on those DOIs
my_dois_oa <- roadoi::oadoi_fetch(dois = my_dois,
                                 email = "name@example.edu")

# print column names
names(my_dois_oa)

# use filter() to overwrite the data frame and keep only items that are available OA
my_dois_oa <- my_dois_oa %>%
  dplyr::filter(is_oa == TRUE)

# print the data frame with best open access location unnested
my_dois_oa %>%
    tidyr::unnest(best_oa_location)
