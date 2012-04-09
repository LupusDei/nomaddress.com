
import sys
import mechanize
from BeautifulSoup import BeautifulSoup
import re

# Validate arguments
if (sys.argv.__len__() != 12):
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


#parse the phone number
if(phone.find(" ext:") != -1):
	phone_array = phone.split(' ext:',1);
	phone_digits = phone_array[0].split("-", 2);
	phone_extension = phone_array[1];
else:
	phone_digits = phone.split("-",2);

if len(phone_digits) != 3:
    print "Phone Argument Invalid."
    print "Please enter your phone number in the following format:"
    print "XXX-XXX-XXXX ext:XX if you have an extension number"
    print "or XXX-XXX-XXXX if you don't have an extension number"
    sys.exit(0)

# Prepare browser
browser = mechanize.Browser()
browser.set_handle_robots(False)
browser.addheaders = [("User-agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13")]

browser.open("https://signin.ebay.com/ws/eBayISAPI.dll?SignIn&ru=http%3A%2F%2Fwww.ebay.com%2F")

# Select log-in form
browser.select_form(name="SignInForm")
browser["userid"] = username
browser["pass"] = password

browser.submit()
if (browser.title() != "eBay.com"): # Wrong password or username
    print "The username and password you entered do not match any accounts on record."
    sys.exit(0)

# Go to Add New Address page
open_response = browser.open("http://payments.ebay.com/ws/eBayISAPI.dll?UserAddresses&cmd=standalone")

# Get the country corresponding code for ebay
open_response_html = open_response.read()
open_soup = BeautifulSoup(open_response_html)
country_select = open_soup.find("select", id="country")
country_options = country_select.findAll("option")

country_code = -1

for option in country_options:
    if country == option.string.encode():
        country_code = option["value"].encode()

if country_code == -1:
    print "Update address failed."
    print "Your country is not supported by eBay."
    sys.exit(0)


browser.select_form(name="pageForm")

# Fill out the form
browser["country"] = [country_code]
browser["contactName"] = first_name + " " + last_name
browser["address1"] = address1
browser["address2"] = address2
browser["city"] = city
browser["stateName"] = [state]
browser["zip"] = zipcode
browser["dayphone1"] = phone_digits[0]
browser["dayphone2"] = phone_digits[1]
browser["dayphone3"] = phone_digits[2]

if(phone.find(" ext:") != -1):
    browser["dayphone4"] = phone_extension;

#make this address preferred address
browser["preferred"] = ["1"];

# Submit the form by clicking Save & Continue
response = browser.submit(nr=3);

#get the resposne html
response_html = response.read();
soup = BeautifulSoup(response_html);
errorMsg = soup.find("div", "stsMsg");

#check if error message printed
if(errorMsg == None):
    print "Congratulations! Successfully added new address!"
    sys.exit(0)
else:
    print "Update address failed."
    errorName = soup.findAll("span", "status_fieldName")
    errorInfo = soup.findAll("span", "status_errorMsg")

    #no error name meaning the error is an address error
    #print the suggested address
    if(len(errorName) == 0):
        recommend_address_div = soup.findAll("div", id="raddrPanel")
        recommend_address_spans = recommend_address_div[0].findAll("span")
        print "Please verify your address. The address recommended for you is:"
	for i in range (1, 3):
	        for content in recommend_address_spans[i].contents:
        	    if content.string != None:
                	print(content.string),

    #print the error otherwise
    else:
        print "You have to fix the errors below:"
        for i in range(len(errorName)):
	    print (errorName[i].string.encode()) + " - " + (errorInfo[i].string.encode())

    sys.exit(0) 
