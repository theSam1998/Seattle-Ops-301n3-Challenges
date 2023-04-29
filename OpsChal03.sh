#!/bin/bash
#Author: Sam Allan
#Script: Ops Challenge class 3
#Date of last revision: 04/28/2023
#Purpose: Create a script that allows for user input based permissions changes.
#Create a new bash script that performs the following:
#Prompts user for input directory path.
#Prompts user for input permissions number (e.g. 777 to perform a chmod 777)
#Navigates to directory input by user and changes all files inside it to input setting.
#Prints to screen directory contents and new permissions settings of everything in directory.
#variables: var1, storing input of directory/filepath. var2, storing permissions number. var3, storing log filename and path.

#MAIN
echo "welcome to the extremely dangerous file permission changer!" 
echo "I can change the permissions of any file in any way you'd like!"
sleep 1
echo "please be warned, I will perform any action you tell me to!"
echo "even an action you don't actually intend to make!"
echo "remember to run this file with elevated permissions, or else it will not be able to function properly!"
sleep 1
read -p "please, proceed with caution! press enter when ready to begin."
echo "provide me with the directory path!"
read -p "if you want to change a specific file, please include that at the end of the path: " var1
read -p "now tell me the permissions number you'd like to assign to the previous input: " var2
var3=/var/log/permissionschangelog.txt
if [[ -d "$var1" ]]
then
    echo "changing directory to input" | tee -a "$var3" 
    sleep 1
    cd "$var1"
    echo "original directory permissions:" | tee -a "$var3" 
    ls -al >> "$var3" 
    echo "changing directory permissions to input recursively" | tee -a "$var3" 
    sleep 1
    chmod -R "$var2" . >> "$var3"
    echo "finished!" | tee -a "$var3"
    sleep 1
else
    echo "changing file permissions to input..." | tee -a "$var3" 
    sleep 1
    chmod "$var2" "$var1" >> "$var3"
    echo "finished!" | tee -a "$var3" 
    sleep 1
fi
echo "$var1" " has been changed to permissions code " "$var2" | tee -a "$var3" 
ls -al | tee -a "$var3"
read -p "press enter to exit the program"