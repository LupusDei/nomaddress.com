#!/usr/bin/env python

import sys

import mechanize

import string

from HTMLParser import HTMLParser

class TagStripper(HTMLParser):
    def __init__(self):
        self.reset()
        self.fed = []
    def handle_data(self, d):
        self.fed.append(d)
    def get_data(self):
        return ''.join(self.fed)

def strip_tags(html):
    s = TagStripper()
    s.feed(html)
    return s.get_data()

driver_license_number = sys.argv[1]
last_4_digits_ssn = sys.argv[2]
street_address = sys.argv[3]
city = sys.argv[4]
zip_code = sys.argv[5]
county = sys.argv[6]

street_address.replace('"', '').strip()

# Request first page
request = mechanize.Request("https://www.ilsos.gov/addrchange/")
response = mechanize.urlopen(request)
forms = mechanize.ParseResponse(response, backwards_compat=False)
response.close()
form = forms[0]

# Select the correct option, which is Dirvers in our case
form.find_control("updateType").items[0].selected = True
request2 = form.click()

# Request second page
response2 = mechanize.urlopen(request2)
forms2 = mechanize.ParseResponse(response2, backwards_compat=False)
form = forms2[0]

# fill in the main form
form["dlNo"] = driver_license_number
form["last4Ssn"] = last_4_digits_ssn
form["street"] = street_address
form["city"] = city
form["zipCode"] = zip_code

for item in form.find_control("county").items:
	labels = item.get_labels()
    	if(labels[0].text.lower() == county.lower()):
		item.selected = True
		break

#for item in form.find_control("county").items:
    #print item.name

#Request third page which is the confirmation page
request3 = form.click()

try:
    response3 = mechanize.urlopen(request3)
except mechanize.HTTPError, response3:
    sys.exit("Bad URL")

forms3 = mechanize.ParseResponse(response3, backwards_compat=False)
form = forms3[0]

request4 = form.click() #confirm

#This should show us the success page
try:
    response4 = mechanize.urlopen(request4)
except mechanize.HTTPError, response4:
    sys.exit("Bad URL")

lines = response4.readlines()
count = 0

#This is a hard coded hack for the DMV website, ideally we should parse the html but yeah
success = 0
for line in lines:
    count = count+1
    line = line.replace('\t','').strip()
    line = strip_tags(line)
    if(line == "Your address has successfully been updated."):
      success = 1
      break

if(success == 1):
    print "Successful Update"
else:
    print "Update Failure"
