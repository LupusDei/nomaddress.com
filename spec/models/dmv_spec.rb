require 'spec_helper'

describe Dmv do
  before do
    @valid_dmv = Dmv.new(:driver_license => "s123456", :ssn => "1234", :county => "Champaign")
    @valid_dmv.address = Address.new(:line1 => "Address", :city => "somewhere", :zip => "123456", :state => "somestate")
    @valid_dmv.should be_valid
  end

  it "requires driver_license" do
    @valid_dmv.driver_license = ""
    @valid_dmv.should_not be_valid
  end

  it "requires ssn" do
    @valid_dmv.ssn = ""
    @valid_dmv.should_not be_valid
  end

  it "requires county" do
    @valid_dmv.county = ""
    @valid_dmv.should_not be_valid
  end

  it "requires address" do
    @valid_dmv.address = nil
    @valid_dmv.should_not be_valid
  end

  it "driver_license should only contains numbers and letters" do
    @valid_dmv.driver_license = "@**invalid123"
    @valid_dmv.should_not be_valid
  end

  it "ssn should only contains digits" do
    @valid_dmv.ssn = "cra1"
    @valid_dmv.should_not be_valid
  end

  it "ssn should only be 4 digit" do
    @valid_dmv.ssn = "123"
    @valid_dmv.should_not be_valid

    @valid_dmv.ssn = "12345"
    @valid_dmv.should_not be_valid
  end

  it "county should only contains letters" do
    @valid_dmv.county = "123crazy"
    @valid_dmv.should_not be_valid
  end
end
