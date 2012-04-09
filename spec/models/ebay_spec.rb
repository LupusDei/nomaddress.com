require 'spec_helper'

describe Ebay do

  before do
    @valid_ebay = Ebay.new(:username => "usrname", :first_name => "ebay", :last_name => "ebay", :country => "United States", :phone_number => "123-123-1234")
    @valid_ebay.address = Address.new(:line1 => "Address", :city => "somewhere", :zip => "123456", :state => "somestate")
    @valid_ebay.should be_valid
  end


  it "is a subscribable" do
    @valid_ebay.subscription.should be_nil
  end

  it "requires username" do
    @valid_ebay.username = ""
    @valid_ebay.should_not be_valid
  end

  it "requires first_name" do
    @valid_ebay.first_name = ""
    @valid_ebay.should_not be_valid
  end

  it "requires last_name" do
    @valid_ebay.last_name = ""
    @valid_ebay.should_not be_valid
  end

  it "requires country" do
    @valid_ebay.country = ""
    @valid_ebay.should_not be_valid
  end

  it "requres phone_number" do
    @valid_ebay.phone_number = nil
    @valid_ebay.should_not be_valid
  end
end
