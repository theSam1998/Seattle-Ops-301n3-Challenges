#!/bin/bash
    options=( 1 2 3 4 )
while true; do
    echo "-------menu------"
    echo "1) Say Hello"
    echo "2) Ping Self"
    echo "3) IP Info"
    echo "4) Exit" 
    #asking what to do
    read -p "what action would you like me to perform?" input
    while [[ $input -gt 4 ]]; do
        read -p "sorry, please select an option from the selections listed above" input
    done
    while [[ $input -lt 1 ]]; do
        read -p "sorry, please select an option from the selections listed above" input
    done
    if [[ $input = ${options[0]} ]]; then
        echo "---==Xx_-_hello world_-_xX==---"
    elif [[ $input = ${options[1]} ]]; then
        result=$(ping -c1 $(hostname))
        echo "Ping result: $result"
    elif [[ $input = ${options[2]} ]]; then
        IP=$(ip addr show)
        echo "your IP information: $IP"
    elif [[ $input = ${options[3]} ]]; then
        echo "OK, Goodbye!"
        sleep 2
        exit 0
    fi
done