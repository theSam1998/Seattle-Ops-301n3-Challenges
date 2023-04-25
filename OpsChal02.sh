#!/bin/bash
#Author: Samuel Allan
#Date of last revision: 04/24/2023
#Script: Ops Challenge Class 02
#Purpose: copy the syslog file in /var/log to current working directory, appending the date and time the copy was made to the filename.
#Variables: var1, holds filepath and filename. var2, holds formatting for date and time for the appended filename.
#Functions: faketimer, simulates a loading bar


#setting variable to store name and path of syslog file
var1=/var/log/syslog
#setting variable to store date and time format.
#format displays abreviated day, month, day of the month, and the full year, followed by the hour and minute separated by dashes, as I found it difficult to make sense of without this separation.
var2=$(date +"%a%b%d%Y_%H-%M")
#storing counter value for fake loading bar
var3=0
#storing filename appended with date and time information from var2
var4="syslog_$var2"
var5=$(date)

#creating function faketimer to simulate loading progress
faketimer () {
    #setting while loop to analyze whether var3's value is less than 5
    while [ $var3 -lt 5 ]
    do
    #pause for one second
        sleep 1
        #print a period to the terminal
        echo "."
        #add 1 to the value of var3
        var3=$((var3 + 1 ))
    done
    #print statement acknowledging completion of the task
    echo "finished!"
}

#print to the terminal the impending action
echo "copying syslog file to pwd. the current date and time is $var5"
#run the faketimer function to simulate loading progress
faketimer
#copy the syslog file to the pwd with the date and time added to the end of the filename
cp $var1 $var4 
#print the appended filename to the screen
echo "your appended filename is $var4"

#END


##references: thesam1998 Ops201repository OpsChal06, for timer and proper syntax.