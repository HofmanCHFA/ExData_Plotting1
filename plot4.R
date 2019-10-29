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
df$Voltage <- as.numeric(df$Voltage)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)

#Plot with base R
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(df$datetime, df$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")

plot(df$datetime, df$Voltage, type="l", ylab="Voltage (volt)", xlab="")

plot(df$datetime, df$Sub_metering_1, type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(df$datetime, df$Global_reactive_power, type="l", ylab="Global Rective Power (kilowatts)",xlab="")

#Save
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(df$datetime, df$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")

plot(df$datetime, df$Voltage, type="l", ylab="Voltage (volt)", xlab="")

plot(df$datetime, df$Sub_metering_1, type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(df$datetime, df$Global_reactive_power, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
dev.off()

