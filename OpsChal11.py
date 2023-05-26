#Author: Sam Allan
#Date of last revision: 05/25/2023
#Script: Seatlte-Ops-301n3 Ops Challenge 11
#Purpose: Create a Python script that fetches this information using Psutil:
#!Time spent by normal processes executing in user mode
#!Time spent by processes executing in kernel mode
#!Time when system was idle
#!Time spent by priority processes executing in user mode
#!Time spent waiting for I/O to complete.
#!Time spent for servicing hardware interrupts
#!Time spent for servicing software interrupts
#!Time spent by other operating systems running in a virtualized environment
#!Time spent running a virtual CPU for guest operating systems under the control of the Linux kernel
#!Print all of the above (individually is fine)
#Stretch goals:
#Save the information to a .txt file.
#Email the .txt file to yourself using Sendmail.
#import space:

import psutil
import time
#variables:
#setting times variable to hold the output of psutil.cpu_times
times = psutil.cpu_times()
#setting filename variable to store the filename to which we write the output
filename = "cputimes.txt"
#MAIN

#defining function
def get_cpu_times():#will do this:
    #output is set as a variable that holds an empty dictionary.
    #note on dictionaries: they store their contents as key-value pairs. "{key1: value1, key2:, value2}"
    #square brackets are used to access elements within a dictionary, in this case we are assigning a value to our own keys.
    output = {}
    #calling the dictionary, assigning the key to display some explanatory text, and setting the value to nothing.
    output["all times displayed in seconds"] = ""
    #setting the key to explain the output, and calling the times tuple we got earlier with the .user attribute this process repeats for the following commands.
    output["time spent by processes executing in user mode:" ] = times.user
    output["time spent by processes executing in kernel mode:" ] = times.system
    output["time spent idling: "] = times.idle
    output["time spent by priority processes executing in user mode: "] = times.nice
    output["time spent waiting for I/O to complete: "] = times.iowait
    output["time spent servicing hardware interrupts: "] = times.irq
    output["time spent servicing software interrupts: "] = times.softirq
    output["time spent by other operating systems running in a virtualized environment: "] = times.steal
    output["time spent running a virtual CPU for guest OS under the control of Linux kernel: "] = times.guest
    #return the output dictionary to be used later
    return output
#setting a variable to hold the output of the function we just defined earlier.
good_stuff = get_cpu_times()
#for each key and value in the output
for key, value in good_stuff.items():
    #print each key and value in that order to the terminal
    print(f"{key}: {value}")
    #pause after each one
    time.sleep(1)
    #logging process, opening the filename we defined earlier in write mode as an arbitrary printer variable
with open(filename, "w") as printer:
    #for each key and value
    for key, value in good_stuff.items():
        #write to the file each key and value as a separate line.
        printer.write(f"{key}: {value}\n")


#END