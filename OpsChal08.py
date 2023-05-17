#Author: Sam Allan
#Date of last revision: 05/16/2023
#Script: Seattle 301n3 Ops Challenge 08
#Purpose: write a script that does the following:
#Assign to a variable a list of ten string elements.
#Print the fourth element of the list.
#Print the sixth through tenth element of the list.
#Change the value of the seventh element to “onion”.
#Stretch Goals:
#Use the below Python methods once each against your list to manipulate the elements in your list:
#!append()
#!clear()
#!copy()
#!count()
#extend()
#!index()
#!insert()
#!pop()
#!reverse()
#!remove()
#!sort()

import time
#var:
new_plastics = ["twitchin jig", "bobbers", "weights", "leader line", "marabou jigs", "wooly buggers", "spinners", "soft beads", "hooks", "yarn", "corkies"]
tackle_box = ["spinner", "chatterbait", "senko", "crankbait", "jerkbait", "spinnerbait", "bobber", "jig", "hooks", "weights"]
salmon_box = tackle_box.copy()
#MAIN
print("time to go fishing! lets look in the tackle box.")
time.sleep(1)
print(tackle_box)
time.sleep(2)
print("whoa, there sure is a lot of stuff in here, look at this cool thing! I found a")
time.sleep(1)
print(tackle_box[3], "!")
time.sleep(2)
print("whoa, I really like all these ones!")
time.sleep(1)
print(tackle_box[5:])
time.sleep(2)
print("but I think I need to add something else!")
time.sleep(2)
tackle_box[6] = "popper"
print(tackle_box)
time.sleep(2)
print("And some more!")
time.sleep(2)
tackle_box.append("swimbaits")
print(tackle_box)
time.sleep(2)
salmon_box.clear()
print("lets add another type of plastic! just in case.")
tackle_box.insert(4, "fluke")
time.sleep(2)
print(tackle_box)
time.sleep(2)
print("crankbaits are my")
print(tackle_box.count("crankbait"), "st favorite lure!")
time.sleep(2)
salmon_box.extend(new_plastics)
print("now lets go over the salmon gear!")
time.sleep(2)
print(salmon_box.index("spinners"))
time.sleep(2)
print(salmon_box.pop(0))
time.sleep(2)
print("I've moved the spinners from the bass box to the salmon box")
time.sleep(2)
tackle_box.remove("spinner")
tackle_box.reverse()
print(tackle_box)
time.sleep(2)
print("whoops! I messed up the order, lets get them organized again!")
time.sleep(2)
tackle_box.sort()
print(tackle_box)
time.sleep(2)
print("there we go, now that it's sorted lets look over both boxes!")
time.sleep(2)
print(tackle_box, salmon_box)
time.sleep(2)
print("time to go fishing!")
time.sleep(2)
