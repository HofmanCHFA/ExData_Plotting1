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
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

#Plot with base R
plot(df$datetime, df$Sub_metering_1, type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save
png(file="plot3.png",width=480,height=480)
plot(df$datetime, df$Sub_metering_1, type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

#Plot with ggplot2 just as an exercise
ggplot(df, aes(x = datetime)) + geom_line(aes(y = Sub_metering_1)) + geom_line(aes(y = Sub_metering_2), color = "red") + 
  geom_line(aes(y = Sub_metering_3), color="steelblue")   + labs(y="Global Active Power (Kilowatts)", x = "Days and Times")
