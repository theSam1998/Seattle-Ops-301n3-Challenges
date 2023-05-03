#!/bin/bash
#Author: Sam Allan
#Date of last revision: 5/2/2023
#Script: Ops Challenge: Class 04
#Purpose: Write a bash script that launches a menu system with 4 options:
#hello world, ping self, ip info, and exit. 
#Incorporate a loop to bring back the menu after the user makes a selection.
#Variables: Options array holding 4 integers(1234), input variable created to store user input
#IP variable created to store result of ip addr show command, result variable created to store result of self ping

#MAIN

#storing valid selections in an array
options=( 1 2 3 4 )
#until the script encounters a break command, loop the following behavior
while true; do
#display menu
    echo "-------menu------"
    echo "1) Say Hello"
    echo "2) Ping Self"
    echo "3) IP Info"
    echo "4) Exit" 
    #asking what to do
    read -p "what action would you like me to perform?" input
    #while input is outside the options available, ask again for valid input
    while [[ $input -gt 4 ]]; do
        read -p "sorry, please select an option from the selections listed above" input
    done
    while [[ $input -lt 1 ]]; do
        read -p "sorry, please select an option from the selections listed above" input
    done
    #if input is option 1, then print hello world to the screen with some added style
    if [[ $input = ${options[0]} ]]; then
        echo "---==Xx_-_hello world_-_xX==---"
        sleep 2
    #if input is option 2, ping self and print result to screen
    elif [[ $input = ${options[1]} ]]; then
        result=$(ping -c1 $(hostname))
        echo "Ping result: $result"
        sleep 2
    #if input is option 3, show the IP information
    elif [[ $input = ${options[2]} ]]; then
        IP=$(ip addr show)
        echo "your IP information: $IP"
        sleep 2
    #if input is option 4, exit the program
    elif [[ $input = ${options[3]} ]]; then
        echo "OK, Goodbye!"
        sleep 2
        exit 0
    fi
done

#END