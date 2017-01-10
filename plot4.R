require("dplyr");

load_consumption_data <- function()
{
  consumption_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",as.is=TRUE)
  consumption_data <- filter(consumption_data, Global_active_power != "?")
  filtered_data_by_date <- filter(consumption_data, Date=="1/2/2007"| Date=="2/2/2007");
  daba <- mutate(filtered_data_by_date, dt = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))) 
}

plot4 <- function()
{
  consumption_data <- load_consumption_data();
  png(filename="plot4.png", width = 480, height=480, units="px")
  par(mfrow=c(2,2))
  plot(consumption_data$datetime, as.numeric(consumption_data$Global_active_power), type="l", lwd=1, ylab="Global Active Power (kilowatts)", xlab="")
  plot(consumption_data$datetime,consumption_data$Voltage, lwd=1, col="black", type="l", ylab="Voltage", xlab="datetime")
  
  plot(consumption_data$datetime, consumption_data$Sub_metering_1,lwd=1, col="black",type="l", ylab="Energy sub metering", xlab="")
  with(consumption_data, lines(datetime, Sub_metering_2,lwd=1, col="red"))
  with(consumption_data, lines(datetime, Sub_metering_3,lwd=1, col="blue"))
  legend("topright",bty="n", lty = 1, col=c("black", "red", "purple"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(consumption_data$datetime, consumption_data$Global_reactive_power,lwd=1, col="black",type="l", ylab="Global_reactive_power", xlab="datetime")
  
  dev.off()
}