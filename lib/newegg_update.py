#!/usr/bin/env python

"""
Script to add a new address on Newegg using Selenium

author: Chen Wang (wang213),
        Feng Shan (shan16)

12:08 AM CST
April 29th, 2012

"""

from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait # available since 2.4.0
from selenium.webdriver.support.ui import Select
import time
import sys

# Validate arguments
if (sys.argv.__len__() != 11):
  print ("Arguments Invalid. \nUsage: filename email password first_name last_name address_lin1 addres_line2 city state zipcode phone_number")
  sys.exit(0)

for i in range(11):
  if i == 6:
    continue
  if len(sys.argv[i]) == 0:
    print ("All fields except for address_line2 are required.")
    sys.exit(0)

if (len(sys.argv[8]) != 2):
  print ("Please use 2 letter abbreviations for state.")
  sys.exit(0)

if (len(sys.argv[10]) > 14 or len(sys.argv[10]) < 10):
  print ("Invalid Phone Number.")
  sys.exit(0)


# Store all user inputs
email = sys.argv[1]
password = sys.argv[2]
first_name = sys.argv[3]
last_name = sys.argv[4]
address_line1 = sys.argv[5]
address_line2 = sys.argv[6]
city = sys.argv[7]
state = sys.argv[8]
zipcode = sys.argv[9]
phone = sys.argv[10]


# Create a new instance of the Firefox driver
driver = webdriver.Firefox()


# Go to Newegg login page by manually clicking login link
# since direct access to that link will cause Anti-spam validation text 
driver.get("http://www.newegg.com")
login_link = driver.find_element_by_link_text("Log in or Register")
login_link.click()


# Fill out the login form
ne_username = driver.find_element_by_name("UserName")
ne_username.send_keys(email)

ne_password = driver.find_element_by_name("UserPwd")
ne_password.send_keys(password)

ne_password.submit()


# Go to Address book to add a new an address
driver.find_element_by_link_text("Address Book").click()
driver.find_element_by_link_text("Add New Address").click()


# Find all nessacery form elements
ne_first_name = driver.find_element_by_name("SFirstName")
ne_last_name = driver.find_element_by_name("SLastName")
ne_address_line1 = driver.find_element_by_name("SAddress1")
ne_address_line2 = driver.find_element_by_name("SAddress2")
ne_city = driver.find_element_by_name("SCity")
ne_state = Select(driver.find_element_by_name("SState"))
ne_zipcode = driver.find_element_by_name("SZip")
ne_phone1 = driver.find_element_by_name("ShippingPhone_tel1")
ne_phone2 = driver.find_element_by_name("ShippingPhone_tel2")
ne_phone3 = driver.find_element_by_name("ShippingPhone_tel3")
ne_phone_ext = driver.find_element_by_name("ShippingPhone_ext1")


# Fill out the form and click "Save" button
ne_first_name.send_keys(first_name)
ne_last_name.send_keys(last_name)
ne_address_line1.send_keys(address_line1)
ne_address_line2.send_keys(address_line2)
ne_city.send_keys(city)
ne_state.select_by_value(state);
ne_zipcode.send_keys(zipcode)
ne_phone1.send_keys(phone[:3])
ne_phone2.send_keys(phone[3:6])
ne_phone3.send_keys(phone[6:10])
ne_phone_ext.send_keys(phone[10:])

save = driver.find_element_by_link_text("Save")
save.click()


# Strange: without this line Selenium won't find the div with id
# error below. We have no idea of the reason.
driver.title


# Check sucess
ne_error = driver.find_element_by_id("error").text

if len(ne_error) != 0:
  print ("Failed to add address! Please check zip code or state.")
  driver.quit()
  sys.exit(0)
else:
  print ("Successfully added new address.")


# Quit the browser driver
driver.quit()
