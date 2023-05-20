#Author: Sam Allan
#Date of Last Revision: 05/20/2023
#Script: Seattle Ops 301n3 challenge 09
#Purpose: Create if statements using these logical conditionals below. Each statement should print information to the screen depending on if the condition is met.
#!Equals: a == b
#!Not Equals: a != b
#!Less than: a < b
#!Less than or equal to: a <= b
#!Greater than: a > b
#!Greater than or equal to: a >= b
#!Create an if statement using a logical conditional of your choice and include elif keyword that executes when other conditions are not met.
#!Create an if statement that includes both elif and else to execute when both if and elif are not met.
#Stretch Goals (Optional Objectives)
#Pursue stretch goals if you are a more advanced user or have remaining lab time.
#!Create an if statement with two conditions by using and between conditions.
#!Create an if statement with two conditions by using or between conditions.
#Create a nested if statement.
#Create an if statement that includes pass to avoid errors.

#Variables:
#sit, storing where the user is sitting as an argument when the function is called.
#chairs, storing the number of chairs the user has sat in as an integer in a variable.

# MAIN

def sit_finder(sit):

    if sit == "chair":
        print("you're sitting in a chair!")
        return True
    elif sit != "chair":
        print("where on earth are you sitting?!")
        return False

def chair_number(chairs):
    if isinstance(chairs, str):
        print("I don't know what you're talking about")
        return 0
    elif chairs <= 3:
        print("somebody loves standing")
    elif chairs < 20:
        print("that's not that many chairs")
    elif chairs >= 90:
        print("whoa, ok, slow down chairmaster")
    elif chairs > 50:
        print("whoa, buddy, that's a lot of chairs")
    elif chairs <= 50:
        print("ok, pretty average amount of chairs")
    else:
        print("I forgot what we were talking about.")
    return chairs

sit = sit_finder(input("where are you sitting?"))

user_input = input("how many chairs have you sat in?")
try:
    user_input = int(user_input)
except ValueError:
    # If the conversion fails, user_input will remain a string
    pass

num_chairs = chair_number(user_input)

if num_chairs > 50 and sit:
    print("you are sitting in a chair, and have sat in more than 50 chairs.")

if num_chairs == 420 or 69:
    print("I see what you did there.")
    
# END