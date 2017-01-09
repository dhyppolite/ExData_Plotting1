require("dplyr");

load_consumption_data <- function()
{
  consumption_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",as.is=TRUE)
  consumption_data <- filter(consumption_data, Global_active_power != "?")
  filtered_data_by_date <- filter(consumption_data, Date=="1/2/2007"| Date=="2/2/2007");
  daba <- mutate(filtered_data_by_date, dt = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))) 
}

plot3 <- function()
{
  consumption_data <- load_consumption_data();
  png(filename="plot3.png", width = 800, height=600, units="px")
  plot(consumption_data$dt, consumption_data$Sub_metering_1,lwd=1, col="black",type="l", ylab="Energy sub metering", xlab="")
  with(consumption_data, lines(dt, Sub_metering_2,lwd=1, col="red"))
  with(consumption_data, lines(dt, Sub_metering_3,lwd=1, col="blue"))
  
  legend("topright", pch="-", col=c("black", "red", "purple"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  dev.off()
}