##download the dat
filename<-"coursera_exploratorydatanalysis_ass1.zip"

if (!file.exists(filename)){
        fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,filename)
}

unzip(filename)


dat<-read.table("household_power_consumption.txt",header = T,sep=';')


## convert the Date and Time variables to Date/Time classes 
dat$Date<-as.Date(dat$Date,"%d/%m/%Y")
dat$Time<-format(strptime(dat$Time,"%H:%M:%S"),"%H:%M:%S")



##extract only the dates 2007-02-01 and 2007-02-02
feb<-rbind(dat[dat$Date=='2007-02-01',],dat[dat$Date=='2007-02-02',])      

##
