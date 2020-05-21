library(dplyr) #Use of library dplyr for better data handling

png("plot2.png", width = 480, height = 480)

#load dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile ="exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip",
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#subset data for requested dates
sdata <- filter(data, as.Date(Date, format = "%d/%m/%Y") == "2007-02-01"|
                    as.Date(Date, format = "%d/%m/%Y") == "2007-02-02" )

#plot the line without the x axis
plot(rownames(sdata), as.numeric(as.character(sdata$Global_active_power))
     , type = "l", xlab ="", ylab = "Global Active Power (kilowatts)", xaxt = "n")

#add x axis as requested
xticks <- c(match("1/2/2007", sdata$Date), match("2/2/2007", sdata$Date),  nrow(sdata))
ticklabels <- c("Thu", "Fri", "Sat") # vector of tick label's names
axis(side = 1, at = xticks, labels = ticklabels) #Add axis to the plot

dev.off()