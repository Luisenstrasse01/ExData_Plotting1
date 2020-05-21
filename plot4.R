library(dplyr) #load dplyr library for better data handling

#function for adding x axis as requested for less typing. Its called in each 
#plot drawing code
weekdayaxis <- function() 
    {
    
    xticks <- c(match("1/2/2007", sdata$Date), match("2/2/2007", sdata$Date), nrow(sdata))
    ticklabels <- c("Thu", "Fri", "Sat")
    
    axis(side = 1, at = xticks, labels = ticklabels)
    
    }

png("plot4.png", width = 480, height = 480)

#set the output data with 2x2 plots
par(mfrow = c(2,2))

#load data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile ="exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#subset data
sdata <- filter(data, as.Date(Date, format = "%d/%m/%Y") == "2007-02-01"|
                    as.Date(Date, format = "%d/%m/%Y") == "2007-02-02" )

#Plot 1,1
plot(rownames(sdata), as.numeric(as.character(sdata$Global_active_power)), type = "l", xlab ="", ylab = "Global Active Power", xaxt = "n")
weekdayaxis()

#Plot 1,2
plot(rownames(sdata), as.numeric(as.character(sdata$Voltage)), type = "l", xlab ="datetime", ylab = "Voltage", xaxt = "n")
weekdayaxis()

#Plot 2,1
plot(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_1)), type = "l", xlab ="", ylab = "Energy sub metering", xaxt = "n")
lines(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_2)), col = "blue")
lines(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_3)), col = "red")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = colnames(sdata)[7:9], box.lty = "blank")
weekdayaxis()

#Plot 2,2
plot(rownames(sdata), as.numeric(as.character(sdata$Global_reactive_power)), type = "l", xlab ="datetime", ylab = "Global_reactive_power", xaxt = "n")
weekdayaxis()

dev.off()