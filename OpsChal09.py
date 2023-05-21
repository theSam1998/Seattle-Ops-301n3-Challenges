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
#!Create a nested if statement.
#Create an if statement that includes pass to avoid errors.

#Variables:
#sit, storing where the user is sitting as an argument when the function is called.
#chairs, storing the number of chairs the user has sat in as an integer in a variable.

# MAIN
#defining function sit_finder to try to find where you are sitting. It can only verify whether or not the user is sitting in a chair.
def sit_finder(sit):
#if the user is sitting in a chair
    if sit == "chair":
        #give them a helpful reminder.
        print("you're sitting in a chair!")
        #return the value true to be used later.
        return True
    #else, if they're sitting in something that does not equal a chair
    elif sit != "chair":
        #despair
        print("where on earth are you sitting?!")
        #return False value to be used later
        return False
#defining chair_number function to find how many chairs the user has sat in
def chair_number(chairs):
    #if they try to say a word instead of a number
    if isinstance(chairs, str):
        #feign confusion
        print("I don't know what you're talking about")
        #return a 0 integer to be used when the function is called later.
        return 0
    #else if they've sat in fewer than 3 chairs
    elif chairs <= 3:
        #chastise them
        print("somebody loves standing")
        #if they've sat in fewer than 20 chairs
    elif chairs < 20:
        #scold them
        print("that's not that many chairs")
    #if it's greater than 90 chairs
    elif chairs >= 90:
        #make fun of the user
        print("whoa, ok, slow down chairmaster")
    #if it's greater than 50 chairs
    elif chairs > 50:
        #be impressed
        print("whoa, buddy, that's a lot of chairs")
    #if it's fewer than or equal to 50, unless one of the above conditions has already been met
    elif chairs <= 50:
        #be unimpressed
        print("ok, pretty average amount of chairs")
    #otherwise
    else:
        #forget the topic
        print("I forgot what we were talking about.")
        #return the integer value given by any of these conditions that is set off to the variable "chairs"
    return chairs
#calling the function within a variable, asking for user input in the argument.
sit = sit_finder(input("where are you sitting?"))
#storing user input in a variable to be used as an argument when the num_chairs function is called
user_input = input("how many chairs have you sat in?")
#if the contents of the user_input variable is a string, attempt to convert it to an integer. 
try:
    user_input = int(user_input)
except ValueError:
    # If the conversion fails, user_input will remain a string
    pass

#setting another variable to house the function for use in the following two lines
num_chairs = chair_number(user_input)

#if they have sat in more than 50 chairs and are currently sitting in a chair
if num_chairs > 50 and sit:
    #deliver a helpful reminder.
    print("you are sitting in a chair, and have sat in more than 50 chairs.")
#if the number of chairs they've sat in is equal to 420 or 69
if num_chairs == 420 or num_chairs == 69:
    #let them know they've been caught.
    print("I see what you did there.")
    
if num_chairs > 1000:
    yikes = input("how on earth have you sat in so many chairs")
    try:
        yikes = int(yikes)
        # Now that yikes is an integer, we can do further checks or operations
        varibul = input("what are you talking about?")
        try:
            varibul = int(varibul)
            print("you're insane.")
        except ValueError:
            print("ok, I see what you mean.")
    except ValueError:
        if yikes == "chairs":
            print("you're insane.")
        else:
            print ("sus.")
    
if num_chairs <50 and not sit:
    print("wowowowowowowowowow")
else:
    pass

# END