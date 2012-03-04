#!/usr/bin/env python

"""
Script to add a new address on Amazon

author: Chen Wang(wang213), Feng Shan(shan16)

11:50 PM CST
March 3rd, 2012

"""


import sys
import mechanize

# Validate arguments
if (sys.argv.__len__() != 11):
    sys.exit("Arguments Invalid. \nUsage: filename email password full_name address1 addres2 city state zipcode country phone_number")

# Store all user inputs
email = sys.argv[1]
password = sys.argv[2]
name = sys.argv[3]
address1 = sys.argv[4]
address2 = sys.argv[5]
city = sys.argv[6]
state = sys.argv[7]
zipcode = sys.argv[8]
country = sys.argv[9]
phone = sys.argv[10]

# Prepare browser
browser = mechanize.Browser()
browser.set_handle_robots(False)
browser.addheaders = [("User-agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13")]

browser.open("http://www.amazon.com/gp/flex/sign-out.html")

# Select log-in form
browser.select_form(name="sign-in")
browser["email"] = email
browser["password"] = password

browser.submit()

if (browser.title() == "Sign In"): # Wrong password or email
    sys.exit("The email address and password you entered do not match any accounts on record.")

# Go to Add New Address page
browser.open("https://www.amazon.com/gp/css/account/address/view.html?viewID=newAddress")
browser.select_form(nr=1)

# Fill out the form
browser["enterAddressFullName"] = name
browser["enterAddressAddressLine1"] = address1
browser["enterAddressAddressLine2"] = address2
browser["enterAddressCity"] = city
browser["enterAddressStateOrRegion"] = state
browser["enterAddressPostalCode"] = zipcode

# Need to handle country

browser["enterAddressPhoneNumber"] = phone

# Submit the form by clicking Save & Continue
browser.submit(name="newAddress")

if (browser.title() == "Your Account"):
    sys.exit("Congratulations! Successfully added new address!")
else:
    browser.select_form(nr=1)

try:
    
    # Select original address if an address was entered
    # and Amazon has a suggestion
    browser.find_control("addr").items[0].selected = True
   
    # Store suggestion for future print 
    suggested_address1 = browser["addr_1address1"]
    suggested_address2 = browser["addr_1address2"]
    suggested_address3 = browser["addr_1address3"]
    suggested_city = browser["addr_1city"]
    suggested_state = browser["addr_1state"]
    suggested_zip = browser["addr_1zip"]

    browser.submit(name="useSelectedAddress")
    
    if (browser.title() == "Your Account"):
        # On address book. Successfully added new address
        print "Congratulations! Successfully added new address!"

        # Print suggestion
        print "Address suggested by Amazon:"
        print suggested_address1 # address1 should not be empty in any case

        # Print address lines if they are not empty
        if (suggested_address2 != ""):
            print suggested_address2

        if (suggested_address3 != ""):
            print suggested_address3

        print suggested_city + " " + suggested_state + ", " + suggested_zip

    else:
        # Address not added. Unknown Error
        print "Failed to add new address!"

except mechanize._form.ControlNotFoundError, e:
    # Could not find the control, due to invalid address. Exit
    sys.exit("Failed to add new address! Address not valid!")
