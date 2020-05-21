png("plot1.png")

#load data set
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile ="exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#Subset data for the requested dates
sdata <- subset(data, as.Date(Date, format = "%d/%m/%Y") == "2007-02-01"|
                   as.Date(Date, format = "%d/%m/%Y") == "2007-02-02" )

#plot histogram
hist(as.numeric(as.character(sdata$Global_active_power)), col = "red",
     xlab = "Global Active Power (kilowatts)" , ylab = "Frequency",
     main = "Global Active Power")

dev.off()
