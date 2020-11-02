fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileURL, 'data.zip')
unzip('data.zip')
list.files()
library(lubridate)
library(dplyr)

#Reading data

df <- read.table('household_power_consumption.txt', header = TRUE, sep = ';')
df <- tbl_df(df)
Date_Time <- dmy_hms(paste(df$Date, df$Time))
df0 <- cbind(Date_Time, df)
#Subsetting needed rows and converting data to numeric

dates <- ymd(c("2007-02-01","2007-02-02"))
df1 <- filter(df0, date(Date_Time) %in% dates)
df1[,3:9] <- apply(df1[,3:9], 2, function(x) x <- as.numeric(x))

#Creating plot

plot(df1$Date_Time, df1$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.copy(png, "plot2.png")
dev.off()

