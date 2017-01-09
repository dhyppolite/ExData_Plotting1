require("dplyr");

load_consumption_data <- function()
{
  consumption_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",as.is=TRUE)
  consumption_data <- filter(consumption_data, Global_active_power != "?")
  filtered_data_by_date <- filter(consumption_data, Date=="1/2/2007"| Date=="2/2/2007");
  daba <- mutate(filtered_data_by_date, dt = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))) 
}

plot2 <- function()
{
  consumption_data <- load_consumption_data();
  png(filename="plot2.png", width = 800, height=600, units="px")
  with(consumption_data,plot(dt, as.numeric(Global_active_power), type="l", lwd=1, ylab="Global Active Power (kilowatts)"), xlab="")
  dev.off()
}