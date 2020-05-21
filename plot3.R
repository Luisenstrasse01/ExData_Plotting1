library(dplyr)

#open png device
png("plot3.png", width = 480, height = 480)

#load dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile ="exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#subset data for requested dates
sdata <- filter(data, as.Date(Date, format = "%d/%m/%Y") == "2007-02-01"|
                    as.Date(Date, format = "%d/%m/%Y") == "2007-02-02" )

#plot the line without the x axis and first line
plot(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_1)), type = "l",
     xlab ="", ylab = "Energy sub metering", xaxt = "n")

#add aditional lines
lines(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_2)), col = "blue")
lines(rownames(sdata), as.numeric(as.character(sdata$Sub_metering_3)), col = "red")

#add legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = colnames(sdata)[7:9])

#add x axis as requested
xticks <- c(match("1/2/2007", sdata$Date), match("2/2/2007", sdata$Date), nrow(sdata))
ticklabels <- c("Thu", "Fri", "Sat")
axis(side = 1, at = xticks, labels = ticklabels)


dev.off()