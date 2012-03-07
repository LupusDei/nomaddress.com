#!/usr/bin/env python

"""
Testing script to test amazon_update.py by comparing
the inputs, outputs and the added addresses on Amazon.com

author: Chen Wang(wang213), Feng Shan(shan16)

1:18 AM CST
March 7th, 2012

"""


import subprocess
import string
import random
import mechanize

# Global Variables

cmd_start = "python amazon_update.py"
wait_sentence = "It may take several seconds depending on the connections."
email = "nomaddresstest@gmail.com"
password = "cs428test"



"""
Generate a random name to avoid duplication.
"""
def create_random_name():
    first_len = random.randint(3, 8)
    last_len = random.randint(3, 8)

    first_name = ""
    for i in range(0, first_len):
        rand = random.randint(65, 90)
        first_name += chr(rand)

    last_name = ""
    for i in range(0, last_len):
        rand = random.randint(65, 90)
        last_name += chr(rand)

    return first_name + " " + last_name

"""
Test for a correct address. It should be successfully added.
"""
def correct_test(random_name):
    test_name = "correct_test"
    print "TESTING " + test_name
    print wait_sentence

    line1 = "202 E GREEN ST APT 806"
    city = "CHAMPAIGN"
    state = "IL"
    zipcode =  "61820-8171"

    output = test_helper(email, password,
                random_name, line1, "",
                city, state, zipcode, "", "2178987615")

    is_added = get_add_from_amazon(random_name, line1, city, state, zipcode)

    if ((output == "Congratulations! Successfully added new address!\n") and is_added):
        print test_name + " PASSED!"
    else:
        print test_name + " FAILED!"

"""
Test for a valid address in bad format. Amazon should return a suggestion
and the original address should be added.
"""
def suggestion_test(random_name):
    test_name = "suggestion_test"
    print "TESTING " + test_name
    print wait_sentence

    line1 = "202 E Green St Apt 806"
    city = "Urbana"
    state = "IL"
    zipcode =  "61820"

    output = test_helper(email, password,
                random_name, "202 E Green St Apt 806", "",
                "Urbana", "IL", "61820", "", "2178987615")

    is_added = get_add_from_amazon(random_name, line1, city, state, zipcode)

    if string.find(output, "Address suggested by Amazon:") > 0 and is_added:
        print test_name + " PASSED!"
    else:
        print test_name + " FAILED!"

"""
Test for a wrong address. It should not be added.
"""
def wrong_address_test(random_name):
    test_name = "wrong_address_test"
    print "TESTING " + test_name
    print wait_sentence

    output = test_helper(email, password,
                random_name, "0 Random St Apt 0", "",
                "Urbana", "IL", "61820", "", "2178987615")

    if output == "Failed to add new address! Address not valid!\n":
        print test_name + " PASSED!"
    else:
        print test_name + " FAILED!"

"""
Test for a wrong password/email. The script should indicate it.
"""
def wrong_password_test(random_name):
    test_name = "wrong_password_test" 
    print "TESTING " + test_name
    print wait_sentence

    output = test_helper("email@email.email", password,
                random_name, "0 Random St Apt 0", "",
                "Urbana", "IL", "61820", "", "2178987615")

    if output == "The email address and password you entered do not match any accounts on record.\n":
        print test_name + " PASSED!"
    else:
        print test_name + " FAILED!"


"""
Test helper to run the update script and return the output
"""
def test_helper(email, password, full_name,
                 line1, line2, city, state,
                 zipcode, country, phone_num):
    output = subprocess.check_output(cmd_start + " "
                                   + email + " "
                                   + password + " "
                                   + "\"" + full_name + "\" "
                                   + "\"" + line1 + "\" "
                                   + "\"" + line2 + "\" "
                                   + "\"" + city + "\" "
                                   + "\"" + state + "\" "
                                   + zipcode + " "
                                   + "\"" + country + "\" "
                                   + phone_num, shell=True)
    return output

"""
It logs into amazon and grab the new address added. Then it checks whether
it matches the input address.
"""
def get_add_from_amazon(full_name, line1, city, state, zipcode):
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

    address_page = browser.open("https://www.amazon.com/gp/css/account/address/view.html").read()
    
    name_pos = string.find(address_page, "displayAddressFullName")
    full_name_amazon = address_page[(name_pos + 27):(name_pos + 27 + len(full_name))]
    if full_name_amazon != full_name:
        return False

    line1_pos = string.find(address_page, "displayAddressAddressLine1")
    line1_amazon = address_page[(line1_pos + 28):(line1_pos + 28 + len(line1))]
    if line1_amazon != line1:
        return False

    region_pos = string.find(address_page, "displayAddressCityStateOrRegionPostalCode")
    region_line = city + ", " + state + " " + zipcode
    region_line_amazon = address_page[(region_pos + 43):(region_pos + 43 + len(region_line))]
    if region_line_amazon != region_line:
        return False

    return True
    


# Test cases calls
name = create_random_name()
print "****** TEST CASE 0: ******"
correct_test(name)
print "\n****** TEST CASE 1: ******"
suggestion_test(name)
print "\n****** TEST CASE 2: ******"
wrong_address_test(name)
print "\n****** TEST CASE 3: ******"
wrong_password_test(name)
