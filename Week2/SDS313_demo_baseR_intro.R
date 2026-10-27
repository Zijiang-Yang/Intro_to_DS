#==============================================================================#
# SDS 313: Introduction to Data Science
# Code Demo: Foundations of Base R Programming
# Dataset: Austin Airbnb Listings (Inside Airbnb)
#==============================================================================#


#------------------------------------------------------------------------------#
# 1. GETTING COMFORTABLE IN RSTUDIO & BASIC ARITHMETIC
#------------------------------------------------------------------------------#

# Three main ways to submit/run code from this script window:
# 1. Put your cursor anywhere on a line and click the "Run" button (top right).
# 2. Highlight one or multiple lines and click "Run".
# 3. Use keyboard shortcuts:
#    - Mac: Command + Enter
#    - Windows: Ctrl + Enter

# Basic arithmetic expressions evaluated directly by R:
5 + 7
12 * 8
(100 - 15) / 5
2^4 # Exponentiation (2 raised to the power of 4)

# Comments: Any line (or part of a line) starting with '#' is ignored by R.
# Use comments generously to take notes during lecture!


#------------------------------------------------------------------------------#
# 2. BUILT-IN BASE R FUNCTIONS
#------------------------------------------------------------------------------#

# Functions are pre-written commands that take inputs (arguments) inside parentheses
# and return an output.
# Syntax: function_name(argument1, argument2, ...)

abs(-15) # Absolute value -> returns 15
sqrt(81) # Square root -> returns 9

# Functions can take multiple arguments separated by commas:
# Here we calculate the square root of 2, rounded to 4 decimal places
round(sqrt(2), 4)

# Mathematical constants built directly into base R:
pi
cos(pi)
sin(pi / 2)

# Getting help: To view documentation for any function, type '?' before the name
?sqrt
?round


#------------------------------------------------------------------------------#
# 3. ASSIGNING OBJECTS & WORKING MEMORY
#------------------------------------------------------------------------------#

# To store a value in R's working memory (Environment) to use later, we assign it
# to a variable name using the assignment operator '<-' (or '=').
# In R, '<-' is the standard, idiomatic assignment operator.

nightly_price <- 150
nightly_price # Typing the object name prints its current value

# You can use assigned objects in calculations:
nightly_price * 7 # Weekly cost at this nightly rate

# CASE SENSITIVITY:
# R is strictly case-sensitive! Object 'nightly_price' is different from 'Nightly_price'.
# Running the line below will produce an error because 'Nightly_price' does not exist:
# Nightly_price + 10


#------------------------------------------------------------------------------#
# 4. VECTORS: THE CORE DATA STRUCTURE IN R
#------------------------------------------------------------------------------#

# A vector is a 1-dimensional sequence of values of the EXACT same data type.
# We create vectors using the c() function, which stands for "combine" (or "concatenate").

# A. Numeric Vectors (numbers)
prices <- c(75, 120, 250, 45, 300, 150)
prices

# Generating sequences and repetitions:
room_ids <- 1:10 # Sequence of integers from 1 to 10
fee_schedule <- seq(from = 0, to = 100, by = 25) # Sequence: 0, 25, 50, 75, 100
cleaning_fee <- rep(50, times = 6) # Repeats the number 50 six times

# B. Character Vectors (text strings enclosed in single or double quotes)
neighborhoods <- c("Downtown", "East Austin", "Zilker", "Downtown", "Campus")
neighborhoods

# TYPE COERCION:
# If you mix numbers and strings inside a single vector, R automatically converts
# (coerces) EVERYTHING into character strings!
mixed_vector <- c(100, 200, "Unavailable")
mixed_vector # Notice the quotes around "100" and "200"
# mixed_vector + 10 # This will fail because you cannot do math on character strings!

# C. Logical Vectors (boolean values: TRUE or FALSE, typed in all caps)
has_wifi <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
has_wifi

# D. Useful Summary Functions for Vectors:
length(prices) # How many items are in the vector?
sum(prices) # Sum of all values
mean(prices) # Average price
sd(prices) # Standard deviation
fivenum(prices) # Tukey's five-number summary: Min, Q1, Median, Q3, Max

# Categorical summary:
table(neighborhoods) # Counts frequencies of each unique string

# Logical summing:
# R treats TRUE as 1 and FALSE as 0. Summing a logical vector counts the TRUEs!
sum(has_wifi) # Total number of listings with wifi


#------------------------------------------------------------------------------#
# 5. ENVIRONMENT MANAGEMENT
#------------------------------------------------------------------------------#

# List all object names currently stored in your working environment:
ls()

# Remove a specific object from working memory:
# rm(mixed_vector)

# Clear your ENTIRE workspace environment:
# rm(list = ls())
# (You can also click the broom/sweep icon in the top right "Environment" pane)


#------------------------------------------------------------------------------#
# 6. VECTOR INDEXING & LOGICAL CONDITIONS
#------------------------------------------------------------------------------#

# We use square brackets [ ] to extract (index) specific elements from a vector.

austin_prices <- c(85, 150, 45, 320, 110, 95, 500, 200)

# Positional Indexing:
austin_prices[1] # Extract the 1st element
austin_prices[3:5] # Extract elements 3 through 5
austin_prices[c(1, 4, 7)] # Extract non-consecutive elements (1st, 4th, and 7th)

# Logical Operators in R:
# == (equal to)
# != (not equal to)
# <  (less than)
# <= (less than or equal to)
# >  (greater than)
# >= (greater than or equal to)
# &  (logical AND)
# |  (logical OR)

# Logical Comparisons evaluate element-by-element, returning TRUE or FALSE:
austin_prices > 100

# Logical Indexing: "Show me the values in austin_prices WHERE the price is > 100"
austin_prices[austin_prices > 100]

# Compound Logical Conditions:
# Between $100 and $300 per night (inclusive):
austin_prices[austin_prices >= 100 & austin_prices <= 300]

# Budget (< $100) OR Luxury (> $400):
austin_prices[austin_prices < 100 | austin_prices > 400]

# which() returns the INDEX POSITIONS where a statement is TRUE:
which(austin_prices > 200) # Indices of prices > 200
austin_prices[which(austin_prices > 200)] # Values at those indices


#------------------------------------------------------------------------------#
# IN-CLASS PRACTICE 1: VECTORS & LOGICAL INDEXING
#------------------------------------------------------------------------------#

# Vector representing number of reviews for 8 different listings:
review_counts <- c(12, 0, 145, 3, 89, 0, 220, 41)

# 1. Display all review counts that have at least 50 reviews.
# ...

# 2. Without counting manually, find the total number of listings that have 0 reviews.
# ...


# 3. Extract all listings with between 10 and 100 reviews (inclusive) and store
#    them in a new vector called 'moderate_reviews'.
# ...


#------------------------------------------------------------------------------#
# 7. DOWNLOADING & IMPORTING EXTERNAL DATA (DATA FRAMES)
#------------------------------------------------------------------------------#

# Automated Data Ingestion:
# We download the official Austin Airbnb listings dataset directly from the web
# so no manual file download/moving is required.
data_url <- "https://data.insideairbnb.com/united-states/tx/austin/2026-06-22/visualisations/listings.csv"

# Import CSV into R using base R's read.csv():
airbnb <- read.csv(data_url)

# A Data Frame is a 2D table of rows (observations) and columns (variables).
# Inspecting basic structure:
dim(airbnb) # Number of rows and columns [rows, cols]
nrow(airbnb) # Total rows (listings)
ncol(airbnb) # Total columns (variables)
names(airbnb) # Vector of all column names
head(airbnb, n = 3) # Display first 3 rows
tail(airbnb, n = 3) # Display last 3 rows


#------------------------------------------------------------------------------#
# 8. INSPECTING COLUMNS WITH '$' AND HANDLING MISSING DATA (NA)
#------------------------------------------------------------------------------#

# Use the '$' operator to extract an individual column as a vector: df$column_name

# Inspect room types available in Austin:
head(airbnb$room_type)
table(airbnb$room_type) # Summary table of room types

# Calculate summary statistics on price:
mean(airbnb$price)
median(airbnb$price)
range(airbnb$price)

# DEALING WITH MISSING VALUES (NA):
# In real-world data, missing values are represented as NA.
# Let's inspect the 'reviews_per_month' column:
mean(airbnb$reviews_per_month) # Returns NA!

# Why? If a vector contains even one NA, arithmetic summary functions return NA.
# Solution: Use 'na.rm = TRUE' to remove NAs before calculating!
mean(airbnb$reviews_per_month, na.rm = TRUE)
median(airbnb$reviews_per_month, na.rm = TRUE)

# Detecting NAs:
# is.na() returns TRUE if a cell is NA, FALSE otherwise
head(is.na(airbnb$reviews_per_month))

# Count total missing values in the reviews_per_month column:
sum(is.na(airbnb$reviews_per_month))


#------------------------------------------------------------------------------#
# 9. 2D DATA FRAME INDEXING & SUBSETTING: [rows, columns]
#------------------------------------------------------------------------------#

# For 2-dimensional data frames, bracket notation requires: df[row_index, column_index]

# Positional Subsetting:
airbnb[5, ] # Entire 5th row (all columns)
airbnb[, 2] # Entire 2nd column
airbnb[1:5, c(2, 5, 10)] # Rows 1-5 for columns 2, 5, and 10

# Subsetting rows by name:
head(airbnb[, c("name", "neighbourhood", "room_type", "price")])

# LOGICAL SUBSETTING (Filtering Rows based on conditions):
# "Give me all rows where room_type is 'Entire home/apt' and all columns"
entire_homes <- airbnb[airbnb$room_type == "Entire home/apt", ]
dim(entire_homes)

# Multiple conditions:
# High-demand budget listings: price <= 100 AND number_of_reviews >= 50
budget_popular <- airbnb[airbnb$price <= 100 & airbnb$number_of_reviews >= 50, ]
dim(budget_popular)
head(budget_popular[, c("name", "neighbourhood", "price", "number_of_reviews")])


#------------------------------------------------------------------------------#
# 10. CREATING NEW VARIABLES IN A DATA FRAME
#------------------------------------------------------------------------------#

# To add a new column to an existing data frame, assign it with df$new_column_name:

# 1. Binary indicator (0/1): Is the minimum stay short term (<= 3 nights)?
airbnb$is_short_term <- 1 * (airbnb$minimum_nights <= 3)
table(airbnb$is_short_term)

# 2. Estimated cost for a 3-night stay:
airbnb$cost_3nights <- airbnb$price * 3

# Inspect our newly created columns:
head(airbnb[, c("name", "price", "minimum_nights", "is_short_term", "cost_3nights")])


#------------------------------------------------------------------------------#
# IN-CLASS PRACTICE 2: DATA FRAME EXPLORATION
#------------------------------------------------------------------------------#

# 1. What is the listing name, neighborhood, and price in the 25th row of 'airbnb'?
# ...

# 2. Create a new subset called 'downtown_listings' that contains only listings
#    in the neighborhood "Downtown" (or matching zip code/area).
#    How many listings are in this subset?
# ...

# 3. Create a new column in 'airbnb' called 'is_expensive' that equals 1 if the
#    price is strictly greater than $300/night, and 0 otherwise.
#    How many listings in Austin are classified as expensive?
# ...