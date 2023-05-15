#!/usr/bin/env python3
#Author: Samuel Allan
#Date of last revision: 5/13/2023
#script: Seattle Ops 301n3 Challenge 07
#purpose: Script must ask the user for a file path and read a user input string into a variable.
#Script must use the os.walk() function from the os library.
#Script must enclose the os.walk() function within a python function that hands it the user input file path.
#stretch goals: Have the script save the output as a .txt file.
#Have the script open the .txt file with Libre Office Writer.
#Add a function to your Python script that performs the following as a first step to prepare a test directory.
#Takes a user input string
#Creates a directory named the string using os.makdirs function
#Create sub-directories within the directory named ‘string_01’, ‘string_02’, and ‘string_03’
# Import libraries

import os

#defining function "make_dir" to create test directories
def make_dir(name):
    os.makedirs(name, exist_ok= True)
    # The names of the subdirectories are the user's string followed by '_01', '_02', and '_03'
    for i in range(1, 4):
        #creating full path for subdirectories
        os.makedirs(os.path.join(name, f"{name}_{str(i).zfill(2)}"), exist_ok=True)

# defining function "print_dir_contents" to hold the filepath input from the user and crawl through displaying files and subdirs, and inspecting each subdir
def print_dir_contents(file_path):
    #for the root name, directories, and files in the provided filepath, do
    for (root, dirs, files) in os.walk(file_path):
        #print the root
        print("==root==")
        print(root)
        #print the directories
        print("==dirs==")
        print(dirs)
        #print the files
        print("==files==")
        print(files)

# Main

#until you encounter a break, 
while True:
    #prompt the user to ask whether or not they'd like to create a test directory
    dir_choice = input("would you like to create a test directory?")
    #if they answered yes
    if dir_choice == "y":
        #ask them for its name
        dir_name = input ("enter the test directory's name here:")
        #use the function with the name given
        make_dir(dir_name)
    else:
        #say alright and move on
        print("ok, I will not create a test directory.")
    #setting variable file_path to hold filepath given by user
    file_path = input("Enter a filepath here:")
    #setting variable right_choice to ask whether the filepath given is correct or not
    right_choice = input("is " + file_path + "the correct file path? y/n")
    #if it is correct
    if right_choice == "y":
        #use the function with the path given
        print_dir_contents(file_path)
        break
    else:
        #if not, prompt the user for the right path again.
        print("please enter the correct filepath.")

### Pass the variable into the function here

# End