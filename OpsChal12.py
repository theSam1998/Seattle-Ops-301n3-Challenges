#Author: Sam Allan
#Date of last revision: 04/30/2023
#Script: Code Fellows Ops 301n3 Ops Challenge 12
#Purpose: Create a Python script that performs the following:
#!Prompt the user to type a string input as the variable for your destination URL.
#!Prompt the user to select a HTTP Method of the following options:
#!   GET
#!   POST
#!   PUT
#!   DELETE
#!   HEAD
#!   PATCH
#!   OPTIONS
#!Print to the screen the entire request your script is about to send. Ask the user to confirm before proceeding.
#Using the requests library, perform a GET request against your lab web server.
#!For the given header, translate the codes into plain terms that print to the screen; for example, a 404 error should print Site not found to the terminal instead of 404.
#!For the given URL, print response header information to the screen.
#Have your script perform authentication into api.github.com using the auth command.
#!Add timeouts to your script.
#!Add error handling to your script.

#Import space:
import requests
import time
#Mandatory greeting
print("hello!")
time.sleep(1)
#Global Variables:
status_codes = {
    100: 'Continue',
    101: 'Switching Protocols',
    102: 'Processing',
    200: 'OK',
    201: 'Created',
    202: 'Accepted',
    203: 'Non-Authoritative Information',
    204: 'No Content',
    205: 'Reset Content',
    206: 'Partial Content',
    207: 'Multi-Status',
    208: 'Already Reported',
    226: 'IM Used',
    300: 'Multiple Choices',
    301: 'Moved Permanently',
    302: 'Found',
    303: 'See Other',
    304: 'Not Modified',
    305: 'Use Proxy',
    307: 'Temporary Redirect',
    308: 'Permanent Redirect',
    400: 'Bad Request',
    401: 'Unauthorized',
    402: 'Payment Required',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    406: 'Not Acceptable',
    407: 'Proxy Authentication Required',
    408: 'Request Timeout',
    409: 'Conflict',
    410: 'Gone',
    411: 'Length Required',
    412: 'Precondition Failed',
    413: 'Payload Too Large',
    414: 'URI Too Long',
    415: 'Unsupported Media Type',
    416: 'Range Not Satisfiable',
    417: 'Expectation Failed',
    418: 'I\'m a teapot',
    421: 'Misdirected Request',
    422: 'Unprocessable Entity',
    423: 'Locked',
    424: 'Failed Dependency',
    426: 'Upgrade Required',
    428: 'Precondition Required',
    429: 'Too Many Requests',
    431: 'Request Header Fields Too Large',
    451: 'Unavailable For Legal Reasons',
    500: 'Internal Server Error',
    501: 'Not Implemented',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
    505: 'HTTP Version Not Supported',
    506: 'Variant Also Negotiates',
    507: 'Insufficient Storage',
    508: 'Loop Detected',
    510: 'Not Extended',
    511: 'Network Authentication Required'
}
yes_forms = ["Y", "y", "YES", "yes", "yES", "Yes", "YeS", "yeS", "yEs", "YEs"]
no_forms = ["N", "n", "NO", "no", "No", "nO"]
input_var = input("please provide me with a valid URL! I promise not to do anything sketchy with it...")
try:
    input_var = int(input_var)
except ValueError:
    while True:
        print(" you have the following options: ")
        time.sleep(1)
        print("\n--------HTTP_METHODS_MENU---------\n", "0----GET\n", "1----POST\n", "2----PUT\n", "3----DELETE\n", "4----HEAD\n", "5----PATCH\n", "6----OPTIONS\n", "7----EXIT\n")
        choice_var = input("which one would you like to use?")
        try:
            choice_var = int(choice_var)
            if choice_var == 0:
                while True:
                    print("Sending GET request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        get_response = requests.get(input_var, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        time.sleep(1)
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 1:
                while True:
                    print("Sending POST request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        data_input = input("Please enter the data for the POST request in the format 'key:value': ")
                        data_dict = dict(item.split(":") for item in data_input.split(","))
                        get_response = requests.post(input_var, data=data_dict, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        time.sleep(1)
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 2:
                while True:
                    print("Sending PUT request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        data_input = input("Please enter the data for the PUT request in the format 'key:value': ")
                        data_dict = dict(item.split(":") for item in data_input.split(","))
                        get_response = requests.put(input_var, data=data_dict, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 3:
                while True:
                    print("Sending DELETE request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        get_response = requests.delete(input_var, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        time.sleep(1)
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 4:
                while True:
                    print("Sending HEAD request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        get_response = requests.head(input_var, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        time.sleep(1)
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 5:
                while True:
                    print("Sending PATCH request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        data_input = input("Please enter the data for the PATCH request in the format 'key:value': ")
                        data_dict = dict(item.split(":") for item in data_input.split(","))
                        get_response = requests.patch(input_var, data=data_dict, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 6:
                while True:
                    print("Sending OPTIONS request to", input_var, ". Do you want to proceed? Y/N")
                    procedure_var = input()
                    if procedure_var in yes_forms:
                        get_response = requests.options(input_var, timeout=3)
                        print("Your http status code is:", get_response)
                        print(status_codes.get(get_response.status_code, 'Unknown status code'))
                        print("your response header is:", get_response.headers)
                        time.sleep(4)
                        break
                    if procedure_var in no_forms:
                        print("ok, another time then.")
                        time.sleep(1)
                        break
                    else:
                        print("invalid input, try again")
            elif choice_var == 7:
                print("goodbye!")
                time.sleep(1)
                break
            elif choice_var > 7: 
                print("invalid option selected, please select a valid option")
                time.sleep(1)
            elif choice_var < 0: 
                print("invalid option selected, please select a valid option")
                time.sleep(1)
        except ValueError:    
            print("USER ERROR: invalid input provided, ensure everything is correct and try again.")
            time.sleep(3)
#MAIN












#END