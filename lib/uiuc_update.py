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

# Validate arguments
if (sys.argv.__len__() != 9):
    print ("Arguments Invalid. \nUsage: filename addr1 addr2 city state zipcode nation phone valid_date_from")
    sys.exit(0)

address1 = sys.argv[1]
address2 = sys.argv[2]
city = sys.argv[3]
state = sys.argv[4]
zip_code = sys.argv[5]
nation = sys.argv[6]
phone = sys.argv[7]
valid_date_from = sys.argv[8]

address1.replace('"', '').strip()
address2.replace('"', '').strip()

phone_area = phone[0] + phone[1] + phone[2]
phone_num = phone[3] + phone[4] + phone[5] + phone[6]

# Request first page
request = mechanize.Request("https://ui2web1.apps.uillinois.edu/BANPROD1/bwgkogad.P_SelectAtypUpdate")
response = mechanize.urlopen(request)
forms = mechanize.ParseResponse(response, backwards_compat=False)
response.close()
form = forms[1]		# forms[0] is a search box input

# Select the correct option
# Options are Billing Address, Diploma Address, Local Address (International), Mailing Address, Permanent
# Set to Mailing Address now
form.find_control("atyp").items[5].selected = True
request2 = form.click()

# Request second page
response2 = mechanize.urlopen(request2)
forms2 = mechanize.ParseResponse(response2, backwards_compat=False)
form = forms2[1]	# forms[0] is a search box input

# fill in the main form
form["fdate"] = valid_date_from
form["str1"] = address1
form["str2"] = address2
form["city"] = city
    
for item in form.find_control("stat").items:
    labels = item.get_labels()
    if(labels[0].text.lower() == state.lower()):
        item.selected = True
        break

for item in form.find_control("natn").items:
    labels = item.get_labels()
    if(labels[0].text.lower() == nation.lower()):
        item.selected = True
        break
                        
form["area"] = phone_area
form["num"] = phone_numb

#Request third page, which comes back to initial Addresses and Phones page
request3 = form.click()

#This should show us the success page
try:
    response4 = mechanize.urlopen(request4)
except mechanize.HTTPError, response4:
    sys.exit("Bad URL")

if (response4.title() == "Addresses and Phones; Personal Info tab"):
    print "Update Mailing Address for UIUC Address"
else:
    print "failed updating."