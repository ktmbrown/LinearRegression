#libraries
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)

# downloading data
if(!file.exists("./data")) {dir.create("./data")}
url <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip'
download.file(url, destfile = './data/student.zip',method='curl' )
unzip('./data/student.zip',exdir = './data')


# reading data
df <- read.csv('data/student-mat.csv', sep=';')

# first glance
head(df)
str(df)
summary(df)

# check for NAs
any(is.na(df))

#---------------------------exploratory data analysis---------------------------#

# checking numeric correlation
numeric.cols <- sapply(df,is.numeric)

# correlation of numeric columns
corr.data <- cor(df[,numeric.cols])

# view correlation data
print(corr.data)

# Correlation plots - with corrplot
print(corrplot(corr.data, method='color'))

# Correlation plots - with corrgram
print(corrgram(df))
corrgram(df,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

# histogram of G3 (predicted value)
ggplot(df,aes(x=G3)) + geom_histogram(bins=20,alpha=0.5,fill='blue') + theme_minimal()


