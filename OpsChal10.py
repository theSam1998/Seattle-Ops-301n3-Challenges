#Author: Sam Allan
#Date of last revision: 05/23/2023
#Script: Seattle Ops 301n3 Ops Challenge 10
#Purpose: Using file handling commands, create a Python script that creates a new .txt file,
#appends three lines, prints to the screen the first line, then deletes the .txt file.
#Stretch goals:
#Export your pfSense configuration.
#Have your Python script open the exported file.
#Code up your script to change a value inside the file.
#Save the changes out to a new file name.
#Re-import the modified configuration file, to verify that your changes will be accepted by pfSense.
#import modules:
import os



#Variables:
document = "textdoc.txt"

# MAIN


with open(document, "w") as doc:
    doc.write("testing\n")
    doc.write("testing2\n")
    doc.write("testing3\n")
with open(document, "r") as doc:
    print(doc.readlines(1))    
os.remove(document)








# END