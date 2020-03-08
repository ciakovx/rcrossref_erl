
# Introduction

The Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. 

Azure Notebooks is a free hosted service to develop and run Jupyter notebooks in the cloud with no installation.

We are using these platforms to avoid having to install R and R Studio onto your own computer. Furthermore, by interacting with R in this notebook, you will be able to execute code that I have already written, and see explanations of it first hand. Because this is such a brief session, we cannot go into detail about learning the R language, but I have provided some resources at the end of this document.

I have also created a **binder** of this project, which will allow you to launch it in RStudio in your browser without having to download anything. Though we will not be using this as the basis of today's session, it may be of some use to you. Launch it at 

[![launch binder](https://camo.githubusercontent.com/483bae47a175c24dfbfc57390edd8b6982ac5fb3/68747470733a2f2f6d7962696e6465722e6f72672f62616467655f6c6f676f2e737667)](https://mybinder.org/v2/gh/ciakovx/rcrossref_erl/master?urlpath=rstudio)

If you plan on using `rcrossref` more extensively, I would recommend downloading R and R Studio to your own computer and using it there. Also, the Crossref team encourages requests with appropriate contact information, and will forward you to a dedicated API cluster for improved performance when you share your email with them. We cannot do that in this notebook, but you can do that in R.

For a more detailed walkthrough of this entire lesson, including instructions for downloading R and R Studio, sharing your email with Crossref, and much more, please visit the set of tutorials at https://ciakovx.github.io/fsci_syllabus.html.

# Licensing

This walkthrough is distributed under a [https://creativecommons.org/licenses/by/4.0/](Creative Commons Attribution 4.0 International (CC BY 4.0) License). 


<div>
    <br>
    <a>
        <img src="images/ccby.png" style="width: 400px;">
    </a>
</div>

# Jupyter Notebooks

<div>
        <a>
            <img src="images/jupyter.png" style="width: 400px;">
</a></div><a>

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
* **Alt (or option on Mac) + Enter** to Run cell and insert a new cell below.
* **Ctrl (or Cmd on Mac) + Z**: Undo

---
**TRY IT YOURSELF**

Select the below cell in Edit Mode by double clicking in it, or by clicking it on the margin and pressing **Enter**. It should have a green border. Notice that this is a **Code** cell. Press Shift + Enter to execute the code. This will print the output and select the next cell.

Then, when you are in the next cell, press Ctrl + Enter. This will print the output and stay in the same cell.

Then, press the down arrow on your keyboard to to to the next cell. Enter Edit Mode (green border) by pressing Enter. Press Alt (or option on Mac) + Enter. This will print the output and create a new cell.

Then press the down arrow or select the new empty cell. Make sure you are in Command Mode (blue border). Press D twice to delete the new cell.</a>


```R
# press Shift + Enter
print("You just ran the cell and selected the next cell")
```

    [1] "You just ran the cell and selected the next cell"



```R
# press Ctrl + Enter
print("You just ran this cell and the focus stayed here in this cell")
```

    [1] "You just ran this cell and the focus stayed here in this cell"



```R
# press Alt (or option on Mac) + Enter
print("You just ran the cell and inserted a new cell below it")
```

    [1] "You just ran the cell and inserted a new cell below it"


Notice the text in the above cells that starts with a hash **#** character. The hash indicates a **comment**. Anything following the hash symbol will not be evaluated. 

# Install and load `rcrossref`, `dplyr`, `purrr`, `stringr`, and `tidyr`

When you download R it already has a number of functions built in: these encompass what is called **Base R**. However, many R users write their own libraries of functions, package them together in R **packages**, and provide them to the R community at no charge. This extends the capacity of R and allows us to do much more. In many cases, they improve on the Base R functions by making them easier and more straight-forward to use.

First install `rcrossref` using the `install.packages()` function. Notice the package name is in quotation marks.

Click on the left margin of the cell below so it turns blue. Then click the **Run** button on the top toolbar, or press **Ctrl + Enter**. This will **execute** the code, installing the necessary packages into your Jupyter Notebook environment. 

This may take a couple minutes. You will see a \[*\] on the left margins while the package installs. When the asterisk becomes a number, we will be ready. 


```R
install.packages('rcrossref')
```

    Installing package into ‘/home/nbuser/R’
    (as ‘lib’ is unspecified)


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

# increase number of columns and rows displayed when we print a table
options(repr.matrix.max.cols=100, repr.matrix.max.rows=20)
```

<div>
    <br>
    <a>
        <img src="images/tidyverse.png" style="width: 150px;">
    </a>
</div>

# R Basics

<div>
    <br>
    <a>
        <img src="images/R.png" style="width: 200px;">
    </a>
    <br>
</div>

R is more of a programming language than a statistics program. It was started by Robert Gentleman and Ross Ihaka from the University of Auckland in 1995. They described it as “a language for data analysis and graphics.”1 You can use R to create, import, and scrape data from the web; clean and reshape it; visualize it; run statistical analysis and modeling operations on it; text and data mine it; and much more.

If you intend on continuing your R journey after this workshop, I recommend installing R and R Studio and doing your scripting there. To install R, go to https://www.r-project.org/. Click on CRAN (Comprehensive R Archive Network) under Download, and scroll down to your country. Select the download link corresponding to the city that is geographically closest to you. Go to https://www.rstudio.com/products/RStudio/#Desktop to download the RStudio desktop software.


We don't have enough time in today's workshop to learn much about R. There are many excellent R tutorials at the end of this document. To get help on R functions within Jupyter Notebooks, type `help()` with the function name in parentheses. For example, `help(sum)` or `help(which)`. This will provide a description of the function, its usage, and the arguments the function takes.

## Writing &amp; Evaluating Expressions

The *prompt* is the blinking cursor in a Code cell prompting you to take action. We type *expressions* into the prompt, and press Ctrl + Enter to *evaluate* those expressions.

Evaluate this expression:


```R
# Press Ctrl + Enter or click the Run button to evaluate 2 + 2
2 + 2
```


4


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


5


As we saw above, you can also use the `print()` function:


```R
# using print() will do the same thing as just typing the variable in, it just makes it explicit
print(y)
```

    [1] 5


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


4


Typing a question mark before a function will pull the help page up in the Navigation Pane in the lower right. Type `?sum` to view the help page for the `sum` function. You can also call `help(sum)`. This will provide the description of the function, how it is to be used, and the arguments. 

In the case of `sum()`, the ellipses `. . .` represent an unlimited number of numeric elements. `sum()` also takes the argument `na.rm`. This is a logical (`TRUE/FALSE`) argument specifying if NA values (missing data) should be removed when the argument is evaluated.

The function `is.function()` will check if an argument is a function in R. If it is a function, it will print `TRUE` to the console.



```R
# confirm that sum is a function
is.function(sum)
```


TRUE



```R
# sum takes an unlimited number (. . .) of numeric elements
sum(3, 4, 5, 6, 7)
```


25



```R
# evaluating a sum with missing values will return NA
sum(3, 4, NA)
```


&lt;NA&gt;



```R
# look at the help file for sum
?sum
```


```R
# but setting the argument na.rm to TRUE will remove the NA
sum(3, 4, na.rm = TRUE)
```


7


Functions can be nested within each other. For example, `sqrt()` takes the square root of the number provided in the function call. Therefore you can run `sum(sqrt(9), 4)` to take the sum of the square root of 9 (3) and add it to 4. Or you could write the quadratic formula: `[(-b) + sqrt((b^2) - 4ac)] / (2*a)`.

# Crossref &amp; `rcrossref`

## Crossref

<div>
    <br>
    <a>
        <img src="images/crossref-logo.png" style="width: 200px;">
    </a>
    <br>
</div>


Crossref is a a not-for-profit membership organization dedicated to interlinking scholarly metadata, including journals, books, conference proceedings, working papers, technical reports, data sets, authors, funders, and more. The [Crossref REST API](https://github.com/CrossRef/rest-api-doc) allows anybody to search and reuse members' metadata in a variety of ways. Read [examples of user stories](https://www.crossref.org/services/metadata-delivery/user-stories/).

## `rcrossref`

`rcrossref` is a package developed by [Scott Chamberlain](https://scottchamberlain.info/), Hao Zhu, Najko Jahn, Carl Boettiger, and Karthik Ram, part of the [rOpenSci](https://ropensci.org/) set of packages. rOpenSci is an incredible organization dedicated to open and reproducible research using shared data and reusable software. I strongly recommend you browse their set of packages at https://ropensci.org/packages/.

<div>
    <br>
    <a>
        <img src="images/ropensci.png" style="width: 200px;">
    </a>
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


<dl>
	<dt>$meta</dt>
		<dd>NULL</dd>
	<dt>$data</dt>
		<dd><table>
<caption>A data.frame: 1 x 53</caption>
<thead>
	<tr><th>title</th><th>publisher</th><th>issn</th><th>last_status_check_time</th><th>deposits_abstracts_current</th><th>deposits_orcids_current</th><th>deposits</th><th>deposits_affiliations_backfile</th><th>deposits_update_policies_backfile</th><th>deposits_similarity_checking_backfile</th><th>deposits_award_numbers_current</th><th>deposits_resource_links_current</th><th>deposits_articles</th><th>deposits_affiliations_current</th><th>deposits_funders_current</th><th>deposits_references_backfile</th><th>deposits_abstracts_backfile</th><th>deposits_licenses_backfile</th><th>deposits_award_numbers_backfile</th><th>deposits_open_references_backfile</th><th>deposits_open_references_current</th><th>deposits_references_current</th><th>deposits_resource_links_backfile</th><th>deposits_orcids_backfile</th><th>deposits_funders_backfile</th><th>deposits_update_policies_current</th><th>deposits_similarity_checking_current</th><th>deposits_licenses_current</th><th>affiliations_current</th><th>similarity_checking_current</th><th>funders_backfile</th><th>licenses_backfile</th><th>funders_current</th><th>affiliations_backfile</th><th>resource_links_backfile</th><th>orcids_backfile</th><th>update_policies_current</th><th>open_references_backfile</th><th>orcids_current</th><th>similarity_checking_backfile</th><th>references_backfile</th><th>award_numbers_backfile</th><th>update_policies_backfile</th><th>licenses_current</th><th>award_numbers_current</th><th>abstracts_backfile</th><th>resource_links_current</th><th>abstracts_current</th><th>open_references_current</th><th>references_current</th><th>total_dois</th><th>current_dois</th><th>backfile_dois</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;date&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;int&gt;</th><th>&lt;int&gt;</th><th>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>PLoS ONE</td><td>Public Library of Science</td><td>1932-6203</td><td>2020-03-08</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>0</td><td>1</td><td>0.1274988</td><td>0.9917525</td><td>0.5958421</td><td>0</td><td>0</td><td>0.1001075</td><td>1</td><td>1</td><td>0.9200942</td><td>0.9055068</td><td>0.9055068</td><td>0.1086978</td><td>0.9999636</td><td>1</td><td>0.5144021</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>230350</td><td>37807</td><td>192543</td></tr>
</tbody>
</table>
</dd>
	<dt>$facets</dt>
		<dd>NULL</dd>
</dl>



This actually comes back as a list of three items: `meta`, `data`, and `facets`. The good stuff is in `data`. 

We use the `pluck()` function from the `purrr` package to pull that data only. We will be using `pluck` throughout this tutorial; it's an easy way of indexing deeply and flexibly into lists to extract information.

We don't have time in this tutorial to discuss list items and purr. For an excellent in-depth tutorial, see Jenny Bryan's [
Introduction to map(): extract elements](https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html).


```R
# get information about the journal and pluck the data
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")
```

The `purrr::pluck()` function is connected to `plosone_details` with something called a [Pipe Operator](https://www.datacamp.com/community/tutorials/pipe-r-tutorial) `%&gt;%`, which we will be using throughout the tutorial. A pipe takes the output of one statement and immediately makes it the input of the next statement. It helps so that you don't have to write every intermediate, processing data to your R environment. You can think of it as "then" in natural language. So the above script first makes the API call with `cr_journals()`, then it applies `pluck()` to extract only the list element called `"data"`, and returns it to the `plosone_details` value.

We now have a **data frame** including the details Croassref has on file about PLoS ONE. Scroll to the right to see all the columns.


```R
plosone_details
```


<table>
<caption>A data.frame: 1 x 53</caption>
<thead>
	<tr><th>title</th><th>publisher</th><th>issn</th><th>last_status_check_time</th><th>deposits_abstracts_current</th><th>deposits_orcids_current</th><th>deposits</th><th>deposits_affiliations_backfile</th><th>deposits_update_policies_backfile</th><th>deposits_similarity_checking_backfile</th><th>deposits_award_numbers_current</th><th>deposits_resource_links_current</th><th>deposits_articles</th><th>deposits_affiliations_current</th><th>deposits_funders_current</th><th>deposits_references_backfile</th><th>deposits_abstracts_backfile</th><th>deposits_licenses_backfile</th><th>deposits_award_numbers_backfile</th><th>deposits_open_references_backfile</th><th>deposits_open_references_current</th><th>deposits_references_current</th><th>deposits_resource_links_backfile</th><th>deposits_orcids_backfile</th><th>deposits_funders_backfile</th><th>deposits_update_policies_current</th><th>deposits_similarity_checking_current</th><th>deposits_licenses_current</th><th>affiliations_current</th><th>similarity_checking_current</th><th>funders_backfile</th><th>licenses_backfile</th><th>funders_current</th><th>affiliations_backfile</th><th>resource_links_backfile</th><th>orcids_backfile</th><th>update_policies_current</th><th>open_references_backfile</th><th>orcids_current</th><th>similarity_checking_backfile</th><th>references_backfile</th><th>award_numbers_backfile</th><th>update_policies_backfile</th><th>licenses_current</th><th>award_numbers_current</th><th>abstracts_backfile</th><th>resource_links_current</th><th>abstracts_current</th><th>open_references_current</th><th>references_current</th><th>total_dois</th><th>current_dois</th><th>backfile_dois</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;date&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;dbl&gt;</th><th>&lt;int&gt;</th><th>&lt;int&gt;</th><th>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>PLoS ONE</td><td>Public Library of Science</td><td>1932-6203</td><td>2020-03-08</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>FALSE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>TRUE</td><td>0</td><td>1</td><td>0.1274988</td><td>0.9917525</td><td>0.5958421</td><td>0</td><td>0</td><td>0.1001075</td><td>1</td><td>1</td><td>0.9200942</td><td>0.9055068</td><td>0.9055068</td><td>0.1086978</td><td>0.9999636</td><td>1</td><td>0.5144021</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>230350</td><td>37807</td><td>192543</td></tr>
</tbody>
</table>



There are a number of ways to explore this data frame:


```R
#display information about the data frame
str(plosone_details)
```

    'data.frame':	1 obs. of  53 variables:
     $ title                                : chr "PLoS ONE"
     $ publisher                            : chr "Public Library of Science"
     $ issn                                 : chr "1932-6203"
     $ last_status_check_time               : Date, format: "2020-03-08"
     $ deposits_abstracts_current           : logi FALSE
     $ deposits_orcids_current              : logi TRUE
     $ deposits                             : logi TRUE
     $ deposits_affiliations_backfile       : logi FALSE
     $ deposits_update_policies_backfile    : logi TRUE
     $ deposits_similarity_checking_backfile: logi TRUE
     $ deposits_award_numbers_current       : logi TRUE
     $ deposits_resource_links_current      : logi FALSE
     $ deposits_articles                    : logi TRUE
     $ deposits_affiliations_current        : logi FALSE
     $ deposits_funders_current             : logi TRUE
     $ deposits_references_backfile         : logi TRUE
     $ deposits_abstracts_backfile          : logi FALSE
     $ deposits_licenses_backfile           : logi TRUE
     $ deposits_award_numbers_backfile      : logi TRUE
     $ deposits_open_references_backfile    : logi TRUE
     $ deposits_open_references_current     : logi TRUE
     $ deposits_references_current          : logi TRUE
     $ deposits_resource_links_backfile     : logi FALSE
     $ deposits_orcids_backfile             : logi TRUE
     $ deposits_funders_backfile            : logi TRUE
     $ deposits_update_policies_current     : logi TRUE
     $ deposits_similarity_checking_current : logi TRUE
     $ deposits_licenses_current            : logi TRUE
     $ affiliations_current                 : num 0
     $ similarity_checking_current          : num 1
     $ funders_backfile                     : num 0.127
     $ licenses_backfile                    : num 0.992
     $ funders_current                      : num 0.596
     $ affiliations_backfile                : num 0
     $ resource_links_backfile              : num 0
     $ orcids_backfile                      : num 0.1
     $ update_policies_current              : num 1
     $ open_references_backfile             : num 1
     $ orcids_current                       : num 0.92
     $ similarity_checking_backfile         : num 0.906
     $ references_backfile                  : num 0.906
     $ award_numbers_backfile               : num 0.109
     $ update_policies_backfile             : num 1
     $ licenses_current                     : num 1
     $ award_numbers_current                : num 0.514
     $ abstracts_backfile                   : num 0
     $ resource_links_current               : num 0
     $ abstracts_current                    : num 0
     $ open_references_current              : num 1
     $ references_current                   : num 1
     $ total_dois                           : int 230350
     $ current_dois                         : int 37807
     $ backfile_dois                        : int 192543


Type `?str` into the console to read the description of the `str` function. You can call `str()` on an R object to compactly display information about it, including the data type, the number of elements, and a printout of the first few elements.


```R
# dimensions: 1 row, 53 columns
dim(plosone_details)
```


<ol class="list-inline">
	<li>1</li>
	<li>53</li>
</ol>




```R
# number of rows
nrow(plosone_details)
```


1



```R
# number of columns
ncol(plosone_details)
```


53



```R
# column names
names(plosone_details)
```


<ol class="list-inline">
	<li>'title'</li>
	<li>'publisher'</li>
	<li>'issn'</li>
	<li>'last_status_check_time'</li>
	<li>'deposits_abstracts_current'</li>
	<li>'deposits_orcids_current'</li>
	<li>'deposits'</li>
	<li>'deposits_affiliations_backfile'</li>
	<li>'deposits_update_policies_backfile'</li>
	<li>'deposits_similarity_checking_backfile'</li>
	<li>'deposits_award_numbers_current'</li>
	<li>'deposits_resource_links_current'</li>
	<li>'deposits_articles'</li>
	<li>'deposits_affiliations_current'</li>
	<li>'deposits_funders_current'</li>
	<li>'deposits_references_backfile'</li>
	<li>'deposits_abstracts_backfile'</li>
	<li>'deposits_licenses_backfile'</li>
	<li>'deposits_award_numbers_backfile'</li>
	<li>'deposits_open_references_backfile'</li>
	<li>'deposits_open_references_current'</li>
	<li>'deposits_references_current'</li>
	<li>'deposits_resource_links_backfile'</li>
	<li>'deposits_orcids_backfile'</li>
	<li>'deposits_funders_backfile'</li>
	<li>'deposits_update_policies_current'</li>
	<li>'deposits_similarity_checking_current'</li>
	<li>'deposits_licenses_current'</li>
	<li>'affiliations_current'</li>
	<li>'similarity_checking_current'</li>
	<li>'funders_backfile'</li>
	<li>'licenses_backfile'</li>
	<li>'funders_current'</li>
	<li>'affiliations_backfile'</li>
	<li>'resource_links_backfile'</li>
	<li>'orcids_backfile'</li>
	<li>'update_policies_current'</li>
	<li>'open_references_backfile'</li>
	<li>'orcids_current'</li>
	<li>'similarity_checking_backfile'</li>
	<li>'references_backfile'</li>
	<li>'award_numbers_backfile'</li>
	<li>'update_policies_backfile'</li>
	<li>'licenses_current'</li>
	<li>'award_numbers_current'</li>
	<li>'abstracts_backfile'</li>
	<li>'resource_links_current'</li>
	<li>'abstracts_current'</li>
	<li>'open_references_current'</li>
	<li>'references_current'</li>
	<li>'total_dois'</li>
	<li>'current_dois'</li>
	<li>'backfile_dois'</li>
</ol>



We see this data frame includes one observation of 53 different variables. This includes the total number of DOIs, whether the abstracts, orcids, article references are current; and other information.

You can use the $ symbol to work with particular variables. For example, the `publisher` column:


```R
# print the publisher variable
plosone_details$publisher
```


'Public Library of Science'


The total number of DOIs on file:


```R
# print the total number of DOIs
plosone_details$total_dois
```


230350


Whether the data publishers provide on funders of articles they publish is current in Crossref (a TRUE/FALSE value–called “logical” in R):


```R
# is funder data current on deposits?
plosone_details$deposits_funders_current
```


TRUE


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
# look up journal details using the cr_journals function and assign it to a new value (e.g. plosone_details). 
# Remember to include a %>% pipe and call purrr::pluck("data")

```


```R
# print the journal details to the console by typing in the value name

```

## Getting journal publications by ISSN

To get metadata for the publications themselves rather than data about the journal, we will again use the `plosone_issn` value in the `issn =` argument to `cr_journals`, but we now set `works = TRUE`.  


```R
# get metadata on articles by setting works = TRUE
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
# print dimensions of this data frame
dim(plosone_publications)
```


<ol class="list-inline">
	<li>25</li>
	<li>28</li>
</ol>



When we run `dim()` (dimensions) on this result, we now see a different number of rows and columns: 25 rows and 28 columns. This is therefore a different dataset than `plosone_details`. Let's call `names()` to see what the column names are:


```R
# print column names
names(plosone_publications)
```


<ol class="list-inline">
	<li>'container.title'</li>
	<li>'created'</li>
	<li>'deposited'</li>
	<li>'published.online'</li>
	<li>'doi'</li>
	<li>'indexed'</li>
	<li>'issn'</li>
	<li>'issue'</li>
	<li>'issued'</li>
	<li>'member'</li>
	<li>'page'</li>
	<li>'prefix'</li>
	<li>'publisher'</li>
	<li>'reference.count'</li>
	<li>'score'</li>
	<li>'source'</li>
	<li>'title'</li>
	<li>'type'</li>
	<li>'update.policy'</li>
	<li>'url'</li>
	<li>'volume'</li>
	<li>'author'</li>
	<li>'link'</li>
	<li>'license'</li>
	<li>'reference'</li>
	<li>'subject'</li>
	<li>'funder'</li>
	<li>'clinical-trial-number'</li>
</ol>



We view the entire data frame below. Because there are some nested lists within the data, we will use the `select()` function from the `dplyr` package to select only a few columns. This will make it easier for us to view here in the Azure Notebook environment. You can also use the `select()` function to rearrange the columns.


```R
# print select columns from the data frame
plosone_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 25 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Extinction-Dependent Alterations in Corticostriatal mGluR2/3 and mGluR7 Receptors following Chronic Methamphetamine Self-Administration in Rats      </td><td>10.1371/journal.pone.0034299</td><td>7 </td><td>3 </td><td>e34299  </td><td>2012-03-29</td><td>http://dx.doi.org/10.1371/journal.pone.0034299</td><td>Public Library of Science (PLoS)</td><td>77</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Pathophysiological Defects and Transcriptional Profiling in the RBM20-/- Rat Model                                                                   </td><td>10.1371/journal.pone.0084281</td><td>8 </td><td>12</td><td>e84281  </td><td>2013-12-19</td><td>http://dx.doi.org/10.1371/journal.pone.0084281</td><td>Public Library of Science (PLoS)</td><td>60</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Ab-Externo AAV-Mediated Gene Delivery to the Suprachoroidal Space Using a 250 Micron Flexible Microcatheter                                          </td><td>10.1371/journal.pone.0017140</td><td>6 </td><td>2 </td><td>e17140  </td><td>2011-02-11</td><td>http://dx.doi.org/10.1371/journal.pone.0017140</td><td>Public Library of Science (PLoS)</td><td>11</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Proteomic and Phospho-Proteomic Profile of Human Platelets in Basal, Resting State: Insights into Integrin Signaling                                 </td><td>10.1371/journal.pone.0007627</td><td>4 </td><td>10</td><td>e7627   </td><td>2009-10-27</td><td>http://dx.doi.org/10.1371/journal.pone.0007627</td><td>Public Library of Science (PLoS)</td><td>67</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Alterations of Neuromuscular Function after the World's Most Challenging Mountain Ultra-Marathon                                                     </td><td>10.1371/journal.pone.0065596</td><td>8 </td><td>6 </td><td>e65596  </td><td>2013-06-26</td><td>http://dx.doi.org/10.1371/journal.pone.0065596</td><td>Public Library of Science (PLoS)</td><td>51</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Integrated Metagenomic and Physiochemical Analyses to Evaluate the Potential Role of Microbes in the Sand Filter of a Drinking Water Treatment System</td><td>10.1371/journal.pone.0061011</td><td>8 </td><td>4 </td><td>e61011  </td><td>2013-04-11</td><td>http://dx.doi.org/10.1371/journal.pone.0061011</td><td>Public Library of Science (PLoS)</td><td>43</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Major Facilitator Superfamily Domain-Containing Protein 2a (MFSD2A) Has Roles in Body Growth, Motor Function, and Lipid Metabolism                   </td><td>10.1371/journal.pone.0050629</td><td>7 </td><td>11</td><td>e50629  </td><td>2012-11-29</td><td>http://dx.doi.org/10.1371/journal.pone.0050629</td><td>Public Library of Science (PLoS)</td><td>52</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Analysis of Autophagy Genes in Microalgae: Chlorella as a Potential Model to Study Mechanism of Autophagy                                            </td><td>10.1371/journal.pone.0041826</td><td>7 </td><td>7 </td><td>e41826  </td><td>2012-07-27</td><td>http://dx.doi.org/10.1371/journal.pone.0041826</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Osteoprotegerin Regulates Pancreatic β-Cell Homeostasis upon Microbial Invasion                                                                      </td><td>10.1371/journal.pone.0146544</td><td>11</td><td>1 </td><td>e0146544</td><td>2016-01-11</td><td>http://dx.doi.org/10.1371/journal.pone.0146544</td><td>Public Library of Science (PLoS)</td><td>54</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Health Behavior and Metabolic Risk Factors Associated with Normal Weight Obesity in Adolescents                                                      </td><td>10.1371/journal.pone.0161451</td><td>11</td><td>8 </td><td>e0161451</td><td>2016-08-25</td><td>http://dx.doi.org/10.1371/journal.pone.0161451</td><td>Public Library of Science (PLoS)</td><td>42</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>Cross-Modal Calibration of Vestibular Afference for Human Balance                                                                            </td><td>10.1371/journal.pone.0124532</td><td>10</td><td>4 </td><td>e0124532</td><td>2015-04-20</td><td>http://dx.doi.org/10.1371/journal.pone.0124532</td><td>Public Library of Science (PLoS)</td><td>44</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Genetic Factors Are Not the Major Causes of Chronic Diseases                                                                                 </td><td>10.1371/journal.pone.0154387</td><td>11</td><td>4 </td><td>e0154387</td><td>2016-04-22</td><td>http://dx.doi.org/10.1371/journal.pone.0154387</td><td>Public Library of Science (PLoS)</td><td>45</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Manipulation of Pre-Target Activity on the Right Frontal Eye Field Enhances Conscious Visual Perception in Humans                            </td><td>10.1371/journal.pone.0036232</td><td>7 </td><td>5 </td><td>e36232  </td><td>2012-05-15</td><td>http://dx.doi.org/10.1371/journal.pone.0036232</td><td>Public Library of Science (PLoS)</td><td>46</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Splicing of the rSlo Gene Affects the Molecular Composition and Drug Response of Ca2+-Activated K+ Channels in Skeletal Muscle               </td><td>10.1371/journal.pone.0040235</td><td>7 </td><td>7 </td><td>e40235  </td><td>2012-07-10</td><td>http://dx.doi.org/10.1371/journal.pone.0040235</td><td>Public Library of Science (PLoS)</td><td>55</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>5-HT2C Receptors in the Basolateral Amygdala and Dorsal Striatum Are a Novel Target for the Anxiolytic and Antidepressant Effects of Exercise</td><td>10.1371/journal.pone.0046118</td><td>7 </td><td>9 </td><td>e46118  </td><td>2012-09-25</td><td>http://dx.doi.org/10.1371/journal.pone.0046118</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Task-Level Strategies for Human Sagittal-Plane Running Maneuvers Are Consistent with Robotic Control Policies                                </td><td>10.1371/journal.pone.0051888</td><td>7 </td><td>12</td><td>e51888  </td><td>2012-12-20</td><td>http://dx.doi.org/10.1371/journal.pone.0051888</td><td>Public Library of Science (PLoS)</td><td>49</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Fc Gamma Receptor IIb on GM-CSF Macrophages Controls Immune Complex Mediated Inhibition of Inflammatory Signals                              </td><td>10.1371/journal.pone.0110966</td><td>9 </td><td>10</td><td>e110966 </td><td>2014-10-23</td><td>http://dx.doi.org/10.1371/journal.pone.0110966</td><td>Public Library of Science (PLoS)</td><td>37</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Does the Clock Make the Poison? Circadian Variation in Response to Pesticides                                                                </td><td>10.1371/journal.pone.0006469</td><td>4 </td><td>7 </td><td>e6469   </td><td>2009-07-31</td><td>http://dx.doi.org/10.1371/journal.pone.0006469</td><td>Public Library of Science (PLoS)</td><td>52</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Sleep Architecture When Sleeping at an Unusual Circadian Time and Associations with Insulin Sensitivity                                      </td><td>10.1371/journal.pone.0072877</td><td>8 </td><td>8 </td><td>e72877  </td><td>2013-08-08</td><td>http://dx.doi.org/10.1371/journal.pone.0072877</td><td>Public Library of Science (PLoS)</td><td>34</td><td>journal-article</td><td>1932-6203</td></tr>
	<tr><td>Tradeoff between Stability and Maneuverability during Whole-Body Movements                                                                   </td><td>10.1371/journal.pone.0021815</td><td>6 </td><td>7 </td><td>e21815  </td><td>2011-07-14</td><td>http://dx.doi.org/10.1371/journal.pone.0021815</td><td>Public Library of Science (PLoS)</td><td>29</td><td>journal-article</td><td>1932-6203</td></tr>
</tbody>
</table>



Here we are just getting back the last 25 articles that have been indexed in Crossref by PLoS ONE. However, this gives you a taste of how rich the metadata is. We have the dates the article was deposited and published online, the title, DOI, the ISSN, the volume, issue, and page numbers, the number of references, the URL, and for some items, the subjects. The omitted columns include information on licensing, authors, and more. We will deal with those columns further down.

## Getting multiple publications by ISSN

You can also pass multiple ISSNs to `cr_journals`. Here we create 2 new values, `jama_issn` and `jah_issn`. These are ISSNs for the *Journal of American History* and *JAMA: The Journal of the American Medical Association*. We then pass them to `cr_journals` by passing them to the `c()` function, which will combine them (it's like CONCATENATE in Excel). We set `works` to `TRUE` so we'll get the publications metadata, and we set the `limit` to 50, so we'll get 50 publications per journal.


```R
# assign the JAMA and JAH ISSNs
jama_issn <- '1538-3598'
jah_issn <- '0021-8723'

# get the last 10 publications on deposit from each journal. For multiple ISSNs, use c() to combine them
jah_jama_publications <- rcrossref::cr_journals(issn = c(jama_issn, jah_issn), works = T, limit = 10) %>%
  purrr::pluck("data")
```

Here we used `c()` to combine `jama_issn` and `jah_issn`. `c()` is used to create a **vector** in R. A vector is a sequence of elements of the same type. In this case, even though the ISSNs are numbers, we created them as `character` vectors by surrounding them in quotation marks. You can use single or double quotes. Above, when we assigned 5 to `y`, we created a `numeric` vector. 

Vectors can only contain “homogenous” data–in other words, all data must be of the same type. The type of a vector determines what kind of analysis you can do on it. For example, you can perform mathematical operations on `numeric` objects, but not on `character` objects. You can think of vectors as columns in an Excel spreadsheet: for example, in a name column, you want every value to be a character; in a date column, you want every value to be a date; etc.

Going back to our `jah_jama_publications` object, we have a dataframe composed of 20 observations of 24 variables. This is a rich set of metadata for the articles in the given publications. The fields are detailed in the [Crossref documentation](https://github.com/CrossRef/rest-api-doc/blob/master/api_format.md#work), including the field name, type, description, and whether or not it's required. Some of these fields are title, DOI, DOI prefix identifer, ISSN, volume, issue, publisher, abstract (if provided), reference count (if provided--i.e., the number of references *in* the given article), link (if provided), subject (if provided), and other information. The number of citations *to* the article are not pulled, but these can be gathered separately with `cr_citation_count()` (see below).


```R
# print column names
names(jah_jama_publications)
```


<ol class="list-inline">
	<li>'container.title'</li>
	<li>'created'</li>
	<li>'deposited'</li>
	<li>'published.print'</li>
	<li>'doi'</li>
	<li>'indexed'</li>
	<li>'issn'</li>
	<li>'issue'</li>
	<li>'issued'</li>
	<li>'member'</li>
	<li>'page'</li>
	<li>'prefix'</li>
	<li>'publisher'</li>
	<li>'reference.count'</li>
	<li>'score'</li>
	<li>'source'</li>
	<li>'title'</li>
	<li>'type'</li>
	<li>'url'</li>
	<li>'volume'</li>
	<li>'author'</li>
	<li>'link'</li>
	<li>'reference'</li>
</ol>




```R
# print data frame with select columns
jah_jama_publications %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 20 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Basics of International Humanitarian Missions; Emergency Relief Operations                                                                       </td><td>10.1001/jama.291.2.249  </td><td>291</td><td>2</td><td>249-250  </td><td>2004-01-14</td><td>http://dx.doi.org/10.1001/jama.291.2.249  </td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Saving Lives and Saving Money: Transforming Health and Healthcare                                                                                </td><td>10.1001/jama.291.2.251-a</td><td>291</td><td>2</td><td>251-251  </td><td>2004-01-14</td><td>http://dx.doi.org/10.1001/jama.291.2.251-a</td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Books, Journals, New Media Received                                                                                                              </td><td>10.1001/jama.291.2.252  </td><td>291</td><td>2</td><td>252-253  </td><td>2004-01-14</td><td>http://dx.doi.org/10.1001/jama.291.2.252  </td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Affirmative Action in Medicine: Improving Health Care for Everyone                                                                               </td><td>10.1001/jama.291.2.251-b</td><td>291</td><td>2</td><td>251-a-252</td><td>2004-01-14</td><td>http://dx.doi.org/10.1001/jama.291.2.251-b</td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Hemangiomas and Other Congenital Malformations in Infants Exposed to Antiretroviral Therapy In Utero                                             </td><td>10.1001/jama.291.3.305  </td><td>291</td><td>3</td><td>305-305  </td><td>2004-01-21</td><td>http://dx.doi.org/10.1001/jama.291.3.305  </td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>The Privatization of Health Care Reform: Legal and Regulatory Perspectives                                                                       </td><td>10.1001/jama.291.3.375-a</td><td>291</td><td>3</td><td>375-375  </td><td>2004-01-21</td><td>http://dx.doi.org/10.1001/jama.291.3.375-a</td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td><span style="white-space: pre-wrap;">Textbook of Gastroenterology, vols 1 &amp; 2; Atlas of Gastroenterology                                                                              </span></td><td>10.1001/jama.291.3.375-b</td><td>291</td><td>3</td><td>375-a-376</td><td>2004-01-21</td><td>http://dx.doi.org/10.1001/jama.291.3.375-b</td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Silent Injustice: True Stories of Innocent Women                                                                                                 </td><td>10.1001/jama.291.3.376  </td><td>291</td><td>3</td><td>376-377  </td><td>2004-01-21</td><td>http://dx.doi.org/10.1001/jama.291.3.376  </td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td><span style="white-space: pre-wrap;">Fitzpatrick's Dermatology in General Medicine, vols 1 &amp; 2                                                                                        </span></td><td><span style="white-space: pre-wrap;">10.1001/jama.291.3.377  </span></td><td>291</td><td>3</td><td><span style="white-space: pre-wrap;">377-378  </span></td><td>2004-01-21</td><td><span style="white-space: pre-wrap;">http://dx.doi.org/10.1001/jama.291.3.377  </span></td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Books, Journals, New Media Received                                                                                                              </td><td>10.1001/jama.291.3.378-b</td><td>291</td><td>3</td><td>378-a-379</td><td>2004-01-21</td><td>http://dx.doi.org/10.1001/jama.291.3.378-b</td><td>American Medical Association (AMA)</td><td>0</td><td>journal-article</td><td>0098-7484,1538-3598</td></tr>
	<tr><td>Outlawing "Treachery": Split Tickets and Ballot Laws in New York and New Jersey, 1880-1910                                                       </td><td>10.2307/1908893         </td><td>72 </td><td>4</td><td>835      </td><td>1986-03   </td><td>http://dx.doi.org/10.2307/1908893         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>Circulating Race and Empire: Transnational Labor Activism and the Politics of Anti-Asian Agitation in the Anglo-American Pacific World, 1880-1910</td><td>10.1093/jahist/96.3.678 </td><td>96 </td><td>3</td><td>678-701  </td><td>2009-12-01</td><td>http://dx.doi.org/10.1093/jahist/96.3.678 </td><td>Oxford University Press (OUP)     </td><td>5</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>Abraham Lincoln: A Constitutional Biography                                                                                                      </td><td>10.2307/2675150         </td><td>88 </td><td>2</td><td>649      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675150         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>And I Will Dwell in Their Midst: Orthodox Jews in Suburbia                                                                                       </td><td>10.2307/2675242         </td><td>88 </td><td>2</td><td>731      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675242         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>International Politics and Civil Rights Policies in the United States, 1941-1960                                                                 </td><td>10.2307/2675236         </td><td>88 </td><td>2</td><td>726      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675236         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>The Cold War American West, 1945-1989                                                                                                            </td><td>10.2307/2675235         </td><td>88 </td><td>2</td><td>725      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675235         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>America's Instrument: The Banjo in the Nineteenth Century                                                                                        </td><td>10.2307/2675168         </td><td>88 </td><td>2</td><td>665      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675168         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>Designs against Charleston: The Trial Record of the Denmark Vesey Slave Conspiracy of 1822                                                       </td><td>10.2307/2675142         </td><td>88 </td><td>2</td><td>642      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675142         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>Scarlett Doesn't Live Here Anymore: Southern Women in the Civil War Era                                                                          </td><td>10.2307/2675156         </td><td>88 </td><td>2</td><td>654      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675156         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
	<tr><td>Skull Wars: Kennewick Man, Archaeology, and the Battle for Native American Identity                                                              </td><td>10.2307/2675255         </td><td>88 </td><td>2</td><td>742      </td><td>2001-09   </td><td>http://dx.doi.org/10.2307/2675255         </td><td>Oxford University Press (OUP)     </td><td>0</td><td>journal-article</td><td>0021-8723          </td></tr>
</tbody>
</table>



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
# assign the JLSC ISSN
jlsc_issn <- "2162-3309"

# get articles published since January 1, 2019
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, 
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")

# print the dataframe with select column
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 20 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Considering Creative Activity in Institutional Repositories: An Exploration of Faculty Perceptions                                 </td><td>10.7710/2162-3309.2312</td><td>8</td><td>1</td><td>2312</td><td>2020-02-25</td><td>http://dx.doi.org/10.7710/2162-3309.2312</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Avoiding the “Axe”: Advancing Affordable and Open Education Resources at a Midsize University                                      </td><td>10.7710/2162-3309.2259</td><td>7</td><td>1</td><td>NA  </td><td>2019-05-20</td><td>http://dx.doi.org/10.7710/2162-3309.2259</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>The Development of the Journal Evaluation Tool to Evaluate the Credibility of Publication Venues                                   </td><td>10.7710/2162-3309.2250</td><td>7</td><td>1</td><td>NA  </td><td>2019-06-04</td><td>http://dx.doi.org/10.7710/2162-3309.2250</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Meaningful Metrics: A 21st Century Librarian's Guide to Bibliometrics, Altmetrics, and Research Impact [Book Review]               </td><td>10.7710/2162-3309.2290</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-15</td><td>http://dx.doi.org/10.7710/2162-3309.2290</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Bibliometrics and Research Evaluation: Uses and Abuses                                                                             </td><td>10.7710/2162-3309.2286</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-10</td><td>http://dx.doi.org/10.7710/2162-3309.2286</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Creating a Library Publishing Program: Your Options Are Limited                                                                    </td><td>10.7710/2162-3309.2262</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-10</td><td>http://dx.doi.org/10.7710/2162-3309.2262</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Online Safety and Academic Scholarship: Exploring Researchers’ Concerns from Ghana                                                 </td><td>10.7710/2162-3309.2263</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-15</td><td>http://dx.doi.org/10.7710/2162-3309.2263</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Data Management Practices in Academic Library Learning Analytics: A Critical Review                                                </td><td>10.7710/2162-3309.2268</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-22</td><td>http://dx.doi.org/10.7710/2162-3309.2268</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Strategies for Supporting OER Adoption through Faculty and Instructor Use of a Federated Search Tool                               </td><td>10.7710/2162-3309.2279</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-22</td><td>http://dx.doi.org/10.7710/2162-3309.2279</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>When a Repository Is Not Enough: Redesigning a Digital Ecosystem to Serve Scholarly Communication                                  </td><td>10.7710/2162-3309.2225</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-26</td><td>http://dx.doi.org/10.7710/2162-3309.2225</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Opening Up Open Access Institutional Repositories to Demonstrate Value: Two Universities’ Pilots on Including Metadata-Only Records</td><td>10.7710/2162-3309.2220</td><td>7</td><td>1</td><td>NA  </td><td>2019-03-08</td><td>http://dx.doi.org/10.7710/2162-3309.2220</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Dynamic Research Support for Academic Libraries [Book Review]                                                                      </td><td>10.7710/2162-3309.2307</td><td>7</td><td>1</td><td>NA  </td><td>2019-04-15</td><td>http://dx.doi.org/10.7710/2162-3309.2307</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Course Review: CopyrightX                                                                                                          </td><td>10.7710/2162-3309.2297</td><td>7</td><td>1</td><td>NA  </td><td>2019-04-11</td><td>http://dx.doi.org/10.7710/2162-3309.2297</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Whose Research is it Anyway? Academic Social Networks Versus Institutional Repositories                                            </td><td>10.7710/2162-3309.2243</td><td>7</td><td>1</td><td>NA  </td><td>2019-04-25</td><td>http://dx.doi.org/10.7710/2162-3309.2243</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Mapping the Scholarly Literature Found in Scopus on “Research Data Management”: A Bibliometric and Data Visualization Approach     </td><td>10.7710/2162-3309.2266</td><td>7</td><td>1</td><td>NA  </td><td>2019-04-25</td><td>http://dx.doi.org/10.7710/2162-3309.2266</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Library Publishers as Educators: Crafting Curriculum for Undergraduate Research Journals                                           </td><td>10.7710/2162-3309.2296</td><td>7</td><td>1</td><td>NA  </td><td>2019-05-06</td><td>http://dx.doi.org/10.7710/2162-3309.2296</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Embracing New Trends in Scholarly Communication: From Competency Requirements in the Workplace to LIS Curriculum Presence          </td><td>10.7710/2162-3309.2291</td><td>7</td><td>1</td><td>NA  </td><td>2019-07-19</td><td>http://dx.doi.org/10.7710/2162-3309.2291</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>The Five Laws of OER: Observations from Ranganathan                                                                                </td><td>10.7710/2162-3309.2299</td><td>7</td><td>1</td><td>NA  </td><td>2019-08-20</td><td>http://dx.doi.org/10.7710/2162-3309.2299</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>JLSC Board Editorial 2019                                                                                                          </td><td>10.7710/2162-3309.2334</td><td>7</td><td>1</td><td>NA  </td><td>2019-09-12</td><td>http://dx.doi.org/10.7710/2162-3309.2334</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>We Can Do I.T.: Women in Library Information Technology                                                                            </td><td>10.7710/2162-3309.2320</td><td>7</td><td>1</td><td>NA  </td><td>2019-09-16</td><td>http://dx.doi.org/10.7710/2162-3309.2320</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



### Filtering by funder with `award.funder`

You can also return all articles funded by a specific funder. See the [Crossref Funder Registry](https://gitlab.com/crossref/open_funder_registry) for a list of funders and their DOIs. 

Here, we will combine two filters: `award.funder` and `from_pub_date` to return all articles published in PLoS ONE where a) at least one funder is the National Institutes of Health, and b) the article was published after March 1, 2020. Note that we set a `limit` here of 25 because we are doing a teaching activity and we don't want to send heavy queries. If you were doing this on your own, you would likely want to remove the limit.


```R
# assign the PLoS ONE ISSN and the NIH Funder DOI
plosone_issn <- '1932-6203'
nih_funder_doi <- '10.13039/100000002'

# get articles published in PLoS since 3/1 funded by NIH
plosone_publications_nih <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25,
                                                 filter = c(award.funder = nih_funder_doi,
                                                           from_pub_date = '2020-03-01')) %>%
  purrr::pluck("data")
```

We will use `unnest()` from the `tidyr` package to view the data frame here. This is described below in [Unnesting List Columns](https://rcrossref2-clarkeiakovakis.notebooks.azure.com/j/notebooks/rcrossref_20200305.ipynb#Unnesting-list-columns).


```R
# print the dataframe, first unnesting the funder column
plosone_publications_nih %>%
    tidyr::unnest(funder)
```


<table>
<caption>A tibble: 21 x 32</caption>
<thead>
	<tr><th>container.title</th><th>created</th><th>deposited</th><th>published.online</th><th>doi</th><th>indexed</th><th>issn</th><th>issue</th><th>issued</th><th>member</th><th>page</th><th>prefix</th><th>publisher</th><th>reference.count</th><th>score</th><th>source</th><th>subject</th><th>title</th><th>type</th><th>update.policy</th><th>url</th><th>volume</th><th>DOI</th><th>name</th><th>doi.asserted.by</th><th>award</th><th>award1</th><th>award2</th><th>award3</th><th>award4</th><th>award5</th><th>award6</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion                                    </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>10.13039/100000002   </td><td>National Institutes of Health                           </td><td>publisher</td><td>R21AG049293 </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion                                    </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>10.13039/100000049   </td><td>National Institute on Aging                             </td><td>publisher</td><td>R56AG058769 </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>10.13039/100000002   </td><td>National Institutes of Health                           </td><td>publisher</td><td>NA          </td><td>R01AG055401</td><td>K01AG042498</td><td>P01AG026572</td><td>R01HL130462</td><td>P30AG043073</td><td>R01HL126804</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>10.13039/501100000320</td><td>Alzheimer's Society                                     </td><td>crossref </td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>10.13039/100011699   </td><td>BRACE                                                   </td><td>publisher</td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>10.13039/501100000274</td><td>British Heart Foundation                                </td><td>crossref </td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>NA                   </td><td>University of Southern California Zumberge Research Fund</td><td>NA       </td><td>1R34AG049652</td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>NA                   </td><td>Schaeffer-Amgen Fellowship Program                      </td><td>NA       </td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>NA                   </td><td>Sigmund Gestetner Foundation                            </td><td>NA       </td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>NA                   </td><td>NIHR-EME                                                </td><td>NA       </td><td>NA          </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229541</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229541</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>62</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Association of combination statin and antihypertensive therapy with reduced Alzheimer’s disease and related dementia risk                                        </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229541</td><td>15</td><td>NA                </td><td>Medical Research Council                  </td><td>NA       </td><td>NA              </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228163</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228163</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>41</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Immunotherapy with DNA vaccine and live attenuated rubella/SIV gag vectors plus early ART can prevent SIVmac251 viral rebound in acutely infected rhesus macaques</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228163</td><td>15</td><td>10.13039/100000038</td><td>U.S. Food and Drug Administration         </td><td>publisher</td><td>NA              </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228163</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228163</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>41</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Immunotherapy with DNA vaccine and live attenuated rubella/SIV gag vectors plus early ART can prevent SIVmac251 viral rebound in acutely infected rhesus macaques</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228163</td><td>15</td><td>10.13039/100000002</td><td>National Institutes of Health             </td><td>publisher</td><td>R01 AI118586    </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228163</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228163</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>41</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Immunotherapy with DNA vaccine and live attenuated rubella/SIV gag vectors plus early ART can prevent SIVmac251 viral rebound in acutely infected rhesus macaques</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228163</td><td>15</td><td>10.13039/100000054</td><td>National Cancer Institute                 </td><td>publisher</td><td>NA              </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229537</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229537</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>59</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Combined analysis of microbial metagenomic and metatranscriptomic sequencing data to assess in situ physiological conditions in the premature infant gut         </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229537</td><td>15</td><td>10.13039/100000002</td><td>National Institutes of Health             </td><td>publisher</td><td>RAI092531A      </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229537</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229537</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>59</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Combined analysis of microbial metagenomic and metatranscriptomic sequencing data to assess in situ physiological conditions in the premature infant gut         </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229537</td><td>15</td><td>10.13039/100000912</td><td>March of Dimes Foundation                 </td><td>publisher</td><td>5-FY10-103      </td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0229537</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0229537</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>59</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Combined analysis of microbial metagenomic and metatranscriptomic sequencing data to assess in situ physiological conditions in the premature infant gut         </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0229537</td><td>15</td><td>10.13039/100005825</td><td>National Institute of Food and Agriculture</td><td>publisher</td><td>2016-67012-24717</td><td>NA                       </td><td>NA                       </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-03</td><td>2020-03-03</td><td>2020-03-03</td><td>10.1371/journal.pone.0227094</td><td>2020-03-03</td><td>1932-6203</td><td>3</td><td>2020-03-03</td><td>340</td><td>e0227094</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>43</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Shedding and stability of CWD prion seeding activity in cervid feces                                                                                             </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0227094</td><td>15</td><td>10.13039/100000002</td><td>National Institutes of Health             </td><td>publisher</td><td>NA              </td><td>RO1-NS061902             </td><td>PO1-AI077774             </td><td>RO1-NS076894</td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-02</td><td>2020-03-02</td><td>2020-03-02</td><td>10.1371/journal.pone.0228871</td><td>2020-03-02</td><td>1932-6203</td><td>3</td><td>2020-03-02</td><td>340</td><td>e0228871</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>53</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Variability in protein cargo detection in technical and biological replicates of exosome-enriched extracellular vesicles                                         </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228871</td><td>15</td><td>10.13039/100000002</td><td>National Institutes of Health             </td><td>crossref </td><td>NA              </td><td>Grant R01 HL132870 (L.S.)</td><td>Grant R01 HL128228 (L.S.)</td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-06</td><td>2020-03-06</td><td>2020-03-06</td><td>10.1371/journal.pone.0228557</td><td>2020-03-06</td><td>1932-6203</td><td>3</td><td>2020-03-06</td><td>340</td><td>e0228557</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>29</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Novel drug combination nanoparticles exhibit enhanced plasma exposure and dose-responsive effects on eliminating breast cancer lung metastasis                   </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228557</td><td>15</td><td>10.13039/100000002</td><td>National Institutes of Health             </td><td>publisher</td><td>NA              </td><td>1S10OD010652-01          </td><td>UM1AI120176              </td><td>NA          </td><td>NA</td><td>NA</td><td>NA</td></tr>
</tbody>
</table>



If you scroll all the way to the right, you can see the funder information. Look at the `title` column and you will notice that some article titles are now duplicated, however you will see different funders in the `name` column. This is because a single article may have multiple funders, and a new row is created for each funder, with data including the `award` number.

### Filtering by license with `has_license`

You may be interested in licensing information for articles; for instance, gathering publications in a given journal that are licensed under Creative Commons. First run `cr_journals` with `works` set to `FALSE` in order to return journal details so you can check if the publisher even sends article licensing information to Crossref--it's not required. We will use PLOS ONE again as an example.



```R
# assign the PLoS ONE ISSN and get journal details by setting works = FALSE
plosone_issn <- '1932-6203'
plosone_details <- rcrossref::cr_journals(issn = plosone_issn, works = FALSE) %>%
  purrr::pluck("data")
```

We can check the `deposits_licenses_current` variables to see if license data on file is current. If it is `TRUE`, PLoS ONE does send licensing information and it is current. 


```R
# is article licensing data on file current?
plosone_details$deposits_licenses_current
```


TRUE


We can now rerun the query but set `works = TRUE`, and set the `has_license` to `TRUE`. This will therefore return only articles that have license information. We will set our `limit` to 25.


```R
# get last 25 articles on file where has_license is TRUE
plosone_license <- rcrossref::cr_journals(issn = plosone_issn, works = T, limit = 25, filter = c(`has_license` = TRUE)) %>% 
  pluck("data")
```


```R
# print the data with select columns
plosone_license %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn, license)
```


<table>
<caption>A tibble: 25 x 12</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th><th>license</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;list&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Extinction-Dependent Alterations in Corticostriatal mGluR2/3 and mGluR7 Receptors following Chronic Methamphetamine Self-Administration in Rats      </td><td>10.1371/journal.pone.0034299</td><td>7 </td><td>3 </td><td>e34299  </td><td>2012-03-29</td><td>http://dx.doi.org/10.1371/journal.pone.0034299</td><td>Public Library of Science (PLoS)</td><td>77</td><td>journal-article</td><td>1932-6203</td><td>2012-03-29                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Pathophysiological Defects and Transcriptional Profiling in the RBM20-/- Rat Model                                                                   </td><td>10.1371/journal.pone.0084281</td><td>8 </td><td>12</td><td>e84281  </td><td>2013-12-19</td><td>http://dx.doi.org/10.1371/journal.pone.0084281</td><td>Public Library of Science (PLoS)</td><td>60</td><td>journal-article</td><td>1932-6203</td><td>2013-12-19                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , vor                                        </td></tr>
	<tr><td>Ab-Externo AAV-Mediated Gene Delivery to the Suprachoroidal Space Using a 250 Micron Flexible Microcatheter                                          </td><td>10.1371/journal.pone.0017140</td><td>6 </td><td>2 </td><td>e17140  </td><td>2011-02-11</td><td>http://dx.doi.org/10.1371/journal.pone.0017140</td><td>Public Library of Science (PLoS)</td><td>11</td><td>journal-article</td><td>1932-6203</td><td>2011-02-11                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Proteomic and Phospho-Proteomic Profile of Human Platelets in Basal, Resting State: Insights into Integrin Signaling                                 </td><td>10.1371/journal.pone.0007627</td><td>4 </td><td>10</td><td>e7627   </td><td>2009-10-27</td><td>http://dx.doi.org/10.1371/journal.pone.0007627</td><td>Public Library of Science (PLoS)</td><td>67</td><td>journal-article</td><td>1932-6203</td><td>2009-10-27                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Alterations of Neuromuscular Function after the World's Most Challenging Mountain Ultra-Marathon                                                     </td><td>10.1371/journal.pone.0065596</td><td>8 </td><td>6 </td><td>e65596  </td><td>2013-06-26</td><td>http://dx.doi.org/10.1371/journal.pone.0065596</td><td>Public Library of Science (PLoS)</td><td>51</td><td>journal-article</td><td>1932-6203</td><td>2013-06-26                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Integrated Metagenomic and Physiochemical Analyses to Evaluate the Potential Role of Microbes in the Sand Filter of a Drinking Water Treatment System</td><td>10.1371/journal.pone.0061011</td><td>8 </td><td>4 </td><td>e61011  </td><td>2013-04-11</td><td>http://dx.doi.org/10.1371/journal.pone.0061011</td><td>Public Library of Science (PLoS)</td><td>43</td><td>journal-article</td><td>1932-6203</td><td>2013-04-11                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Major Facilitator Superfamily Domain-Containing Protein 2a (MFSD2A) Has Roles in Body Growth, Motor Function, and Lipid Metabolism                   </td><td>10.1371/journal.pone.0050629</td><td>7 </td><td>11</td><td>e50629  </td><td>2012-11-29</td><td>http://dx.doi.org/10.1371/journal.pone.0050629</td><td>Public Library of Science (PLoS)</td><td>52</td><td>journal-article</td><td>1932-6203</td><td>2012-11-29                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Analysis of Autophagy Genes in Microalgae: Chlorella as a Potential Model to Study Mechanism of Autophagy                                            </td><td>10.1371/journal.pone.0041826</td><td>7 </td><td>7 </td><td>e41826  </td><td>2012-07-27</td><td>http://dx.doi.org/10.1371/journal.pone.0041826</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>journal-article</td><td>1932-6203</td><td>2012-07-27                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Osteoprotegerin Regulates Pancreatic β-Cell Homeostasis upon Microbial Invasion                                                                      </td><td>10.1371/journal.pone.0146544</td><td>11</td><td>1 </td><td>e0146544</td><td>2016-01-11</td><td>http://dx.doi.org/10.1371/journal.pone.0146544</td><td>Public Library of Science (PLoS)</td><td>54</td><td>journal-article</td><td>1932-6203</td><td>2016-01-11                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , vor                                        </td></tr>
	<tr><td>Health Behavior and Metabolic Risk Factors Associated with Normal Weight Obesity in Adolescents                                                      </td><td>10.1371/journal.pone.0161451</td><td>11</td><td>8 </td><td>e0161451</td><td>2016-08-25</td><td>http://dx.doi.org/10.1371/journal.pone.0161451</td><td>Public Library of Science (PLoS)</td><td>42</td><td>journal-article</td><td>1932-6203</td><td>2016-08-25                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , vor                                        </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>Cross-Modal Calibration of Vestibular Afference for Human Balance                                                                            </td><td>10.1371/journal.pone.0124532</td><td>10</td><td>4 </td><td>e0124532</td><td>2015-04-20</td><td>http://dx.doi.org/10.1371/journal.pone.0124532</td><td>Public Library of Science (PLoS)</td><td>44</td><td>journal-article</td><td>1932-6203</td><td>2015-04-20                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , vor                                        </td></tr>
	<tr><td>Genetic Factors Are Not the Major Causes of Chronic Diseases                                                                                 </td><td>10.1371/journal.pone.0154387</td><td>11</td><td>4 </td><td>e0154387</td><td>2016-04-22</td><td>http://dx.doi.org/10.1371/journal.pone.0154387</td><td>Public Library of Science (PLoS)</td><td>45</td><td>journal-article</td><td>1932-6203</td><td>2016-04-22                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , vor                                        </td></tr>
	<tr><td>Manipulation of Pre-Target Activity on the Right Frontal Eye Field Enhances Conscious Visual Perception in Humans                            </td><td>10.1371/journal.pone.0036232</td><td>7 </td><td>5 </td><td>e36232  </td><td>2012-05-15</td><td>http://dx.doi.org/10.1371/journal.pone.0036232</td><td>Public Library of Science (PLoS)</td><td>46</td><td>journal-article</td><td>1932-6203</td><td>2012-05-15                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Splicing of the rSlo Gene Affects the Molecular Composition and Drug Response of Ca2+-Activated K+ Channels in Skeletal Muscle               </td><td>10.1371/journal.pone.0040235</td><td>7 </td><td>7 </td><td>e40235  </td><td>2012-07-10</td><td>http://dx.doi.org/10.1371/journal.pone.0040235</td><td>Public Library of Science (PLoS)</td><td>55</td><td>journal-article</td><td>1932-6203</td><td>2012-07-10                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>5-HT2C Receptors in the Basolateral Amygdala and Dorsal Striatum Are a Novel Target for the Anxiolytic and Antidepressant Effects of Exercise</td><td>10.1371/journal.pone.0046118</td><td>7 </td><td>9 </td><td>e46118  </td><td>2012-09-25</td><td>http://dx.doi.org/10.1371/journal.pone.0046118</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>journal-article</td><td>1932-6203</td><td>2012-09-25                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Task-Level Strategies for Human Sagittal-Plane Running Maneuvers Are Consistent with Robotic Control Policies                                </td><td>10.1371/journal.pone.0051888</td><td>7 </td><td>12</td><td>e51888  </td><td>2012-12-20</td><td>http://dx.doi.org/10.1371/journal.pone.0051888</td><td>Public Library of Science (PLoS)</td><td>49</td><td>journal-article</td><td>1932-6203</td><td>2012-12-20                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Fc Gamma Receptor IIb on GM-CSF Macrophages Controls Immune Complex Mediated Inhibition of Inflammatory Signals                              </td><td>10.1371/journal.pone.0110966</td><td>9 </td><td>10</td><td>e110966 </td><td>2014-10-23</td><td>http://dx.doi.org/10.1371/journal.pone.0110966</td><td>Public Library of Science (PLoS)</td><td>37</td><td>journal-article</td><td>1932-6203</td><td>2014-10-23                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Does the Clock Make the Poison? Circadian Variation in Response to Pesticides                                                                </td><td>10.1371/journal.pone.0006469</td><td>4 </td><td>7 </td><td>e6469   </td><td>2009-07-31</td><td>http://dx.doi.org/10.1371/journal.pone.0006469</td><td>Public Library of Science (PLoS)</td><td>52</td><td>journal-article</td><td>1932-6203</td><td>2009-07-31                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Sleep Architecture When Sleeping at an Unusual Circadian Time and Associations with Insulin Sensitivity                                      </td><td>10.1371/journal.pone.0072877</td><td>8 </td><td>8 </td><td>e72877  </td><td>2013-08-08</td><td>http://dx.doi.org/10.1371/journal.pone.0072877</td><td>Public Library of Science (PLoS)</td><td>34</td><td>journal-article</td><td>1932-6203</td><td>2013-08-08                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
	<tr><td>Tradeoff between Stability and Maneuverability during Whole-Body Movements                                                                   </td><td>10.1371/journal.pone.0021815</td><td>6 </td><td>7 </td><td>e21815  </td><td>2011-07-14</td><td>http://dx.doi.org/10.1371/journal.pone.0021815</td><td>Public Library of Science (PLoS)</td><td>29</td><td>journal-article</td><td>1932-6203</td><td>2011-07-14                                 , http://creativecommons.org/licenses/by/4.0/, 0                                          , unspecified                                </td></tr>
</tbody>
</table>



The license data comes in as a nested column. We can unnest it using `tidyr::unnest`, which we used above with funders and will be discussed more below. 


```R
# print the data frame with license unnested. The .drop argument will drop all other list columns.
plosone_license %>%
  tidyr::unnest(license, .drop = TRUE)
```


<table>
<caption>A tibble: 25 x 26</caption>
<thead>
	<tr><th>container.title</th><th>created</th><th>deposited</th><th>published.online</th><th>doi</th><th>indexed</th><th>issn</th><th>issue</th><th>issued</th><th>member</th><th>page</th><th>prefix</th><th>publisher</th><th>reference.count</th><th>score</th><th>source</th><th>title</th><th>type</th><th>update.policy</th><th>url</th><th>volume</th><th>subject</th><th>date</th><th>URL</th><th>delay.in.days</th><th>content.version</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;int&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>PLoS ONE</td><td>2012-03-29</td><td>2019-06-26</td><td>2012-03-29</td><td>10.1371/journal.pone.0034299</td><td>2020-02-05</td><td>1932-6203</td><td>3 </td><td>2012-03-29</td><td>340</td><td>e34299  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>77</td><td>1</td><td>Crossref</td><td>Extinction-Dependent Alterations in Corticostriatal mGluR2/3 and mGluR7 Receptors following Chronic Methamphetamine Self-Administration in Rats      </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0034299</td><td>7 </td><td>NA                                                                                                                </td><td>2012-03-29</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2013-12-19</td><td>2019-08-05</td><td>2013-12-19</td><td>10.1371/journal.pone.0084281</td><td>2020-02-05</td><td>1932-6203</td><td>12</td><td>2013-12-19</td><td>340</td><td>e84281  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>60</td><td>1</td><td>Crossref</td><td>Pathophysiological Defects and Transcriptional Profiling in the RBM20-/- Rat Model                                                                   </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0084281</td><td>8 </td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>2013-12-19</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>vor        </td></tr>
	<tr><td>PLoS ONE</td><td>2011-02-11</td><td>2018-10-23</td><td>2011-02-11</td><td>10.1371/journal.pone.0017140</td><td>2020-02-05</td><td>1932-6203</td><td>2 </td><td>2011-02-11</td><td>340</td><td>e17140  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>11</td><td>1</td><td>Crossref</td><td>Ab-Externo AAV-Mediated Gene Delivery to the Suprachoroidal Space Using a 250 Micron Flexible Microcatheter                                          </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0017140</td><td>6 </td><td>NA                                                                                                                </td><td>2011-02-11</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2009-10-26</td><td>2018-10-23</td><td>2009-10-27</td><td>10.1371/journal.pone.0007627</td><td>2020-02-05</td><td>1932-6203</td><td>10</td><td>2009-10-27</td><td>340</td><td>e7627   </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>67</td><td>1</td><td>Crossref</td><td>Proteomic and Phospho-Proteomic Profile of Human Platelets in Basal, Resting State: Insights into Integrin Signaling                                 </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0007627</td><td>4 </td><td>NA                                                                                                                </td><td>2009-10-27</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2013-06-26</td><td>2019-07-16</td><td>2013-06-26</td><td>10.1371/journal.pone.0065596</td><td>2020-02-05</td><td>1932-6203</td><td>6 </td><td>2013-06-26</td><td>340</td><td>e65596  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>51</td><td>1</td><td>Crossref</td><td>Alterations of Neuromuscular Function after the World's Most Challenging Mountain Ultra-Marathon                                                     </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0065596</td><td>8 </td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>2013-06-26</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2013-04-11</td><td>2019-07-12</td><td>2013-04-11</td><td>10.1371/journal.pone.0061011</td><td>2020-02-05</td><td>1932-6203</td><td>4 </td><td>2013-04-11</td><td>340</td><td>e61011  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>43</td><td>1</td><td>Crossref</td><td>Integrated Metagenomic and Physiochemical Analyses to Evaluate the Potential Role of Microbes in the Sand Filter of a Drinking Water Treatment System</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0061011</td><td>8 </td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>2013-04-11</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2012-11-29</td><td>2019-07-06</td><td>2012-11-29</td><td>10.1371/journal.pone.0050629</td><td>2020-02-05</td><td>1932-6203</td><td>11</td><td>2012-11-29</td><td>340</td><td>e50629  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>52</td><td>1</td><td>Crossref</td><td>Major Facilitator Superfamily Domain-Containing Protein 2a (MFSD2A) Has Roles in Body Growth, Motor Function, and Lipid Metabolism                   </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0050629</td><td>7 </td><td>NA                                                                                                                </td><td>2012-11-29</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2012-07-28</td><td>2016-04-20</td><td>2012-07-27</td><td>10.1371/journal.pone.0041826</td><td>2020-02-05</td><td>1932-6203</td><td>7 </td><td>2012-07-27</td><td>340</td><td>e41826  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>1</td><td>Crossref</td><td>Analysis of Autophagy Genes in Microalgae: Chlorella as a Potential Model to Study Mechanism of Autophagy                                            </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0041826</td><td>7 </td><td>NA                                                                                                                </td><td>2012-07-27</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLOS ONE</td><td>2016-01-11</td><td>2019-09-03</td><td>2016-01-11</td><td>10.1371/journal.pone.0146544</td><td>2020-02-05</td><td>1932-6203</td><td>1 </td><td>2016-01-11</td><td>340</td><td>e0146544</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>54</td><td>1</td><td>Crossref</td><td>Osteoprotegerin Regulates Pancreatic β-Cell Homeostasis upon Microbial Invasion                                                                      </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0146544</td><td>11</td><td>NA                                                                                                                </td><td>2016-01-11</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>vor        </td></tr>
	<tr><td>PLOS ONE</td><td>2016-08-25</td><td>2019-09-12</td><td>2016-08-25</td><td>10.1371/journal.pone.0161451</td><td>2020-02-05</td><td>1932-6203</td><td>8 </td><td>2016-08-25</td><td>340</td><td>e0161451</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>42</td><td>1</td><td>Crossref</td><td>Health Behavior and Metabolic Risk Factors Associated with Normal Weight Obesity in Adolescents                                                      </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0161451</td><td>11</td><td>NA                                                                                                                </td><td>2016-08-25</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>vor        </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>PLOS ONE</td><td>2015-04-20</td><td>2019-08-23</td><td>2015-04-20</td><td>10.1371/journal.pone.0124532</td><td>2020-02-04</td><td>1932-6203</td><td>4 </td><td>2015-04-20</td><td>340</td><td>e0124532</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>44</td><td>1</td><td>Crossref</td><td>Cross-Modal Calibration of Vestibular Afference for Human Balance                                                                            </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0124532</td><td>10</td><td>NA                                                                                                                </td><td>2015-04-20</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>vor        </td></tr>
	<tr><td>PLOS ONE</td><td>2016-04-22</td><td>2019-09-06</td><td>2016-04-22</td><td>10.1371/journal.pone.0154387</td><td>2020-02-04</td><td>1932-6203</td><td>4 </td><td>2016-04-22</td><td>340</td><td>e0154387</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>45</td><td>1</td><td>Crossref</td><td>Genetic Factors Are Not the Major Causes of Chronic Diseases                                                                                 </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0154387</td><td>11</td><td>NA                                                                                                                </td><td>2016-04-22</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>vor        </td></tr>
	<tr><td>PLoS ONE</td><td>2012-05-15</td><td>2018-10-24</td><td>2012-05-15</td><td>10.1371/journal.pone.0036232</td><td>2020-02-04</td><td>1932-6203</td><td>5 </td><td>2012-05-15</td><td>340</td><td>e36232  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>46</td><td>1</td><td>Crossref</td><td>Manipulation of Pre-Target Activity on the Right Frontal Eye Field Enhances Conscious Visual Perception in Humans                            </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0036232</td><td>7 </td><td>NA                                                                                                                </td><td>2012-05-15</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2012-07-10</td><td>2019-06-30</td><td>2012-07-10</td><td>10.1371/journal.pone.0040235</td><td>2020-02-04</td><td>1932-6203</td><td>7 </td><td>2012-07-10</td><td>340</td><td>e40235  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>55</td><td>1</td><td>Crossref</td><td>Splicing of the rSlo Gene Affects the Molecular Composition and Drug Response of Ca2+-Activated K+ Channels in Skeletal Muscle               </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0040235</td><td>7 </td><td>NA                                                                                                                </td><td>2012-07-10</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2012-09-26</td><td>2016-04-20</td><td>2012-09-25</td><td>10.1371/journal.pone.0046118</td><td>2020-02-04</td><td>1932-6203</td><td>9 </td><td>2012-09-25</td><td>340</td><td>e46118  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>0 </td><td>1</td><td>Crossref</td><td>5-HT2C Receptors in the Basolateral Amygdala and Dorsal Striatum Are a Novel Target for the Anxiolytic and Antidepressant Effects of Exercise</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0046118</td><td>7 </td><td>NA                                                                                                                </td><td>2012-09-25</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2012-12-20</td><td>2019-07-07</td><td>2012-12-20</td><td>10.1371/journal.pone.0051888</td><td>2020-02-04</td><td>1932-6203</td><td>12</td><td>2012-12-20</td><td>340</td><td>e51888  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>49</td><td>1</td><td>Crossref</td><td>Task-Level Strategies for Human Sagittal-Plane Running Maneuvers Are Consistent with Robotic Control Policies                                </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0051888</td><td>7 </td><td>NA                                                                                                                </td><td>2012-12-20</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2014-10-23</td><td>2019-08-16</td><td>2014-10-23</td><td>10.1371/journal.pone.0110966</td><td>2020-02-04</td><td>1932-6203</td><td>10</td><td>2014-10-23</td><td>340</td><td>e110966 </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>37</td><td>1</td><td>Crossref</td><td>Fc Gamma Receptor IIb on GM-CSF Macrophages Controls Immune Complex Mediated Inhibition of Inflammatory Signals                              </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0110966</td><td>9 </td><td>NA                                                                                                                </td><td>2014-10-23</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2009-07-30</td><td>2019-05-21</td><td>2009-07-31</td><td>10.1371/journal.pone.0006469</td><td>2020-02-04</td><td>1932-6203</td><td>7 </td><td>2009-07-31</td><td>340</td><td>e6469   </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>52</td><td>1</td><td>Crossref</td><td>Does the Clock Make the Poison? Circadian Variation in Response to Pesticides                                                                </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0006469</td><td>4 </td><td>NA                                                                                                                </td><td>2009-07-31</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2013-08-08</td><td>2019-07-20</td><td>2013-08-08</td><td>10.1371/journal.pone.0072877</td><td>2020-02-04</td><td>1932-6203</td><td>8 </td><td>2013-08-08</td><td>340</td><td>e72877  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>34</td><td>1</td><td>Crossref</td><td>Sleep Architecture When Sleeping at an Unusual Circadian Time and Associations with Insulin Sensitivity                                      </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0072877</td><td>8 </td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>2013-08-08</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
	<tr><td>PLoS ONE</td><td>2011-07-14</td><td>2019-06-13</td><td>2011-07-14</td><td>10.1371/journal.pone.0021815</td><td>2020-02-04</td><td>1932-6203</td><td>7 </td><td>2011-07-14</td><td>340</td><td>e21815  </td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>29</td><td>1</td><td>Crossref</td><td>Tradeoff between Stability and Maneuverability during Whole-Body Movements                                                                   </td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0021815</td><td>6 </td><td>NA                                                                                                                </td><td>2011-07-14</td><td>http://creativecommons.org/licenses/by/4.0/</td><td>0</td><td>unspecified</td></tr>
</tbody>
</table>



This adds four columns all the way to the right: 
* **date** (Date on which this license begins to take effect) 
* **URL** (Link to a web page describing this license--in this case, Creative Commons)
* **delay in days** (Number of days between the publication date of the work and the start date of this license), and 
* **content.version**, which specifies the version of the article the licensing data pertains to (VOR = Version of Record, AM = Accepted Manuscript, TDM = Text and Data Mining). 

Browsing the rows, we see all are CC BY 4.0, which stands to reason given *PLOS ONE* is an open access publisher and [applies the CC BY license](https://journals.plos.org/plosone/s/licenses-and-copyright) to the articles they publish. 

## Filtering rows and selecting columns with `dplyr`

You can use the `filter()` and `select()` functions from the `dplyr` package if you want to get subsets of this data after you have made the query. Note that this is a completely different `filter` than the one used above inside the `cr_journals()` function. That one was an argument sent with the API call that filtered the results before they were returned. This is a separate function that is part of `dplyr` to help you filter a data frame in R. 

To learn more about the `dplyr` package, read the ["Data Transformation" chapter in *R For Data Science*](https://r4ds.had.co.nz/transform.html).

Above, we retrieved all articles from the *Journal of Librarianship &amp; Scholarly Communication* published after January 1, 2019. Let's say you want only volume 8, issue 1:


```R
# assign the JLSC ISSN and get all publications after January 1, 2019
jlsc_issn <- "2162-3309"
jlsc_publications_2019 <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                                 filter = c(from_pub_date='2019-01-01')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_2019 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 25 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Considering Creative Activity in Institutional Repositories: An Exploration of Faculty Perceptions                  </td><td>10.7710/2162-3309.2312</td><td>8</td><td>1</td><td>2312</td><td>2020-02-25</td><td>http://dx.doi.org/10.7710/2162-3309.2312</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Avoiding the “Axe”: Advancing Affordable and Open Education Resources at a Midsize University                       </td><td>10.7710/2162-3309.2259</td><td>7</td><td>1</td><td>NA  </td><td>2019-05-20</td><td>http://dx.doi.org/10.7710/2162-3309.2259</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>The Development of the Journal Evaluation Tool to Evaluate the Credibility of Publication Venues                    </td><td>10.7710/2162-3309.2250</td><td>7</td><td>1</td><td>NA  </td><td>2019-06-04</td><td>http://dx.doi.org/10.7710/2162-3309.2250</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Meaningful Metrics: A 21st Century Librarian's Guide to Bibliometrics, Altmetrics, and Research Impact [Book Review]</td><td>10.7710/2162-3309.2290</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-15</td><td>http://dx.doi.org/10.7710/2162-3309.2290</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Bibliometrics and Research Evaluation: Uses and Abuses                                                              </td><td>10.7710/2162-3309.2286</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-10</td><td>http://dx.doi.org/10.7710/2162-3309.2286</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Creating a Library Publishing Program: Your Options Are Limited                                                     </td><td>10.7710/2162-3309.2262</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-10</td><td>http://dx.doi.org/10.7710/2162-3309.2262</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Online Safety and Academic Scholarship: Exploring Researchers’ Concerns from Ghana                                  </td><td>10.7710/2162-3309.2263</td><td>7</td><td>1</td><td>NA  </td><td>2019-01-15</td><td>http://dx.doi.org/10.7710/2162-3309.2263</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Data Management Practices in Academic Library Learning Analytics: A Critical Review                                 </td><td>10.7710/2162-3309.2268</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-22</td><td>http://dx.doi.org/10.7710/2162-3309.2268</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Strategies for Supporting OER Adoption through Faculty and Instructor Use of a Federated Search Tool                </td><td>10.7710/2162-3309.2279</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-22</td><td>http://dx.doi.org/10.7710/2162-3309.2279</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>When a Repository Is Not Enough: Redesigning a Digital Ecosystem to Serve Scholarly Communication                   </td><td>10.7710/2162-3309.2225</td><td>7</td><td>1</td><td>NA  </td><td>2019-02-26</td><td>http://dx.doi.org/10.7710/2162-3309.2225</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>Library Publishers as Educators: Crafting Curriculum for Undergraduate Research Journals                                 </td><td>10.7710/2162-3309.2296</td><td>7</td><td>1</td><td>NA</td><td>2019-05-06</td><td>http://dx.doi.org/10.7710/2162-3309.2296</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Embracing New Trends in Scholarly Communication: From Competency Requirements in the Workplace to LIS Curriculum Presence</td><td>10.7710/2162-3309.2291</td><td>7</td><td>1</td><td>NA</td><td>2019-07-19</td><td>http://dx.doi.org/10.7710/2162-3309.2291</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>The Five Laws of OER: Observations from Ranganathan                                                                      </td><td>10.7710/2162-3309.2299</td><td>7</td><td>1</td><td>NA</td><td>2019-08-20</td><td>http://dx.doi.org/10.7710/2162-3309.2299</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>JLSC Board Editorial 2019                                                                                                </td><td>10.7710/2162-3309.2334</td><td>7</td><td>1</td><td>NA</td><td>2019-09-12</td><td>http://dx.doi.org/10.7710/2162-3309.2334</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>We Can Do I.T.: Women in Library Information Technology                                                                  </td><td>10.7710/2162-3309.2320</td><td>7</td><td>1</td><td>NA</td><td>2019-09-16</td><td>http://dx.doi.org/10.7710/2162-3309.2320</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>A Team Approach: Library Publishing Partnerships with Scholarly Societies                                                </td><td>10.7710/2162-3309.2326</td><td>7</td><td>1</td><td>NA</td><td>2019-11-21</td><td>http://dx.doi.org/10.7710/2162-3309.2326</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Volume 7 Masthead                                                                                                        </td><td>10.7710/2162-3309.2351</td><td>7</td><td>1</td><td>NA</td><td>2019-12-04</td><td>http://dx.doi.org/10.7710/2162-3309.2351</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Scholarly Publishing Literacy at the University of South Florida Libraries: From Advising to Active Involvement          </td><td>10.7710/2162-3309.2310</td><td>7</td><td>1</td><td>NA</td><td>2019-12-04</td><td>http://dx.doi.org/10.7710/2162-3309.2310</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>From Meow to ROAR: Expanding Open Access Repository Services at the University of Houston Libraries                      </td><td>10.7710/2162-3309.2309</td><td>7</td><td>1</td><td>NA</td><td>2019-12-13</td><td>http://dx.doi.org/10.7710/2162-3309.2309</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>Grey Literature: Use, Creation, and Citation Habits of Faculty Researchers across Disciplines                            </td><td>10.7710/2162-3309.2314</td><td>7</td><td>1</td><td>NA</td><td>2019-12-18</td><td>http://dx.doi.org/10.7710/2162-3309.2314</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>




```R
# use filter from dplyr to get only volume 8, issue 1
jlsc_8_1 <- jlsc_publications_2019 %>%
  dplyr::filter(volume == "8",
         issue == "1") 

# print the data frame with select columns
jlsc_8_1 %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 1 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Considering Creative Activity in Institutional Repositories: An Exploration of Faculty Perceptions</td><td>10.7710/2162-3309.2312</td><td>8</td><td>1</td><td>2312</td><td>2020-02-25</td><td>http://dx.doi.org/10.7710/2162-3309.2312</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



`filter()` will go through each row of your existing `jlsc_publications_2019` data frame, and keep only those rows with values matching the filters you input. **Note:** be careful of filtering by ISSN. If a journal has multiple ISSNs they'll be combined in a single cell with a comma and the `filter()` will fail, as with JAMA above. In this case it may be wiser to use `str_detect()`, as described a couple code chunks down.


```R
jah_jama_publications$issn[1]
```


'0098-7484,1538-3598'


We can use `filter()` to get a single article from within this data frame if we need, either by DOI:


```R
# filter to get "The Five Laws of OER" article by DOI
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(doi == "10.7710/2162-3309.2299") 

# print data frame with select columns
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 1 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>The Five Laws of OER: Observations from Ranganathan</td><td>10.7710/2162-3309.2299</td><td>7</td><td>1</td><td>NA</td><td>2019-08-20</td><td>http://dx.doi.org/10.7710/2162-3309.2299</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



Or by title:


```R
# use str_detect to search the title column for articles that include the term OER
jlsc_article <- jlsc_publications_2019 %>%
  dplyr::filter(stringr::str_detect(title, "OER"))

# print the data frame with select column
jlsc_article %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 2 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Strategies for Supporting OER Adoption through Faculty and Instructor Use of a Federated Search Tool</td><td>10.7710/2162-3309.2279</td><td>7</td><td>1</td><td>NA</td><td>2019-02-22</td><td>http://dx.doi.org/10.7710/2162-3309.2279</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>The Five Laws of OER: Observations from Ranganathan                                                 </td><td>10.7710/2162-3309.2299</td><td>7</td><td>1</td><td>NA</td><td>2019-08-20</td><td>http://dx.doi.org/10.7710/2162-3309.2299</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



Here, we use the `str_detect()` function from the `stringr` package, which is loaded as part of the `tidyverse`, in order to find a single term (OER) in the title.

Remember that these `dplyr` and `stringr` functions are searching through our existing data frame `jlsc_publications_2019`, not issuing new API calls.

## Field queries

There is yet another way of making your query more precise, and that is to use a field query (`flq`) argument to `cr_journals()`. This allows you to search in specific bibliographic fields such as author, editor, titles, ISSNs, and author affiliation (not widely available). These are listed in the [Crossref documentation](https://github.com/CrossRef/rest-api-doc#field-queries) and reproduced below. You *must* provide an ISSN--in other words, you can't run a field query for authors across all journals. 

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
# assign JLSC ISSN and query the bibliographic field for terms mentioning open access. 
jlsc_issn <- "2162-3309"
jlsc_publications_oa <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.bibliographic` = 'open access')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, issn, author)
```


<table>
<caption>A tibble: 25 x 8</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>issn</th><th>author</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;list&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Campus Open Access Funds: Experiences of the KU “One University” Open
                        Access Author Fund                                 </td><td>10.7710/2162-3309.1252</td><td>3</td><td>1            </td><td>1252</td><td>2015-09-18</td><td>2162-3309</td><td>Rachel        , Allison C.    , Crystal       , Deborah       , Ada           , Gyore         , Reeve         , Cameron-Vedros, Ludwig        , Emmett        , first         , additional    , additional    , additional    , additional    </td></tr>
	<tr><td>Open Access and the Author-Pays Problem: Assuring Access for Readers and
                        Authors in the Global Academic Community        </td><td>10.7710/2162-3309.1064</td><td>1</td><td>3            </td><td>1064</td><td>2013-02-28</td><td>2162-3309</td><td>A Townsend, Ada       , Marc L    , Peterson  , Emmett    , Greenberg , first     , additional, additional</td></tr>
	<tr><td>“Open Don’t Mean Free”: A Reflection on the Potential Advantages and
                        Disadvantages of Publishing Research via Open Access</td><td>10.7710/2162-3309.1049</td><td>1</td><td>2            </td><td>1049</td><td>2012-09-28</td><td>2162-3309</td><td>Frank C, Manista, first  </td></tr>
	<tr><td>Open Data, [Open] Access: Linking Data Sharing and Article Sharing in the Earth Sciences                                                          </td><td>10.7710/2162-3309.2150</td><td>5</td><td>General Issue</td><td>NA  </td><td>2017      </td><td>2162-3309</td><td>Samantha , Teplitzky, first    </td></tr>
	<tr><td>Innovation Fair Abstracts, SPARC 2012 Open Access Meeting                                                                                         </td><td>10.7710/2162-3309.1042</td><td>1</td><td>1            </td><td>1042</td><td>2012-05-15</td><td>2162-3309</td><td>Abstract, Authors , first   </td></tr>
	<tr><td><span style="white-space: pre-wrap;">Point &amp; Counterpoint Is CC BY the Best Open Access License?                                                                                       </span></td><td>10.7710/2162-3309.1043</td><td>1</td><td><span style="white-space: pre-wrap;">1            </span></td><td>1043</td><td>2012-05-15</td><td>2162-3309</td><td><span style="white-space: pre-wrap;">Klaus     , Sanford   , Graf      , Thatcher  , first     , additional</span></td></tr>
	<tr><td>Developing Open Access Journals: A Practical Guide                                                                                                </td><td>10.7710/2162-3309.1028</td><td>1</td><td>1            </td><td>1028</td><td>2012-05-15</td><td>2162-3309</td><td>Caitlin, Bakker , first  </td></tr>
	<tr><td>Up from Under the “Open Access” Bus                                                                                                               </td><td>10.7710/2162-3309.1045</td><td>1</td><td>2            </td><td>1045</td><td>2012-09-28</td><td>2162-3309</td><td>Paul   , Royster, first  </td></tr>
	<tr><td>Response to “Is CC BY the Best Open Access License?”                                                                                              </td><td>10.7710/2162-3309.1055</td><td>1</td><td>2            </td><td>1055</td><td>2012-09-28</td><td>2162-3309</td><td>Andras, Holl  , first </td></tr>
	<tr><td>“Free to All”: Library Publishing and the Challenge of Open
                        Access                                                       </td><td>10.7710/2162-3309.1181</td><td>2</td><td>4            </td><td>1181</td><td>2014-12-11</td><td>2162-3309</td><td>Micah     , Josh      , Vandegrift, Bolick    , first     , additional</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>The Accessibility Quotient: A New Measure of Open Access                                                                                                  </td><td>10.7710/2162-3309.1025</td><td>1</td><td>1            </td><td>1025</td><td>2012-05-15</td><td>2162-3309</td><td>Mathew A    , Katharine H , Ellen Finnie, Willmott    , Dunn        , Duranceau   , first       , additional  , additional  </td></tr>
	<tr><td>All That Glisters: Investigating Collective Funding Mechanisms for Gold
                        Open Access in Humanities Disciplines                    </td><td>10.7710/2162-3309.1131</td><td>2</td><td>3            </td><td>1131</td><td>2014-08-01</td><td>2162-3309</td><td>Martin Paul, Eve        , first      </td></tr>
	<tr><td>Foxes Propose New Guidelines for Henhouse Design: Comments on NISO’s
                        Proposed Open Access Metadata Standards                     </td><td>10.7710/2162-3309.1170</td><td>2</td><td>3            </td><td>1170</td><td>2014-08-01</td><td>2162-3309</td><td>Paul   , Royster, first  </td></tr>
	<tr><td>Counting the Cost: A Report on APC-Supported Open Access Publishing in a
                        Research Library                                        </td><td>10.7710/2162-3309.1184</td><td>2</td><td>4            </td><td>1184</td><td>2014-12-11</td><td>2162-3309</td><td>Mark P    , Eva T     , Kerri     , Newton    , Cunningham, O'Connell , first     , additional, additional</td></tr>
	<tr><td>University Faculty Awareness and Attitudes towards Open Access Publishing
                        and the Institutional Repository: A Case Study         </td><td>10.7710/2162-3309.1210</td><td>3</td><td>1            </td><td>1210</td><td>2015-05-06</td><td>2162-3309</td><td>Zheng Y (Lan), Yu           , Yang         , Li           , first        , additional   </td></tr>
	<tr><td>Better Sharing Through Licenses? Measuring the Influence of Creative
                        Commons Licenses on the Usage of Open Access Monographs     </td><td>10.7710/2162-3309.1187</td><td>3</td><td>1            </td><td>1187</td><td>2015-03-10</td><td>2162-3309</td><td>Ronald , Snijder, first  </td></tr>
	<tr><td>Open Access Status of Nano ELSI Research: Determining Availability of a
                        Core Collection of Research for a Disciplinary Repository</td><td>10.7710/2162-3309.1190</td><td>3</td><td>1            </td><td>1190</td><td>2015-06-05</td><td>2162-3309</td><td>Rebecca      , Jessica      , Reznik-Zellen, Adamick      , first        , additional   </td></tr>
	<tr><td>From Concerned to Cautiously Optimistic: Assessing Faculty Perceptions
                        and Knowledge of Open Access in a Campus-Wide Study       </td><td>10.7710/2162-3309.1212</td><td>3</td><td>1            </td><td>1212</td><td>2015-06-22</td><td>2162-3309</td><td>Annie M, Gaines , first  </td></tr>
	<tr><td>A Resonant Message: Aligning Scholar Values and Open Access Objectives in OA Policy Outreach to Faculty and Graduate Students                             </td><td>10.7710/2162-3309.2152</td><td>4</td><td>General Issue</td><td>NA  </td><td>2016      </td><td>2162-3309</td><td>Jane        , Johnson Otto, first       </td></tr>
	<tr><td>Open Access Policies and Academic Freedom: Understanding and Addressing Conflicts                                                                         </td><td>10.7710/2162-3309.2104</td><td>5</td><td>General Issue</td><td>NA  </td><td>2017      </td><td>2162-3309</td><td>David James, Johnston   , first      </td></tr>
</tbody>
</table>



### Field query by author, contributor, or editor

The `flq` argument can also be used for authors, contributors, or editors. Here we search the same journal for authors with the name Salo (looking for all articles written by Dorothea Salo).




```R
# Use the query.author field query to find JLSC articles with author name Salo
jlsc_publications_auth <- rcrossref::cr_journals(issn = jlsc_issn, works = T, limit = 25,
                                            flq = c(`query.author` = 'salo')) %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_publications_auth %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 2 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>How to Scuttle a Scholarly Communication Initiative</td><td>10.7710/2162-3309.1075</td><td>1</td><td>4</td><td>1075</td><td>2013-08-15</td><td>http://dx.doi.org/10.7710/2162-3309.1075</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
	<tr><td>On the Mark? Responses to a Sting                  </td><td>10.7710/2162-3309.1116</td><td>2</td><td>1</td><td>1116</td><td>2013-12-09</td><td>http://dx.doi.org/10.7710/2162-3309.1116</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



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
# assign the PLOS ISSN and get the last 25 articles on deposit
plosone_issn <- '1932-6203'
plosone_publications <- cr_journals(issn = plosone_issn, works = TRUE, limit = 5) %>%
  pluck("data")

# use the toJSON function to convert the output to JSON
plosone_publications_json <- jsonlite::toJSON(plosone_publications)
```

Print the JSON, triple click inside the box to highlight the text, and copy it to the clipboard.


```R
# print the JSON
plosone_publications_json
```


    [{"container.title":"PLoS ONE","created":"2012-03-29","deposited":"2019-06-26","published.online":"2012-03-29","doi":"10.1371/journal.pone.0034299","indexed":"2020-02-05","issn":"1932-6203","issue":"3","issued":"2012-03-29","member":"340","page":"e34299","prefix":"10.1371","publisher":"Public Library of Science (PLoS)","reference.count":"77","score":"1","source":"Crossref","title":"Extinction-Dependent Alterations in Corticostriatal mGluR2/3 and mGluR7 Receptors following Chronic Methamphetamine Self-Administration in Rats","type":"journal-article","update.policy":"http://dx.doi.org/10.1371/journal.pone.corrections_policy","url":"http://dx.doi.org/10.1371/journal.pone.0034299","volume":"7","author":[{"given":"Marek","family":"Schwendt","sequence":"first"},{"given":"Carmela M.","family":"Reichel","sequence":"additional"},{"given":"Ronald E.","family":"See","sequence":"additional"}],"link":[{"URL":"http://dx.plos.org/10.1371/journal.pone.0034299","content.type":"unspecified","content.version":"vor","intended.application":"similarity-checking"}],"license":[{"date":"2012-03-29","URL":"http://creativecommons.org/licenses/by/4.0/","delay.in.days":0,"content.version":"unspecified"}],"reference":[{"key":"ref1","doi.asserted.by":"crossref","first.page":"1847","DOI":"10.1038/sj.npp.1301578","article.title":"Acute physiological and behavioral effects of intranasal methamphetamine in humans.","volume":"33","author":"CL Hart","year":"2008","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref2","doi.asserted.by":"crossref","first.page":"317","DOI":"10.1176/jnp.15.3.317","article.title":"Neuropsychological effects of chronic methamphetamine use on neurotransmitters and cognition: a review.","volume":"15","author":"TE Nordahl","year":"2003","journal.title":"J Neuropsychiatry Clin Neurosci"},{"key":"ref3","doi.asserted.by":"crossref","first.page":"141","DOI":"10.1080/10673220591003605","article.title":"Implications of chronic methamphetamine use: a literature review.","volume":"13","author":"CW Meredith","year":"2005","journal.title":"Harv Rev Psychiatry"},{"key":"ref4","first.page":"301","article.title":"The need for speed: an update on methamphetamine addiction.","volume":"31","author":"AM Barr","year":"2006","journal.title":"J Psychiatry Neurosci"},{"key":"ref5","doi.asserted.by":"crossref","first.page":"77","DOI":"10.4065/81.1.77","article.title":"Methamphetamine abuse: a perfect storm of complications.","volume":"81","author":"TW Lineberry","year":"2006","journal.title":"Mayo Clin Proc"},{"key":"ref6","doi.asserted.by":"crossref","first.page":"1272","DOI":"10.1016/j.biopsych.2006.07.031","article.title":"Attentional control and brain metabolite levels in methamphetamine abusers.","volume":"61","author":"R Salo","year":"2007","journal.title":"Biol Psychiatry"},{"key":"ref7","doi.asserted.by":"crossref","first.page":"1581","DOI":"10.1016/j.addbeh.2008.07.024","article.title":"Comparing the dynamic course of heroin, cocaine, and methamphetamine use over 10 years.","volume":"33","author":"YI Hser","year":"2008","journal.title":"Addict Behav"},{"key":"ref8","doi.asserted.by":"crossref","first.page":"345","DOI":"10.1007/s11920-006-0035-x","article.title":"Management of methamphetamine abuse and dependence.","volume":"8","author":"W Ling","year":"2006","journal.title":"Curr Psychiatry Rep"},{"key":"ref9","doi.asserted.by":"crossref","first.page":"309","DOI":"10.1080/09595230801919494","article.title":"A systematic review of cognitive and behavioural therapies for methamphetamine dependence.","volume":"27","author":"NK Lee","year":"2008","journal.title":"Drug Alcohol Rev"},{"key":"ref10","doi.asserted.by":"crossref","first.page":"31","DOI":"10.1080/08897070802218554","article.title":"Pharmacotherapy of methamphetamine addiction: an update.","volume":"29","author":"A Elkashef","year":"2008","journal.title":"Subst Abus"},{"key":"ref11","doi.asserted.by":"crossref","first.page":"48","DOI":"10.1007/s00213-006-0353-z","article.title":"Escalation of methamphetamine self-administration in rats: a dose-effect function.","volume":"186","author":"O Kitamura","year":"2006","journal.title":"Psychopharmacology (Berl)"},{"key":"ref12","doi.asserted.by":"crossref","first.page":"615","DOI":"10.1007/s00213-008-1187-7","article.title":"Extended methamphetamine self-administration enhances reinstatement of drug seeking and impairs novel object recognition in rats.","volume":"199","author":"JL Rogers","year":"2008","journal.title":"Psychopharmacology (Berl)"},{"key":"ref13","doi.asserted.by":"crossref","first.page":"555","DOI":"10.1124/jpet.109.155770","article.title":"Extended methamphetamine self-administration in rats results in a selective reduction of dopamine transporter levels in the prefrontal cortex and dorsal striatum not accompanied by marked monoaminergic depletion.","volume":"331","author":"M Schwendt","year":"2009","journal.title":"J Pharmacol Exp Ther"},{"key":"ref14","doi.asserted.by":"crossref","first.page":"782","DOI":"10.1038/npp.2010.212","article.title":"Loss of object recognition memory produced by extended access to methamphetamine self-administration is reversed by positive allosteric modulation of metabotropic glutamate receptor 5.","volume":"36","author":"CM Reichel","year":"2011","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref15","doi.asserted.by":"crossref","first.page":"406","DOI":"10.1016/j.pneurobio.2005.04.003","article.title":"Mechanisms of neurotransmitter release by amphetamines: a review.","volume":"75","author":"D Sulzer","year":"2005","journal.title":"Prog Neurobiol"},{"key":"ref16","doi.asserted.by":"crossref","first.page":"218","DOI":"10.1016/j.bcp.2007.06.039","article.title":"Glutamatergic substrates of drug addiction and alcoholism.","volume":"75","author":"JT Gass","year":"2008","journal.title":"Biochem Pharmacol"},{"key":"ref17","doi.asserted.by":"crossref","first.page":"203","DOI":"10.1002/syn.890170310","article.title":"Methamphetamine-induced neurotoxicity: roles for glutamate and dopamine efflux.","volume":"17","author":"SE Stephans","year":"1994","journal.title":"Synapse"},{"key":"ref18","doi.asserted.by":"crossref","first.page":"315","DOI":"10.1111/j.1749-6632.1996.tb17452.x","article.title":"The role of glutamate in the neurotoxic effects of methamphetamine.","volume":"801","author":"T Ohmori","year":"1996","journal.title":"Ann N Y Acad Sci"},{"key":"ref19","doi.asserted.by":"crossref","first.page":"820","DOI":"10.1038/npp.2008.140","article.title":"mGluR5 antagonism attenuates methamphetamine reinforcement and prevents reinstatement of methamphetamine-seeking behavior in rats.","volume":"34","author":"JT Gass","year":"2009","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref20","article.title":"Distinct Neurochemical Adaptations Within the Nucleus Accumbens Produced by a History of Self-Administered vs Non-Contingently Administered Intravenous Methamphetamine","author":"KD Lominac","year":"2011"},{"key":"ref21","doi.asserted.by":"crossref","first.page":"87","DOI":"10.1016/S0014-2999(01)01066-4","article.title":"Comparative effects of dextromethorphan and dextrorphan on morphine, methamphetamine, and nicotine self-administration in rats.","volume":"422","author":"SD Glick","year":"2001","journal.title":"Eur J Pharmacol"},{"key":"ref22","doi.asserted.by":"crossref","first.page":"405","DOI":"10.1016/S0091-3057(00)00317-8","article.title":"Dextromethorphan alters methamphetamine self-administration in the rat.","volume":"67","author":"JH Jun","year":"2000","journal.title":"Pharmacology, biochemistry, and behavior"},{"key":"ref23","doi.asserted.by":"crossref","first.page":"RC89","DOI":"10.1523/JNEUROSCI.20-15-j0006.2000","article.title":"Glutamate transmission in the nucleus accumbens mediates relapse in cocaine addiction.","volume":"20","author":"JL Cornish","year":"2000","journal.title":"J Neurosci"},{"key":"ref24","doi.asserted.by":"crossref","first.page":"2916","DOI":"10.1523/JNEUROSCI.22-07-02916.2002","article.title":"Cocaine administered into the medial prefrontal cortex reinstates cocaine-seeking behavior by increasing AMPA receptor-mediated glutamate transmission in the nucleus accumbens.","volume":"22","author":"WK Park","year":"2002","journal.title":"J Neurosci"},{"key":"ref25","doi.asserted.by":"crossref","first.page":"143","DOI":"10.1007/s00213-006-0372-9","article.title":"The group II metabotropic glutamate receptor agonist, LY379268, inhibits both cocaine- and food-seeking behavior in rats.","volume":"186","author":"J Peters","year":"2006","journal.title":"Psychopharmacology (Berl)"},{"key":"ref26","doi.asserted.by":"crossref","first.page":"153","DOI":"10.1016/S0166-4328(02)00238-3","article.title":"Effects of intra-accumbens focal administrations of glutamate antagonists on object recognition memory in mice.","volume":"138","author":"F Sargolini","year":"2003","journal.title":"Behav Brain Res"},{"key":"ref27","doi.asserted.by":"crossref","first.page":"182","DOI":"10.1038/nn.2250","article.title":"N-Acetylcysteine reverses cocaine-induced metaplasticity.","volume":"12","author":"K Moussawi","year":"2009","journal.title":"Nat Neurosci"},{"key":"ref28","doi.asserted.by":"crossref","first.page":"240","DOI":"10.1016/j.biopsych.2010.02.011","article.title":"Behavioral and functional evidence of metabotropic glutamate receptor 2/3 and metabotropic glutamate receptor 5 dysregulation in cocaine-escalated rats: factor in the transition to dependence.","volume":"68","author":"Y Hao","year":"2010","journal.title":"Biol Psychiatry"},{"key":"ref29","doi.asserted.by":"crossref","first.page":"164","DOI":"10.1016/j.ejphar.2006.10.011","article.title":"Interactive effects of the mGlu5 receptor antagonist MPEP and the mGlu2/3 receptor antagonist LY341495 on nicotine self-administration and reward deficits associated with nicotine withdrawal in rats.","volume":"554","author":"ME Liechti","year":"2007","journal.title":"Eur J Pharmacol"},{"key":"ref30","doi.asserted.by":"crossref","first.page":"227","DOI":"10.1016/j.pbb.2007.12.019","article.title":"A comparison of the effects of different operant training experiences and dietary restriction on the reinstatement of cocaine-seeking in rats.","volume":"89","author":"M Bongiovanni","year":"2008","journal.title":"Pharmacology, biochemistry, and behavior"},{"key":"ref31","doi.asserted.by":"crossref","first.page":"70","DOI":"10.1038/nature01249","article.title":"Extinction-induced upregulation in AMPA receptors reduces cocaine-seeking behaviour.","volume":"421","author":"MA Sutton","year":"2003","journal.title":"Nature"},{"key":"ref32","doi.asserted.by":"crossref","first.page":"3584","DOI":"10.1523/JNEUROSCI.5146-05.2006","article.title":"Different neural substrates mediate cocaine seeking after abstinence versus extinction training: a critical role for the dorsolateral caudate-putamen.","volume":"26","author":"RA Fuchs","year":"2006","journal.title":"J Neurosci"},{"key":"ref33","doi.asserted.by":"crossref","first.page":"293","DOI":"10.1124/jpet.107.130534","article.title":"Dysregulation of dopamine transporter trafficking and function after abstinence from cocaine self-administration in rats: evidence for differential regulation in caudate putamen and nucleus accumbens.","volume":"325","author":"DJ Samuvel","year":"2008","journal.title":"J Pharmacol Exp Ther"},{"key":"ref34","doi.asserted.by":"crossref","first.page":"5858","DOI":"10.1038/sj.onc.1207774","article.title":"The Ras-related protein AGS1/RASD1 suppresses cell growth.","volume":"23","author":"G Vaidyanathan","year":"2004","journal.title":"Oncogene"},{"key":"ref35","doi.asserted.by":"crossref","DOI":"10.1016/S0924-8196(00)80044-5","article.title":"Metabotropic glutamate receptors immunocytochemical and in situ hybridization analyses","author":"R Shigemoto","year":"2000"},{"key":"ref36","doi.asserted.by":"crossref","first.page":"5","DOI":"10.1002/(SICI)1096-9861(19980105)390:1<5::AID-CNE2>3.0.CO;2-6","article.title":"Immunohistochemical localization of metabotropic glutamate receptors mGluR1a and mGluR2/3 in the rat basal ganglia.","volume":"390","author":"CM Testa","year":"1998","journal.title":"J Comp Neurol"},{"key":"ref37","doi.asserted.by":"crossref","first.page":"747","DOI":"10.1016/j.biopsych.2006.12.005","article.title":"Altered dimerization of metabotropic glutamate receptor 3 in schizophrenia.","volume":"62","author":"C Corti","year":"2007","journal.title":"Biol Psychiatry"},{"key":"ref38","first.page":"145","article.title":"The role of GPCR dimerisation/oligomerisation in receptor signalling.","author":"G Milligan","year":"2006","journal.title":"Ernst Schering Found Symp Proc"},{"key":"ref39","doi.asserted.by":"crossref","first.page":"131","DOI":"10.1016/j.tips.2005.01.004","article.title":"Emerging role of homo- and heterodimerization in G-protein-coupled receptor biosynthesis and maturation.","volume":"26","author":"S Bulenger","year":"2005","journal.title":"Trends Pharmacol Sci"},{"key":"ref40","first.page":"402","article.title":"NMDA Receptor-dependent Recruitment of AMPA Receptor and Calnexin to Plasma Membrane in Cultured Rat Hippocampal Neurons.","volume":"41","author":"J Tsujimura","year":"2002","journal.title":"Bulletin of the Japanese Society for Neurochemistry"},{"key":"ref41","doi.asserted.by":"crossref","first.page":"35751","DOI":"10.1074/jbc.M007476200","article.title":"Cell surface expression of calnexin, a molecular chaperone in the endoplasmic reticulum.","volume":"275","author":"Y Okazaki","year":"2000","journal.title":"J Biol Chem"},{"key":"ref42","doi.asserted.by":"crossref","first.page":"1434","DOI":"10.1111/j.1471-4159.2005.03130.x","article.title":"Environmental enrichment decreases cell surface expression of the dopamine transporter in rat medial prefrontal cortex.","volume":"93","author":"J Zhu","year":"2005","journal.title":"J Neurochem"},{"key":"ref43","doi.asserted.by":"crossref","first.page":"183","DOI":"10.1016/S0896-6273(00)00095-7","article.title":"Dexras1: a G protein specifically coupled to neuronal nitric oxide synthase via CAPON.","volume":"28","author":"M Fang","year":"2000","journal.title":"Neuron"},{"key":"ref44","doi.asserted.by":"crossref","first.page":"1","DOI":"10.1007/s00213-006-0529-6","article.title":"Toward a model of drug relapse: an assessment of the validity of the reinstatement procedure.","volume":"189","author":"DH Epstein","year":"2006","journal.title":"Psychopharmacology (Berl)"},{"key":"ref45","doi.asserted.by":"crossref","first.page":"155","DOI":"10.1046/j.1360-0443.2002.00014.x","article.title":"Applying extinction research and theory to cue-exposure addiction treatments.","volume":"97","author":"CA Conklin","year":"2002","journal.title":"Addiction"},{"key":"ref46","doi.asserted.by":"crossref","first.page":"989","DOI":"10.1016/S0306-4603(01)00289-1","article.title":"Increasing the efficacy of cue exposure treatment in preventing relapse of addictive behavior.","volume":"28","author":"RC Havermans","year":"2003","journal.title":"Addict Behav"},{"key":"ref47","doi.asserted.by":"crossref","first.page":"184","DOI":"10.2174/1874473710902020184","article.title":"Forced abstinence model of relapse to study pharmacological treatments of substance use disorder.","volume":"2","author":"CM Reichel","year":"2009","journal.title":"Curr Drug Abuse Rev"},{"key":"ref48","doi.asserted.by":"crossref","first.page":"1359","DOI":"10.1016/S0306-4522(99)00214-6","article.title":"A role for nucleus accumbens glutamate transmission in the relapse to cocaine-seeking behavior.","volume":"93","author":"JL Cornish","year":"1999","journal.title":"Neuroscience"},{"key":"ref49","doi.asserted.by":"crossref","first.page":"1413","DOI":"10.1038/sj.npp.1301522","article.title":"Differential effects of nucleus accumbens core, shell, or dorsal striatal inactivations on the persistence, reacquisition, or reinstatement of responding for a drug-paired conditioned reinforcer.","volume":"33","author":"P Di Ciano","year":"2008","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref50","doi.asserted.by":"crossref","first.page":"903","DOI":"10.1111/j.1460-9568.2010.07134.x","article.title":"Role of the prefrontal cortex and nucleus accumbens in reinstating methamphetamine seeking.","volume":"31","author":"A Rocha","year":"2010","journal.title":"Eur J Neurosci"},{"key":"ref51","doi.asserted.by":"crossref","first.page":"321","DOI":"10.1007/s00213-007-0850-8","article.title":"The role of dorsal vs ventral striatal pathways in cocaine-seeking behavior after prolonged abstinence in rats.","volume":"194","author":"RE See","year":"2007","journal.title":"Psychopharmacology (Berl)"},{"key":"ref52","doi.asserted.by":"crossref","first.page":"6046","DOI":"10.1523/JNEUROSCI.1045-08.2008","article.title":"Infralimbic prefrontal cortex is responsible for inhibiting cocaine seeking in extinguished rats.","volume":"28","author":"J Peters","year":"2008","journal.title":"J Neurosci"},{"key":"ref53","doi.asserted.by":"crossref","first.page":"7984","DOI":"10.1523/JNEUROSCI.1244-10.2010","article.title":"Extinction training after cocaine self-administration induces glutamatergic plasticity to inhibit cocaine seeking.","volume":"30","author":"LA Knackstedt","year":"2010","journal.title":"J Neurosci"},{"key":"ref54","doi.asserted.by":"crossref","first.page":"167","DOI":"10.1016/j.neulet.2008.12.028","article.title":"Neuroadaptations in the cellular and postsynaptic group 1 metabotropic glutamate receptor mGluR5 and Homer proteins following extinction of cocaine self-administration.","volume":"452","author":"MB Ghasemzadeh","year":"2009","journal.title":"Neurosci Lett"},{"key":"ref55","doi.asserted.by":"crossref","first.page":"60","DOI":"10.1016/j.brainres.2011.06.041","article.title":"Glutamatergic plasticity in medial prefrontal cortex and ventral tegmental area following extended-access cocaine self-administration.","volume":"1413","author":"MB Ghasemzadeh","year":"2011","journal.title":"Brain Res"},{"key":"ref56","doi.asserted.by":"crossref","first.page":"119","DOI":"10.1016/j.bbr.2007.08.001","article.title":"The effects of extinction training in reducing the reinstatement of drug-seeking behavior: involvement of NMDA receptors.","volume":"185","author":"L Kelamangalath","year":"2007","journal.title":"Behav Brain Res"},{"key":"ref57","doi.asserted.by":"crossref","first.page":"648","DOI":"10.1101/lm.81404","article.title":"Extinction training regulates neuroadaptive responses to withdrawal from chronic cocaine self-administration.","volume":"11","author":"DW Self","year":"2004","journal.title":"Learn Mem"},{"key":"ref58","doi.asserted.by":"crossref","first.page":"332","DOI":"10.1002/(SICI)1096-9861(19980413)393:3<332::AID-CNE6>3.0.CO;2-2","article.title":"Immunohistochemical localization of metabotropic glutamate receptors, mGluR7a and mGluR7b, in the central nervous system of the adult rat and mouse: a light and electron microscopic study.","volume":"393","author":"A Kinoshita","year":"1998","journal.title":"J Comp Neurol"},{"key":"ref59","doi.asserted.by":"crossref","first.page":"949","DOI":"10.1016/0306-4522(95)00533-1","article.title":"The metabotropic glutamate receptors, mGluR2 and mGluR3, show unique postsynaptic, presynaptic and glial localizations.","volume":"71","author":"RS Petralia","year":"1996","journal.title":"Neuroscience"},{"key":"ref60","first.page":"1368","article.title":"Activation of mGluR7s inhibits cocaine-induced reinstatement of drug-seeking behavior by a nucleus accumbens glutamate-mGluR2/3 mechanism in rats.","volume":"114","author":"X Li","year":"2010","journal.title":"J Neurochem"},{"key":"ref61","doi.asserted.by":"crossref","first.page":"6389","DOI":"10.1523/JNEUROSCI.1007-05.2005","article.title":"Cystine/glutamate exchange regulates metabotropic glutamate receptor presynaptic inhibition of excitatory transmission and vulnerability to cocaine seeking.","volume":"25","author":"MM Moran","year":"2005","journal.title":"J Neurosci"},{"key":"ref62","doi.asserted.by":"crossref","first.page":"608","DOI":"10.1124/jpet.102.039735","article.title":"Modulation of group II metabotropic glutamate receptor signaling by chronic cocaine.","volume":"303","author":"ZX Xi","year":"2002","journal.title":"J Pharmacol Exp Ther"},{"key":"ref63","doi.asserted.by":"crossref","first.page":"337","DOI":"10.1007/s00213-010-1828-5","article.title":"Modafinil effects on reinstatement of methamphetamine seeking in a rat model of relapse.","volume":"210","author":"CM Reichel","year":"2010","journal.title":"Psychopharmacology (Berl)"},{"key":"ref64","doi.asserted.by":"crossref","first.page":"2203","DOI":"10.1038/npp.2010.94","article.title":"Modafinil blocks reinstatement of extinguished opiate-seeking in rats: mediation by a glutamate mechanism.","volume":"35","author":"P Tahsili-Fahadan","year":"2010","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref65","doi.asserted.by":"crossref","first.page":"186","DOI":"10.1002/1097-4547(20000715)61:2<186::AID-JNR9>3.0.CO;2-X","article.title":"Quantitative characterization of crude synaptosomal fraction (P-2) components by flow cytometry.","volume":"61","author":"KH Gylys","year":"2000","journal.title":"J Neurosci Res"},{"key":"ref66","doi.asserted.by":"crossref","first.page":"948","DOI":"10.1111/j.1471-4159.2004.02937.x","article.title":"Enhancement of glutamate uptake mediates the neuroprotection exerted by activating group II or III metabotropic glutamate receptors on astrocytes.","volume":"92","author":"HH Yao","year":"2005","journal.title":"J Neurochem"},{"key":"ref67","doi.asserted.by":"crossref","first.page":"379","DOI":"10.1016/j.brainresrev.2009.03.002","article.title":"Methamphetamine toxicity and messengers of death.","volume":"60","author":"IN Krasnova","year":"2009","journal.title":"Brain Res Rev"},{"key":"ref68","doi.asserted.by":"crossref","first.page":"1119","DOI":"10.1016/j.neuropharm.2011.11.003","article.title":"Methamphetamine-induced changes in the object recognition memory circuit.","volume":"62","author":"CM Reichel","year":"2012","journal.title":"Neuropharmacology"},{"key":"ref69","doi.asserted.by":"crossref","first.page":"187","DOI":"10.2174/156802610790411018","article.title":"Metabotropic glutamate receptors as therapeutic targets for cognitive disorders.","volume":"10","author":"A Gravius","year":"2010","journal.title":"Curr Top Med Chem"},{"key":"ref70","doi.asserted.by":"crossref","first.page":"93","DOI":"10.1038/nature06612","article.title":"Identification of a serotonin/glutamate receptor complex implicated in psychosis.","volume":"452","author":"J Gonzalez-Maeso","year":"2008","journal.title":"Nature"},{"key":"ref71","doi.asserted.by":"crossref","first.page":"173","DOI":"10.1016/S0893-133X(00)00250-5","article.title":"Effects of single and repeated phencyclidine administration on the expression of metabotropic glutamate receptor subtype mRNAs in rat brain.","volume":"25","author":"S Abe","year":"2001","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref72","doi.asserted.by":"crossref","first.page":"107","DOI":"10.1093/schbul/18.1.107","article.title":"Chronic methamphetamine intoxication model of schizophrenia in animals.","volume":"18","author":"Y Machiyama","year":"1992","journal.title":"Schizophr Bull"},{"key":"ref73","doi.asserted.by":"crossref","first.page":"183","DOI":"10.1016/j.neulet.2010.07.002","article.title":"Lamotrigine blocks the initiation and expression of repeated high-dose methamphetamine-induced prepulse inhibition deficit in rats.","volume":"481","author":"Y Nakato","year":"2010","journal.title":"Neurosci Lett"},{"key":"ref74","doi.asserted.by":"crossref","first.page":"233","DOI":"10.1016/j.drugalcdep.2011.07.010","article.title":"Reinstatement of methamphetamine seeking in male and female rats treated with modafinil and allopregnanolone.","volume":"120","author":"NA Holtz","year":"2012","journal.title":"Drug Alcohol Depend"},{"key":"ref75","doi.asserted.by":"crossref","first.page":"950","DOI":"10.1038/npp.2010.233","article.title":"Effect of modafinil on learning and task-related brain activity in methamphetamine-dependent and healthy individuals.","volume":"36","author":"DG Ghahremani","year":"2011","journal.title":"Neuropsychopharmacology: official publication of the American College of Neuropsychopharmacology"},{"key":"ref76","doi.asserted.by":"crossref","first.page":"173","DOI":"10.1016/j.drugalcdep.2009.08.013","article.title":"Evaluation of modafinil effects on cardiovascular, subjective, and reinforcing effects of methamphetamine in methamphetamine-dependent volunteers.","volume":"106","author":"R De La Garza 2nd","year":"2010","journal.title":"Drug Alcohol Depend"},{"key":"ref77","article.title":"The Rat Brain in Sterotaxic Coordinates","author":"G Paxinos","year":"2007"}]},{"container.title":"PLoS ONE","created":"2013-12-19","deposited":"2019-08-05","published.online":"2013-12-19","doi":"10.1371/journal.pone.0084281","indexed":"2020-02-05","issn":"1932-6203","issue":"12","issued":"2013-12-19","member":"340","page":"e84281","prefix":"10.1371","publisher":"Public Library of Science (PLoS)","reference.count":"60","score":"1","source":"Crossref","title":"Pathophysiological Defects and Transcriptional Profiling in the RBM20-/- Rat Model","type":"journal-article","update.policy":"http://dx.doi.org/10.1371/journal.pone.corrections_policy","url":"http://dx.doi.org/10.1371/journal.pone.0084281","volume":"8","author":[{"given":"Wei","family":"Guo","sequence":"first"},{"given":"Jonathan M.","family":"Pleitner","sequence":"additional"},{"given":"Kurt W.","family":"Saupe","sequence":"additional"},{"given":"Marion L.","family":"Greaser","sequence":"additional"}],"link":[{"URL":"http://dx.plos.org/10.1371/journal.pone.0084281","content.type":"unspecified","content.version":"vor","intended.application":"similarity-checking"}],"license":[{"date":"2013-12-19","URL":"http://creativecommons.org/licenses/by/4.0/","delay.in.days":0,"content.version":"vor"}],"reference":[{"key":"ref1","doi.asserted.by":"crossref","first.page":"325","DOI":"10.1007/s10974-005-9039-0","article.title":"Developmental changes in rat cardiac titin/connectin: transitions in normal animals and in mutants with a delayed pattern of isoform transition","volume":"26","author":"ML Greaser","year":"2005","journal.title":"J Muscle Res Cell Motil"},{"key":"ref2","doi.asserted.by":"crossref","first.page":"983","DOI":"10.1016/j.yjmcc.2008.02.272","article.title":"Mutation that dramatically alters rat titin isoform expression and cardiomyocyte passive tension","volume":"44","author":"ML Greaser","year":"2008","journal.title":"J Mol Cell Cardiol"},{"key":"ref3","doi.asserted.by":"crossref","first.page":"766","DOI":"10.1038/nm.2693","article.title":"RBM20, a gene for hereditary cardiomyopathy, regulates titin splicing","volume":"18","author":"W Guo","year":"2012","journal.title":"Nat Med"},{"key":"ref4","doi.asserted.by":"crossref","first.page":"930","DOI":"10.1016/j.jacc.2009.05.038","article.title":"Mutations in ribonucleic acid binding protein gene cause familial dilated cardiomyopathy","volume":"54","author":"KM Brauch","year":"2009","journal.title":"J Am Coll Cardiol"},{"key":"ref5","doi.asserted.by":"crossref","first.page":"90","DOI":"10.1111/j.1752-8062.2010.00198.x","article.title":"Identification of novel mutations in RBM20 in patients with dilated cardiomyopathy. Clin","volume":"3","author":"D Li","year":"2010","journal.title":"Transl Sci"},{"key":"ref6","doi.asserted.by":"crossref","first.page":"390","DOI":"10.1016/j.hrthm.2011.10.016","article.title":"Genetic variation in the alternative splicing regulator RBM20 is associated with dilated cardiomyopathy","volume":"9","author":"MM Refaat","year":"2012","journal.title":"Heart Rhythm"},{"key":"ref7","doi.asserted.by":"crossref","first.page":"293","DOI":"10.1126/science.270.5234.293","article.title":"Titins: giant proteins in charge of muscle ultrastructure and elasticity","volume":"270","author":"S Labeit","year":"1995","journal.title":"Science"},{"key":"ref8","doi.asserted.by":"crossref","first.page":"1065","DOI":"10.1161/hh2301.100981","article.title":"The complete gene sequence of titin, expression of an unusual approximately 700-kDa titin isoform, and its interaction with obscurin identify a novel Z-line to I-band linking system","volume":"89","author":"ML Bang","year":"2001","journal.title":"Circ Res"},{"key":"ref9","doi.asserted.by":"crossref","first.page":"1301","DOI":"10.1016/j.mod.2004.07.003","article.title":"Titin isoform changes in rat myocardium during development","volume":"121","author":"CM Warren","year":"2004","journal.title":"Mech Dev"},{"key":"ref10","doi.asserted.by":"crossref","first.page":"505","DOI":"10.1161/01.RES.0000115522.52554.86","article.title":"Developmental control of titin isoform expression and passive stiffness in fetal and neonatal myocardium","volume":"94","author":"S Lahmers","year":"2004","journal.title":"Circ Res"},{"key":"ref11","doi.asserted.by":"crossref","first.page":"967","DOI":"10.1161/01.RES.0000124301.48193.E1","article.title":"Developmentally regulated switching of titin size alters myofibrillar stiffness in the perinatal heart","volume":"94","author":"CA Opitz","year":"2004","journal.title":"Circ Res"},{"key":"ref12","doi.asserted.by":"crossref","first.page":"59","DOI":"10.1161/01.RES.86.1.59","article.title":"Differential expression of cardiac titin isoforms and modulation of cellular stiffness","volume":"86","author":"O Cazorla","year":"2000","journal.title":"Circ Res"},{"key":"ref13","doi.asserted.by":"crossref","first.page":"175","DOI":"10.1023/A:1026053530766","article.title":"Gigantic variety: expression patterns of titin isoforms in striated muscles and consequences for myofibrillar passive stiffness","volume":"24","author":"C Neagoe","year":"2003","journal.title":"J Muscle Res Cell Motil"},{"key":"ref14","doi.asserted.by":"crossref","first.page":"235","DOI":"10.1161/01.RES.87.3.235","article.title":"Alterations in the determinants of diastolic suction during pacing tachycardia","volume":"87","author":"SP Bell","year":"2000","journal.title":"Circ Res"},{"key":"ref15","doi.asserted.by":"crossref","first.page":"1384","DOI":"10.1161/01.CIR.0000029804.61510.02","article.title":"Changes in titin isoform expression in pacing-induced cardiac failure give rise to increased passive muscle stiffness","volume":"106","author":"Y Wu","year":"2002","journal.title":"Circulation"},{"key":"ref16","doi.asserted.by":"crossref","first.page":"1695","DOI":"10.1002/elps.200305392","article.title":"Vertical agarose gel electrophoresis and electroblotting of high-molecular-weight proteins","volume":"24","author":"CM Warren","year":"2003","journal.title":"Electrophoresis"},{"key":"ref17","doi.asserted.by":"crossref","first.page":"1966","DOI":"10.1161/CIRCULATIONAHA.105.587519","article.title":"Myocardial structure and function differ in systolic and diastolic heart failure","volume":"113","author":"L van Heerebeek","year":"2006","journal.title":"Circulation"},{"key":"ref18","doi.asserted.by":"crossref","first.page":"1333","DOI":"10.1161/01.CIR.0000029803.93022.93","article.title":"Titin isoform switch in ischemic human heart disease","volume":"106","author":"C Neagoe","year":"2002","journal.title":"Circulation"},{"key":"ref19","doi.asserted.by":"crossref","first.page":"708","DOI":"10.1161/01.RES.0000143901.37063.2f","article.title":"Passive stiffness changes caused by upregulation of compliant titin isoforms in human dilated cardiomyopathy hearts","volume":"95","author":"I Makarenko","year":"2004","journal.title":"Circ Res"},{"key":"ref20","doi.asserted.by":"crossref","first.page":"186","DOI":"10.1016/j.yjmcc.2006.09.017","article.title":"Hypothyroidism leads to increased collagen-based stiffness and re-expression of large cardiac titin isoforms with high compliance","volume":"42","author":"Y Wu","year":"2007","journal.title":"J Mol Cell Cardiol"},{"key":"ref21","first.page":"155","article.title":"Altered titin expression, myocardial stiffness, and left ventricular function in patients with dilated cardiomyopathy","volume":"110","author":"SF Nagueh","year":"2004"},{"key":"ref22","article.title":"Titin diversity—alternative splicing gone wild","author":"W Guo","year":"2010"},{"key":"ref23","doi.asserted.by":"crossref","first.page":"86","DOI":"10.1016/S0008-6363(03)00328-6","article.title":"Titin isoform expression in normal and hypertensive myocardium","volume":"59","author":"CM Warren","year":"2003","journal.title":"Cardiovasc Res"},{"key":"ref24","doi.asserted.by":"crossref","first.page":"848","DOI":"10.1002/elps.200800583","article.title":"Gel Band Fitter--a computer program for analysis of closely spaced electrophoretic and immunoblotted bands","volume":"30","author":"MI Mitov","year":"2009","journal.title":"Electrophoresis"},{"key":"ref25","doi.asserted.by":"crossref","first.page":"221","DOI":"10.1161/01.CIR.104.2.221","article.title":"Exercise training attenuates age-associated diastolic dysfunction in rats","volume":"104","author":"DA Brenner","year":"2001","journal.title":"Circulation"},{"key":"ref26","doi.asserted.by":"crossref","first.page":"1115","DOI":"10.1097/00004872-200206000-00022","article.title":"A gene expression analysis in rat kidney following high and low salt intake","volume":"20","author":"P Barta","year":"2002","journal.title":"J Hypertens"},{"key":"ref27","doi.asserted.by":"crossref","first.page":"e15","DOI":"10.1093/nar/gng015","article.title":"Summaries of Affymetrix GeneChip probe level data","volume":"31","author":"RA Irizarry","year":"2003","journal.title":"Nucleic Acids Res"},{"key":"ref28","doi.asserted.by":"crossref","first.page":"e45","DOI":"10.1093/nar/29.9.e45","article.title":"A new mathematical model for relative quantification in real-time RT-PCR","volume":"29","author":"MW Pfaffl","year":"2001","journal.title":"Nucleic Acids Res"},{"key":"ref29","doi.asserted.by":"crossref","first.page":"431","DOI":"10.1006/jmbi.2001.5017","article.title":"Structural and functional studies of titin&apos;s fn3 modules reveal conserved surface patterns and binding to myosin S1--a possible role in the Frank-Starling mechanism of the heart","volume":"313","author":"C Muhle-Goll","year":"2001","journal.title":"J Mol Biol"},{"key":"ref30","doi.asserted.by":"crossref","first.page":"284","DOI":"10.1161/01.RES.0000117769.88862.F8","article.title":"The giant protein titin: a major player in myocardial mechanics, signaling, and disease","volume":"94","author":"HL Granzier","year":"2004","journal.title":"Circ Res"},{"key":"ref31","doi.asserted.by":"crossref","first.page":"557","DOI":"10.1161/CIRCRESAHA.109.200964","article.title":"Truncation of titin’s elastic PEVK region leads to cardiomyopathy with diastolic dysfunction","volume":"105","author":"HL Granzier","year":"2009","journal.title":"Circ Res"},{"key":"ref32","doi.asserted.by":"crossref","first.page":"3444","DOI":"10.1073/pnas.0608543104","article.title":"Targeted deletion of titin N2B region leads to diastolic dysfunction and cardiac atrophy","volume":"104","author":"MH Radke","year":"2007","journal.title":"Proc Natl Acad Sci U S A"},{"key":"ref33","doi.asserted.by":"crossref","first.page":"S276","DOI":"10.1054/jcaf.2002.129278","article.title":"Titin: an endosarcomeric protein that modulates myocardial stiffness in DCM","volume":"8","author":"Y Wu","year":"2002","journal.title":"J Card Fail"},{"key":"ref34","doi.asserted.by":"crossref","first.page":"H697","DOI":"10.1152/ajpheart.00800.2011","article.title":"The magnitude of length-dependent changes in contractile properties varies with titin isoform in rat ventricles","volume":"302","author":"JR Patel","year":"2012","journal.title":"Am J Physiol Heart Circ Physiol"},{"key":"ref35","doi.asserted.by":"crossref","first.page":"804","DOI":"10.1016/j.bbamcr.2012.08.011","article.title":"Impact of titin isoform on length dependent activation and <underline>cross-bridge<\/underline> <underline>cycling<\/underline> <underline>kinetics<\/underline> <underline>in<\/underline> <underline>rat<\/underline> <underline>skeletal<\/underline> <underline>muscle<\/underline>","volume":"1833","author":"RD Mateja","year":"2013","journal.title":"Biochim Biophys Acta"},{"key":"ref36","article.title":"Investigations into the effects of altered titin isoform expression in striated muscle","author":"JM Pleitner","year":"2013","journal.title":"University of Wisconsin-Madison"},{"key":"ref37","doi.asserted.by":"crossref","first.page":"926","DOI":"10.1161/01.CIR.52.5.926","article.title":"Congenital heart malformations associated with disproportionate ventricular septal thickening","volume":"52","author":"BJ Maron","year":"1975","journal.title":"Circulation"},{"key":"ref38","doi.asserted.by":"crossref","first.page":"697","DOI":"10.1016/0022-2828(75)90146-7","article.title":"Intramitochondrial glycogen deposits in hypertrophied human myocardium","volume":"7","author":"BJ Maron","year":"1975","journal.title":"J Mol Cell Cardiol"},{"key":"ref39","doi.asserted.by":"crossref","first.page":"504","DOI":"10.1161/01.CIR.83.2.504","article.title":"Impairment of the myocardial ultrastructure and changes of the cytoskeleton in dilated cardiomyopathy","volume":"83","author":"J Schaper","year":"1991","journal.title":"Circulation"},{"key":"ref40","doi.asserted.by":"crossref","first.page":"189","DOI":"10.1016/S0167-5273(01)00566-6","article.title":"A semi-immobilization of a partial auricle induces hypertrophy and ultrastructural alteration of cardiomyocytes","volume":"81","author":"M Muto","year":"2001","journal.title":"Int J Cardiol"},{"key":"ref41","doi.asserted.by":"crossref","first.page":"984","DOI":"10.1161/01.CIR.0000051865.66123.B7","article.title":"Progression from compensated hypertrophy to failure in the pressure-overloaded human heart: structural deterioration and compensatory mechanisms","volume":"107","author":"S Hein","year":"2003","journal.title":"Circulation"},{"key":"ref42","doi.asserted.by":"crossref","first.page":"520","DOI":"10.1038/labinvest.2010.43","article.title":"Impairment of ultrastructure and cytoskeleton during progression of cardiac hypertrophy to heart failure","volume":"90","author":"A Gupta","year":"2010","journal.title":"Lab Invest"},{"key":"ref43","first.page":"123","article.title":"Changes in striated muscle fibres during contraction and growth with particular reference to myofibril splitting","volume":"9","author":"G Goldspink","year":"1971","journal.title":"J Cell Sci"},{"key":"ref44","first.page":"607","article.title":"Mechanism of myofibril growth and proliferation in fish muscle","volume":"22","author":"S Patterson","year":"1976","journal.title":"J Cell Sci"},{"key":"ref45","doi.asserted.by":"crossref","first.page":"65","DOI":"10.1016/1050-1738(96)00005-9","article.title":"The cell biology of the cardiac interstitium","volume":"6","author":"TK Borg","year":"1996","journal.title":"Trends Cardiovasc Med"},{"key":"ref46","doi.asserted.by":"crossref","first.page":"1774","DOI":"10.1096/fasebj.13.13.1774","article.title":"Connective tissue growth factor mediates transforming growth factor beta-induced collagen synthesis: down-regulation by cAMP","volume":"13","author":"MR Duncan","year":"1999","journal.title":"FASEB J"},{"key":"ref47","doi.asserted.by":"crossref","first.page":"1805","DOI":"10.1006/jmcc.2000.1215","article.title":"CTGF expression is induced by TGF-β in cardiac fibroblasts and cardiac myocytes: a potential role in heart fibrosis","volume":"32","author":"MM Chen","year":"2000","journal.title":"J Mol Cell Cardiol"},{"key":"ref48","doi.asserted.by":"crossref","first.page":"1241","DOI":"10.1093/ndt/gfg159","article.title":"The thrombospondin 1-TGF-β axis in fibrotic renal disease","volume":"18","author":"C Hugo","year":"2003","journal.title":"Nephrol Dial Transplant"},{"key":"ref49","doi.asserted.by":"crossref","first.page":"F407","DOI":"10.1152/ajprenal.00093.2007","article.title":"The small GTPase Rac-1 is a regulator of mesangial cell morphology and thrombospondin-1 expression","volume":"294","author":"K Giehl","year":"2008","journal.title":"Am J Physiol Renal Physiol"},{"key":"ref50","doi.asserted.by":"crossref","first.page":"2650","DOI":"10.1007/s00125-005-0006-5","article.title":"Glomerular expression of thrombospondin-1, transforming growth factor β and connective tissue growth factor at different stages of diabetic nephropathy and their interdependent roles in mesangial response to diabetic stimuli","volume":"48","author":"NA Wahab","year":"2005","journal.title":"Diabetologia"},{"key":"ref51","doi.asserted.by":"crossref","first.page":"1541","DOI":"10.1096/fj.04-1546fje","article.title":"Connective tissue growth factor [CTGF]/CCN2 stimulates mesangial cell migration through integrated dissolution of focal adhesion complexes and activation of cell polarization","volume":"18","author":"JK Crean","year":"2004","journal.title":"FASEB J"},{"key":"ref52","first.page":"637","article.title":"Sense and stretchability: the role of titin and titin-associated proteins in myocardial stress-sensing and mechanical dysfunction","volume":"77","author":"WA Linke","year":"2008","journal.title":"Cardiovasc Res"},{"key":"ref53","doi.asserted.by":"crossref","first.page":"1","DOI":"10.1016/j.cca.2006.06.035","article.title":"Cardiac titin: structure, functions and role in disease","volume":"375","author":"MM LeWinter","year":"2007","journal.title":"Clin Chim Acta"},{"key":"ref54","doi.asserted.by":"crossref","first.page":"48983","DOI":"10.1074/jbc.M404881200","article.title":"Thrombospondin induces RhoA inactivation through FAK-dependent signaling to stimulate focal adhesion disassembly","volume":"279","author":"AW Orr","year":"2004","journal.title":"J Biol Chem"},{"key":"ref55","doi.asserted.by":"crossref","first.page":"951","DOI":"10.1016/j.jmb.2003.09.012","article.title":"The muscle ankyrin repeat proteins: CARP, ankrd2/Arpp and DARP as a family of titin filament-based stress response molecules","volume":"333","author":"MK Miller","year":"2003","journal.title":"J Mol Biol"},{"key":"ref56","doi.asserted.by":"crossref","first.page":"3870","DOI":"10.1172/JCI34472","article.title":"An FHL1-containing complex within the cardiomyocyte sarcomere mediates hypertrophic biomechanical stress responses in mice","volume":"118","author":"F Sheikh","year":"2008","journal.title":"J Clin Invest"},{"key":"ref57","doi.asserted.by":"crossref","first.page":"29273","DOI":"10.1074/jbc.M112.372839","article.title":"A novel mechanism involving four and a half lim domain protein-1 and extracellular-signal-regulated kinase-2 regulates titin phosphorylation and mechanics","volume":"287","author":"A Raskin","year":"2012","journal.title":"J Biol Chem"},{"key":"ref58","doi.asserted.by":"crossref","first.page":"930","DOI":"10.1111/j.1440-1681.2003.03937.x","article.title":"Cosegregation analysis of natriuretic peptide genes and blood pressure in the spontaneously hypertensive rat","volume":"30","author":"P Ye","year":"2003","journal.title":"Clin Exp Pharmacol Physiol"},{"key":"ref59","doi.asserted.by":"crossref","first.page":"65","DOI":"10.1007/s11010-005-9014-5","article.title":"Simvastatin attenuates hypertrophic responses induced by cardiotrophin-1 via JAK-STAT pathway in cultured cardiomyocytes","volume":"284","author":"L Wu","year":"2006","journal.title":"Mol Cell Biochem"},{"key":"ref60","doi.asserted.by":"crossref","first.page":"186","DOI":"10.1152/physiol.00005.2010","article.title":"The giant protein titin as an integrator of myocyte signaling pathways","volume":"25","author":"WA Linke","year":"2010","journal.title":"Physiol (Bethesda)"}],"subject":"General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine"},{"container.title":"PLoS ONE","created":"2011-02-11","deposited":"2018-10-23","published.online":"2011-02-11","doi":"10.1371/journal.pone.0017140","indexed":"2020-02-05","issn":"1932-6203","issue":"2","issued":"2011-02-11","member":"340","page":"e17140","prefix":"10.1371","publisher":"Public Library of Science (PLoS)","reference.count":"11","score":"1","source":"Crossref","title":"Ab-Externo AAV-Mediated Gene Delivery to the Suprachoroidal Space Using a 250 Micron Flexible Microcatheter","type":"journal-article","update.policy":"http://dx.doi.org/10.1371/journal.pone.corrections_policy","url":"http://dx.doi.org/10.1371/journal.pone.0017140","volume":"6","author":[{"given":"Marc C.","family":"Peden","sequence":"first"},{"given":"Jeff","family":"Min","sequence":"additional"},{"given":"Craig","family":"Meyers","sequence":"additional"},{"given":"Zachary","family":"Lukowski","sequence":"additional"},{"given":"Qiuhong","family":"Li","sequence":"additional"},{"given":"Sanford L.","family":"Boye","sequence":"additional"},{"given":"Monica","family":"Levine","sequence":"additional"},{"given":"William W.","family":"Hauswirth","sequence":"additional"},{"given":"Ramakrishna","family":"Ratnakaram","sequence":"additional"},{"given":"William","family":"Dawson","sequence":"additional"},{"given":"Wesley C.","family":"Smith","sequence":"additional"},{"given":"Mark B.","family":"Sherwood","sequence":"additional"}],"link":[{"URL":"http://dx.plos.org/10.1371/journal.pone.0017140","content.type":"unspecified","content.version":"vor","intended.application":"similarity-checking"}],"license":[{"date":"2011-02-11","URL":"http://creativecommons.org/licenses/by/4.0/","delay.in.days":0,"content.version":"unspecified"}],"reference":[{"key":"ref1","doi.asserted.by":"crossref","first.page":"2231","DOI":"10.1056/NEJMoa0802268","article.title":"Effect of gene therapy on visual function in Leber’s congenital amaurosis.","volume":"358","author":"JW Bainbridge","year":"2008","journal.title":"N Engl J Med"},{"key":"ref2","doi.asserted.by":"crossref","first.page":"2240","DOI":"10.1056/NEJMoa0802315","article.title":"Safety and efficacy of gene transfer for Leber’s congenital amaurosis.","volume":"358","author":"AM Maguire","year":"2008","journal.title":"N Engl J Med"},{"key":"ref3","doi.asserted.by":"crossref","first.page":"979","DOI":"10.1089/hum.2008.107","article.title":"Treatment of Leber congenital amaurosis due to RPE65 mutations by ocular subretinal injection of adeno-associated virus gene vector: short-term results of a Phase I trial.","volume":"19","author":"WW Hauswirth","year":"2008","journal.title":"Hum Gene Ther"},{"key":"ref4","doi.asserted.by":"crossref","first.page":"15112","DOI":"10.1073/pnas.0807027105","article.title":"Human gene therapy for RPE65 isomerase deficiency activates the retinoid cycle of vision but with slow rod kinetics.","volume":"105","author":"AV Cideciyan","year":"2008","journal.title":"Proc Natl Acad Sci U S A"},{"key":"ref5","doi.asserted.by":"crossref","first.page":"643","DOI":"10.1038/mt.2009.277","article.title":"Gene therapy for Leber’s congenital amaurosis is safe and effective through 1.5 years after vector administration.","volume":"18","author":"F Simonelli","year":"2010","journal.title":"Mol Ther"},{"key":"ref6","doi.asserted.by":"crossref","first.page":"1217","DOI":"10.1016/j.jcrs.2007.03.051","article.title":"Canaloplasty: circumferential viscodilation and tensioning of Schlemm’s canal using a flexible microcatheter for the treatment of open-angle glaucoma in adults: interim clinical study analysis.","volume":"33","author":"RA Lewis","year":"2007","journal.title":"J Cataract Refract Surg"},{"key":"ref7","doi.asserted.by":"crossref","first.page":"777","DOI":"10.1016/j.ajo.2006.05.045","article.title":"Cannulation of the suprachoroidal space: a novel drug delivery methodology to the posterior segment.","volume":"142","author":"TW Olsen","year":"2006","journal.title":"Am J Ophthalmol"},{"key":"ref8","doi.asserted.by":"crossref","first.page":"158","DOI":"10.1016/S1046-2023(02)00220-7","article.title":"Production and purification of serotype 1, 2, and 5 recombinant adeno-associated viral vectors.","volume":"28","author":"S Zolotukhin","year":"2002","journal.title":"Methods"},{"key":"ref9","doi.asserted.by":"crossref","first.page":"377","DOI":"10.1016/j.visres.2007.08.009","article.title":"Comparative analysis of in vivo and in vitro AAV vector transduction in the neonatal mouse retina: Effects of serotype and site of administration.","volume":"48","author":"J Pang","year":"2008","journal.title":"Vision Res"},{"key":"ref10","doi.asserted.by":"crossref","first.page":"784","DOI":"10.1038/nature08401","article.title":"Gene therapy for red-green colour blindness in adult primates.","volume":"461","author":"K Mancuso","year":"2009","journal.title":"Nature"},{"key":"ref11","first.page":"1994","article.title":"AAV-mediated gene transfer of pigment epithelium-derived factor inhibits choroidal neovascularization.","volume":"43","author":"K Mori","year":"2002","journal.title":"Invest Opthalmol Vis Sci"}]},{"container.title":"PLoS ONE","created":"2009-10-26","deposited":"2018-10-23","published.online":"2009-10-27","doi":"10.1371/journal.pone.0007627","indexed":"2020-02-05","issn":"1932-6203","issue":"10","issued":"2009-10-27","member":"340","page":"e7627","prefix":"10.1371","publisher":"Public Library of Science (PLoS)","reference.count":"67","score":"1","source":"Crossref","title":"Proteomic and Phospho-Proteomic Profile of Human Platelets in Basal, Resting State: Insights into Integrin Signaling","type":"journal-article","update.policy":"http://dx.doi.org/10.1371/journal.pone.corrections_policy","url":"http://dx.doi.org/10.1371/journal.pone.0007627","volume":"4","author":[{"given":"Amir H.","family":"Qureshi","sequence":"first"},{"given":"Vineet","family":"Chaoji","sequence":"additional"},{"given":"Dony","family":"Maiguel","sequence":"additional"},{"given":"Mohd Hafeez","family":"Faridi","sequence":"additional"},{"given":"Constantinos J.","family":"Barth","sequence":"additional"},{"given":"Saeed M.","family":"Salem","sequence":"additional"},{"given":"Mudita","family":"Singhal","sequence":"additional"},{"given":"Darren","family":"Stoub","sequence":"additional"},{"given":"Bryan","family":"Krastins","sequence":"additional"},{"given":"Mitsunori","family":"Ogihara","sequence":"additional"},{"given":"Mohammed J.","family":"Zaki","sequence":"additional"},{"given":"Vineet","family":"Gupta","sequence":"additional"}],"link":[{"URL":"http://dx.plos.org/10.1371/journal.pone.0007627","content.type":"unspecified","content.version":"vor","intended.application":"similarity-checking"}],"license":[{"date":"2009-10-27","URL":"http://creativecommons.org/licenses/by/4.0/","delay.in.days":0,"content.version":"unspecified"}],"reference":[{"key":"ref1","doi.asserted.by":"crossref","first.page":"938","DOI":"10.1056/NEJMra0801082","article.title":"Mechanisms of thrombus formation.","volume":"359","author":"B Furie","year":"2008","journal.title":"N Engl J Med"},{"key":"ref2","doi.asserted.by":"crossref","first.page":"2023","DOI":"10.1016/S0140-6736(00)05108-4","article.title":"Platelet derived CD154 (CD40 ligand) and febrile responses to transfusion.","volume":"357","author":"RP Phipps","year":"2001","journal.title":"Lancet"},{"key":"ref3","doi.asserted.by":"crossref","first.page":"3378","DOI":"10.1172/JCI27196","article.title":"Platelets in inflammation and atherogenesis.","volume":"115","author":"M Gawaz","year":"2005","journal.title":"J Clin Invest"},{"key":"ref4","doi.asserted.by":"crossref","first.page":"153","DOI":"10.1111/j.1423-0410.2005.00618.x","article.title":"Current methods of assessing platelet function: relevance to transfusion medicine.","volume":"88","author":"R Cardigan","year":"2005","journal.title":"Vox Sang"},{"key":"ref5","doi.asserted.by":"crossref","first.page":"3011","DOI":"10.1182/blood-2008-06-077891","article.title":"The GPIIb/IIIa (integrin alphaIIbbeta3) odyssey: a technology-driven saga of a receptor with twists, turns, and even a bend.","volume":"112","author":"BS Coller","year":"2008","journal.title":"Blood"},{"key":"ref6","doi.asserted.by":"crossref","first.page":"1606","DOI":"10.1182/blood-2004-04-1257","article.title":"Integrins: dynamic scaffolds for adhesion and signaling in platelets.","volume":"104","author":"SJ Shattil","year":"2004","journal.title":"Blood"},{"key":"ref7","doi.asserted.by":"crossref","first.page":"1393","DOI":"10.1172/JCI109597","article.title":"Exposure of platelet fibrinogen receptors by ADP and epinephrine.","volume":"64","author":"JS Bennett","year":"1979","journal.title":"J Clin Invest"},{"key":"ref8","first.page":"907","article.title":"Analysis of GPIIb/IIIa receptor number by quantification of 7E3 binding to human platelets.","volume":"88","author":"CL Wagner","year":"1996","journal.title":"Blood"},{"key":"ref9","doi.asserted.by":"crossref","first.page":"3983","DOI":"10.1182/blood-2006-06-026518","article.title":"Proteomic approaches to dissect platelet function: Half the story.","volume":"108","author":"DV Gnatenko","year":"2006","journal.title":"Blood"},{"key":"ref10","doi.asserted.by":"crossref","first.page":"1214","DOI":"10.1161/ATVBAHA.108.167452","article.title":"A central resource for platelet proteomics.","volume":"28","author":"G Cagney","year":"2008","journal.title":"Arterioscler Thromb Vasc Biol"},{"key":"ref11","doi.asserted.by":"crossref","first.page":"1326","DOI":"10.1161/ATVBAHA.107.161000","article.title":"Platelet protein interactions: map, signaling components, and phosphorylation groundstate.","volume":"28","author":"M Dittrich","year":"2008","journal.title":"Arterioscler Thromb Vasc Biol"},{"key":"ref12","doi.asserted.by":"crossref","first.page":"314","DOI":"10.1074/mcp.M200002-MCP200","article.title":"A strategy for the rapid identification of phosphorylation sites in the phosphoproteome.","volume":"1","author":"JA MacDonald","year":"2002","journal.title":"Mol Cell Proteomics"},{"key":"ref13","doi.asserted.by":"crossref","first.page":"2622","DOI":"10.1002/1522-2683(20000701)21:13<2622::AID-ELPS2622>3.0.CO;2-3","article.title":"Identification of platelet proteins separated by two-dimensional gel electrophoresis and analyzed by matrix assisted laser desorption/ionization-time of flight-mass spectrometry and detection of tyrosine-phosphorylated proteins.","volume":"21","author":"K Marcus","year":"2000","journal.title":"Electrophoresis"},{"key":"ref14","doi.asserted.by":"crossref","first.page":"642","DOI":"10.1002/1615-9861(200206)2:6<642::AID-PROT642>3.0.CO;2-I","article.title":"Identification of the phosphotyrosine proteome from thrombin activated platelets.","volume":"2","author":"PB Maguire","year":"2002","journal.title":"Proteomics"},{"key":"ref15","doi.asserted.by":"crossref","first.page":"2088","DOI":"10.1182/blood-2003-07-2392","article.title":"Differential proteome analysis of TRAP-activated platelets: involvement of DOK-2 and phosphorylation of RGS proteins.","volume":"103","author":"A Garcia","year":"2004","journal.title":"Blood"},{"key":"ref16","doi.asserted.by":"crossref","first.page":"5332","DOI":"10.1002/pmic.200600299","article.title":"A global proteomics approach identifies novel phosphorylated signaling proteins in GPVI-activated platelets: involvement of G6f, a novel platelet Grb2-binding membrane adapter.","volume":"6","author":"A Garcia","year":"2006","journal.title":"Proteomics"},{"key":"ref17","doi.asserted.by":"crossref","first.page":"526","DOI":"10.1021/pr0704130","article.title":"Phosphoproteome of resting human platelets.","volume":"7","author":"RP Zahedi","year":"2008","journal.title":"J Proteome Res"},{"key":"ref18","doi.asserted.by":"crossref","first.page":"973","DOI":"10.1007/s00216-003-2021-z","article.title":"Differential analysis of phosphorylated proteins in resting and thrombin-stimulated human platelets.","volume":"376","author":"K Marcus","year":"2003","journal.title":"Anal Bioanal Chem"},{"key":"ref19","doi.asserted.by":"crossref","first.page":"1015","DOI":"10.1002/elps.1150190617","article.title":"Identification of phosphorylated proteins from thrombin-activated human platelets isolated by two-dimensional gel electrophoresis by electrospray ionization-tandem mass spectrometry (ESI-MS/MS) and liquid chromatography-electrospray ionization-mass spectrometry (LC-ESI-MS).","volume":"19","author":"D Immler","year":"1998","journal.title":"Electrophoresis"},{"key":"ref20","doi.asserted.by":"crossref","first.page":"193","DOI":"10.1074/mcp.M700137-MCP200","article.title":"Biological variation of the platelet proteome in the elderly population and its implication for biomarker research.","volume":"7","author":"W Winkler","year":"2008","journal.title":"Mol Cell Proteomics"},{"key":"ref21","doi.asserted.by":"crossref","first.page":"996","DOI":"10.1046/j.1365-2362.1996.2360585.x","article.title":"Flow cytometric analysis of platelet activation markers CD62P and CD63 in patients with coronary artery disease.","volume":"26","author":"T Murakami","year":"1996","journal.title":"Eur J Clin Invest"},{"key":"ref22","doi.asserted.by":"crossref","first.page":"75","DOI":"10.1111/j.1365-2257.2004.00662.x","article.title":"Are platelets activated after a rapid, one-step density gradient centrifugation? Evidence from flow cytometric analysis.","volume":"27","author":"K Bagamery","year":"2005","journal.title":"Clin Lab Haematol"},{"key":"ref23","doi.asserted.by":"crossref","first.page":"1439","DOI":"10.1111/j.1537-2995.2008.01738.x","article.title":"Flow cytometric measurement of CD62P (P-selectin) expression on platelets: a multicenter optimization and standardization effort.","volume":"48","author":"J Curvers","year":"2008","journal.title":"Transfusion"},{"key":"ref24","doi.asserted.by":"crossref","first.page":"206","DOI":"10.1016/0005-2736(87)90170-2","article.title":"Correlation between calpain-mediated cytoskeletal degradation and expression of platelet procoagulant activity. A role for the platelet membrane-skeleton in the regulation of membrane lipid asymmetry?","volume":"903","author":"PF Verhallen","year":"1987","journal.title":"Biochim Biophys Acta"},{"key":"ref25","doi.asserted.by":"crossref","first.page":"497","DOI":"10.1042/bj2740497","article.title":"Investigation of the role of calpain as a stimulus-response mediator in human platelets using new synthetic inhibitors.","volume":"274 ( Pt 2)","author":"J Anagli","year":"1991","journal.title":"Biochem J"},{"key":"ref26","doi.asserted.by":"crossref","first.page":"133","DOI":"10.1006/abbi.1999.1427","article.title":"The behavior of calpain-generated N- and C-terminal fragments of talin in integrin-mediated signaling pathways.","volume":"371","author":"M Hayashi","year":"1999","journal.title":"Arch Biochem Biophys"},{"key":"ref27","doi.asserted.by":"crossref","first.page":"28071","DOI":"10.1074/jbc.274.40.28071","article.title":"The Talin head domain binds to integrin beta subunit cytoplasmic tails and regulates integrin activation.","volume":"274","author":"DA Calderwood","year":"1999","journal.title":"J Biol Chem"},{"key":"ref28","doi.asserted.by":"crossref","first.page":"63","DOI":"10.1002/prca.200780067","article.title":"Comparison of human platelet membrane-cytoskeletal proteins with the plasma proteome: Towards understanding the platelet-plasma nexus.","volume":"2","author":"DW Greening","year":"2008","journal.title":"Proteomics Clin Appl"},{"key":"ref29","doi.asserted.by":"crossref","first.page":"245","DOI":"10.1007/978-1-60327-310-7_17","article.title":"Enrichment of human platelet membranes for proteomic analysis.","volume":"528","author":"DW Greening","year":"2009","journal.title":"Methods Mol Biol"},{"key":"ref30","doi.asserted.by":"crossref","first.page":"2096","DOI":"10.1182/blood-2003-08-2804","article.title":"Characterization of the proteins released from activated platelets leads to localization of novel platelet proteins in human atherosclerotic lesions.","volume":"103","author":"JA Coppinger","year":"2004","journal.title":"Blood"},{"key":"ref31","doi.asserted.by":"crossref","first.page":"1189","DOI":"10.1002/elps.200406196","article.title":"Two-dimensional Blue Native/sodium dodecyl sulfate gel electrophoresis for analysis of multimeric proteins in platelets.","volume":"26","author":"D Claeys","year":"2005","journal.title":"Electrophoresis"},{"key":"ref32","doi.asserted.by":"crossref","first.page":"288","DOI":"10.1002/1615-9861(200203)2:3<288::AID-PROT288>3.0.CO;2-0","article.title":"Towards complete analysis of the platelet proteome.","volume":"2","author":"EE O'Neill","year":"2002","journal.title":"Proteomics"},{"key":"ref33","doi.asserted.by":"crossref","first.page":"1754","DOI":"10.1074/mcp.M500209-MCP200","article.title":"The human platelet membrane proteome reveals several new potential membrane proteins.","volume":"4","author":"J Moebius","year":"2005","journal.title":"Mol Cell Proteomics"},{"key":"ref34","doi.asserted.by":"crossref","first.page":"1516","DOI":"10.1021/pr0500760","article.title":"The platelet microparticle proteome.","volume":"4","author":"BA Garcia","year":"2005","journal.title":"J Proteome Res"},{"key":"ref35","doi.asserted.by":"crossref","first.page":"656","DOI":"10.1002/pmic.200300665","article.title":"Extensive analysis of the human platelet proteome by two-dimensional gel electrophoresis and mass spectrometry.","volume":"4","author":"A Garcia","year":"2004","journal.title":"Proteomics"},{"key":"ref36","doi.asserted.by":"crossref","first.page":"3193","DOI":"10.1002/pmic.200401142","article.title":"The human platelet proteome mapped by peptide-centric proteomics: a functional protein profile.","volume":"5","author":"L Martens","year":"2005","journal.title":"Proteomics"},{"key":"ref37","doi.asserted.by":"crossref","first.page":"548","DOI":"10.1074/mcp.D600007-MCP200","article.title":"A comprehensive proteomics and genomics analysis reveals novel transmembrane proteins in human platelets and mouse megakaryocytes including G6b-B, a novel immunoreceptor tyrosine-based inhibitory motif protein.","volume":"6","author":"YA Senis","year":"2007","journal.title":"Mol Cell Proteomics"},{"key":"ref38","first.page":"1743","article.title":"Structure of human platelet membrane glycoproteins IIb and IIIa as determined by electron microscopy.","volume":"260","author":"NA Carrell","year":"1985","journal.title":"J Biol Chem"},{"key":"ref39","doi.asserted.by":"crossref","first.page":"1963","DOI":"10.1016/j.bbapap.2006.08.017","article.title":"Phosphoproteomics of human platelets: A quest for novel activation pathways.","volume":"1764","author":"RP Zahedi","year":"2006","journal.title":"Biochim Biophys Acta"},{"key":"ref40","doi.asserted.by":"crossref","first.page":"2883","DOI":"10.1021/ac981409y","article.title":"Immobilized gallium(III) affinity chromatography of phosphopeptides.","volume":"71","author":"MC Posewitz","year":"1999","journal.title":"Anal Chem"},{"key":"ref41","first.page":"19","article.title":"Model studies on iron(III) ion affinity chromatography. II. Interaction of immobilized iron(III) ions with phosphorylated amino acids, peptides and proteins.","volume":"604","author":"G Muszynska","year":"1992","journal.title":"J Chromatogr"},{"key":"ref42","doi.asserted.by":"crossref","first.page":"635","DOI":"10.1016/j.cell.2006.09.026","article.title":"Global, in vivo, and site-specific phosphorylation dynamics in signaling networks.","volume":"127","author":"JV Olsen","year":"2006","journal.title":"Cell"},{"key":"ref43","doi.asserted.by":"crossref","first.page":"1488","DOI":"10.1073/pnas.0609836104","article.title":"Large-scale phosphorylation analysis of mouse liver.","volume":"104","author":"J Villen","year":"2007","journal.title":"Proc Natl Acad Sci U S A"},{"key":"ref44","doi.asserted.by":"crossref","first.page":"1391","DOI":"10.1038/nbt1146","article.title":"An iterative statistical approach to the identification of protein phosphorylation motifs from large-scale data sets.","volume":"23","author":"D Schwartz","year":"2005","journal.title":"Nat Biotechnol"},{"key":"ref45","doi.asserted.by":"crossref","first.page":"1188","DOI":"10.1101/gr.849004","article.title":"WebLogo: a sequence logo generator.","volume":"14","author":"GE Crooks","year":"2004","journal.title":"Genome Res"},{"key":"ref46","doi.asserted.by":"crossref","first.page":"285","DOI":"10.1038/nbt0307-285","article.title":"A curated compendium of phosphorylation motifs.","volume":"25","author":"R Amanchy","year":"2007","journal.title":"Nat Biotechnol"},{"key":"ref47","doi.asserted.by":"crossref","first.page":"1032","DOI":"10.1038/nature03985","article.title":"A network-based analysis of systemic inflammation in humans.","volume":"437","author":"SE Calvano","year":"2005","journal.title":"Nature"},{"key":"ref48","doi.asserted.by":"crossref","first.page":"83","DOI":"10.1038/nmeth.1280","article.title":"An empirical framework for binary interactome mapping.","volume":"6","author":"K Venkatesan","year":"2009","journal.title":"Nat Methods"},{"key":"ref49","doi.asserted.by":"crossref","first.page":"R171","DOI":"10.1093/hmg/ddi335","article.title":"Interactome: gateway into systems biology.","volume":"14 Spec No. 2","author":"ME Cusick","year":"2005","journal.title":"Hum Mol Genet"},{"key":"ref50","doi.asserted.by":"crossref","first.page":"104","DOI":"10.1126/science.1158684","article.title":"High-quality binary protein interaction map of the yeast interactome network.","volume":"322","author":"H Yu","year":"2008","journal.title":"Science"},{"key":"ref51","doi.asserted.by":"crossref","first.page":"91","DOI":"10.1038/nmeth.1281","article.title":"An experimentally derived confidence score for binary protein-protein interactions.","volume":"6","author":"P Braun","year":"2009","journal.title":"Nat Methods"},{"key":"ref52","doi.asserted.by":"crossref","first.page":"1173","DOI":"10.1038/nature04209","article.title":"Towards a proteome-scale map of the human protein-protein interaction network.","volume":"437","author":"JF Rual","year":"2005","journal.title":"Nature"},{"key":"ref53","doi.asserted.by":"crossref","first.page":"8685","DOI":"10.1073/pnas.0701361104","article.title":"The human disease network.","volume":"104","author":"KI Goh","year":"2007","journal.title":"Proc Natl Acad Sci U S A"},{"key":"ref54","doi.asserted.by":"crossref","first.page":"D767","DOI":"10.1093/nar/gkn892","article.title":"Human Protein Reference Database–2009 update.","volume":"37","author":"TS Keshava Prasad","year":"2009","journal.title":"Nucleic Acids Res"},{"key":"ref55","doi.asserted.by":"crossref","first.page":"2498","DOI":"10.1101/gr.1239303","article.title":"Cytoscape: a software environment for integrated models of biomolecular interaction networks.","volume":"13","author":"P Shannon","year":"2003","journal.title":"Genome Res"},{"key":"ref56","doi.asserted.by":"crossref","first.page":"858","DOI":"10.1038/ncb0807-858","article.title":"Functional atlas of the integrin adhesome.","volume":"9","author":"R Zaidel-Bar","year":"2007","journal.title":"Nat Cell Biol"},{"key":"ref57","doi.asserted.by":"crossref","first.page":"2","DOI":"10.1186/1471-2105-4-2","article.title":"An automated method for finding molecular complexes in large protein interaction networks.","volume":"4","author":"GD Bader","year":"2003","journal.title":"BMC Bioinformatics"},{"key":"ref58","doi.asserted.by":"crossref","first.page":"30901","DOI":"10.1074/jbc.M001908200","article.title":"Threonine phosphorylation of the beta 3 integrin cytoplasmic tail, at a site recognized by PDK1 and Akt/PKB in vitro, regulates Shc binding.","volume":"275","author":"RI Kirk","year":"2000","journal.title":"J Biol Chem"},{"key":"ref59","doi.asserted.by":"crossref","first.page":"185","DOI":"10.1016/j.bbamcr.2006.08.053","article.title":"Threonine phosphorylation of integrin beta3 in calyculin A-treated platelets is selectively sensitive to 5′-iodotubercidin.","volume":"1773","author":"KM Lerea","year":"2007","journal.title":"Biochim Biophys Acta"},{"key":"ref60","doi.asserted.by":"crossref","first.page":"1914","DOI":"10.1074/jbc.274.4.1914","article.title":"Phosphorylation sites in the integrin beta3 cytoplasmic domain in intact platelets.","volume":"274","author":"KM Lerea","year":"1999","journal.title":"J Biol Chem"},{"key":"ref61","doi.asserted.by":"crossref","first.page":"36423","DOI":"10.1074/jbc.M004068200","article.title":"Identification of shc as the primary protein binding to the tyrosine-phosphorylated beta 3 subunit of alpha IIbbeta 3 during outside-in integrin platelet signaling.","volume":"275","author":"KJ Cowan","year":"2000","journal.title":"J Biol Chem"},{"key":"ref62","doi.asserted.by":"crossref","first.page":"265","DOI":"10.1083/jcb.200112113","article.title":"Coordinate interactions of Csk, Src, and Syk kinases with [alpha]IIb[beta]3 initiate integrin signaling to the cytoskeleton.","volume":"157","author":"A Obergfell","year":"2002","journal.title":"J Cell Biol"},{"key":"ref63","doi.asserted.by":"crossref","first.page":"33039","DOI":"10.1074/jbc.C400239200","article.title":"Protein phosphatase 1 associates with the integrin alphaIIb subunit and regulates signaling.","volume":"279","author":"KV Vijayan","year":"2004","journal.title":"J Biol Chem"},{"key":"ref64","doi.asserted.by":"crossref","first.page":"29568","DOI":"10.1074/jbc.M203179200","article.title":"Adaptor protein Shc is an isoform-specific direct activator of the tyrosine kinase c-Src.","volume":"277","author":"K Sato","year":"2002","journal.title":"J Biol Chem"},{"key":"ref65","doi.asserted.by":"crossref","first.page":"2404","DOI":"10.1021/pr050208p","article.title":"Efficient method for the proteomic analysis of fixed and embedded tissues.","volume":"4","author":"DE Palmer-Toy","year":"2005","journal.title":"J Proteome Res"},{"key":"ref66","doi.asserted.by":"crossref","first.page":"D501","DOI":"10.1093/nar/gki025","article.title":"NCBI Reference Sequence (RefSeq): a curated non-redundant sequence database of genomes, transcripts and proteins.","volume":"33","author":"KD Pruitt","year":"2005","journal.title":"Nucleic Acids Res"},{"key":"ref67","doi.asserted.by":"crossref","first.page":"378","DOI":"10.1016/S1044-0305(02)00352-5","article.title":"Qscore: an algorithm for evaluating SEQUEST database search results.","volume":"13","author":"RE Moore","year":"2002","journal.title":"J Am Soc Mass Spectrom"}]},{"container.title":"PLoS ONE","created":"2013-06-26","deposited":"2019-07-16","published.online":"2013-06-26","doi":"10.1371/journal.pone.0065596","indexed":"2020-02-05","issn":"1932-6203","issue":"6","issued":"2013-06-26","member":"340","page":"e65596","prefix":"10.1371","publisher":"Public Library of Science (PLoS)","reference.count":"51","score":"1","source":"Crossref","title":"Alterations of Neuromuscular Function after the World's Most Challenging Mountain Ultra-Marathon","type":"journal-article","update.policy":"http://dx.doi.org/10.1371/journal.pone.corrections_policy","url":"http://dx.doi.org/10.1371/journal.pone.0065596","volume":"8","author":[{"given":"Jonas","family":"Saugy","sequence":"first"},{"given":"Nicolas","family":"Place","sequence":"additional"},{"given":"Guillaume Y.","family":"Millet","sequence":"additional"},{"given":"Francis","family":"Degache","sequence":"additional"},{"given":"Federico","family":"Schena","sequence":"additional"},{"given":"Grégoire P.","family":"Millet","sequence":"additional"}],"link":[{"URL":"http://dx.plos.org/10.1371/journal.pone.0065596","content.type":"unspecified","content.version":"vor","intended.application":"similarity-checking"}],"license":[{"date":"2013-06-26","URL":"http://creativecommons.org/licenses/by/4.0/","delay.in.days":0,"content.version":"unspecified"}],"reference":[{"key":"ref1","doi.asserted.by":"crossref","first.page":"77","DOI":"10.1186/1741-7015-10-77","article.title":"Ultramarathon is an outstanding model for the study of adaptive responses to extreme load and stress","volume":"10","author":"GP Millet","year":"2012","journal.title":"BMC medicine"},{"key":"ref2","doi.asserted.by":"crossref","first.page":"56","DOI":"10.1016/j.wem.2011.11.001","article.title":"Increasing creatine kinase concentrations at the 161-km Western States Endurance Run","volume":"23","author":"MD Hoffman","year":"2012","journal.title":"Wilderness & environmental medicine"},{"key":"ref3","doi.asserted.by":"crossref","first.page":"e17059","DOI":"10.1371/journal.pone.0017059","article.title":"Neuromuscular consequences of an extreme mountain ultra-marathon","volume":"6","author":"GY Millet","year":"2011","journal.title":"PLoS ONE"},{"key":"ref4","doi.asserted.by":"crossref","first.page":"486","DOI":"10.1152/japplphysiol.00122.2001","article.title":"Alterations of neuromuscular function after an ultramarathon","volume":"92","author":"GY Millet","year":"2002","journal.title":"Journal of applied physiology"},{"key":"ref5","doi.asserted.by":"crossref","DOI":"10.1111/j.1600-0838.2012.01481.x","unstructured":"Robach P, Boisson RC, Vincent L, Lundby C, Moutereau S, et al.. (2012) Hemolysis induced by an extreme mountain ultra-marathon is not associated with a decrease in total red blood cell volume. Scandinavian journal of medicine &amp; science in sports."},{"key":"ref6","doi.asserted.by":"crossref","first.page":"1224","DOI":"10.1152/japplphysiol.01202.2009","article.title":"Central and peripheral contributions to neuromuscular fatigue induced by a 24-h treadmill run","volume":"108","author":"V Martin","year":"2010","journal.title":"Journal of applied physiology"},{"key":"ref7","doi.asserted.by":"crossref","first.page":"489","DOI":"10.2165/11588760-000000000-00000","article.title":"Can neuromuscular fatigue explain running strategies and performance in ultra-marathons?: the flush model","volume":"41","author":"GY Millet","year":"2011","journal.title":"Sports Medicine"},{"key":"ref8","doi.asserted.by":"crossref","first.page":"1054","DOI":"10.1249/01.mss.0000222831.35897.5f","article.title":"Exertional Rhabdomyolysis during a 246-km continuous running race","volume":"38","author":"KP Skenderi","year":"2006","journal.title":"Med Sci Sports Exerc"},{"key":"ref9","first.page":"1146","article.title":"The acute effects of twenty-four hours of sleep loss on the performance of national-caliber male collegiate weightlifters","volume":"21","author":"PA Blumert","year":"2007","journal.title":"Journal of strength and conditioning research/National Strength & Conditioning Association"},{"key":"ref10","doi.asserted.by":"crossref","first.page":"273","DOI":"10.1007/BF02425487","article.title":"The effect of sleep deprivation and exercise load on isokinetic leg strength and endurance","volume":"73","author":"R Bulbulian","year":"1996","journal.title":"European journal of applied physiology and occupational physiology"},{"key":"ref11","first.page":"225","article.title":"Electro-mechanical response times and muscle strength after sleep deprivation","volume":"13","author":"JD Symons","year":"1988","journal.title":"Can J Sport Sci"},{"key":"ref12","doi.asserted.by":"crossref","first.page":"374","DOI":"10.1249/00005768-198808000-00008","article.title":"Physical performance and physiological responses following 60 hours of sleep deprivation","volume":"20","author":"JD Symons","year":"1988","journal.title":"Medicine and science in sports and exercise"},{"key":"ref13","doi.asserted.by":"crossref","DOI":"10.1186/1741-7015-10-78","unstructured":"Schütz UHW, Schmidt-Trucksäss A, Knechtle B, Machann J, Wiedelbach H, et al.. (2012) The Transeurope Footrace Project: Longitudinal data acquisition in a cluster randomized mobile MRI observational cohort study on 44 endurance runners at a 64-stage 4,486km transcontinental ultramarathon. BMC Medicine."},{"key":"ref14","doi.asserted.by":"crossref","first.page":"215","DOI":"10.1152/japplphysiol.00022.2012","article.title":"Distinct profiles of neuromuscular fatigue during muscle contractions below and above the critical torque in humans","volume":"113","author":"M Burnley","year":"2012","journal.title":"Journal of applied physiology"},{"key":"ref15","doi.asserted.by":"crossref","first.page":"486","DOI":"10.1002/mus.20714","article.title":"Assessment of the reliability of central and peripheral fatigue after sustained maximal voluntary contraction of the quadriceps muscle","volume":"35","author":"N Place","year":"2007","journal.title":"Muscle & nerve"},{"key":"ref16","doi.asserted.by":"crossref","first.page":"73","DOI":"10.1111/j.1748-1716.1994.tb09786.x","article.title":"Electromyographic responses of the human triceps surae and force tremor during sustained submaximal isometric plantar flexion","volume":"152","author":"WN Loscher","year":"1994","journal.title":"Acta physiologica Scandinavica"},{"key":"ref17","doi.asserted.by":"crossref","first.page":"361","DOI":"10.1016/S1050-6411(00)00027-4","article.title":"Development of recommendations for SEMG sensors and sensor placement procedures","volume":"10","author":"HJ Hermens","year":"2000","journal.title":"J Electromyogr Kinesiol"},{"key":"ref18","doi.asserted.by":"crossref","first.page":"253","DOI":"10.1016/j.jelekin.2006.04.001","article.title":"Neuromuscular fatigue differs with biofeedback type when performing a submaximal contraction","volume":"17","author":"N Place","year":"2007","journal.title":"Journal of electromyography and kinesiology: official journal of the International Society of Electrophysiological Kinesiology"},{"key":"ref19","doi.asserted.by":"crossref","first.page":"667","DOI":"10.1080/00365510802126844","article.title":"Acute variation of biochemical markers of muscle damage following a 21-km, half-marathon run","volume":"68","author":"G Lippi","year":"2008","journal.title":"Scand J Clin Lab Invest"},{"key":"ref20","first.page":"377","article.title":"Foot-strike haemolysis after a 60-km ultramarathon","volume":"10","author":"G Lippi","year":"2012","journal.title":"Blood Transfus"},{"key":"ref21","doi.asserted.by":"crossref","first.page":"701","DOI":"10.1152/japplphysiol.01051.2007","article.title":"Comparison of electrical and magnetic stimulations to assess quadriceps muscle function","volume":"106","author":"S Verges","year":"2009","journal.title":"Journal of applied physiology"},{"key":"ref22","doi.asserted.by":"crossref","first.page":"861","DOI":"10.1002/(SICI)1097-4598(199607)19:7<861::AID-MUS8>3.0.CO;2-7","article.title":"Quantitation of central activation failure during maximal voluntary contractions in humans","volume":"19","author":"JA Kent-Braun","year":"1996","journal.title":"Muscle & nerve"},{"key":"ref23","doi.asserted.by":"crossref","first.page":"105","DOI":"10.2165/00007256-200434020-00004","article.title":"Alterations of neuromuscular function after prolonged running, cycling and skiing exercises","volume":"34","author":"GY Millet","year":"2004","journal.title":"Sports Medicine"},{"key":"ref24","doi.asserted.by":"crossref","first.page":"392","DOI":"10.1136/bjsm.2008.050799","article.title":"The anticipatory regulation of performance: the physiological basis for pacing strategies and the development of a perception-based model for exercise performance","volume":"43","author":"R Tucker","year":"2009","journal.title":"British Journal of Sports Medicine"},{"key":"ref25","doi.asserted.by":"crossref","first.page":"54","DOI":"10.1111/j.1600-0838.2009.01001.x","article.title":"Physiological and biological factors associated with a 24 h treadmill ultra-marathon performance","volume":"21","author":"GY Millet","year":"2011","journal.title":"Scandinavian journal of medicine & science in sports"},{"key":"ref26","doi.asserted.by":"crossref","first.page":"374","DOI":"10.2165/00007256-200737040-00026","article.title":"The central governor model of exercise regulation applied to the marathon","volume":"37","author":"TD Noakes","year":"2007","journal.title":"Sports medicine"},{"key":"ref27","doi.asserted.by":"crossref","first.page":"691","DOI":"10.1002/mus.880070902","article.title":"Changes in muscle contractile properties and neural control during human muscular fatigue","volume":"7","author":"B Bigland-Ritchie","year":"1984","journal.title":"Muscle & nerve"},{"key":"ref28","doi.asserted.by":"crossref","first.page":"1","DOI":"10.1007/s00421-010-1480-0","article.title":"Muscle fatigue: from observations in humans to underlying mechanisms studied in intact single muscle fibres","volume":"110","author":"N Place","year":"2010","journal.title":"European journal of applied physiology"},{"key":"ref29","doi.asserted.by":"crossref","first.page":"334","DOI":"10.1111/j.1440-1681.2008.05021.x","article.title":"Mechanisms of fatigue induced by isometric contractions in exercising humans and in mouse isolated single muscle fibres","volume":"36","author":"N Place","year":"2009","journal.title":"Clinical and experimental pharmacology & physiology"},{"key":"ref30","doi.asserted.by":"crossref","first.page":"2198","DOI":"10.1073/pnas.0711074105","article.title":"Remodeling of ryanodine receptor complex causes “aky”channels: a molecular mechanism for decreased exercise capacity","volume":"105","author":"AM Bellinger","year":"2008","journal.title":"Proceedings of the National Academy of Sciences of the United States of America"},{"key":"ref31","doi.asserted.by":"crossref","first.page":"82","DOI":"10.3389/fphys.2012.00082","article.title":"Fatigue is a Brain-Derived Emotion that Regulates the Exercise Behavior to Ensure the Protection of Whole Body Homeostasis","volume":"3","author":"TD Noakes","year":"2012","journal.title":"Frontiers in physiology"},{"key":"ref32","doi.asserted.by":"crossref","first.page":"2005","DOI":"10.1016/j.jbiomech.2005.06.019","article.title":"Differences in muscle function during walking and running at the same speed","volume":"39","author":"K Sasaki","year":"2006","journal.title":"Journal of biomechanics"},{"key":"ref33","doi.asserted.by":"crossref","first.page":"2283","DOI":"10.1242/jeb.066332","article.title":"The role of elastic energy storage and recovery in downhill and uphill running","volume":"215","author":"KL Snyder","year":"2012","journal.title":"The Journal of experimental biology"},{"key":"ref34","doi.asserted.by":"crossref","first.page":"274","DOI":"10.1080/15438627.2012.697084","article.title":"The effects of a downhill running bout on running economy","volume":"20","author":"WA Braun","year":"2012","journal.title":"Research in sports medicine"},{"key":"ref35","doi.asserted.by":"crossref","first.page":"591","DOI":"10.1055/s-2005-865920","article.title":"Greater muscle damage induced by fast versus slow velocity eccentric exercise","volume":"27","author":"D Chapman","year":"2006","journal.title":"International journal of sports medicine"},{"key":"ref36","doi.asserted.by":"crossref","first.page":"1039","DOI":"10.1152/japplphysiol.01177.2001","article.title":"Energy cost of walking and running at extreme uphill and downhill slopes","volume":"93","author":"AE Minetti","year":"2002","journal.title":"Journal of applied physiology"},{"key":"ref37","doi.asserted.by":"crossref","first.page":"686","DOI":"10.1152/japplphysiol.00642.2012","article.title":"Economy is not sacrificed in ultramarathon runners","volume":"113","author":"GP Millet","year":"2012","journal.title":"Journal of Applied Physiology"},{"key":"ref38","doi.asserted.by":"crossref","first.page":"507","DOI":"10.1152/japplphysiol.00016.2012","article.title":"Sacrificing economy to improve running performance – a reality in the ultramarathon?","volume":"113","author":"GY Millet","year":"2012","journal.title":"Journal of Applied Physiology"},{"key":"ref39","doi.asserted.by":"crossref","first.page":"345","DOI":"10.1007/BF02332962","article.title":"Effect of sleep deprivation on tolerance of prolonged exercise","volume":"47","author":"BJ Martin","year":"1981","journal.title":"European journal of applied physiology and occupational physiology"},{"key":"ref40","doi.asserted.by":"crossref","first.page":"155","DOI":"10.1007/s00421-009-1103-9","article.title":"One night of sleep deprivation decreases treadmill endurance performance","volume":"107","author":"SJ Oliver","year":"2009","journal.title":"European journal of applied physiology"},{"key":"ref41","doi.asserted.by":"crossref","first.page":"580","DOI":"10.1249/00005768-198510000-00011","article.title":"Sleep deprivation, physical fatigue, and the perception of exercise intensity","volume":"17","author":"WS Myles","year":"1985","journal.title":"Medicine and science in sports and exercise"},{"key":"ref42","doi.asserted.by":"crossref","first.page":"983","DOI":"10.1113/jphysiol.2003.056598","article.title":"Leukocytes, cytokines, growth factors and hormones in human skeletal muscle and blood after uphill or downhill running","volume":"556","author":"C Malm","year":"2004","journal.title":"The Journal of physiology"},{"key":"ref43","doi.asserted.by":"crossref","first.page":"89","DOI":"10.1136/bjsm.29.2.89","article.title":"Eccentric activation and muscle damage: biomechanical and physiological considerations during downhill running","volume":"29","author":"RG Eston","year":"1995","journal.title":"British Journal of Sports Medicine"},{"key":"ref44","doi.asserted.by":"crossref","first.page":"264","DOI":"10.1136/bjsm.33.4.264","article.title":"The biochemistry of runners in a 1600 km ultramarathon","volume":"33","author":"KE Fallon","year":"1999","journal.title":"British Journal of Sports Medicine"},{"key":"ref45","doi.asserted.by":"crossref","first.page":"75","DOI":"10.1097/00005768-200301000-00013","article.title":"Human albumin synthesis is increased by an ultra-endurance trial","volume":"35","author":"I Mischler","year":"2003","journal.title":"Medicine and science in sports and exercise"},{"key":"ref46","doi.asserted.by":"crossref","first.page":"477","DOI":"10.1080/02640410701552872","article.title":"Intensity and physiological strain of competitive ultra-endurance exercise in humans","volume":"26","author":"SJ Lucas","year":"2008","journal.title":"Journal of sports sciences"},{"key":"ref47","doi.asserted.by":"crossref","first.page":"457","DOI":"10.1113/jphysiol.1993.sp019645","article.title":"Mechanical factors in the initiation of eccentric contraction-induced injury in rat soleus muscle","volume":"464","author":"GL Warren","year":"1993","journal.title":"The Journal of physiology"},{"key":"ref48","doi.asserted.by":"crossref","first.page":"288","DOI":"10.1080/02640414.2012.729135","article.title":"The effects of eccentric exercise-induced muscle damage on running kinematics at different speeds","volume":"31","author":"T Tsatalas","year":"2013","journal.title":"Journal of sports sciences"},{"key":"ref49","doi.asserted.by":"crossref","first.page":"1565","DOI":"10.1152/japplphysiol.00578.2007","article.title":"Influence of concentric and eccentric resistance training on architectural adaptation in human quadriceps muscles","volume":"103","author":"AJ Blazevich","year":"2007","journal.title":"J Appl Physiol"},{"key":"ref50","doi.asserted.by":"crossref","first.page":"2723","DOI":"10.1007/s00421-011-1894-3","article.title":"Muscle architecture and EMG activity changes during isotonic and isokinetic eccentric exercises","volume":"111","author":"G Guilhem","year":"2011","journal.title":"Eur J Appl Physiol"},{"key":"ref51","doi.asserted.by":"crossref","first.page":"34","DOI":"10.1007/s004210100430","article.title":"The repeated bout effect of reduced-load eccentric exercise on elbow flexor muscle damage","volume":"85","author":"K Nosaka","year":"2001","journal.title":"Eur J Appl Physiol"}],"subject":"General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine"}] 


Go to [Code Beautify](https://codebeautify.org/jsonviewer) and paste the JSON on the left side. Click **Tree Viewer** to view the data. Open the first item to view the metadata. Note especially the last few variables. These are nested lists, as a single article can have multiple authors, and each author has a given name, family name, and sequence of authorship.

To write to JSON, use `jsonlite::write_json()`


```R
# write a JSON file
jsonlite::write_json(plosone_publications_json, "plosone_publications.json")
```

# Using `cr_works()` to get data on articles

`cr_works()` allows you to search by DOI or a general query in order to return the Crossref metadata.

It is important to note, as Crossref does [in the documentation](https://github.com/CrossRef/rest-api-doc/blob/master/demos/crossref-api-demo.ipynb):

&gt; Crossref does not use "works" in the FRBR sense of the word. In Crossref parlance, a "work" is just a thing identified by a DOI. In practice, Crossref DOIs are used as citation identifiers. So, in FRBR terms, this means, that a Crossref DOI tends to refer to one *expression* which might include multiple *manifestations*. So, for example, the ePub, HTML and PDF version of an article will share a Crossref DOI because the differences between them should not effect the interpretation or crediting of the content. In short, they can be cited interchangeably. The same is true of the "accepted manuscript" and the "version-of-record" of that accepted manuscript.


## Searching by DOI

You can pass a DOI directly to `cr_works()` using the `dois` argument:


```R
# Get metadata for a single article by DOI
jlsc_ku_oa <- cr_works(dois = '10.7710/2162-3309.1252') %>%
  purrr::pluck("data")

# print the data frame with select columns
jlsc_ku_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 1 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Campus Open Access Funds: Experiences of the KU “One University” Open
                        Access Author Fund</td><td>10.7710/2162-3309.1252</td><td>3</td><td>1</td><td>1252</td><td>2015-09-18</td><td>http://dx.doi.org/10.7710/2162-3309.1252</td><td>Pacific University Library</td><td>0</td><td>journal-article</td><td>2162-3309</td></tr>
</tbody>
</table>



You can also pass more than one DOI. Here we start by assigning our DOIs to a variable `my_dois`, then pass it to `cr_works()` in the `doi` argument:


```R
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
```


<table>
<caption>A tibble: 7 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Open Access Publishing: A Literature Review                                         </td><td>10.2139/ssrn.2697412          </td><td>NA </td><td>NA  </td><td>NA     </td><td>2014      </td><td>http://dx.doi.org/10.2139/ssrn.2697412          </td><td>Elsevier BV                            </td><td>0  </td><td>journal-article</td><td>1556-5068          </td></tr>
	<tr><td>Hybrid open access—A longitudinal study                                             </td><td>10.1016/j.joi.2016.08.002     </td><td>10 </td><td>4   </td><td>919-932</td><td>2016-11   </td><td>http://dx.doi.org/10.1016/j.joi.2016.08.002     </td><td>Elsevier BV                            </td><td>33 </td><td>journal-article</td><td>1751-1577          </td></tr>
	<tr><td>The Development of Open Access Journal Publishing from 1993 to 2009                 </td><td>10.1371/journal.pone.0020961  </td><td>6  </td><td>6   </td><td>e20961 </td><td>2011-06-13</td><td>http://dx.doi.org/10.1371/journal.pone.0020961  </td><td>Public Library of Science (PLoS)       </td><td>31 </td><td>journal-article</td><td>1932-6203          </td></tr>
	<tr><td>The Impact Factor Fallacy                                                           </td><td>10.3389/fpsyg.2018.01487      </td><td>9  </td><td>NA  </td><td>NA     </td><td>2018-08-20</td><td>http://dx.doi.org/10.3389/fpsyg.2018.01487      </td><td>Frontiers Media SA                     </td><td>52 </td><td>journal-article</td><td>1664-1078          </td></tr>
	<tr><td>Funders should mandate open citations                                               </td><td>10.1038/d41586-018-00104-7    </td><td>553</td><td>7687</td><td>129-129</td><td>2018-01   </td><td>http://dx.doi.org/10.1038/d41586-018-00104-7    </td><td>Springer Science and Business Media LLC</td><td>0  </td><td>journal-article</td><td>0028-0836,1476-4687</td></tr>
	<tr><td>The academic, economic and societal impacts of Open Access: an evidence-based review</td><td>10.12688/f1000research.8460.2 </td><td>5  </td><td>NA  </td><td>632    </td><td>2016-06-09</td><td>http://dx.doi.org/10.12688/f1000research.8460.2 </td><td>F1000 Research Ltd                     </td><td>184</td><td>journal-article</td><td>2046-1402          </td></tr>
	<tr><td>Open Access                                                                         </td><td>10.7551/mitpress/9286.001.0001</td><td>NA </td><td>NA  </td><td>NA     </td><td>2012      </td><td>http://dx.doi.org/10.7551/mitpress/9286.001.0001</td><td>The MIT Press                          </td><td>0  </td><td>book           </td><td>NA                 </td></tr>
</tbody>
</table>



## Unnesting list columns

Authors, links, licenses, funders, and some other values can appear in nested lists when you call `cr_journals` because there can be, and often are, multiple of each of these items per article. You can check the data classes on all variables by running `typeof()` across all columns using the `map_chr()` function from `purrr`:



```R
# query to get data on a specific PLOS article
plos_article <- cr_works(dois = '10.1371/journal.pone.0228782') %>%
  purrr::pluck("data")

# print the type of each column (e.g. character, numeric, logical, list)
purrr::map_chr(plos_article, typeof)
```


<dl class="dl-horizontal">
	<dt>container.title</dt>
		<dd>'character'</dd>
	<dt>created</dt>
		<dd>'character'</dd>
	<dt>deposited</dt>
		<dd>'character'</dd>
	<dt>published.online</dt>
		<dd>'character'</dd>
	<dt>doi</dt>
		<dd>'character'</dd>
	<dt>indexed</dt>
		<dd>'character'</dd>
	<dt>issn</dt>
		<dd>'character'</dd>
	<dt>issue</dt>
		<dd>'character'</dd>
	<dt>issued</dt>
		<dd>'character'</dd>
	<dt>member</dt>
		<dd>'character'</dd>
	<dt>page</dt>
		<dd>'character'</dd>
	<dt>prefix</dt>
		<dd>'character'</dd>
	<dt>publisher</dt>
		<dd>'character'</dd>
	<dt>reference.count</dt>
		<dd>'character'</dd>
	<dt>score</dt>
		<dd>'character'</dd>
	<dt>source</dt>
		<dd>'character'</dd>
	<dt>subject</dt>
		<dd>'character'</dd>
	<dt>title</dt>
		<dd>'character'</dd>
	<dt>type</dt>
		<dd>'character'</dd>
	<dt>update.policy</dt>
		<dd>'character'</dd>
	<dt>url</dt>
		<dd>'character'</dd>
	<dt>volume</dt>
		<dd>'character'</dd>
	<dt>author</dt>
		<dd>'list'</dd>
	<dt>funder</dt>
		<dd>'list'</dd>
	<dt>link</dt>
		<dd>'list'</dd>
	<dt>license</dt>
		<dd>'list'</dd>
	<dt>reference</dt>
		<dd>'list'</dd>
</dl>



Our `plos_article` data frame has a nested list for **author**. We can unnest this column using `unnest()` from the `tidyr` package. The `.drop = TRUE` argument will drop any other list columns.


```R
# unnest author column
plos_article %>%
    tidyr::unnest(author, .drop = TRUE)
```


<table>
<caption>A tibble: 5 x 27</caption>
<thead>
	<tr><th>container.title</th><th>created</th><th>deposited</th><th>published.online</th><th>doi</th><th>indexed</th><th>issn</th><th>issue</th><th>issued</th><th>member</th><th>page</th><th>prefix</th><th>publisher</th><th>reference.count</th><th>score</th><th>source</th><th>subject</th><th>title</th><th>type</th><th>update.policy</th><th>url</th><th>volume</th><th>ORCID</th><th>authenticated.orcid</th><th>given</th><th>family</th><th>sequence</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;lgl&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>http://orcid.org/0000-0001-5870-9336</td><td>TRUE</td><td>Ruonan   </td><td>Jia    </td><td>first     </td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>NA                                  </td><td>  NA</td><td>Ellen    </td><td>Furlong</td><td>additional</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>NA                                  </td><td>  NA</td><td>Sean     </td><td>Gao    </td><td>additional</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>NA                                  </td><td>  NA</td><td>Laurie R.</td><td>Santos </td><td>additional</td></tr>
	<tr><td>PLOS ONE</td><td>2020-03-04</td><td>2020-03-04</td><td>2020-03-04</td><td>10.1371/journal.pone.0228782</td><td>2020-03-04</td><td>1932-6203</td><td>3</td><td>2020-03-04</td><td>340</td><td>e0228782</td><td>10.1371</td><td>Public Library of Science (PLoS)</td><td>73</td><td>1</td><td>Crossref</td><td>General Biochemistry, Genetics and Molecular Biology,General Agricultural and Biological Sciences,General Medicine</td><td>Learning about the Ellsberg Paradox reduces, but does not abolish, ambiguity aversion</td><td>journal-article</td><td>http://dx.doi.org/10.1371/journal.pone.corrections_policy</td><td>http://dx.doi.org/10.1371/journal.pone.0228782</td><td>15</td><td>NA                                  </td><td>  NA</td><td>Ifat     </td><td>Levy   </td><td>additional</td></tr>
</tbody>
</table>



We can see this has added 5 rows and 3 new columns: **given** (first name), **family** (last name), and **sequence** (order in which they appeared).

See https://ciakovx.github.io/rcrossref.html#unnesting_list_columns for more detailed strategies in unnesting nested lists in Crossref. For more details, call `?unnest` and read the [R for Data Science section on Unnesting](https://r4ds.had.co.nz/many-models.html#unnesting).

---
**TRY IT YOURSELF**

1. Refer back to the type of each column above. Try unnesting one of the other list columns. Scroll all the way to the right. What new columns have appeared? Have any rows been duplicated?

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
# do a general query for the term open access and a field query to return results where the author name includes Suber
suber_oa <- cr_works(query = 'open+access', flq = c(`query.author` = 'suber')) %>%
  pluck("data")

# print the data frame with select columns
suber_oa %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 20 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Open access in the USA                                                                               </td><td>10.1016/b978-1-84334-203-8.50015-7</td><td>NA </td><td>NA     </td><td>149-160    </td><td>2006      </td><td>http://dx.doi.org/10.1016/b978-1-84334-203-8.50015-7</td><td>Elsevier                                                  </td><td>0</td><td>book-chapter   </td><td>NA                 </td></tr>
	<tr><td>Gratis Open Access                                                                                   </td><td>10.32388/878441                   </td><td>NA </td><td>NA     </td><td>NA         </td><td>2019-07-22</td><td>http://dx.doi.org/10.32388/878441                   </td><td>Qeios                                                     </td><td>1</td><td>reference-entry</td><td>NA                 </td></tr>
	<tr><td>Open Access                                                                                          </td><td>10.32388/499151                   </td><td>NA </td><td>NA     </td><td>NA         </td><td>2019-07-19</td><td>http://dx.doi.org/10.32388/499151                   </td><td>Qeios                                                     </td><td>1</td><td>reference-entry</td><td>NA                 </td></tr>
	<tr><td>Open Access                                                                                          </td><td>10.7551/mitpress/9286.001.0001    </td><td>NA </td><td>NA     </td><td>NA         </td><td>2012      </td><td>http://dx.doi.org/10.7551/mitpress/9286.001.0001    </td><td>The MIT Press                                             </td><td>0</td><td>book           </td><td>NA                 </td></tr>
	<tr><td>Open Access in 2007                                                                                  </td><td>10.3998/3336451.0011.110          </td><td>11 </td><td>1      </td><td>NA         </td><td>2008-01-30</td><td>http://dx.doi.org/10.3998/3336451.0011.110          </td><td>University of Michigan Library                            </td><td>0</td><td>journal-article</td><td>1080-2711          </td></tr>
	<tr><td>Knowledge Unbound                                                                                    </td><td>10.7551/mitpress/8479.001.0001    </td><td>NA </td><td>NA     </td><td>NA         </td><td>2016      </td><td>http://dx.doi.org/10.7551/mitpress/8479.001.0001    </td><td>The MIT Press                                             </td><td>0</td><td>book           </td><td>NA                 </td></tr>
	<tr><td>Open Access in 2008                                                                                  </td><td>10.3998/3336451.0012.104          </td><td>12 </td><td>1      </td><td>NA         </td><td>2009-02-15</td><td>http://dx.doi.org/10.3998/3336451.0012.104          </td><td>University of Michigan Library                            </td><td>0</td><td>journal-article</td><td>1080-2711          </td></tr>
	<tr><td>Ensuring open access for publicly funded research                                                    </td><td>10.1136/bmj.e5184                 </td><td>345</td><td>aug08 1</td><td>e5184-e5184</td><td>2012-08-08</td><td>http://dx.doi.org/10.1136/bmj.e5184                 </td><td>BMJ                                                       </td><td>0</td><td>journal-article</td><td>1756-1833          </td></tr>
	<tr><td>Promoting Open Access in the Humanities                                                              </td><td>10.1353/syl.2005.0001             </td><td>16 </td><td>1      </td><td>231-246    </td><td>2005      </td><td>http://dx.doi.org/10.1353/syl.2005.0001             </td><td>Project Muse                                              </td><td>0</td><td>journal-article</td><td>2160-5157          </td></tr>
	<tr><td>Open access: other ways                                                                              </td><td>10.1038/426015b                   </td><td>426</td><td>6962   </td><td>15-15      </td><td>2003-11   </td><td>http://dx.doi.org/10.1038/426015b                   </td><td>Springer Science and Business Media LLC                   </td><td>0</td><td>journal-article</td><td>0028-0836,1476-4687</td></tr>
	<tr><td>Open access?                                                                                         </td><td>10.1038/ngeo450                   </td><td>2  </td><td>3      </td><td>155-155    </td><td>2009-03   </td><td>http://dx.doi.org/10.1038/ngeo450                   </td><td>Springer Science and Business Media LLC                   </td><td>1</td><td>journal-article</td><td>1752-0894,1752-0908</td></tr>
	<tr><td>Thoughts on prestige, quality, and open access                                                       </td><td>10.1163/095796510x546959          </td><td>21 </td><td>1-2    </td><td>115-128    </td><td>2010      </td><td>http://dx.doi.org/10.1163/095796510x546959          </td><td>Brill                                                     </td><td>0</td><td>journal-article</td><td>0957-9656,1878-4712</td></tr>
	<tr><td>Open Access to Electronic Theses and Dissertations                                                   </td><td>10.14429/djlit.28.1.149           </td><td>28 </td><td>1      </td><td>25-34      </td><td>2008-01-01</td><td>http://dx.doi.org/10.14429/djlit.28.1.149           </td><td>Defence Scientific Information and Documentation Centre   </td><td>0</td><td>journal-article</td><td>0974-0643,0976-4658</td></tr>
	<tr><td>Open Access and Quality                                                                              </td><td>10.14429/djlit.28.1.152           </td><td>28 </td><td>1      </td><td>49-56      </td><td>2008-01-01</td><td>http://dx.doi.org/10.14429/djlit.28.1.152           </td><td>Defence Scientific Information and Documentation Centre   </td><td>0</td><td>journal-article</td><td>0974-0643,0976-4658</td></tr>
	<tr><td>Open access, impact, and demand                                                                      </td><td>10.1136/bmj.330.7500.1097         </td><td>330</td><td>7500   </td><td>1097-1098  </td><td>2005-05-12</td><td>http://dx.doi.org/10.1136/bmj.330.7500.1097         </td><td>BMJ                                                       </td><td>0</td><td>journal-article</td><td>0959-8138,1468-5833</td></tr>
	<tr><td>SCHOLARLY COMMUNICATION: Removing barriers to research: An introduction to open access for librarians</td><td>10.5860/crln.64.2.92              </td><td>64 </td><td>2      </td><td>92-113     </td><td>2003-02-01</td><td>http://dx.doi.org/10.5860/crln.64.2.92              </td><td>American Library Association                              </td><td>0</td><td>journal-article</td><td>2150-6698,0099-0086</td></tr>
	<tr><td>A living open book                                                                                   </td><td>10.5334/bal.l                     </td><td>NA </td><td>NA     </td><td>113-117    </td><td>2014-11-28</td><td>http://dx.doi.org/10.5334/bal.l                     </td><td>Ubiquity Press                                            </td><td>0</td><td>book-chapter   </td><td>NA                 </td></tr>
	<tr><td>Public access to federally funded research: The Cornyn-Lieberman and CURES bills                     </td><td>10.5860/crln.67.6.7637            </td><td>67 </td><td>6      </td><td>362-365    </td><td>2006-06-01</td><td>http://dx.doi.org/10.5860/crln.67.6.7637            </td><td>American Library Association                              </td><td>0</td><td>journal-article</td><td>2150-6698,0099-0086</td></tr>
	<tr><td>Support for the NIH Public Access Policy                                                             </td><td>10.1126/science.313.5793.1572a    </td><td>313</td><td>5793   </td><td>1572a-1572a</td><td>2006-09-15</td><td>http://dx.doi.org/10.1126/science.313.5793.1572a    </td><td>American Association for the Advancement of Science (AAAS)</td><td>0</td><td>journal-article</td><td>0036-8075,1095-9203</td></tr>
	<tr><td>NSF 19-501 AccelNet Proposal: Community of Open Scholarship Grassroots Networks (COSGN)              </td><td>10.31222/osf.io/d7mwk             </td><td>NA </td><td>NA     </td><td>NA         </td><td>2020-01-30</td><td>http://dx.doi.org/10.31222/osf.io/d7mwk             </td><td>Center for Open Science                                   </td><td>0</td><td>posted-content </td><td>NA                 </td></tr>
</tbody>
</table>



Dr. Suber has written lots of materials that includes the term "open access." We can use the `filter()` function from `dplyr` to look only at books, from the **type** column:


```R
# use filter() from dplyr to filter that result to include only books
suber_oa_books <- suber_oa %>%
  filter(type == "book")

# print the data frame with select columns
suber_oa_books %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 2 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Open Access      </td><td>10.7551/mitpress/9286.001.0001</td><td>NA</td><td>NA</td><td>NA</td><td>2012</td><td>http://dx.doi.org/10.7551/mitpress/9286.001.0001</td><td>The MIT Press</td><td>0</td><td>book</td><td>NA</td></tr>
	<tr><td>Knowledge Unbound</td><td>10.7551/mitpress/8479.001.0001</td><td>NA</td><td>NA</td><td>NA</td><td>2016</td><td>http://dx.doi.org/10.7551/mitpress/8479.001.0001</td><td>The MIT Press</td><td>0</td><td>book</td><td>NA</td></tr>
</tbody>
</table>



One is the book from MIT Press that we're looking for; the other is *Knowledge Unbound*, which is a collection of his writings.

We could be more specific from the outset by adding bibliographic information in `query.bibliographic`, such as ISBN (or ISSN, if it's a journal):


```R
# run a different cr_works() query with author set to Suber and his book's ISBN passed to query.bibliographic
suber_isbn <- cr_works(flq = c(`query.author` = 'suber',
                           `query.bibliographic` = '9780262301732')) %>%
  pluck("data")

# print the data frame with select columns
suber_isbn %>%
  dplyr::select(title, doi, issued, url, publisher, type, author)
```


<table>
<caption>A tibble: 1 x 7</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>issued</th><th>url</th><th>publisher</th><th>type</th><th>author</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;list&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Open Access</td><td>10.7551/mitpress/9286.001.0001</td><td>2012</td><td>http://dx.doi.org/10.7551/mitpress/9286.001.0001</td><td>The MIT Press</td><td>book</td><td>Peter, Suber, first</td></tr>
</tbody>
</table>



You can combine the `filter` argument with `flq` to return only items of **type** `book` published in 2012.

## Getting formatted references in a text file

We can use the `cr_cn()` function from the `rcrossref` package to get the citations to those articles in text form in the style you specify. We'll put it into Chicago. The `cr_cn()` function returns each citation into a list element. We can use the `map_chr` and the `pluck` functions from `purrr` to instead assign them to a character vector. 


```R
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
```


<ol class="list-inline">
	<li>'Frosio, Giancarlo F. “Open Access Publishing: A Literature Review.” SSRN Electronic Journal (2014). doi:10.2139/ssrn.2697412.'</li>
	<li>'Laakso, Mikael, and Bo-Christer Björk. “Hybrid Open access—A Longitudinal Study.” Journal of Informetrics 10, no. 4 (November 2016): 919–932. doi:10.1016/j.joi.2016.08.002.'</li>
	<li>'Laakso, Mikael, Patrik Welling, Helena Bukvova, Linus Nyman, Bo-Christer Björk, and Turid Hedlund. “The Development of Open Access Journal Publishing from 1993 to 2009.” Edited by Marcelo Hermes-Lima. PLoS ONE 6, no. 6 (June 13, 2011): e20961. doi:10.1371/journal.pone.0020961.'</li>
	<li>'Paulus, Frieder M., Nicole Cruz, and Sören Krach. “The Impact Factor Fallacy.” Frontiers in Psychology 9 (August 20, 2018). doi:10.3389/fpsyg.2018.01487.'</li>
	<li>'Shotton, David. “Funders Should Mandate Open Citations.” Nature 553, no. 7687 (January 2018): 129–129. doi:10.1038/d41586-018-00104-7.'</li>
	<li>'Tennant, Jonathan P., François Waldner, Damien C. Jacques, Paola Masuzzo, Lauren B. Collister, and Chris. H. J. Hartgerink. “The Academic, Economic and Societal Impacts of Open Access: An Evidence-Based Review.” F1000Research 5 (June 9, 2016): 632. doi:10.12688/f1000research.8460.2.'</li>
	<li>'Suber, Peter. “Open Access” (2012). doi:10.7551/mitpress/9286.001.0001.'</li>
</ol>



Beautiful formatted citations from simply a list of DOIs! You can then write this to a text file using `writeLines`. 


```R
# write the formatted citations to a text file
writeLines(my_citations, "my_citations_text.txt")
```

The above is helpful if you need to paste the references somewhere, and there are loads of other citation styles included in `rcrossref`--view them by calling `rcrossref::get_styles()` and it will print a vector of these styles to your console. I'll just print the first 15 below:


```R
# look at the first 15 styles Crossref offers
rcrossref::get_styles()[1:15]
```


<ol class="list-inline">
	<li>'academy-of-management-review'</li>
	<li>'accident-analysis-and-prevention'</li>
	<li>'aci-materials-journal'</li>
	<li>'acm-sig-proceedings-long-author-list'</li>
	<li>'acm-sig-proceedings'</li>
	<li>'acm-sigchi-proceedings-extended-abstract-format'</li>
	<li>'acm-sigchi-proceedings'</li>
	<li>'acm-siggraph'</li>
	<li>'acme-an-international-journal-for-critical-geographies'</li>
	<li>'acta-amazonica'</li>
	<li>'acta-anaesthesiologica-scandinavica'</li>
	<li>'acta-anaesthesiologica-taiwanica'</li>
	<li>'acta-botanica-croatica'</li>
	<li>'acta-chiropterologica'</li>
	<li>'acta-chirurgiae-orthopaedicae-et-traumatologiae-cechoslovaca'</li>
</ol>



## Getting formatted references in a BibTeX or RIS file

In addition to a text file, you can also write it to BibTeX or RIS:


```R
# Use cr_cn() to get BibTeX files for my DOIs
my_citations_bibtex <- rcrossref::cr_cn(my_dois, format = "bibtex") %>%
  purrr::map_chr(., purrr::pluck, 1)
```

Write it to a .bib file using `writeLines()`:


```R
# write to bibtex file
writeLines(my_citations_bibtex, "my_citations_bibtex.bib")
```

## Getting works from a typed citation in a Word document/text file

This can be helpful if you have a bibliography in a Word document or text file that you want to get into a reference management tool like Zotero. For instance, you may have written the citations in APA style and need to change to Chicago, but don't want to rekey it all out. Or perhaps you jotted down your citations hastily and left out volume, issue, or page numbers, and you need a nice, fully-formatted citation.

If each citation is on its own line in your document's bibliography, then you can probably paste the whole bibliography into an Excel spreadsheet. If it goes as planned, each citation will be in its own cell. You can then save it to a CSV file, which can then be read into R. 



```R
# read in a CSV file of citations
my_references <- read.csv("references.txt", stringsAsFactors = FALSE, fileEncoding = "ISO 8859-1")

# print the file
my_references
```


<table>
<caption>A data.frame: 8 x 1</caption>
<thead>
	<tr><th>reference</th></tr>
	<tr><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Frosio, G. F. (2014). Open Access Publishing: A Literature Review. SSRN Electronic Journal. https://doi.org/10.2139/ssrn.2697412                                                                                                                                     </td></tr>
	<tr><td><span style="white-space: pre-wrap;">Laakso, M., &amp; Bjork, B.-C. (2016). Hybrid open access: A longitudinal study. Journal of Informetrics, 10(4), 919-932. https://doi.org/10.1016/j.joi.2016.08.002                                                                                                      </span></td></tr>
	<tr><td><span style="white-space: pre-wrap;">Laakso, M., Welling, P., Bukvova, H., Nyman, L., Bjork, B.-C., &amp; Hedlund, T. (2011). The Development of Open Access Journal Publishing from 1993 to 2009. PLoS ONE, 6(6), e20961. https://doi.org/10.1371/journal.pone.0020961                                       </span></td></tr>
	<tr><td><span style="white-space: pre-wrap;">Paulus, F. M., Cruz, N., &amp; Krach, S. (2018). The Impact Factor Fallacy. Frontiers in Psychology, 9. https://doi.org/10.3389/fpsyg.2018.01487                                                                                                                         </span></td></tr>
	<tr><td>Science, Digital; Hook, Daniel; Hahnel, Mark; Calvert, Ian (2019): The Ascent of Open Access. figshare. Journal contribution. https://doi.org/10.6084/m9.figshare.7618751                                                                                            </td></tr>
	<tr><td>Shotton, D. (2018). Funders should mandate open citations. Nature, 553(7687), 129-129. https://doi.org/10.1038/d41586-018-00104-7                                                                                                                                    </td></tr>
	<tr><td>Suber, P. (2012). Open access. Cambridge, Mass: MIT Press.                                                                                                                                                                                                           </td></tr>
	<tr><td>Tennant, J. P., Waldner, F., Jacques, D. C., Masuzzo, P., Collister, L. B., &amp; Hartgerink, C. H. J. (2016). The academic, economic and societal impacts of Open Access: an evidence-based review. F1000Research, 5, 632. https://doi.org/10.12688/f1000research.8460.2</td></tr>
</tbody>
</table>



As you can see, these are just raw citations, not divided into variables by their metadata elements (that is, with title in one column, author in another, etc.). But, we can now run a query to get precisely that from Crossref using `cr_works`. Because `cr_works` is not vectorized, we will need to build a loop using `map()` from the `purrr` package. 

Don't mind the technical details--it is basically saying to take each row and look it up in the Crossref search engine. Basically, this is the equivalent of copy/pasting the whole reference into the Crossref search engine. The loop will `print()` the citation before searching for it so we can keep track of where it is. We set the `limit` to 5 because if Crossref didn't find it in the first 5 results, it's not likely to be there at all.


```R
# loop through the references column, using cr_works() to look the item up and return the top 5 hits
my_references_works_list <- purrr::map(
  my_references$reference,
  function(x) {
    print(x)
    my_works <- rcrossref::cr_works(query = x, limit = 5) %>%
      purrr::pluck("data")
  })
```

    [1] "Frosio, G. F. (2014). Open Access Publishing: A Literature Review. SSRN Electronic Journal. https://doi.org/10.2139/ssrn.2697412"
    [1] "Laakso, M., & Bjork, B.-C. (2016). Hybrid open access: A longitudinal study. Journal of Informetrics, 10(4), 919-932. https://doi.org/10.1016/j.joi.2016.08.002"
    [1] "Laakso, M., Welling, P., Bukvova, H., Nyman, L., Bjork, B.-C., & Hedlund, T. (2011). The Development of Open Access Journal Publishing from 1993 to 2009. PLoS ONE, 6(6), e20961. https://doi.org/10.1371/journal.pone.0020961"
    [1] "Paulus, F. M., Cruz, N., & Krach, S. (2018). The Impact Factor Fallacy. Frontiers in Psychology, 9. https://doi.org/10.3389/fpsyg.2018.01487"
    [1] "Science, Digital; Hook, Daniel; Hahnel, Mark; Calvert, Ian (2019): The Ascent of Open Access. figshare. Journal contribution. https://doi.org/10.6084/m9.figshare.7618751"
    [1] "Shotton, D. (2018). Funders should mandate open citations. Nature, 553(7687), 129-129. https://doi.org/10.1038/d41586-018-00104-7"
    [1] "Suber, P. (2012). Open access. Cambridge, Mass: MIT Press."
    [1] "Tennant, J. P., Waldner, F., Jacques, D. C., Masuzzo, P., Collister, L. B., & Hartgerink, C. H. J. (2016). The academic, economic and societal impacts of Open Access: an evidence-based review. F1000Research, 5, 632. https://doi.org/10.12688/f1000research.8460.2"


The Crossref API assigns a score to each item returned within each query, giving a measure of the API's confidence in the match. The item with the highest score is returned first in the datasets. We can return the first result in each item in the `my_references_works_list` by using `map_dfr()`, which is like `map()` except it returns the results into a data frame rather than a list:


```R
# for each reference looked up, get back the first result
my_references_works_df <- my_references_works_list %>%
  purrr::map_dfr(., function(x) {
    x[1, ]
  })

# print the data frame with select columns
my_references_works_df %>%
  dplyr::select(title, doi, volume, issue, page, issued, url, publisher, reference.count, type, issn)
```


<table>
<caption>A tibble: 8 x 11</caption>
<thead>
	<tr><th>title</th><th>doi</th><th>volume</th><th>issue</th><th>page</th><th>issued</th><th>url</th><th>publisher</th><th>reference.count</th><th>type</th><th>issn</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Open Access Publishing: A Literature Review                                                                                                                                       </td><td>10.2139/ssrn.2697412         </td><td>NA </td><td>NA  </td><td>NA     </td><td>2014      </td><td>http://dx.doi.org/10.2139/ssrn.2697412         </td><td>Elsevier BV                            </td><td>0  </td><td>journal-article</td><td>1556-5068          </td></tr>
	<tr><td>Hybrid open access—A longitudinal study                                                                                                                                           </td><td>10.1016/j.joi.2016.08.002    </td><td>10 </td><td>4   </td><td>919-932</td><td>2016-11   </td><td>http://dx.doi.org/10.1016/j.joi.2016.08.002    </td><td>Elsevier BV                            </td><td>33 </td><td>journal-article</td><td>1751-1577          </td></tr>
	<tr><td>The Development of Open Access Journal Publishing from 1993 to 2009                                                                                                               </td><td>10.1371/journal.pone.0020961 </td><td>6  </td><td>6   </td><td>e20961 </td><td>2011-06-13</td><td>http://dx.doi.org/10.1371/journal.pone.0020961 </td><td>Public Library of Science (PLoS)       </td><td>31 </td><td>journal-article</td><td>1932-6203          </td></tr>
	<tr><td>The Impact Factor Fallacy                                                                                                                                                         </td><td>10.3389/fpsyg.2018.01487     </td><td>9  </td><td>NA  </td><td>NA     </td><td>2018-08-20</td><td>http://dx.doi.org/10.3389/fpsyg.2018.01487     </td><td>Frontiers Media SA                     </td><td>52 </td><td>journal-article</td><td>1664-1078          </td></tr>
	<tr><td>Table S1: Digital copies of visualizations, alignments, and phylogenetic trees deposited at Figshare (also accessible under Figshare Collection doi:10.6084/m9.figshare.c.3521787)</td><td>10.7717/peerj.2951/supp-3    </td><td>NA </td><td>NA  </td><td>NA     </td><td>NA        </td><td>http://dx.doi.org/10.7717/peerj.2951/supp-3    </td><td>PeerJ                                  </td><td>0  </td><td>component      </td><td>NA                 </td></tr>
	<tr><td>Funders should mandate open citations                                                                                                                                             </td><td>10.1038/d41586-018-00104-7   </td><td>553</td><td>7687</td><td>129-129</td><td>2018-01   </td><td>http://dx.doi.org/10.1038/d41586-018-00104-7   </td><td>Springer Science and Business Media LLC</td><td>0  </td><td>journal-article</td><td>0028-0836,1476-4687</td></tr>
	<tr><td>Open Access by Peter Suber. MIT Press, Cambridge, MA, U.S.A., 2012. 230 pp. ISBN: 978-0- 262-51763-8                                                                              </td><td>10.1162/leon_r_00535         </td><td>46 </td><td>2   </td><td>180-181</td><td>2013-04   </td><td>http://dx.doi.org/10.1162/leon_r_00535         </td><td>MIT Press - Journals                   </td><td>3  </td><td>journal-article</td><td>0024-094X,1530-9282</td></tr>
	<tr><td>The academic, economic and societal impacts of Open Access: an evidence-based review                                                                                              </td><td>10.12688/f1000research.8460.1</td><td>5  </td><td>NA  </td><td>632    </td><td>2016-04-11</td><td>http://dx.doi.org/10.12688/f1000research.8460.1</td><td>F1000 Research Ltd                     </td><td>137</td><td>journal-article</td><td>2046-1402          </td></tr>
</tbody>
</table>



We can print just the titles to quickly see how well they match with the titles of the works we requested:


```R
# print the title column
my_references_works_df$title
```


<ol class="list-inline">
	<li>'Open Access Publishing: A Literature Review'</li>
	<li>'Hybrid open access—A longitudinal study'</li>
	<li>'The Development of Open Access Journal Publishing from 1993 to 2009'</li>
	<li>'The Impact Factor Fallacy'</li>
	<li>'Table S1: Digital copies of visualizations, alignments, and phylogenetic trees deposited at Figshare (also accessible under Figshare Collection doi:10.6084/m9.figshare.c.3521787)'</li>
	<li>'Funders should mandate open citations'</li>
	<li>'Open Access by Peter Suber. MIT Press, Cambridge, MA, U.S.A., 2012. 230 pp. ISBN: 978-0- 262-51763-8'</li>
	<li>'The academic, economic and societal impacts of Open Access: an evidence-based review'</li>
</ol>



Not bad! Looks like we got 6 out of 8, with problems on number 5 and 7. To see more about how to troubleshoot those two, go to https://ciakovx.github.io/rcrossref.html#getting_works_from_a_typed_citation_in_a_word_documenttext_file

## Writing publications to CSV

We will use the `write.csv()` function to write our data to disk as a CSV file. 


```R
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
```

Unfortunately, you cannot simply write the `plosone_publications` data frame to a CSV, due to the nested lists. It will throw an error: `"Error in stream_delim_(df, path, ...) : Don't know how to handle vector of type list."`

I run through three solutions at https://ciakovx.github.io/rcrossref.html#writing_publications_to_disk

Here, we will use solution 3: You can use `mutate()` from `dplyr` to coerce the list columns into character vectors with `as.character()`.

First, identify the list vectors:


```R
# use map_chr to print the column types
purrr::map_chr(my_dois_works, typeof)
```


<dl class="dl-horizontal">
	<dt>container.title</dt>
		<dd>'character'</dd>
	<dt>created</dt>
		<dd>'character'</dd>
	<dt>deposited</dt>
		<dd>'character'</dd>
	<dt>doi</dt>
		<dd>'character'</dd>
	<dt>indexed</dt>
		<dd>'character'</dd>
	<dt>issn</dt>
		<dd>'character'</dd>
	<dt>issued</dt>
		<dd>'character'</dd>
	<dt>member</dt>
		<dd>'character'</dd>
	<dt>prefix</dt>
		<dd>'character'</dd>
	<dt>publisher</dt>
		<dd>'character'</dd>
	<dt>reference.count</dt>
		<dd>'character'</dd>
	<dt>score</dt>
		<dd>'character'</dd>
	<dt>source</dt>
		<dd>'character'</dd>
	<dt>title</dt>
		<dd>'character'</dd>
	<dt>type</dt>
		<dd>'character'</dd>
	<dt>url</dt>
		<dd>'character'</dd>
	<dt>author</dt>
		<dd>'list'</dd>
	<dt>alternative.id</dt>
		<dd>'character'</dd>
	<dt>published.print</dt>
		<dd>'character'</dd>
	<dt>issue</dt>
		<dd>'character'</dd>
	<dt>page</dt>
		<dd>'character'</dd>
	<dt>update.policy</dt>
		<dd>'character'</dd>
	<dt>volume</dt>
		<dd>'character'</dd>
	<dt>assertion</dt>
		<dd>'list'</dd>
	<dt>link</dt>
		<dd>'list'</dd>
	<dt>license</dt>
		<dd>'list'</dd>
	<dt>published.online</dt>
		<dd>'character'</dd>
	<dt>reference</dt>
		<dd>'list'</dd>
	<dt>subject</dt>
		<dd>'character'</dd>
	<dt>abstract</dt>
		<dd>'character'</dd>
	<dt>isbn</dt>
		<dd>'character'</dd>
</dl>



For any variables that are type `list`, coerce those columns to character:


```R
# use mutate() to coerce list columns to character vectors
my_dois_mutated <- my_dois_works %>%
  dplyr::mutate(author = as.character(author)) %>%
  dplyr::mutate(assertion = as.character(assertion)) %>%
  dplyr::mutate(link = as.character(link)) %>%
  dplyr::mutate(license = as.character(license)) %>%
  dplyr::mutate(reference = as.character(reference))
write.csv(my_dois_mutated, "my_dois_mutated.csv")
```

Again, this is not an ideal solution, but if you need to move the data into CSV to view in Excel, it can do the trick.

# Using `roadoi` to check for open access

`roadoi` was developed by Najko Jahn, with reviews from Tuija Sonkkila and Ross Mounce. It interfaces with [Unpaywall](https://unpaywall.org) (which used to be called oaDOI), an important tool developed by [ImpactStory](http://unpaywall.org/team) (Heather Piwowar and Jason Priem) for locating open access versions of scholarship--read more in this [*Nature* article](https://www.nature.com/articles/d41586-018-05968-3). See here for [the `roadoi` documentation](https://cran.r-project.org/web/packages/roadoi/roadoi.pdf).

This incredible [Introduction to `roadoi`](https://cran.r-project.org/web/packages/roadoi/vignettes/intro.html) by Najko Jahn provides much of what you need to know to use the tool, as well as an interesting use case. Also see his recently published article [Open Access Evidence in Unpaywall](https://subugoe.github.io/scholcomm_analytics/posts/unpaywall_evidence/), running deep analysis on Unpaywall data.

First install the package and load it.



```R
# install the roadoi package
install.packages("roadoi")
```

    Installing package into ‘/home/nbuser/R’
    (as ‘lib’ is unspecified)



```R
# load the roadoi package
library(roadoi)
```

## Setting up `roadoi`

Your API calls to Unpaywall must include a valid email address where you can be reached in order to keep the service open and free for everyone. 

## Checking OA status with `oadoi_fetch`

We then create DOI vector and use the `oadoi_fetch()` function from `roadoi`. 

**Be sure to replace the email below with your own**


```R
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
```

Look at the column names.


```R
# print column names
names(my_dois_oa)
```


<ol class="list-inline">
	<li>'doi'</li>
	<li>'best_oa_location'</li>
	<li>'oa_locations'</li>
	<li>'data_standard'</li>
	<li>'is_oa'</li>
	<li>'genre'</li>
	<li>'oa_status'</li>
	<li>'has_repository_copy'</li>
	<li>'journal_is_oa'</li>
	<li>'journal_is_in_doaj'</li>
	<li>'journal_issns'</li>
	<li>'journal_issn_l'</li>
	<li>'journal_name'</li>
	<li>'publisher'</li>
	<li>'title'</li>
	<li>'year'</li>
	<li>'updated'</li>
	<li>'authors'</li>
</ol>



The returned variables are described on the [Unpaywall Data Format](http://unpaywall.org/data-format) page.

We can see that Unpaywall could not find OA versions for two of the seven of these, so we will filter them out:


```R
# use filter() to overwrite the data frame and keep only items that are available OA
my_dois_oa <- my_dois_oa %>%
  dplyr::filter(is_oa == TRUE)
```

As above, it is easier to use `unnest()` to more closely view one of the variables:


```R
# print the data frame with best open access location unnested
my_dois_oa %>%
    tidyr::unnest(best_oa_location)
```


<table>
<caption>A tibble: 6 x 29</caption>
<thead>
	<tr><th>doi</th><th>oa_locations</th><th>data_standard</th><th>is_oa</th><th>genre</th><th>oa_status</th><th>has_repository_copy</th><th>journal_is_oa</th><th>journal_is_in_doaj</th><th>journal_issns</th><th>journal_issn_l</th><th>journal_name</th><th>publisher</th><th>title</th><th>year</th><th>updated</th><th>authors</th><th>endpoint_id</th><th>evidence</th><th>host_type</th><th>is_best</th><th>license</th><th>pmh_id</th><th>repository_institution</th><th>updated1</th><th>url</th><th>url_for_landing_page</th><th>url_for_pdf</th><th>version</th></tr>
	<tr><th>&lt;chr&gt;</th><th>&lt;list&gt;</th><th>&lt;int&gt;</th><th>&lt;lgl&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;lgl&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;list&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;lgl&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th><th>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>10.2139/ssrn.2697412         </td><td>kmlgamtfmx4w6tf78ykl                                                         , NA                                                                           , oa repository (via OAI-PMH title and first author match)                     , oa repository (semantic scholar lookup)                                      , repository                                                                   , repository                                                                   , TRUE                                                                         , FALSE                                                                        , cc-by                                                                        , NA                                                                           , oai:zenodo.org:8381                                                          , NA                                                                           , CERN European Organization for Nuclear Research - Zenodo                     , NA                                                                           , 2019-11-21T02:00:14.479076                                                   , 2019-10-01T00:00:00                                                          , https://zenodo.org/record/8381/files/CREATe-Working-Paper-2014-01.pdf        , http://pdfs.semanticscholar.org/a26e/76b34730effa24dab8fa278465553c0cdf98.pdf, https://zenodo.org/record/8381                                               , https://semanticscholar.org/paper/a26e76b34730effa24dab8fa278465553c0cdf98   , https://zenodo.org/record/8381/files/CREATe-Working-Paper-2014-01.pdf        , http://pdfs.semanticscholar.org/a26e/76b34730effa24dab8fa278465553c0cdf98.pdf, publishedVersion                                                             , submittedVersion                                                             </td><td>2</td><td>TRUE</td><td>journal-article</td><td>green </td><td> TRUE</td><td>FALSE</td><td>FALSE</td><td>1556-5068          </td><td>1556-5068</td><td>SSRN Electronic Journal</td><td>Elsevier BV                            </td><td>Open Access Publishing: A Literature Review                                         </td><td>2014</td><td>2020-02-06T10:15:13.003631</td><td>Frosio      , Giancarlo F.</td><td>kmlgamtfmx4w6tf78ykl</td><td>oa repository (via OAI-PMH title and first author match)</td><td>repository</td><td>TRUE</td><td>cc-by</td><td>oai:zenodo.org:8381</td><td>CERN European Organization for Nuclear Research - Zenodo</td><td>2019-11-21T02:00:14.479076</td><td>https://zenodo.org/record/8381/files/CREATe-Working-Paper-2014-01.pdf                        </td><td>https://zenodo.org/record/8381               </td><td>https://zenodo.org/record/8381/files/CREATe-Working-Paper-2014-01.pdf                        </td><td>publishedVersion</td></tr>
	<tr><td>10.1016/j.joi.2016.08.002    </td><td>NA                                       , open (via crossref license)              , publisher                                , TRUE                                     , cc-by                                    , NA                                       , NA                                       , 2020-03-08T17:25:36.368594               , https://doi.org/10.1016/j.joi.2016.08.002, https://doi.org/10.1016/j.joi.2016.08.002, NA                                       , publishedVersion                         </td><td>2</td><td>TRUE</td><td>journal-article</td><td>hybrid</td><td>FALSE</td><td>FALSE</td><td>FALSE</td><td>1751-1577          </td><td>1751-1577</td><td>Journal of Informetrics</td><td>Elsevier BV                            </td><td>Hybrid open access—A longitudinal study                                             </td><td>2016</td><td>2020-02-07T21:11:02.775326</td><td>http://orcid.org/0000-0003-3951-7990, http://orcid.org/0000-0003-1545-9642, FALSE                               , FALSE                               , Laakso                              , Björk                               , Mikael                              , Bo-Christer                         </td><td>NA                  </td><td>open (via crossref license)                             </td><td>publisher </td><td>TRUE</td><td>cc-by</td><td>NA                 </td><td>NA                                                      </td><td>2020-03-08T17:25:36.368594</td><td>https://doi.org/10.1016/j.joi.2016.08.002                                                    </td><td>https://doi.org/10.1016/j.joi.2016.08.002    </td><td>NA                                                                                           </td><td>publishedVersion</td></tr>
	<tr><td>10.1371/journal.pone.0020961 </td><td><span style="white-space: pre-wrap;">NA                                                                                           , NA                                                                                           , pubmedcentral.nih.gov                                                                        , NA                                                                                           , NA                                                                                           , open (via page says license)                                                                 , oa journal (via doaj)                                                                        , oa repository (via OAI-PMH doi match)                                                        , oa repository (via pmcid lookup)                                                             , oa repository (semantic scholar lookup)                                                      , publisher                                                                                    , publisher                                                                                    , repository                                                                                   , repository                                                                                   , repository                                                                                   , TRUE                                                                                         , FALSE                                                                                        , FALSE                                                                                        , FALSE                                                                                        , FALSE                                                                                        , cc-by                                                                                        , cc-by                                                                                        , implied-oa                                                                                   , NA                                                                                           , NA                                                                                           , NA                                                                                           , NA                                                                                           , oai:pubmedcentral.nih.gov:3113847                                                            , NA                                                                                           , NA                                                                                           , NA                                                                                           , NA                                                                                           , pubmedcentral.nih.gov                                                                        , NA                                                                                           , NA                                                                                           , 2018-09-26T18:32:55.188635                                                                   , 2020-03-08T17:25:36.653131                                                                   , 2017-10-22T12:50:17.733660                                                                   , 2020-03-08T17:25:36.653256                                                                   , 2019-10-01T00:00:00                                                                          , https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0020961&amp;type=printable, https://doi.org/10.1371/journal.pone.0020961                                                 , http://europepmc.org/articles/pmc3113847?pdf=render                                          , https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3113847                                         , http://pdfs.semanticscholar.org/066e/b2ec4d41fb27ac7a0403f3a86b098c3e8238.pdf                , https://doi.org/10.1371/journal.pone.0020961                                                 , https://doi.org/10.1371/journal.pone.0020961                                                 , http://europepmc.org/articles/pmc3113847                                                     , https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3113847                                         , https://semanticscholar.org/paper/066eb2ec4d41fb27ac7a0403f3a86b098c3e8238                   , https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0020961&amp;type=printable, NA                                                                                           , http://europepmc.org/articles/pmc3113847?pdf=render                                          , NA                                                                                           , http://pdfs.semanticscholar.org/066e/b2ec4d41fb27ac7a0403f3a86b098c3e8238.pdf                , publishedVersion                                                                             , publishedVersion                                                                             , publishedVersion                                                                             , publishedVersion                                                                             , submittedVersion                                                                             </span></td><td>2</td><td>TRUE</td><td>journal-article</td><td><span style="white-space: pre-wrap;">gold  </span></td><td> TRUE</td><td> TRUE</td><td> TRUE</td><td><span style="white-space: pre-wrap;">1932-6203          </span></td><td>1932-6203</td><td><span style="white-space: pre-wrap;">PLoS ONE               </span></td><td><span style="white-space: pre-wrap;">Public Library of Science (PLoS)       </span></td><td><span style="white-space: pre-wrap;">The Development of Open Access Journal Publishing from 1993 to 2009                 </span></td><td>2011</td><td>2020-02-04T16:37:55.660994</td><td><span style="white-space: pre-wrap;">Laakso     , Welling    , Bukvova    , Nyman      , Björk      , Hedlund    , Mikael     , Patrik     , Helena     , Linus      , Bo-Christer, Turid      , first      , additional , additional , additional , additional , additional </span></td><td><span style="white-space: pre-wrap;">NA                  </span></td><td><span style="white-space: pre-wrap;">open (via page says license)                            </span></td><td>publisher </td><td>TRUE</td><td>cc-by</td><td><span style="white-space: pre-wrap;">NA                 </span></td><td><span style="white-space: pre-wrap;">NA                                                      </span></td><td>2018-09-26T18:32:55.188635</td><td>https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0020961&amp;type=printable</td><td>https://doi.org/10.1371/journal.pone.0020961 </td><td>https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0020961&amp;type=printable</td><td>publishedVersion</td></tr>
	<tr><td>10.3389/fpsyg.2018.01487     </td><td>NA                                                                             , NA                                                                             , NA                                                                             , 319be07214511446630                                                            , NA                                                                             , open (via page says license)                                                   , oa journal (via doaj)                                                          , oa repository (via pmcid lookup)                                               , oa repository (via OAI-PMH doi match)                                          , oa repository (semantic scholar lookup)                                        , publisher                                                                      , publisher                                                                      , repository                                                                     , repository                                                                     , repository                                                                     , TRUE                                                                           , FALSE                                                                          , FALSE                                                                          , FALSE                                                                          , FALSE                                                                          , cc-by                                                                          , cc-by                                                                          , NA                                                                             , cc-by                                                                          , NA                                                                             , NA                                                                             , NA                                                                             , NA                                                                             , oai:eprints.bbk.ac.uk.oai2:23967                                               , NA                                                                             , NA                                                                             , NA                                                                             , NA                                                                             , Birkbeck, University of London - BIROn - Birkbeck Institutional Research Online, NA                                                                             , 2019-11-09T20:20:21.096918                                                     , 2020-03-08T17:25:36.922865                                                     , 2020-03-08T17:25:36.922996                                                     , 2020-03-02T03:24:49.468453                                                     , 2019-10-01T00:00:00                                                            , https://www.frontiersin.org/articles/10.3389/fpsyg.2018.01487/pdf              , https://doi.org/10.3389/fpsyg.2018.01487                                       , https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6109637                           , https://eprints.bbk.ac.uk/23967/1/23967.pdf                                    , http://pdfs.semanticscholar.org/fc82/2399aa6a22352085179b6505db893be13820.pdf  , https://doi.org/10.3389/fpsyg.2018.01487                                       , https://doi.org/10.3389/fpsyg.2018.01487                                       , https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6109637                           , https://eprints.bbk.ac.uk/23967/1/23967.pdf                                    , https://semanticscholar.org/paper/fc822399aa6a22352085179b6505db893be13820     , https://www.frontiersin.org/articles/10.3389/fpsyg.2018.01487/pdf              , NA                                                                             , NA                                                                             , https://eprints.bbk.ac.uk/23967/1/23967.pdf                                    , http://pdfs.semanticscholar.org/fc82/2399aa6a22352085179b6505db893be13820.pdf  , publishedVersion                                                               , publishedVersion                                                               , publishedVersion                                                               , acceptedVersion                                                                , submittedVersion                                                               </td><td>2</td><td>TRUE</td><td>journal-article</td><td>gold  </td><td> TRUE</td><td> TRUE</td><td> TRUE</td><td>1664-1078          </td><td>1664-1078</td><td>Frontiers in Psychology</td><td>Frontiers Media SA                     </td><td>The Impact Factor Fallacy                                                           </td><td>2018</td><td>2020-02-04T08:31:45.023735</td><td>Paulus    , Cruz      , Krach     , Frieder M., Nicole    , Sören     , first     , additional, additional</td><td>NA                  </td><td>open (via page says license)                            </td><td>publisher </td><td>TRUE</td><td>cc-by</td><td>NA                 </td><td>NA                                                      </td><td>2019-11-09T20:20:21.096918</td><td>https://www.frontiersin.org/articles/10.3389/fpsyg.2018.01487/pdf                            </td><td>https://doi.org/10.3389/fpsyg.2018.01487     </td><td>https://www.frontiersin.org/articles/10.3389/fpsyg.2018.01487/pdf                            </td><td>publishedVersion</td></tr>
	<tr><td>10.1038/d41586-018-00104-7   </td><td>NA                                                                              , open (via free pdf)                                                             , publisher                                                                       , TRUE                                                                            , pd                                                                              , NA                                                                              , NA                                                                              , 2019-12-23T19:38:29.249435                                                      , https://www.nature.com/magazine-assets/d41586-018-00104-7/d41586-018-00104-7.pdf, https://doi.org/10.1038/d41586-018-00104-7                                      , https://www.nature.com/magazine-assets/d41586-018-00104-7/d41586-018-00104-7.pdf, publishedVersion                                                                </td><td>2</td><td>TRUE</td><td>journal-article</td><td>hybrid</td><td>FALSE</td><td>FALSE</td><td>FALSE</td><td>0028-0836,1476-4687</td><td>0028-0836</td><td>Nature                 </td><td>Springer Science and Business Media LLC</td><td>Funders should mandate open citations                                               </td><td>2018</td><td>2020-02-27T21:47:08.667168</td><td>Shotton, David  , first  </td><td>NA                  </td><td>open (via free pdf)                                     </td><td>publisher </td><td>TRUE</td><td>pd   </td><td>NA                 </td><td>NA                                                      </td><td>2019-12-23T19:38:29.249435</td><td>https://www.nature.com/magazine-assets/d41586-018-00104-7/d41586-018-00104-7.pdf             </td><td>https://doi.org/10.1038/d41586-018-00104-7   </td><td>https://www.nature.com/magazine-assets/d41586-018-00104-7/d41586-018-00104-7.pdf             </td><td>publishedVersion</td></tr>
	<tr><td>10.12688/f1000research.8460.2</td><td>NA                                                                                                                , NA                                                                                                                , ac9de7698155b820de7                                                                                               , 4665ee5debdab1923cc                                                                                               , lxsakd8rfmjytb469mcw                                                                                              , lxsakd8rfmjytb469mcw                                                                                              , NA                                                                                                                , open (via page says license)                                                                                      , oa journal (via doaj)                                                                                             , oa repository (via OAI-PMH title and first author match)                                                          , oa repository (via OAI-PMH title and first author match)                                                          , oa repository (via OAI-PMH doi match)                                                                             , oa repository (via OAI-PMH title and first author match)                                                          , oa repository (semantic scholar lookup)                                                                           , publisher                                                                                                         , publisher                                                                                                         , repository                                                                                                        , repository                                                                                                        , repository                                                                                                        , repository                                                                                                        , repository                                                                                                        , TRUE                                                                                                              , FALSE                                                                                                             , FALSE                                                                                                             , FALSE                                                                                                             , FALSE                                                                                                             , FALSE                                                                                                             , FALSE                                                                                                             , cc-by                                                                                                             , cc-by                                                                                                             , cc-by                                                                                                             , cc-by                                                                                                             , cc-by                                                                                                             , cc-by                                                                                                             , NA                                                                                                                , NA                                                                                                                , NA                                                                                                                , oai:pubmedcentral.nih.gov:4837983                                                                                 , oai:spiral.imperial.ac.uk:10044/1/31023                                                                           , oai:d-scholarship.pitt.edu:28179                                                                                  , oai:d-scholarship.pitt.edu:29598                                                                                  , NA                                                                                                                , NA                                                                                                                , NA                                                                                                                , National Institutes of Health (USA) - US National Library of Medicine                                             , Imperial College London - Spiral                                                                                  , University of Pittsburgh - D-Scholarship@Pitt                                                                     , University of Pittsburgh - D-Scholarship@Pitt                                                                     , NA                                                                                                                , 2020-01-18T08:07:52.322656                                                                                        , 2020-03-08T17:25:37.457111                                                                                        , 2019-08-17T14:09:21.205573                                                                                        , 2020-03-05T07:12:49.811348                                                                                        , 2020-03-05T20:21:10.853063                                                                                        , 2020-03-05T20:24:30.279043                                                                                        , 2019-10-01T00:00:00                                                                                               , https://f1000research.com/articles/5-632/v2/pdf                                                                   , https://doi.org/10.12688/f1000research.8460.2                                                                     , http://europepmc.org/articles/pmc4837983?pdf=render                                                               , http://spiral.imperial.ac.uk/bitstream/10044/1/31023/6/8450723b-d4ee-47bc-b462-7578f368d0db_8460_-_jon_tennant.pdf, http://d-scholarship.pitt.edu/28179/1/tennant_et_al-ImpactsofOpenAccess.pdf                                       , http://d-scholarship.pitt.edu/29598/1/tennant-et-al-academic-economic-societal-impacts-open-access.pdf            , http://pdfs.semanticscholar.org/547f/b02be822ee011cd006f9d37034c13de2ac0d.pdf                                     , https://doi.org/10.12688/f1000research.8460.2                                                                     , https://doi.org/10.12688/f1000research.8460.2                                                                     , http://europepmc.org/articles/pmc4837983                                                                          , http://hdl.handle.net/10044/1/31023                                                                               , http://d-scholarship.pitt.edu/28179/1/tennant_et_al-ImpactsofOpenAccess.pdf                                       , http://d-scholarship.pitt.edu/29598/1/tennant-et-al-academic-economic-societal-impacts-open-access.pdf            , https://semanticscholar.org/paper/547fb02be822ee011cd006f9d37034c13de2ac0d                                        , https://f1000research.com/articles/5-632/v2/pdf                                                                   , NA                                                                                                                , http://europepmc.org/articles/pmc4837983?pdf=render                                                               , http://spiral.imperial.ac.uk/bitstream/10044/1/31023/6/8450723b-d4ee-47bc-b462-7578f368d0db_8460_-_jon_tennant.pdf, http://d-scholarship.pitt.edu/28179/1/tennant_et_al-ImpactsofOpenAccess.pdf                                       , http://d-scholarship.pitt.edu/29598/1/tennant-et-al-academic-economic-societal-impacts-open-access.pdf            , http://pdfs.semanticscholar.org/547f/b02be822ee011cd006f9d37034c13de2ac0d.pdf                                     , publishedVersion                                                                                                  , publishedVersion                                                                                                  , publishedVersion                                                                                                  , publishedVersion                                                                                                  , acceptedVersion                                                                                                   , acceptedVersion                                                                                                   , submittedVersion                                                                                                  </td><td>2</td><td>TRUE</td><td>journal-article</td><td>gold  </td><td> TRUE</td><td> TRUE</td><td> TRUE</td><td>2046-1402          </td><td>2046-1402</td><td>F1000Research          </td><td>F1000 Research, Ltd.                   </td><td>The academic, economic and societal impacts of Open Access: an evidence-based review</td><td>2016</td><td>2020-02-10T18:08:53.064028</td><td>Tennant     , Waldner     , Jacques     , Masuzzo     , Collister   , Hartgerink  , Jonathan P. , François    , Damien C.   , Paola       , Lauren B.   , Chris. H. J.</td><td>NA                  </td><td>open (via page says license)                            </td><td>publisher </td><td>TRUE</td><td>cc-by</td><td>NA                 </td><td>NA                                                      </td><td>2020-01-18T08:07:52.322656</td><td>https://f1000research.com/articles/5-632/v2/pdf                                              </td><td>https://doi.org/10.12688/f1000research.8460.2</td><td>https://f1000research.com/articles/5-632/v2/pdf                                              </td><td>publishedVersion</td></tr>
</tbody>
</table>



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
