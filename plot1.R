#Load packages
library(tidyverse)
library(lubridate)

#Load dataset
data <- read_csv2(file = "household_power_consumption.txt")

#Check variables
head(data)
str(data)

#Convert date format from chr to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset the data frame for the two days we are interested in
df <- data %>% 
  filter(Date == "2007-02-01" | Date == "2007-02-02")

#Convert chr to nummerical
df$Global_active_power <- as.numeric(df$Global_active_power)

#Plot with base R
hist(df$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

#Save
png(file="plot1.png",width=480,height=480)
hist(df$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()

#Plot with ggplot2 just as an exercise
ggplot(df, aes(x = Global_active_power)) + geom_histogram(bins = 20,  colour="black", fill="red") +
  labs(title="Global Active Power",x="Global Active Power (Kilowatts)", y = "Frequency")

