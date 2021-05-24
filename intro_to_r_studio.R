# Mike Babb
# April 26, 2021
# intro to R studio

# remove all previous objects from memory
rm(list=ls())

# set the working directory
setwd(dir='H:/temp')

my_var <- 'blarcho'

# create a vector
first_vec <- c(1, 3, 5)
first_vec

# Generating list 
# creating a list of a numeric vector, an integer vector, and a character vector
mylist <- list(1.1, c(1,3,7), c("abc", "def"))
mylist

# let's work with one of the bundled in datasets.
# first, let's see all of the datasets available with R:
data()

# we'll use the Motor Trend Car Road Tests datasets, mtcars
head(mtcars)
View(mtcars)
help(mtcars)

# how many rows and columns?
nrow(mtcars)
ncol(mtcars)

# some simple stats
mean(mtcars$mpg)
median(mtcars$mpg)

mtcars$gear


# we can chain functions together
round(mean(mtcars$mpg), 0)

# let's do a simple cross tab of the number of cylinders by horsepower
table(mtcars$cyl, mtcars$hp)

# a basic graph of horsepower by mpg?
plot(x=mtcars$hp, y=mtcars$mpg)
hist(mtcars$mpg)
help(hist)

# add some additional information...
help(plot)
plot(x=mtcars$hp, y=mtcars$mpg,xlab = 'Horsepower', ylab = 'Miles Per Gallon',
     main = 'Miles per gallon vs. Horsepower, 1973 - 1974',
     type = 'p', pch = 19)

# let's color each point by the number of cylinders
# how many cylinders are there?
mtcars$cyl

# what if we want to see the unique cylinders?
unique(mtcars$cyl)
# and then sort the unique values?
sort(unique(mtcars$cyl))

# let's write a function to do this
sunique <- function(x){
  return(sort(unique(x)))
}

sunique(mtcars$cyl)

# 4: green
# 6: blue
# 8: red

# let's add a vector to our mtcars data with the colors of interest
# we'll start by assuming that all colors 
mtcars$cyl_color <- rep(x = 'green', nrow(mtcars))
mtcars$cyl_color[which(x=mtcars$cyl==6)] <- 'blue'
mtcars$cyl_color[which(x=mtcars$cyl==8)] <- 'red'
View(mtcars)

plot(x=mtcars$hp, y=mtcars$mpg,xlab = 'Horsepower', ylab = 'Miles Per Gallon',
     main = 'Miles per gallon vs. Horsepower, 1973 - 1974',
     type = 'p', pch = 19, col = mtcars$cyl_color)
legend(x=250, y = 30, legend=c('4 Cylinders', '6 Cylinders', '8 Cylinders'),
       col=c('green', 'blue', 'red'), pch = rep(19, 3))


# let's use another graphing package to produce our plot
install.packages('ggplot2')
library(ggplot2)


# we need to create factors for our data
mtcars$cyl_factor <- factor(x=mtcars$cyl, levels = c(4,6,8), labels = c('4 Cylinders', '6 Cylinders', '8 Cylinders'))

# basic colors
my_colors <- c('green', 'blue', 'red')
# hundreds of named colors
# https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf
my_colors2 <- c('hotpink3', 'grey30', 'gold3')

my_plot <- ggplot(data = mtcars, mapping=aes(x=hp, y = mpg, color = cyl_factor)) + 
  geom_point(size = 4) +
  scale_color_manual(values = rev(my_colors2)) +
  guides(color  = guide_legend(title = 'No. of Cylinders')) +
  ggtitle(label = 'Miles per gallon vs. Horsepower, 1973 - 1974') +
  theme_classic()
my_plot
# we've updated our mtcars data and build a plot, let's save it to disk in a place where we can access them later

saveRDS(object = mtcars, file='my_mtcars.rds') # save as rds
write.csv(x=mtcars, file='my_mtcars.csv', row.names = FALSE) # save as a comma separated
write.table(x=mtcars, file='my_mtcars.txt', sep = '\t', row.names = FALSE) # save as tab separated

# save the plot
png(file='hp_vs_mpg.png', width = 960, height = 640)
my_plot
dev.off()

# remove everything from memory
rm(list=ls())
# let's read in our modified mtcars
my_mtcars_rds <- readRDS(file='my_mtcars.rds')
head(my_mtcars_rds)

my_mtcars_csv <- read.csv(file='my_mtcars.csv')
head(my_mtcars_csv)

my_mtcars_txt <- read.table(file='my_mtcars.txt', sep = '\t',header = 1)
head(my_mtcars_txt)

original_mtcars <- mtcars

