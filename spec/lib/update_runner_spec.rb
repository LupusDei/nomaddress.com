require 'spec_helper'
require File.expand_path("../../lib/update_runner.rb", File.dirname(__FILE__))

describe UpdateRunner do
  before do
    @options = {:driver_license => "R12345678910", :ssn => "1234", :street => "123 Place", :city => "city", :zip => "12345", :county => "COUNTY"}
  end
  it "can run the dmv script" do
    UpdateRunner.run_dmv(@options).should == "PRETENDED TO RUN THE UPDATE."
  end

  it "has required params" do
    UpdateRunner.dmv_requirements_met(@options).should be_true
  end

  it "must has an all caps county" do
    @options[:county] = "county"
    
    UpdateRunner.dmv_requirements_met(@options).should be_false
  end

  it "can't have any non alphanumeric characts in the street address" do
    @options[:street] = "123 Place st."

    UpdateRunner.dmv_requirements_met(@options).should be_false

    @options[:street] = "123 Place st apt #13"

    UpdateRunner.dmv_requirements_met(@options).should be_false
  end

  it "can remove any aplanumeric chars" do
    UpdateRunner.strip_non_alphanumeric("123 place st. apt #13").should == "123 place st apt 13"
  end

  it "calls the helpers when trying to run the script" do
    @options[:county] = "county"
    @options[:street] = "123 place st. apt #13"

    UpdateRunner.should_receive(:dmv_requirements_met).with(@options).and_return(false)
    UpdateRunner.should_receive(:strip_non_alphanumeric).with(@options[:street]).and_return("123 place st apt 13")

    UpdateRunner.run_dmv(@options)
  end
end
