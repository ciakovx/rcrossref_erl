
# Introduction

The Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. 

Azure Notebooks is a free hosted service to develop and run Jupyter notebooks in the cloud with no installation.

We are using these platforms to avoid having to install R and R Studio onto your own computer. Furthermore, by interacting with R in this notebook, you will be able to execute code that I have already written, and see explanations of it first hand. Because this is such a brief session, we cannot go into detail about learning the R language, but I have provided some resources at the end of this document.

If you plan on using `rcrossref` more extensively, I would recommend downloading R and R Studio. Also, the Crossref team encourages requests with appropriate contact information, and will forward you to a dedicated API cluster for improved performance when you share your email with them. We cannot do that in this notebook, but you can do that in R.

For a more detailed walkthrough of this entire lesson, including instructions for downloading R and R Studio, sharing your email with Crossref, and much more, please visit the set of tutorials at https://ciakovx.github.io/fsci_syllabus.html.

# Licensing

This walkthrough is distributed under a [https://creativecommons.org/licenses/by/4.0/](Creative Commons Attribution 4.0 International (CC BY 4.0) License). 


<div>
    <br>
    <img src="images/ccby.png" style="width: 400px;">
</div>

# Jupyter Notebooks

<div>
    <img src="images/jupyter.png" style="width: 400px;">
</div>

Jupyter Notebooks have two different keyboard input modes:

* **Command Mode** - Make changes on the Notebook level. Indicated by a grey cell border with a blue left margin. 
* **Edit Mode** - Make changes to an individual cell. Indicated by a green cell border

A new cell will always start as a **Code** cell, where you can type in R code and execute it here in your Jupyter notebook. All code in this notebook is R, but in Azure Notebooks you can create Notebooks that are F# or Python.

Please feel free to add your own notes in a Markdown cell during this workshop, or write your own R code!

Useful keyboard shortcurts when you are in Command Mode:
* **Enter** to enter Edit Mode to edit the cell
* **B** to create new cell below the current cell
* **A** to create new cell above the current cell
* **Y** to change a Markdown cell to Code
* **M** to change a Code cell to Markdown
* Press **D** twice to delete the cell
  
Shortcuts when you are in Edit Mode:
* **Esc** to enter Command Mode
* **Ctrl + Enter** to Run cell and stay in the cell
* **Shift + Enter** to Run cell and select the next cell
* **Alt (or option on Mac) + Enter** to Run cell and 
* **Ctrl (or Cmd on Mac) + Z**: Undo

---
**TRY IT YOURSELF**

Select the below cell in Edit Mode by double clicking in it, or by clicking it on the margin and pressing **Enter**. It should have a green border. Notice that this is a **Code** cell. Press Shift + Enter to execute the code. This will print the output and select the next cell.

Then, when you are in the next cell, press Ctrl + Enter. This will print the output and stay in the same cell.

Then, press the down arrow on your keyboard to to to the next cell. Enter Edit Mode (green border) by pressing Enter. Press Alt (or option on Mac) + Enter. This will print the output and create a new cell.

Then press the down arrow or select the new empty cell. Make sure you are in Command Mode (blue border). Press D twice to delete the new cell.


```R
# press Shift + Enter
print("You just ran the cell and selected the next cell")
```


```R
# press Ctrl + Enter
print("You just ran this cell and the focus stayed here in this cell")
```


```R
# press Alt (or option on Mac) + Enter
print("You just ran the cell and inserted a new cell below it")
```

Notice the text in the above cells that starts with a hash **#** character. The hash indicates a **comment**. Anything following the hash symbol will not be evaluated. 

# Install and load `rcrossref`, `dplyr`, `purrr`, `stringr`, and `tidyr`

When you download R it already has a number of functions built in: these encompass what is called **Base R**. However, many R users write their own libraries of functions, package them together in R **packages**, and provide them to the R community at no charge. This extends the capacity of R and allows us to do much more. In many cases, they improve on the Base R functions by making them easier and more straight-forward to use.

First install `rcrossref` using the `install.packages()` function. Notice the package name is in quotation marks.

Click on the left margin of the cell below so it turns blue. Then click the **Run** button on the top toolbar, or press **Ctrl + Enter**. This will **execute** the code, installing the necessary packages into your Jupyter Notebook environment. 

This may take a couple minutes. You will see a \[*\] on the left margins while the package installs. When the asterisk becomes a number, we will be ready. 


```R
install.packages('rcrossref')
```

We will also be using the `dplyr`, `purrr`, `stringr` and `tidyr` packages. These packages are part of the [tidyverse](https://www.tidyverse.org/), a collection of R packages designed for data science.

Fortunately, these packages are pre-installed in Azure Notebooks, so we don't need to install them; we just need to load them into our environment. We do this with the `library()` function. Let's load all three packages by clicking the left margin of the below cell (so it turns blue) and clicking the **Run** button on the top toolbar.

Let's also set an option to see a max number of 100 columns and max 20 rows in our Jupyter Notebooks environment. 




```R
# load packages
library(rcrossref)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)
library(readr)

# increase number of columns and rows displayed when we print a table
options(repr.matrix.max.cols=100, repr.matrix.max.rows=20)
```

<div>
    <br>
    <img src="images/tidyverse.png" style="width: 150px;">
</div>

# R Basics

<div>
    <br>
    <img src="images/R.png" style="width: 200px;">
    <br>
</div>

R is more of a programming language than a statistics program. It was started by Robert Gentleman and Ross Ihaka from the University of Auckland in 1995. They described it as “a language for data analysis and graphics.”1 You can use R to create, import, and scrape data from the web; clean and reshape it; visualize it; run statistical analysis and modeling operations on it; text and data mine it; and much more.

If you intend on continuing your R journey after this workshop, I recommend installing R and R Studio and doing your scripting there. To install R, go to https://www.r-project.org/. Click on CRAN (Comprehensive R Archive Network) under Download, and scroll down to your country. Select the download link corresponding to the city that is geographically closest to you. Go to https://www.rstudio.com/products/RStudio/#Desktop to download the RStudio desktop software.


We don't have enough time in today's workshop to learn much about R. There are many excellent R tutorials at the end of this document. To get help on R functions within Jupyter Notebooks, type `help()` with the function name in parentheses. For example, `help(sum)` or `help(which)`. This will provide a description of the function, its usage, and the arguments the function takes.

## Writing &amp; Evaluating Expressions

The *prompt* is the blinking cursor in a Code cell prompting you to take action. We type *expressions* into the prompt, and press Ctrl + Enter to *evaluate* those expressions.

Evaluate this expression:


```R
2 + 2
```

## Assigning values

The first operator you're going to come across is the assignment operator. This is the angle bracket (AKA the "less than"" symbol): `&lt;`, which you'll get by pressing **Shift + comma** and the hyphen `-` which is located next to the zero key. There is no space between them, and it is designed to look like a left pointing arrow `&lt;-`. 




```R
# assign 5 to y
y <- 5
```

Here I am creating a symbol called `y` and I'm *assigning* it the numeric value 5. Some R users would say "y *gets* 5." Lowercase `y`, is now a *numeric vector* with one element. Or you could say `y` is a numeric vector, and the first element is the number 5. When you assign something to a symbol, nothing happens in the console, but in the Environment pane in the upper right, you will notice a new object, y.

If you now type y into the console, and press Enter on your keyboard, R will evaluate the expression. In this case, R will print the elements that are assigned to y (the number 5). We can do this easily since y only has one element, but if you do this with a large dataset loaded into R, it will obliterate your console because it will print the entire thing. The [1] indicates that the number 5 is the first element of this vector.


```R
# evaluate y
y
```

As we saw above, you can also use the `print()` function:


```R
print(y)
```

---
**TRY IT YOURSELF**

1. Use the new code cells below. Make sure that 5 is assigned to `y` by typing in `y &lt;- 5`
2. Assign the number 10 to variable `x`. Add `x` and `y` and evaluate the expression.
3. Assign `x + y` to variable `myTotal`. 


```R
# assign 5 to y

```


```R
# assign 10 to x

```


```R
# assign the sum of x and y to myTotal. Print myTotal to the console.

```

### Tips for assigning values

* **Do not use names of functions that already exist in R:** The assignment operator assigns a value to a symbol. We can pretty much pick any symbol, or name, for that variable, as long as it is not already a function in R. For example, you wouldn't want to name a variable `sum` because if you might end up in a confusing situation writing `sum(sum)`
* **R is case sensitive**: It is important to note that R is *case sensitive.* If you try evaluating a capital `Y`, you will be told `Error in eval(expr, envir, enclos): object 'Y' not found`.
* **No blank spaces or symbols other than underscores**: R users get around this in a couple of ways, either through capitalization (e.g. `myData`) or underscores (e.g. `my_data`). 
* **Do not begin with numbers or symbols**: Try to evaluate `1z &lt;- 4` or `%z &lt;- 4` and read the error message.
* **Be descriptive, but make your variable names short**: It's good practice to be descriptive with your variable names. If you're loading in a lot of data, choosing `myData` or `x` as a name may not be as helpful as, say, `ebookUsage`. Finally, keep your variable names short, since you will likely be typing them in frequently.



## Calling a function

R is a “functional programming language,” meaning it contains a number of functions you use to do something with your data. Call a function on a variable by entering the function into the console, followed by parentheses and the variables. 


```R
# take the square root of the sum of 2 + 2
sum(2, 2)
```

Typing a question mark before a function will pull the help page up in the Navigation Pane in the lower right. Type `?sum` to view the help page for the `sum` function. You can also call `help(sum)`. This will provide the description of the function, how it is to be used, and the arguments. 

In the case of `sum()`, the ellipses `. . .` represent an unlimited number of numeric elements. `sum()` also takes the argument `na.rm`. This is a logical (`TRUE/FALSE`) argument specifying if NA values (missing data) should be removed when the argument is evaluated.

The function `is.function()` will check if an argument is a function in R. If it is a function, it will print `TRUE` to the console.



```R
# confirm that sum is a function
is.function(sum)
```


```R
# sum takes an unlimited number (. . .) of numeric elements
sum(3, 4, 5, 6, 7)
```


```R
# evaluating a sum with missing values will return NA
sum(3, 4, NA)
```


```R
# look at the help file for sum
?sum
```


```R
# but setting the argument na.rm to TRUE will remove the NA
sum(3, 4, na.rm = TRUE)
```

Functions can be nested within each other. For example, `sqrt()` takes the square root of the number provided in the function call. Therefore you can run `sum(sqrt(9), 4)` to take the sum of the square root of 9 (3) and add it to 4. Or you could write the quadratic formula: `[(-b) + sqrt((b^2) - 4ac)] / (2*a)`.

# `rcrossref`

`rcrossref` is a package developed by [Scott Chamberlain](https://scottchamberlain.info/), Hao Zhu, Najko Jahn, Carl Boettiger, and Karthik Ram, part of the [rOpenSci](https://ropensci.org/) set of packages. rOpenSci is an incredible organization dedicated to open and reproducible research using shared data and reusable software. I strongly recommend you browse their set of packages at https://ropensci.org/packages/.

<div>
    <br>
    <img src="images/ropensci.png" style="width: 200px;">
    <br>
</div>

`rcrossref` serves as an interface to the Crossref API.

**Key links**

* [rcrossref documentation](https://cran.r-project.org/web/packages/rcrossref/rcrossref.pdf)
* [Crossref  REST API documentation](https://github.com/ropensci/rcrossref)
* [Crossref Metadata API JSON Format](https://github.com/CrossRef/rest-api-doc/blob/master/api_format.md)
* Crossref and rcrossref tutorials
    - [my `rcrossref` tutorial](https://ciakovx.github.io/rcrossref.html)
    - rOpenSci [rcrossref tutorial](https://ropensci.org/tutorials/rcrossref_tutorial/)
    - Paul Oldham: ["Accessing the Scientific Literature with Crossref"](https://poldham.github.io/abs/crossref.html)
    - [rcrossref vignette](https://cran.r-project.org/web/packages/rcrossref/vignettes/crossref_vignette.html)

# Getting publications from journals with `cr_journals`

`cr_journals()` takes either an ISSN or a general keyword query, and returns metadata for articles published in the journal, including DOI, title, volume, issue, pages, publisher, authors, etc. A full list of publications in Crossref is [available on their website](https://support.crossref.org/hc/en-us/articles/213197226-Browsable-title-list).

## Getting journal details

Crossref is entirely dependent on publishers to supply the metadata. Some fields are required, while others are optional. You may therefore first be interested in what metadata publishers have submitted to Crossref for a given journal. By using `cr_journals` with `works = FALSE`, you can determine who publishes the journal, the total number of articles for the journal in Crossref, whether abstracts are included, if the full text of articles is deposited, if author ORCIDs are provided, and if the publisher supplies author affiliations, author ORCID iDs, article licensing data, funders for the article, article references, and a few other items. 

First we will create a new vector `plosone_issn` with the ISSN for the journal *PLoS ONE*. 


```R
# assign the PLoS ISSN
plosone_issn <- '1932-6203'
```

We will then run `rcrossref::cr_journals()`, setting the ISSN equal to the `plosone_issn` we just created, and print the results.


```R
# get information about the journal
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE)
plosone_details
```

This actually comes back as a list of three items: `meta`, `data`, and `facets`. The good stuff is in `data`. 

We use the `pluck()` function from the `purrr` package to pull that data only. We will be using `pluck` throughout this tutorial; it's an easy way of indexing deeply and flexibly into lists to extract information.

We don't have time in this tutorial to discuss list items and purr. For an excellent in-depth tutorial, see Jenny Bryan's [
Introduction to map(): extract elements](https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html).


```R
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")
```

The `purrr::pluck()` function is connected to `plosone_details` with something called a [Pipe Operator](https://www.datacamp.com/community/tutorials/pipe-r-tutorial) `%&gt;%`, which we will be using throughout the tutorial. A pipe takes the output of one statement and immediately makes it the input of the next statement. It helps so that you don't have to write every intermediate, processing data to your R environment. You can think of it as "then" in natural language. So the above script first makes the API call with `cr_journals()`, then it applies `pluck()` to extract only the list element called `"data"`, and returns it to the `plosone_details` value.

We now have a **data frame** including the details Croassref has on file about PLoS ONE. Scroll to the right to see all the columns.


```R
plosone_details
```

There are a number of ways to explore this data frame:


```R
#display information about the data frame
str(plosone_details)
```

Type `?str` into the console to read the description of the `str` function. You can call `str()` on an R object to compactly display information about it, including the data type, the number of elements, and a printout of the first few elements.


```R
# dimensions: 1 row, 53 columns
dim(plosone_details)
```


```R
# number of rows
nrow(plosone_details)
```


```R
# number of columns
ncol(plosone_details)
```


```R
# column names
names(plosone_details)
```

We see this data frame includes one observation of 53 different variables. This includes the total number of DOIs, whether the abstracts, orcids, article references are current; and other information.

You can use the $ symbol to work with particular variables. For example, the `publisher` column:


```R
plosone_details$publisher
```

The total number of DOIs on file:


```R
plosone_details$total_dois
```

Whether they deposit data in Crossref on funders of the articles they publish (a TRUE/FALSE value–called “logical” in R):


```R
plosone_details$deposits_funders_current
```

---
**TRY IT YOURSELF**

1. Assign an ISSN for a well-known journal to a new variable in R. Name it whatever you like. You can use the [Scimago Journal Rank](https://www.scimagojr.com/journalrank.php) to look up the ISSN. If you need a couple examples, try [RUSA](https://www.scimagojr.com/journalsearch.php?q=16004&amp;tip=sid&amp;clean=0) or [Library Hi Tech](https://www.scimagojr.com/journalsearch.php?q=144908&amp;tip=sid&amp;clean=0). Make sure to put the ISSN in quotes to create a character vector.
2. Look up the journal details using `cr_journals`. Make sure to pass the argument `works = FALSE`.
3. Print the data to your console by typing in the value name.


**Does it matter if the ISSN has a hyphen or not? Try both methods.**


```R
# assign an ISSN to a value. Call the value what you want (e.g. plosone_issn)

```


```R
# look up journal details using the cr_journals function and assign it to a new value (e.g. plosone_details)

```


```R
# print the journal details to the console by typing in the value name

```

## Getting journal publications by ISSN

To get metadata for the publications themselves rather than data about the journal, we will again use the `plosone_issn` value in the `issn =` argument to `cr_journals`, but we now set `works = TRUE`.  


```R
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")
```

Let's walk through this step by step:

* First, we are creating a new value called `plosone_publications`
* We are using the assignment operator `&lt;-` to assign the results of an operation to this new value
* We are running the function `cr_journals()`. It is not necessary to add `rcrossref::` to the beginning of the function.
* We **pass** three arguments to the function:
    * `issn = plosone_issn` : We defined `plosone_issn` earlier in the session as '1932-6203'. We are reusing that value here to tell the `cr_journals()` function what journal we want information on
    * `works = TRUE` : When we earlier specified `works = FALSE`, we got back information on the publication. When `works = TRUE`, we will get back article level metadata
    * `limit = 25` : We will get back 25 articles. The default number of articles returned is 20, but you can increase or decrease that with the `limit` argument. The max limit is 1000, but you can get more using the `cursor` argument (see below).
* `%&gt;%` : Pipe operator says to R to take the results of this function and use it as the input for what follows
* `pluck("data")` : This will grab only the contents of the list item "data" and return it to `plosone_publications`.

Let's explore the data frame:


```R
dim(plosone_publications)
```

When we run `dim()` (dimensions) on this result, we now see a different number of rows and columns: 25 rows and 28 columns. This is therefore a different dataset than `plosone_details`. Let's call `names()` to see what the column names are:


```R
names(plosone_publications)
```

We view the entire data frame below. Because there are some nested lists within the data, we will use the `select()` function from the `dplyr` package to select only a few columns. This will make it easier for us to view here in the Azure Notebook environment. You can also use the `select()` function to rearrange the columns.


```R
plosone_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

Here we are just getting back the last 25 articles that have been indexed in Crossref by PLoS ONE. However, this gives you a taste of how rich the metadata is. We have the dates the article was deposited and published online, the title, DOI, the ISSN, the volume, issue, and page numbers, the number of references, the URL, and for some items, the subjects. The omitted columns include information on licensing, authors, and more. We will deal with those columns further down.

## Getting multiple publications by ISSN

You can also pass multiple ISSNs to `cr_journals`. Here we create 2 new values, `jama_issn` and `jah_issn`. These are ISSNs for the *Journal of American History* and *JAMA: The Journal of the American Medical Association*. We then pass them to `cr_journals` by passing them to the `c()` function, which will combine them (it's like CONCATENATE in Excel). We set `works` to `TRUE` so we'll get the publications metadata, and we set the `limit` to 50, so we'll get 50 publications per journal.


```R
jama_issn <- '1538-3598'
jah_issn <- '0021-8723'
jah_jama_publications <- rcrossref::cr_journals(issn = c(jama_issn, jah_issn), works = T, limit = 10) %>%
  purrr::pluck("data")
```

Here we used `c()` to combine `jama_issn` and `jah_issn`. `c()` is used to create a **vector** in R. A vector is a sequence of elements of the same type. In this case, even though the ISSNs are numbers, we created them as `character` vectors by surrounding them in quotation marks. You can use single or double quotes. Above, when we assigned 5 to `y`, we created a `numeric` vector. 

Vectors can only contain “homogenous” data–in other words, all data must be of the same type. The type of a vector determines what kind of analysis you can do on it. For example, you can perform mathematical operations on `numeric` objects, but not on `character` objects. You can think of vectors as columns in an Excel spreadsheet: for example, in a name column, you want every value to be a character; in a date column, you want every value to be a date; etc.

Going back to our `jah_jama_publications` object, we have a dataframe composed of 20 observations of 24 variables. This is a rich set of metadata for the articles in the given publications. The fields are detailed in the [Crossref documentation](https://github.com/CrossRef/rest-api-doc/blob/master/api_format.md#work), including the field name, type, description, and whether or not it's required. Some of these fields are title, DOI, DOI prefix identifer, ISSN, volume, issue, publisher, abstract (if provided), reference count (if provided--i.e., the number of references *in* the given article), link (if provided), subject (if provided), and other information. The number of citations *to* the article are not pulled, but these can be gathered separately with `cr_citation_count()` (see below).


```R
names(jah_jama_publications)
jah_jama_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

## Filtering the `cr_journals` query with the `filter` argument

You can use the `filter` argument within `cr_journals` to specify some parameters as the query is executing. This filter is built into the Crossref API query. See the available filters by calling `rcrossref::filter_names()`, and details by calling `rcrossref::filter_details`. It's also in [the API documentation](https://github.com/CrossRef/rest-api-doc#filter-names).

| filter     | possible values | description|
|:-----------|:----------------|:-----------|
| `has-funder` | | metadata which includes one or more funder entry |
| `funder` | `{funder_id}` | metadata which include the `{funder_id}` in FundRef data |
| `location` |`{country_name}` | funder records where location = `{country name}`. Only works on `/funders` route |
| `prefix` | `{owner_prefix}` | metadata belonging to a DOI owner prefix `{owner_prefix}` (e.g. `10.1016` ) |
| `member` | `{member_id}` | metadata belonging to a Crossref member |
| `from-index-date` | `{date}` | metadata indexed since (inclusive) `{date}` |
| `until-index-date` | `{date}` | metadata indexed before (inclusive) `{date}` |
| `from-deposit-date` | `{date}` | metadata last (re)deposited since (inclusive) `{date}` |
| `until-deposit-date` | `{date}` | metadata last (re)deposited before (inclusive) `{date}` |
| `from-update-date` | `{date}` | Metadata updated since (inclusive) `{date}`. Currently the same as `from-deposit-date`. |
| `until-update-date` | `{date}` | Metadata updated before (inclusive) `{date}`. Currently the same as `until-deposit-date`. |
| `from-created-date` | `{date}` | metadata first deposited since (inclusive) `{date}` |
| `until-created-date` | `{date}` | metadata first deposited before (inclusive) `{date}` |
| `from-pub-date` | `{date}` | metadata where published date is since (inclusive) `{date}` |
| `until-pub-date` | `{date}` | metadata where published date is before (inclusive)  `{date}` |
| `from-online-pub-date` | `{date}` | metadata where online published date is since (inclusive) `{date}` |
| `until-online-pub-date` | `{date}` | metadata where online published date is before (inclusive)  `{date}` |
| `from-print-pub-date` | `{date}` | metadata where print published date is since (inclusive) `{date}` |
| `until-print-pub-date` | `{date}` | metadata where print published date is before (inclusive)  `{date}` |
| `from-posted-date` | `{date}` | metadata where posted date is since (inclusive) `{date}` |
| `until-posted-date` | `{date}` | metadata where posted date is before (inclusive)  `{date}` |
| `from-accepted-date` | `{date}` | metadata where accepted date is since (inclusive) `{date}` |
| `until-accepted-date` | `{date}` | metadata where accepted date is before (inclusive)  `{date}` |
| `has-license` | | metadata that includes any `&lt;license_ref&gt;` elements. |
| `license.url` | `{url}` | metadata where `&lt;license_ref&gt;` value equals `{url}` |
| `license.version` | `{string}` | metadata where the `&lt;license_ref&gt;`'s `applies_to` attribute  is `{string}`|
| `license.delay` | `{integer}` | metadata where difference between publication date and the `&lt;license_ref&gt;`'s `start_date` attribute is &lt;= `{integer}` (in days)|
| `has-full-text` |  | metadata that includes any full text `&lt;resource&gt;` elements. |
| `full-text.version` | `{string}`  | metadata where `&lt;resource&gt;` element's `content_version` attribute is `{string}`. |
| `full-text.type` | `{mime_type}`  | metadata where `&lt;resource&gt;` element's `content_type` attribute is `{mime_type}` (e.g. `application/pdf`). |
| `full-text.application` | `{string}` | metadata where `&lt;resource&gt;` link has one of the following intended applications: `text-mining`, `similarity-checking` or `unspecified` |
| `has-references` | | metadata for works that have a list of references |
| `reference-visibility` | `[open, limited, closed]` | metadata for works where references are either `open`, `limited` (to [Metadata Plus subscribers](https://www.crossref.org/services/metadata-delivery/plus-service/)) or `closed` |
| `has-archive` | | metadata which include name of archive partner |
| `archive` | `{string}` | metadata which where value of archive partner is `{string}` |
| `has-orcid` | | metadata which includes one or more ORCIDs |
| `has-authenticated-orcid` | | metadata which includes one or more ORCIDs where the depositing publisher claims to have witness the ORCID owner authenticate with ORCID |
| `orcid` | `{orcid}` | metadata where `&lt;orcid&gt;` element's value = `{orcid}` |
| `issn` | `{issn}` | metadata where record has an ISSN = `{issn}`. Format is `xxxx-xxxx`. |
| `isbn` | `{isbn}` | metadata where record has an ISBN = `{issn}`. |
| `type` | `{type}` | metadata records whose type = `{type}`. Type must be an ID value from the list of types returned by the `/types` resource |
| `directory` | `{directory}` | metadata records whose article or serial are mentioned in the given `{directory}`. Currently the only supported value is `doaj`. |
| `doi` | `{doi}` | metadata describing the DOI `{doi}` |
| `updates` | `{doi}` | metadata for records that represent editorial updates to the DOI `{doi}` |
| `is-update` | | metadata for records that represent editorial updates |
| `has-update-policy` | | metadata for records that include a link to an editorial update policy |
| `container-title` | | metadata for records with a publication title exactly with an exact match |
| `category-name` | | metadata for records with an exact matching category label. Category labels come from [this list](https://www.elsevier.com/solutions/scopus/content) published by Scopus |
| `type` | | metadata for records with type matching a type identifier (e.g. `journal-article`) |
| `type-name` | | metadata for records with an exactly matching type label |
| `award.number` | `{award_number}` | metadata for records with a matching award nunber. Optionally combine with `award.funder` |
| `award.funder` | `{funder doi or id}` | metadata for records with an award with matching funder. Optionally combine with `award.number` |
| `has-assertion` | | metadata for records with any assertions |
| `assertion-group` | | metadata for records with an assertion in a particular group |
| `assertion` | | metadata for records with a particular named assertion |
| `has-affiliation` | | metadata for records that have any affiliation information |
| `alternative-id` | | metadata for records with the given alternative ID, which may be a publisher-specific ID, or any other identifier a publisher may have provided |
| `article-number` | | metadata for records with a given article number |
| `has-abstract` | | metadata for records which include an abstract |
| `has-clinical-trial-number` | | metadata for records which include a clinical trial number |
| `content-domain` | | metadata where the publisher records a particular domain name as the location Crossmark content will appear |
| `has-content-domain` | | metadata where the publisher records a domain name location for Crossmark content |
| `has-domain-restriction` | | metadata where the publisher restricts Crossmark usage to content domains |
| `has-relation` | | metadata for records that either assert or are the object of a relation |
| `relation.type` | | One of the relation types from the Crossref relations schema (e.g. `is-referenced-by`, `is-parent-of`, `is-preprint-of`) |
| `relation.object` | | Relations where the object identifier matches the identifier provided |
| `relation.object-type` | | One of the identifier types from the Crossref relations schema (e.g. `doi`, `issn`) |&lt;/orcid&gt;&lt;/resource&gt;&lt;/resource&gt;&lt;/resource&gt;&lt;/resource&gt;&lt;/license_ref&gt;&lt;/license_ref&gt;&lt;/license_ref&gt;&lt;/license_ref&gt;

### Filtering by publication date with `from_pub_date` and `until_pub_date`
For example, you may only want to pull publications from a given year, or within a date range. Remember to increase the limit or use `cursor` if you need to. Also notice three things about the `filter` argument:

* The query parameter is in backticks (the key next to the 1 on the keyboard)
* The query itself is in single quotes
* The whole thing is wrapped in `c()`

Here, we will get all articles from the *Journal of Librarianship and Scholarly Communication* published after January 1, 2019:


```R
jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

### Filtering by funder with `award.funder`

You can also return all articles funded by a specific funder. See the [Crossref Funder Registry](https://gitlab.com/crossref/open_funder_registry) for a list of funders and their DOIs. 

Here, we will combine two filters: `award.funder` and `from_pub_date` to return all articles published in PLoS ONE where at least one funder is the 


```R
plosone_issn <- '1932-6203'
nih_funder_doi <- '10.13039/100000002'
plosone_publications_orcids <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25,
                                                 filter = c(award.funder = nih_funder_doi,
                                                           from_pub_date = '2020-02-01')) %>%
  purrr::pluck("data")
```

We will use `unnest()` from the `tidyr` package. This is described below in [Unnesting List Columns](https://rcrossref2-clarkeiakovakis.notebooks.azure.com/j/notebooks/rcrossref_20200305.ipynb#Unnesting-list-columns).


```R
plosone_publications_orcids %>%
    tidyr::unnest(funder)
```

If you scroll all the way to the right, you can see the funder information. Look at the `title` column and you will notice that some article titles are now duplicated, however you will see different funders in the `name` column. This is because a single article may have multiple funders, and a new row is created for each funder, with data including the `award` number.

### Filtering by license with `has_license`

You may be interested in licensing information for articles; for instance, gathering publications in a given journal that are licensed under Creative Commons. First run `cr_journals` with `works` set to `FALSE` in order to return journal details so you can check if the publisher even sends article licensing information to Crossref--it's not required. We will use PLOS ONE again as an example.



```R
plosone_issn <- '1932-6203'
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")
```

We can check the `deposits_licenses_backfile` and `deposits_licenses_current` variables. If they are `TRUE`, PLoS ONE does send licensing information and it is current. 


```R
plosone_details$deposits_licenses_backfile
```


```R
plosone_details$deposits_licenses_current
```

We can now rerun the query but set `works = TRUE`, and set the `has_license` to `TRUE`. This will therefore return only articles that have license information. We will set our `limit` to 25.


```R
plosone_license <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25, filter = c(`has_license` = TRUE)) %>% 
  pluck("data")
```


```R
plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license)
```

All articles in *PLoS ONE* are CC licensed, so we have no problem getting results. The license data comes in as a nested column. We can unnest it using `tidyr::unnest`, which will be discussed more below. 


```R
plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license) %>%
  tidyr::unnest(license)
```

This adds four columns all the way to the right: 
* **date** (Date on which this license begins to take effect) 
* **URL** (Link to a web page describing this license--in this case, Creative Commons)
* **delay in days** (Number of days between the publication date of the work and the start date of this license), and 
* **content.version**, which specifies the version of the article the licensing data pertains to (VOR = Version of Record, AM = Accepted Manuscript, TDM = Text and Data Mining). 

Browsing the rows, we see most are CC BY 4.0.

## Filtering rows and selecting columns with `dplyr`

You can use the `filter()` and `select()` functions from the `dplyr` package if you want to get subsets of this data after you have made the query. Note that this is a completely different `filter` than the one used above inside the `cr_journals()` function. That one was an argument sent with the API call that filtered the results before they were returned. This is a separate function that is part of `dplyr` to help you filter a data frame in R. 

Above, we retrieved all articles from the *Journal of Librarianship &amp; Scholarly Communication* published after January 1, 2019. Let's say you want only volume 8, issue 1:


```R
jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")
jlsc_8_1 <- jlsc_publications_2019 %>%
  dplyr::filter(volume == "8",
         issue == "1") 
jlsc_8_1 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

`filter()` will go through each row within the column specified and keep only those values matching the value you input. As we have seen, `select()` keeps only the variables you mention.

Again this is different from issuing the query to Crossref to get back only volume 8, issue 1. 

**Note:** be careful of filtering by ISSN. If a journal has multiple ISSNs they'll be combined in a single cell with a comma and the `filter()` will fail, as with JAMA above. In this case it may be wiser to use `str_detect()`, as described a couple code chunks down.


```R
jah_jama_publications$issn[1]
```

We can use `filter()` to get a single article from within this data frame if we need, either by DOI:


```R
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(doi == "10.7710/2162-3309.2299") 
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

Or by title:


```R
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(stringr::str_detect(title, "OER"))
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

Here, we use the `str_detect()` function from the `stringr` package, which is loaded as part of the `tidyverse`, in order to find a single term (OER) in the title.

Remember that these `dplyr` and `stringr` functions are searching through our existing data frame `jlsc_publications_2019`, not issuing new API calls.

To learn more about the `dplyr` package, read the ["Data Transformation" chapter in *R For Data Science*](https://r4ds.had.co.nz/transform.html).

## Field queries

At the risk of confusing you further (but in the interests of providing more information), there is yet another way of making your query more precise, and that is to use a field query (`flq`) argument to `cr_journals()`. This allows you to specify additional variables, which are listed in the [Crossref documentation](https://github.com/CrossRef/rest-api-doc#field-queries) and reproduced below. You *must* provide an ISSN--in other words, you can't run a field query for authors across all journals. 


| Field query parameter | Description |
|-----------------------|-------------|
| `query.container-title` | Query `container-title` aka. publication name |
| `query.author` | Query author given and family names |
| `query.editor` | Query editor given and family names |
| `query.chair` | Query chair given and family names |
| `query.translator` | Query translator given and family names |
| `query.contributor` | Query author, editor, chair and translator given and family names |
| `query.bibliographic` | Query bibliographic information, useful for citation look up. Includes titles, authors, ISSNs and publication years |
| `query.affiliation` | Query contributor affiliations |

### Field query by title

Here, we get all publications from the Journal of Librarianship and Scholarly Communication with the term "open access" in the title. 



```R
jlsc_issn <- "2162-3309"
jlsc_publications_oa <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.bibliographic` = 'open access')) %>%
  purrr::pluck("data")
jlsc_publications_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, issn, author)
```

### Field query by author, contributor, or editor

The `flq` argument can also be used for authors, contributors, or editors. Here we search the same journal for authors with the name Salo (looking for all articles written by Dorothea Salo).




```R
jlsc_publications_auth <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.author` = 'salo')) %>%
  purrr::pluck("data")
jlsc_publications_auth %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

---
**TRY IT YOURSELF**

1. Assign the ISSN for *College &amp; Research Libraries* to a value - 2150-6701
2. Use the `query.author` field query (`flq`) to find all articles written by Lisa Janicke Hinchliffe 


```R
# assign the C&RL ISSN 2150-6701

```


```R
# use the query.author field query to search for articles written by Lisa Hinchliffe. 

```

# Viewing the JSON file

You can view these files in a JSON viewer using the `toJSON()` function from the `jsonlite` package.


```R
plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 25) %>%
  pluck("data")
plosone_publications_json <- jsonlite::toJSON(plosone_publications)
```

Print the JSON, triple click inside the box to highlight the text, and copy it to the clipboard.


```R
plosone_publications_json
```

Go to [Code Beautify](https://codebeautify.org/jsonviewer) and paste the JSON on the left side. Click **Tree Viewer** to view the data. Open the first item to view the metadata. Note especially the last few variables. These are nested lists, as a single article can have multiple authors, and each author has a given name, family name, and sequence of authorship.

To write to JSON, use `jsonlite::write_json()`


```R
jsonlite::write_json(plosone_publications_json, "plosone_publications.json")
```

# Using `cr_works()` to get data on articles

`cr_works()` allows you to search by DOI or a general query in order to return the Crossref metadata.

It is important to note, as Crossref does [in the documentation](https://github.com/CrossRef/rest-api-doc/blob/master/demos/crossref-api-demo.ipynb):

&gt; Crossref does not use "works" in the FRBR sense of the word. In Crossref parlance, a "work" is just a thing identified by a DOI. In practice, Crossref DOIs are used as citation identifiers. So, in FRBR terms, this means, that a Crossref DOI tends to refer to one *expression* which might include multiple *manifestations*. So, for example, the ePub, HTML and PDF version of an article will share a Crossref DOI because the differences between them should not effect the interpretation or crediting of the content. In short, they can be cited interchangeably. The same is true of the "accepted manuscript" and the "version-of-record" of that accepted manuscript.


## Searching by DOI

You can pass a DOI directly to `cr_works()` using the `dois` argument:


```R
jlsc_ku_oa <- cr_works(dois = '10.7710/2162-3309.1252') %>%
  purrr::pluck("data")
jlsc_ku_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

You can also pass more than one DOI. Here we start by assigning our DOIs to a variable `my_dois`, then pass it to `cr_works()` in the `doi` argument:


```R
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
```

## Unnesting list columns

Authors, links, licenses, funders, and some other values can appear in nested lists when you call `cr_journals` because there can be, and often are, multiple of each of these items per article. You can check the data classes on all variables by running `typeof()` across all columns using the `map_chr()` function from `purrr`:



```R
purrr::map_chr(jlsc_ku_oa, typeof)
```

Our `jlsc_ku_oa` data frame has a nested list for **author**. We can unnest this column using `unnest()` from the `tidyr` package:


```R
jlsc_ku_oa %>%
    tidyr::unnest(author)
```

We can see this has added 5 rows and 3 new columns: **given** (first name), **family** (last name), and **sequence** (order in which they appeared).

See https://ciakovx.github.io/rcrossref.html#unnesting_list_columns for more detailed strategies in unnesting nested lists in Crossref. For more details, call `?unnest` and read the [R for Data Science section on Unnesting](https://r4ds.had.co.nz/many-models.html#unnesting).

## Getting more than 1000 results with the `cursor` argument to `cr_journals`

If our result will have more than 1000 results, we have to use the `cursor` argument. We will not be covering this in this class, but see https://ciakovx.github.io/rcrossref.html#getting_more_than_1000_results_with_the_cursor_argument_to_cr_journals for instructions on how to do it.

## Running general queries on `cr_works()`

You can also use `cr_works()` to run a query based on very simple text keywords. For example, you can run `oa_works &lt;- rcrossref::cr_works(query = "open+access")`.
Paul Oldham [gives a great example of this](https://poldham.github.io/abs/crossref.html#searching_crossref), but does make the comment:

&gt; CrossRef is not a text based search engine and the ability to conduct text based searches is presently crude. Furthermore, we can only search a very limited number of fields and this will inevitably result in lower returns than commercial databases such as Web of Science (where abstracts and author keywords are available). 
Unfortunately there is no boolean AND for Crossref queries (see https://github.com/CrossRef/rest-api-doc/issues/135 and  https://twitter.com/CrossrefSupport/status/1073601263659610113). However, as discussed above, the Crossref API assigns a score to each item returned giving a measure of the API's confidence in the match, and if you connect words using `+` the Crossref API will give items with those terms a higher score.

## Specifying field queries to `cr_works()` with `flq`

As with `cr_journals`, you can use `flq` to pass field queries on to `cr_works()`, such as author.

Here we search for the book *Open Access* by Peter Suber by doing a general keyword search for "open access" and an author search for "suber":



```R
suber_oa <- cr_works(query = 'open+access', flq = c(`query.author` = 'suber')) %>%
  pluck("data")
suber_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

Dr. Suber has written lots of materials that includes the term "open access." We can use the `filter()` function from `dplyr` to look only at books, from the **type** column:


```R
suber_oa_books <- suber_oa %>%
  filter(type == "book")
suber_oa_books %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

One is the book from MIT Press that we're looking for; the other is *Knowledge Unbound*, which is a collection of his writings.

We could be more specific from the outset by adding bibliographic information in `query.bibliographic`, such as ISBN (or ISSN, if it's a journal):


```R
suber_isbn <- cr_works(flq = c(`query.author` = 'suber',
                           `query.bibliographic` = '9780262301732')) %>%
  pluck("data")
suber_isbn %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

You can combine the `filter` argument with `flq` to return only items of **type** `book` published in 2012.

## Getting formatted references in a text file

We can use the `cr_cn()` function from the `rcrossref` package to get the citations to those articles in text form in the style you specify. We'll put it into Chicago. The `cr_cn()` function returns each citation into a list element. We can use the `map_chr` and the `pluck` functions from `purrr` to instead assign them to a character vector. 


```R
my_citations <- rcrossref::cr_cn(my_dois,
                                 format = "text",
                                 style = "chicago-note-bibliography") %>% 
  purrr::map_chr(., purrr::pluck, 1)
my_citations
```

Beautiful formatted citations from simply a list of DOIs! You can then write this to a text file using `writeLines`. 


```R
writeLines(my_citations, "my_citations_text.txt")
```

The above is helpful if you need to paste the references somewhere, and there are loads of other citation styles included in `rcrossref`--view them by calling `rcrossref::get_styles()` and it will print a vector of these styles to your console. I'll just print the first 15 below:


```R
rcrossref::get_styles()[1:15]
```

## Getting formatted references in a BibTeX or RIS file

In addition to a text file, you can also write it to BibTeX or RIS:


```R
my_citations_bibtex <- rcrossref::cr_cn(my_dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)
```

Write it to a .bib file using `writeLines()`:


```R
writeLines(my_citations_bibtex, "my_citations_bibtex.bib")
```

## Getting works from a typed citation in a Word document/text file

This can be helpful if you have a bibliography in a Word document or text file that you want to get into a reference management tool like Zotero. For instance, you may have written the citations in APA style and need to change to Chicago, but don't want to rekey it all out. Or perhaps you jotted down your citations hastily and left out volume, issue, or page numbers, and you need a nice, fully-formatted citation.

If each citation is on its own line in your document's bibliography, then you can probably paste the whole bibliography into an Excel spreadsheet. If it goes as planned, each citation will be in its own cell. You can then save it to a CSV file, which can then be read into R. 



```R
my_references <- read.csv("references.txt", stringsAsFactors = FALSE, fileEncoding = "ISO 8859-1")
my_references
```

As you can see, these are just raw citations, not divided into variables by their metadata elements (that is, with title in one column, author in another, etc.). But, we can now run a query to get precisely that from Crossref using `cr_works`. Because `cr_works` is not vectorized, we will need to build a loop using `map()` from the `purrr` package. 

Don't mind the technical details--it is basically saying to take each row and look it up in the Crossref search engine. Basically, this is the equivalent of copy/pasting the whole reference into the Crossref search engine. The loop will `print()` the citation before searching for it so we can keep track of where it is. We set the `limit` to 5 because if Crossref didn't find it in the first 5 results, it's not likely to be there at all.


```R
my_references_works_list <- purrr::map(
  my_references$reference,
  function(x) {
    print(x)
    my_works <- rcrossref::cr_works(query = x, limit = 5) %>%
      purrr::pluck("data")
  })
```

The Crossref API assigns a score to each item returned within each query, giving a measure of the API's confidence in the match. The item with the highest score is returned first in the datasets. We can return the first result in each item in the `my_references_works_list` by using `map_dfr()`, which is like `map()` except it returns the results into a data frame rather than a list:


```R
my_references_works_df <- my_references_works_list %>%
  purrr::map_dfr(., function(x) {
    x[1, ]
  })
my_references_works_df %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```

We can print just the titles to quickly see how well they match with the titles of the works we requested:


```R
my_references_works_df$title
```

Not bad! Looks like we got 6 out of 8, with problems on number 5 and 7. To see more about how to troubleshoot those two, go to https://ciakovx.github.io/rcrossref.html#getting_works_from_a_typed_citation_in_a_word_documenttext_file

## Writing publications to CSV

We will use the `write_csv()` function from the `readr` package to write our data to disk. 


```R
plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 2) %>%
  pluck("data")
```

Unfortunately, you cannot simply write the `plosone_publications` data frame to a CSV, due to the nested lists. It will throw an error: `"Error in stream_delim_(df, path, ...) : Don't know how to handle vector of type list."`

I run through three solutions at https://ciakovx.github.io/rcrossref.html#writing_publications_to_disk

Here, we will use solution 3: You can use `mutate()` from `dplyr` to coerce the list columns into character vectors.

First, identify the list vectors:


```R
purrr::map_chr(plosone_publications, typeof)
```

Then, coerce those columns to character:


```R
plosone_publications_mutated <- plosone_publications %>%
  dplyr::mutate(author = as.character(author)) %>%
  dplyr::mutate(link = as.character(link)) %>%
  dplyr::mutate(license = as.character(license)) %>%
  dplyr::mutate(reference = as.character(reference)) %>%
  dplyr::mutate(funder = as.character(funder)) %>%
  dplyr::mutate("clinical-trial-number" = as.character("clinical-trial-number"))
write.csv(plosone_publications_mutated, "plosone_publications_mutated.csv")
```

Again, this is not an ideal solution, but if you need to move the data into CSV to view in Excel, it can do the trick.

# Using `roadoi` to check for open access

`roadoi` was developed by Najko Jahn, with reviews from Tuija Sonkkila and Ross Mounce. It interfaces with [Unpaywall](https://unpaywall.org) (which used to be called oaDOI), an important tool developed by [ImpactStory](http://unpaywall.org/team) (Heather Piwowar and Jason Priem) for locating open access versions of scholarship--read more in this [*Nature* article](https://www.nature.com/articles/d41586-018-05968-3). See here for [the `roadoi` documentation](https://cran.r-project.org/web/packages/roadoi/roadoi.pdf).

This incredible [Introduction to `roadoi`](https://cran.r-project.org/web/packages/roadoi/vignettes/intro.html) by Najko Jahn provides much of what you need to know to use the tool, as well as an interesting use case. Also see his recently published article [Open Access Evidence in Unpaywall](https://subugoe.github.io/scholcomm_analytics/posts/unpaywall_evidence/), running deep analysis on Unpaywall data.

First install the package and load it.



```R
install.packages("roadoi")
```


```R
library(roadoi)
```

## Setting up `roadoi`

Your API calls to Unpaywall must include a valid email address where you can be reached in order to keep the service open and free for everyone. 

Run this line of code, replacing the example with your email address:


```R
options(roadoi_email = "clarke.iakovakis@okstate.edu")
```

## Checking OA status with `oadoi_fetch`

We then create DOI vector and use the `oadoi_fetch()` function from `roadoid`. 




```R
my_dois <- c("10.2139/ssrn.2697412", 
                        "10.1016/j.joi.2016.08.002", 
                        "10.1371/journal.pone.0020961", 
                        "10.3389/fpsyg.2018.01487", 
                        "10.1038/d41586-018-00104-7", 
                        "10.12688/f1000research.8460.2", 
                        "10.7551/mitpress/9286.001.0001")
my_dois_oa <- roadoi::oadoi_fetch(dois = my_dois,
                                 email = "clarke.iakovakis@okstate.edu")
```

Look at the column names.


```R
names(my_dois_oa)
```

The returned variables are described on the [Unpaywall Data Format](http://unpaywall.org/data-format) page.

We can see that Unpaywall could not find OA versions for two of the seven of these, so we will filter them out:


```R
my_dois_oa <- my_dois_oa %>%
  filter(is_oa == TRUE)
```

As above, it is easier to use `unnest()` to more closely view one of the variables:


```R
my_dois_oa %>%
    unnest(best_oa_location)
```

# Next steps

There are several other excellent R packages that interface with publication metadata that can be used in conjunction with this package. Examples:

* `rorcid` is a wrapper for the ORCID API. Functions included for searching for people, searching by 'DOI',and searching by ORCID iD. https://cran.r-project.org/web/packages/rorcid/rorcid.pdf. See my walkthrough at https://ciakovx.github.io/rorcid.html.
* `bibliometrix` "is an open-source tool for quantitative research in scientometrics and bibliometrics that includes all the main bibliometric methods of analysis." See more information at https://bibliometrix.org/.
* `rromeo` is a wrapper for the SHERPA-RoMEO API. You can retrieve a set of publications metadata from `rcrossref`, then use the ISSN to look up the policies of the journal regarding the archival of preprints, postprints, and publisher versions. https://cran.r-project.org/web/packages/rromeo/rromeo.pdf
* `crminer` "includes functions for getting getting links to full text of articles, fetching full text articles from those links or Digital Object Identifiers ('DOIs'), and text extraction from 'PDFs'." https://cran.r-project.org/web/packages/crminer/crminer.pdf

# R Resources

## Learning R
1. `swirl` is a package you can install in R to learn about R and data science interactively. Just type `install.packages("swirl")` into your R console, load the package by typing `library("swirl")`, and then type `swirl()`. Read more at &lt;http: swirlstats.com=""&gt;.

2. [Try R](http://tryr.codeschool.com/) is a browser-based interactive tutorial developed by Code School.

3. Anthony Damico's [twotorials](https://www.youtube.com/playlist?list=PLcgz5kNZFCkzSyBG3H-rUaPHoBXgijHfC) are a series of 2 minute videos demonstrating several basic tasks in R.

4. [Cookbook for R](http://www.cookbook-r.com/) by Winston Change provides solutions to common tasks and problems in analyzing data

5. If you're up for a challenge, try the free [R Programming MOOC in Coursera](https://www.coursera.org/learn/r-programming) by Roger Peng.

6. Books:
    * [R For Data Science](http://r4ds.had.co.nz/) by Garrett Grolemund &amp; Hadley Wickham [free]
    * [An Introduction to Data Cleaning with R](https://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf) by Edwin de Jonge &amp; Mark van der Loo [free]
    * [YaRrr! The Pirate's Guide to R](https://bookdown.org/ndphillips/YaRrr/) by Nathaniel D. Phillips [free]
    * Springer's [Use R!](https://link.springer.com/bookseries/6991) series [not free] is mostly specialized, but it has some excellent introductions including Alain F. Zuur et al.'s [A Beginner's Guide to R](https://link.springer.com/book/10.1007/978-0-387-93837-0) and Phil Spector's [Data Manipulation in R](https://link.springer.com/book/10.1007/978-0-387-74731-6)

## Data

If you need some data to play with, type `data()` in the console for a list of data sets. To load a dataset, type it like this: `data(mtcars)`. Type `help(mtcars)` to learn more about it. You can then perform operations, e.g. 
```{r dataloading, comment=NA, eval=F}
head(mtcars)
nrow(mtcars)
mean(mtcars$mpg)
sixCylinder &lt;- mtcars[mtcars$cyl == 6, ]
```

See also rdatamining.com's [list of free datasets](http://www.rdatamining.com/resources/data).

## Cheat Sheets

* [Base R Cheat Sheet](https://paulvanderlaken.files.wordpress.com/2017/08/base-r-cheetsheat.pdf) by Mhairi McNeill
* [Data Transformation with dplyr Cheat Sheet](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf) by RStudio
* [Data Wrangling with dplyr and tidyr Cheat Sheet](https://paulvanderlaken.files.wordpress.com/2017/08/ddplyr-cheatsheet-data-wrangling-plyr.pdf) by RStudio
* [Complete list of RStudio cheatsheets](https://github.com/rstudio/cheatsheets/)

## Style guides
Use these resources to write cleaner code, according to established style conventions

* Hadley Wickham's [Style Guide](http://adv-r.had.co.nz/Style.html)
* Google's [R Style Guide](https://google.github.io/styleguide/Rguide.xml)
* Tip: highlight code in your script pane and press **Ctrl/Cmd + I** on your keyboard to automatically fix the indents&lt;/http:&gt;
