#Author: Sam Allan
#Script: Seattle Ops 301n3 challenge 06
#Date of last revision: 05/09/2023
#Purpose: 
#Utilize the OS module.
#Use three variables to contain the results of whoami, ip a, and lshw -short.
#Use print at least three times.
#repeat script using subprocess module instead.
#MAIN

import os
import subprocess

#set 1, using os module
#setting variables to hold the output of their respective commands.
iam = os.system("whoami")
myip = os.system("ip a")
hrdwr = os.system("lshw -short")
#printing those variables to the screen
print(iam)
print(myip)
print(hrdwr)

#setting list "todo" to hold different commands which are to be done
todo = ["whoami", "ip a", "lshw -short"]
#for each thing in the list
for x in todo:
    #runs the command in question with subprocess.check_output(), shell = True indicates the command should be ran in the shell
    #universal_newlines = True tells check_output to return the value as a string instead of bytes. stores this value in the variable "done" 
    done = subprocess.check_output( x, shell = True, universal_newlines = True)
    #echos the end result to the terminal
    print(done) 
    