require 'spec_helper'

describe Address do

  before do
    @valid_adr = Address.new(:line1 => "Address", :city => "somewhere", :zip => "314159", :state => "mystate")
    @valid_adr.should be_valid
  end
  
  it "requires line1" do
    @valid_adr.line1 = ""
    @valid_adr.should_not be_valid
  end

  it "has a user" do
    @valid_adr.user = User.new(:first_name => "Justin", :last_name => "Martin", :email => "bob@loblaw.com", :password => "thing", :password_confirmation => "thing")
    @valid_adr.save
    adr = Address.find(@valid_adr.id)
    adr.user.first_name.should == "Justin" 
  end

  it "has a default category of 'Home'" do
    @valid_adr.category.should == "Home"
  end

  it "must have one of the defined categories" do
    @valid_adr.category = "crazy invalid"
    @valid_adr.should_not be_valid

    Address.valid_categories.each do |cat|
      @valid_adr.category = cat
      @valid_adr.should be_valid
    end
  end
end
