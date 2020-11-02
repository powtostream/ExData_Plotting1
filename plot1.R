fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileURL, 'data.zip')
unzip('data.zip')
list.files()
library(lubridate)
library(dplyr)

#Reading data

df <- read.table('household_power_consumption.txt', header = TRUE, sep = ';')
df <- tbl_df(df)
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)

#Subsetting needed rows and converting data to numeric

dates <- ymd(c("2007-02-01","2007-02-02"))
df1 <- filter(df, Date %in% dates)
df1[,3:9] <- apply(df1[,3:9], 2, function(x) x <- as.numeric(x))

#Creating histogram

hist(df1$Global_active_power, main = "Global Active Power", col = 'red', xlab = 'Global Active Power (kilowatts)')
dev.copy(png, "plot1.png")
dev.off()
