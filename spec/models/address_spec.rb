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
end
