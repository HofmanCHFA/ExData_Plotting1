#Load packages
library(tidyverse)
library(lubridate)

#Load dataset
data <- read_csv2(file = "household_power_consumption.txt")

#Check variables
head(data)
str(data)

#create datetime
data$datetime <- paste(data$Date, data$Time)

#Convert date format from chr to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset the data frame for the two days we are interested in
df <- data %>% 
  filter(Date == "2007-02-01" | Date == "2007-02-02")

#convert datetime
df$datetime <- as.POSIXct(df$datetime, format = "%d/%m/%Y %H:%M:%S")

#Convert chr to numerical
df$Global_active_power <- as.numeric(df$Global_active_power)

#Plot with base R
plot(df$datetime, df$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Save
png(file="plot2.png",width=480,height=480)
plot(df$datetime, df$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

#Plot with ggplot2 just as an exercise
ggplot(df, aes(y = Global_active_power, x = datetime)) + geom_line()

