## First we read the data stored in our local storage
direct <- getwd()
file <- "household_power_consumption.txt"
workon <- paste(direct,file,sep="/")
outcome <- read.table(workon, header = TRUE, sep=";",na.strings="?",stringsAsFactors=FALSE)
## We will use as.Date() function to concert char type Date info to Date format
outcome$Date <- as.Date(outcome$Date,format="%d/%m/%Y")
##And now we can subset dataset with defined boundries
outcome_ltd <- subset(outcome,subset=(Date >= "2007-02-01" & Date <="2007-02-02"))
## We need to convert Date and Time information as Date/Time 
datetime <- paste(as.Date(outcome_ltd$Date), outcome_ltd$Time)
outcome_ltd$datetime <- as.POSIXct(datetime)
##Plotting time
plot(outcome_ltd$Global_active_power~outcome_ltd$datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
