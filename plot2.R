#
#	Download and extract from zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df_power<- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings = "?")
unlink(temp)
#
#	Convert to POSIX date / time format
df_power$ObsDate<-strptime(paste(df_power$Date, df_power$Time), format = "%d/%m/%Y %T")
#
#	Filter out the required dates and remove NA values
#
df_power1<-df_power[df_power$ObsDate >= "2007/02/01" & df_power$ObsDate < "2007/02/03",]
df_power1<-df_power1[complete.cases(df_power1$Date),]
#
#	Draw plot 2 and save it to PNG file
#
plot(df_power1$ObsDate, df_power1$Global_active_power, xlab = "", ylab="Global Active Power (kilowatts)", type="l")

dev.copy(png, filename="plot2.png")
dev.off()
