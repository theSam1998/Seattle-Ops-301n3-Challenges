#!/bin/bash
#Author: Sam Allan
#Date of last revision: 05/05/2023
#Script: Seattle 301n3 Ops Challenge: Class 05
#Purpose: Write a bash script that performs the following tasks:

#Print to the screen the file size of the log files before compression
#Compress the contents of the log files listed below to a backup directory
#/var/log/syslog
#/var/log/wtmp
#The file name should contain the hostname and the time stamp with the following format -YYYYMMDDHHMMSS
#Example: /var/log/backups/syslog-hostname-20220928081457.zip
#Clear the contents of the log file
#Print to screen the file size of the compressed file
#Compare the size of the compressed files to the size of the original log files

#MAIN

#storing filepath for backup folder in variable
backup_dir="/home/backuplogs"
#storing timestamp format for filename in variable
timestamp=$(date +"%Y%m%d%H%M%S")
#storing logs to be zipped and destroyed in an array.
log_files=("/var/log/syslog" "/var/log/wtmp")

# Create the backup directory if it does not exist
#checking if backup directory exists and only executing conditional if it doesn't
if [[ ! -d "$backup_dir" ]]; then
    #create backup directory if it doesn't exist. if the directory can't be created, exit the program.
    mkdir -p "$backup_dir" || { echo "Error: Failed to create backup directory $backup_dir"; exit 1; }
fi
#for every file in the log_files array, do the following:
for file in "${log_files[@]}"; do
    #if the file doesn't exist, do the following:
    if [[ ! -f "$file" ]]; then
        #tell us it doesn't exist.
        echo "Warning: Log file $file does not exist"
        #skip to the next file and start from the beginning.
        continue
    fi
    #setting file's base size in bytes as a variable 
    pre_size=$(stat -c%s "$file")
    #setting file's original name as a variable
    filename=$(basename "$file")
    #zip the file in question to the backup directory with a timestamp, if this can't be done let us know and exit.
    zip -q "$backup_dir/$filename-$timestamp.zip" "$file" || { echo "Error: Failed to create output file $backup_dir/$filename-$timestamp.zip"; exit 1; }
    #print the base file size to the terminal
    echo "pre compression filesize: $pre_size"
    #setting post compression size in bytes as a variable
    post_size=$(stat -c%s "$backup_dir/$filename-$timestamp.zip")
    #print the size to the terminal
    echo "post compression filesize: $post_size"
    #if the compressed file is smaller than the original file
    if [[ $pre_size -gt $post_size ]]; then
        #let us know everything worked
        echo "compression successful"
        #erase the contents of the original
        cat /dev/null > "$file"
    else
    #let us know it didn't work
        echo "compression unsuccessful"
    fi

done
