require 'spec_helper'

describe User do

  before do
    @valid_user = User.new(:first_name => "Justin", :last_name => "Martin", :email => "bob@loblaw.com", :password => "thing", :password_confirmation => "thing")
    @valid_user.should be_valid
  end

  it "must have a valid email address" do
    @valid_user.email = "not_legit"
    @valid_user.should_not be_valid
  end

  it "has many addresses" do
    @valid_user.addresses.should be_empty 
    adr = Address.new(:line1 => "Address", :city => "somewhere", :zip => "314159", :state => "mystate")
    @valid_user.addresses << adr
    @valid_user.addresses.size.should == 1

    @valid_user.save
    user = User.find(@valid_user.id)
    user.addresses.size.should == 1
  end

  it "becomes active after confirmation" do
    @valid_user.save
    @valid_user.status.should == "pending"

    @valid_user.confirm!

    @valid_user.reload.status.should == "active"
  end
end
