
import sys
import mechanize

# Validate arguments
if (sys.argv.__len__() != 11):
    print ("Arguments Invalid. \nUsage: filename username password first_name last_name address1 addres2 city state zipcode country phone_number")
    sys.exit(0)

# Store all user inputs
username = sys.argv[1]
password = sys.argv[2]
first_name = sys.argv[3]
last_name = sys.argv[4]
address1 = sys.argv[5]
address2 = sys.argv[6]
city = sys.argv[7]
state = sys.argv[8]
zipcode = sys.argv[9]
country = sys.argv[10]
phone = sys.argv[11]

# Prepare browser
browser = mechanize.Browser()
browser.set_handle_robots(False)
browser.addheaders = [("User-agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13")]

browser.open("https://signin.ebay.com/ws/eBayISAPI.dll?SignIn")

# Select log-in form
browser.select_form(name="SignInForm")
browser["userid"] = username
browser["pass"] = password

browser.submit()

if (browser.title() == "Welcome to eBay - Sign in"): # Wrong password or username
    print "The username and password you entered do not match any accounts on record."
    sys.exit(0)

# Go to Add New Address page
browser.open("http://payments.ebay.com/ws/eBayISAPI.dll?UserAddresses&cmd=standalone")
browser.select_form(name="pageForm")

# Fill out the form
browser["country"] = country
browser["contactName"] = first_name + " " + last_name
browser["address1"] = address1
browser["address2"] = address2
browser["stateName"] = state
browser["enterAddressStateOrRegion"] = state
browser["zip"] = zipcode
phone_array = phone.split('ext.',1);
phone_digit = phone_array[0].split("-", 1);
phone_extension = phone_array[1];
browser["dayphone1"] = phone_digit[0];
browser["dayphone2"] = phone_digit[1];
browser["dayphone3"] = phone_digit[2];
browser["dayphone4"] = phone_extension;

#make this address preferred address
browser["preferred"] = 1;

# Submit the form by clicking Save & Continue
browser.submit(name="pageForm")

if (browser.title() == "Your Account"):
    print "Congratulations! Successfully added new address!"
    sys.exit(0)
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
    print "Failed to add new address! Address not valid!"
