# I-690 DATA TIDYING

## RStudio Version: 1.1.456
## R Version: 3.5.1
## Windows 10

## Script Version: 1.0
## Updated: 2019-01-21


# CLEAR WORKSPACE; INSTALL/LOAD PACKAGES

rm(list = ls())

if(!require(zoo)){install.packages("zoo")}
if(!require(readr)){install.packages("readr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(readxl)){install.packages("readxl")}
if(!require(stringr)){install.packages("stringr")}
if(!require(lubridate)){install.packages("lubridate")}

library(zoo)
library(readr)
library(tidyr)
library(dplyr)
library(readxl)
library(stringr)
library(lubridate)


# SET WORKING DIRECTORY; RETRIEVE I-690 FILE

setwd("~/Projects/REIS/I-690")

url <- "https://raw.githubusercontent.com/jamisoncrawford/690/master/Final%20Tables/690_utilization.csv"
util <- read_csv(url); rm(url)


# TIDY I-690 DATASET

util <- util %>% 
  gather(key = race, value = race_hours, black_m:native_f)

util$sex <- NA

for (i in seq_along(util$race)){
  if (str_detect(util$race[i], "_m$")){
    util$sex[i] <- "Male"
  } else if (str_detect(util$race[i], "_f$")){
    util$sex[i] <- "Female"
  }
}

for (i in seq_along(util$race)){
  if (str_detect(util$race[i], "^black")){
    util$race[i] <- "Black"
  } else if (str_detect(util$race[i], "^hispanic")){
    util$race[i] <- "Hispanic"
  } else if (str_detect(util$race[i], "^asian")){
    util$race[i] <- "Asian"
  } else if (str_detect(util$race[i], "^native")){
    util$race[i] <- "Native"
  }
}


# WRITE TO CSV

write_csv(util, "690_util_tidy.csv")
